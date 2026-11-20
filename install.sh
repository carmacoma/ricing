#!/usr/bin/env bash
# Installs Sway + friends on Ubuntu 24.04 and links these dotfiles into $HOME.
# Safe to re-run. GNOME is left untouched; pick "Sway" on the login screen.
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Installing packages"
sudo apt update
sudo apt install -y \
  sway swaybg swayidle swaylock \
  waybar wofi foot mako-notifier \
  grim slurp wl-clipboard \
  brightnessctl pavucontrol network-manager-gnome policykit-1-gnome \
  xdg-desktop-portal-wlr \
  stow unzip curl

echo "==> Installing JetBrainsMono Nerd Font"
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerd"
if [ ! -d "$FONT_DIR" ]; then
  mkdir -p "$FONT_DIR"
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/font.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip -q "$tmp/font.zip" -d "$FONT_DIR"
  rm -rf "$tmp"
  fc-cache -f
fi

mkdir -p "$HOME/Pictures"

echo "==> Linking configs with stow"
for pkg in sway waybar foot mako; do
  # Back up any existing real config so stow doesn't refuse to link
  find "$pkg" -type f | while read -r f; do
    target="$HOME/${f#"$pkg"/}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "    backing up $target -> $target.bak"
      mv "$target" "$target.bak"
    fi
  done
  stow -v -t "$HOME" "$pkg"
done

echo
echo "Done. Log out, click the gear icon on the login screen, choose 'Sway', and log in."
echo "Press Super+Return for a terminal, Super+d for the app launcher."
