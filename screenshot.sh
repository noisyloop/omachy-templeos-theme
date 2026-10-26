#!/bin/bash

# Take the screenshot omarchy.org/themes asks for: a 16:9 shot of the whole
# screen with no mouse cursor, no top bar and no metadata, converted to a
# 1200x675 webp under 100KB.
#
#   ./screenshot.sh            run it in the terminal you want in the shot
#   ./screenshot.sh --info     show the screen resolution and what will be cropped
#   ./screenshot.sh --help     all options
#
# The terminal you run it from turns into the fastfetch window, the capture
# happens in the background a few seconds later, and the files land in
# ~/templeos-screenshot/: preview.png (full size) and templeos.webp (for the site).

set -euo pipefail

NAME="templeos"
DELAY=8
KEEP_BAR=0
OUT="$HOME/templeos-screenshot"
MODE="start"

usage() {
  cat <<EOF
Usage: $0 [--info] [--delay SECONDS] [--keep-bar] [--out DIR]

  --info          Print the focused monitor's resolution and exit
  --delay N       Seconds to wait before the capture (default $DELAY)
  --keep-bar      Leave the top bar (and its clock) in the shot
  --out DIR       Where to save the files (default $OUT)
EOF
}

ARGS=()
while (($#)); do
  case "$1" in
    --info) MODE="info" ;;
    --delay) DELAY="$2"; ARGS+=("$1" "$2"); shift ;;
    --keep-bar) KEEP_BAR=1; ARGS+=("$1") ;;
    --out) OUT="$2"; ARGS+=("$1" "$2"); shift ;;
    --capture) MODE="capture" ;;
    -h | --help) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
  shift
done

for tool in grim magick hyprctl jq; do
  command -v "$tool" >/dev/null || { echo "Missing $tool. It ships with Omarchy; are you running this inside Omarchy?" >&2; exit 1; }
done

read -r MONITOR WIDTH HEIGHT SCALE < <(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.name) \(.width) \(.height) \(.scale)"')

# The largest centered 16:9 area of the screen.
if ((WIDTH * 9 > HEIGHT * 16)); then
  CROP_W=$((HEIGHT * 16 / 9)) CROP_H=$HEIGHT
else
  CROP_W=$WIDTH CROP_H=$((WIDTH * 9 / 16))
fi

if [[ $MODE == info ]]; then
  echo "Monitor:    $MONITOR"
  echo "Resolution: ${WIDTH}x${HEIGHT} (scale $SCALE)"
  if ((CROP_W == WIDTH && CROP_H == HEIGHT)); then
    echo "Aspect:     16:9, nothing will be cropped"
  else
    echo "Aspect:     not 16:9; the shot will be cropped to the centered ${CROP_W}x${CROP_H}"
    echo "            (switch to 1920x1080 or 2560x1440 to keep the whole screen)"
  fi
  exit 0
fi

if [[ $MODE == start ]]; then
  # Hand the capture to a background copy of this script, then turn this
  # terminal into a clean fastfetch window for the shot.
  mkdir -p "$OUT"
  setsid -f "$0" --capture "${ARGS[@]}" >"$OUT/capture.log" 2>&1 </dev/null
  clear
  fastfetch
  exit 0
fi

# --capture: runs in the background.
mkdir -p "$OUT"
BAR_FLAG="$HOME/.local/state/omarchy/toggles/bar-off"
BAR_WAS_HIDDEN=0
[[ -f $BAR_FLAG ]] && BAR_WAS_HIDDEN=1

restore_bar() {
  if ((KEEP_BAR == 0 && BAR_WAS_HIDDEN == 0)); then
    omarchy-toggle-bar off >/dev/null 2>&1 || true
  fi
}
trap restore_bar EXIT

if ((KEEP_BAR == 0)); then
  omarchy-toggle-bar on >/dev/null 2>&1 || true
fi
omarchy-shell -q notifications dismissAll >/dev/null 2>&1 || true

sleep "$DELAY"

# grim captures the monitor at its native pixels and leaves the cursor out.
RAW="$OUT/.raw.png"
grim -o "$MONITOR" "$RAW"
restore_bar
trap - EXIT

magick "$RAW" -gravity center -crop "${CROP_W}x${CROP_H}+0+0" +repage -strip "$OUT/preview.png"
rm -f "$RAW"

# The site's command, stepping the quality down only if it lands over 100KB.
for quality in 80 75 70 65 60 55 50; do
  magick "$OUT/preview.png" -strip -resize '1200>' -quality "$quality" "$OUT/$NAME.webp"
  (($(stat -c %s "$OUT/$NAME.webp") <= 100 * 1024)) && break
done

metadata=$(magick identify -verbose "$OUT/$NAME.webp" "$OUT/preview.png" | grep -ciE 'exif:|gps|xmp|iptc' || true)

{
  echo "Saved to $OUT"
  echo "  preview.png    $(magick identify -format '%wx%h' "$OUT/preview.png"), $(du -h "$OUT/preview.png" | cut -f1)"
  echo "  $NAME.webp  $(magick identify -format '%wx%h' "$OUT/$NAME.webp"), $(du -h "$OUT/$NAME.webp" | cut -f1), quality $quality"
  if ((metadata == 0)); then
    echo "  No EXIF, GPS, XMP or IPTC metadata in either file."
  else
    echo "  Warning: metadata found; check with: magick identify -verbose $OUT/$NAME.webp"
  fi
} | tee "$OUT/result.txt"

command -v notify-send >/dev/null && notify-send "TempleOS screenshot saved" "$(cat "$OUT/result.txt")" || true
