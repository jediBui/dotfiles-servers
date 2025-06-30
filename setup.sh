#!/bin/bash
set -e

echo "==> Updating packages..."
sudo apt update && sudo apt upgrade -y

echo "==> Installing Zsh, Git, Curl..."
sudo apt install -y zsh git curl vim

echo "==> Setting Zsh as your default shell..."
chsh -s "$(command -v zsh)"

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Installing Starship prompt..."
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "==> Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete || true

echo "==> Linking dotfiles..."
ln -sf "$HOME/dotfiles-servers/.zshrc" "$HOME/.zshrc"
#mkdir -p "$HOME/.config"
#ln -sf "$HOME/dotfiles-servers/.config/starship.toml" "$HOME/.config/starship.toml"

echo "==> Installation complete. To use Zsh now, run: zsh"`