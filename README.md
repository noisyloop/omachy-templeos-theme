# TempleOS for Omarchy

> "An idiot admires complexity, a genius admires simplicity." — Terry A. Davis (1969–2018)

A light [Omarchy](https://omarchy.org) theme built from the 16-color EGA palette of
[TempleOS](https://templeos.org): blue ink on a white page, blue window borders, and
pixel-art wallpapers drawn at 640×360 and scaled up 6× with nearest-neighbor.

![TempleOS theme on the Omarchy desktop](screenshots/1-desktop.webp)

## Screenshots

| Omarchy menu | Terminal |
|---|---|
| ![The Omarchy menu in TempleOS colors](screenshots/2-menu.webp) | ![A Foot terminal in TempleOS colors](screenshots/3-terminal.webp) |

## Requirements

- A current [Omarchy](https://omarchy.org) release, which builds each app's colors from a
  theme's `colors.toml`.
- Nothing else. The theme ships only colors, wallpapers and images, no scripts that run
  on their own.

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

[omarchy.org/themes](https://omarchy.org/themes/) lists each theme with one 16:9 screenshot
of a real session: a terminal and an editor open, the theme's own wallpaper, and no cursor,
notification or anything personal. `screenshot.sh` takes it for you.

1. Install the theme and pick the `1-temple` wallpaper (`Super + Ctrl + Space`).
2. Open a terminal (`Super + Return`) and check your screen size:

   ```sh
   ~/.config/omarchy/themes/omachy-templeos/screenshot.sh --info
   ```

   1920x1080 or 2560x1440 is ideal. Anything else gets cropped to a centered 16:9.
3. Open a second terminal and start the editor: `nvim ~/.config/omarchy/themes/omachy-templeos/colors.toml`.
   To show more of the wallpaper, float the windows with `Super + T` and move them with
   `Super + drag` (resize with `Super + right-drag`).
4. In the first terminal, run the script:

   ```sh
   ~/.config/omarchy/themes/omachy-templeos/screenshot.sh
   ```

   That terminal turns into a clean `fastfetch` window. Move the mouse to a screen edge and
   wait 8 seconds. The script hides the top bar and clock, clears notifications, captures the
   screen without the cursor, puts the bar back, and strips all metadata.

The files land in `~/templeos-screenshot/`:

- `templeos.webp`: 1200×675, under 100KB, for `assets/themes/` in
  [omarchy-site](https://github.com/omacom/omarchy-site)
- `preview.png`: full size, to replace this repo's `preview.png` (the picture Omarchy's theme
  switcher shows)

Use `--keep-bar` to leave the bar in, or `--delay 15` for more time to set up.

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
- `screenshot.sh`: takes the omarchy.org screenshot (see above). It only runs when you run it.
- `screenshots/`: the images in this README.

## Credits

The bitmap glyphs in the wallpapers come from [font8x8](https://github.com/dhepper/font8x8)
by Daniel Hepper (public domain). TempleOS was created by Terry A. Davis. This theme is
a tribute; it isn't affiliated with the TempleOS project.
