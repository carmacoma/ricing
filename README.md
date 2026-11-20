# ricing

Dotfiles for my Ubuntu 24.04 laptop: a **Sway** tiling setup with Waybar,
foot and mako, themed with Catppuccin Mocha. GNOME is still installed as a
fallback.

## Layout

Each top-level folder is a [GNU Stow](https://www.gnu.org/software/stow/)
package that mirrors `$HOME`:

| Folder    | What it configures                      |
|-----------|-----------------------------------------|
| `sway/`   | Window manager, keybinds, touchpad, idle |
| `waybar/` | Top status bar                          |
| `foot/`   | Terminal                                |
| `mako/`   | Notifications                           |

`stow sway` symlinks `sway/.config/sway/config` to `~/.config/sway/config`, so
editing either one edits the file in this repo.

## Install

```bash
git clone https://github.com/carmacoma/ricing ~/ricing
cd ~/ricing
./install.sh
```

Then log out, click the gear icon on the login screen, choose **Sway** and
log in. To go back, pick **Ubuntu** on that menu.

## Cheat sheet (Super = Windows key)

| Keys                     | Action                          |
|--------------------------|---------------------------------|
| Super + Return           | Terminal                        |
| Super + d                | App launcher                    |
| Super + q                | Close window                    |
| Super + h/j/k/l or arrows | Move focus                     |
| Super + Shift + h/j/k/l  | Move window                     |
| Super + 1…0              | Switch workspace                |
| Super + Shift + 1…0      | Send window to workspace        |
| Super + b / v            | Next window splits side-by-side / stacked |
| Super + w / s / e        | Tabbed / stacking / split layout |
| Super + f                | Fullscreen                      |
| Super + Shift + Space    | Toggle floating                 |
| Super + r                | Resize mode (Esc to exit)       |
| Super + Escape           | Lock screen                     |
| Super + Shift + s        | Screenshot a region (to clipboard) |
| Super + Shift + c        | Reload config                   |
| Super + Shift + e        | Log out                         |

## Next ideas

- Wallpaper: set `output * bg ~/Pictures/wall.jpg fill` in the sway config
- Shell prompt (Starship) and a zsh/fish config as another stow package
- Matching GTK theme and icons for apps
- Later: port keybinds and Waybar to Hyprland after an Ubuntu upgrade
