# TempleOS for Omarchy

> "An idiot admires complexity, a genius admires simplicity." — Terry A. Davis (1969–2018)

A light [Omarchy](https://omarchy.org) theme built from the 16-color EGA palette of
[TempleOS](https://templeos.org): blue ink on a white page, blue window borders, and
pixel-art wallpapers drawn at 640×360 and scaled up 6× with nearest-neighbor.

![TempleOS theme preview](preview.png)

## Install

Open a terminal (`Super + Return`) and run:

```sh
omarchy theme install https://github.com/noisyloop/omachy-templeos-theme
```

This clones the theme into `~/.config/omarchy/themes/omachy-templeos` and switches to it
right away: terminal, Hyprland borders, bar, launcher, notifications, btop and Neovim all
change together.

Or use the menu instead of the terminal: press `Super + Space`, go to
**Install → Style → Theme**, and paste the URL above.

### Pick a wallpaper

The theme ships three wallpapers. Press `Super + Ctrl + Space` to open the background
switcher and pick one:

- `1-temple`: the Temple, with Terry's quote and the EGA palette
- `2-holyc`: a HolyC listing in a TempleOS editor window
- `3-blue`: a blue TempleOS title screen

### Switch themes, update, remove

| What                     | How                                                                  |
|--------------------------|----------------------------------------------------------------------|
| Switch to another theme  | `Super + Ctrl + Shift + Space` (or `Super + Ctrl + T`) and pick one  |
| Switch back to TempleOS  | Same menu, pick **omachy-templeos**                                  |
| Update to the latest     | `omarchy-theme-update`                                               |
| Remove                   | `omarchy theme remove omachy-templeos`                               |

## Taking a screenshot

The theme listing on [omarchy.org/themes](https://omarchy.org/themes/) wants a 16:9 shot of
a real session with a terminal and an editor open, using the theme's own wallpaper, with no
cursor, notification or anything personal in it. Everything below ships with Omarchy.

1. Install the theme (above) and pick the `1-temple` wallpaper.
2. Set the scene. Open a terminal and run `fastfetch` or `btop` in it. Open a second
   terminal and edit some code with `nvim`. Close anything showing personal information,
   and wait for any notifications to clear.
3. Take the shot without the mouse cursor. `grim` leaves the cursor out by default. From
   one of the terminals run this, then move the mouse to a screen edge and wait 5 seconds:

   ```sh
   sleep 5 && grim ~/preview.png
   ```

4. If your screen isn't 16:9 (for example a 16:10 laptop), crop it:

   ```sh
   magick ~/preview.png -gravity center -crop 16:9 +repage ~/preview.png
   ```

5. Convert it for the site. Aim for 1200×675 and under about 100KB:

   ```sh
   magick ~/preview.png -strip -resize '1200>' -quality 80 ~/templeos.webp
   ```

`~/templeos.webp` goes in `assets/themes/` of
[omarchy-site](https://github.com/omacom/omarchy-site). Replace `preview.png` in this repo
with `~/preview.png` so Omarchy's theme switcher shows the real thing too. (The current
`preview.png` is a rendered mockup.)

## Palette

| Role       | Color     | EGA name    |
|------------|-----------|-------------|
| Background | `#FFFFFF` | White       |
| Foreground | `#0000AA` | Blue        |
| Accent     | `#0000AA` | Blue        |
| Selection  | `#55FFFF` | Light cyan  |
| Red        | `#AA0000` | Red         |
| Green      | `#00AA00` | Green       |
| Yellow     | `#AA5500` | Brown       |
| Cyan       | `#00AAAA` | Cyan        |
| Magenta    | `#AA00AA` | Purple      |
| Muted      | `#AAAAAA` | Light gray  |

The bright row is the other half of the EGA palette (`#5555FF`, `#55FF55`, `#55FFFF`,
`#FF5555`, `#FF55FF`, `#FFFF55`). On a white page, dim "yellow" is EGA brown, just as
it is on the real hardware, so warnings stay readable.

## What's included

- `colors.toml`: the palette. Omarchy generates the terminal, Hyprland borders, Neovim,
  bar, launcher, notification and other configs from it.
- `btop.theme`: a hand-tuned btop palette.
- `backgrounds/`: the three wallpapers.
- `unlock.png`: the pixel-font TempleOS logo for the disk-unlock (Plymouth) screen.
- `icons.theme`, `chromium.theme`: Yaru-blue icons and a white browser frame.

## Credits

The bitmap glyphs in the wallpapers come from [font8x8](https://github.com/dhepper/font8x8)
by Daniel Hepper (public domain). TempleOS was created by Terry A. Davis. This theme is
a tribute; it isn't affiliated with the TempleOS project.
