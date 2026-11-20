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

echo "==> Installing Starship prompt"
if ! command -v starship >/dev/null; then
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y
fi
if ! grep -q 'starship init bash' "$HOME/.bashrc"; then
  printf '\n# Starship prompt\neval "$(starship init bash)"\n' >> "$HOME/.bashrc"
fi

mkdir -p "$HOME/Pictures"

echo "==> Linking configs with stow"
for pkg in sway waybar foot mako starship; do
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
echo "Done. Open a new terminal to see the new prompt."
echo "If you're not in Sway yet: log out, click the gear icon on the login screen, choose 'Sway', and log in."
echo "Press Super+Return for a terminal, Super+d for the app launcher."
