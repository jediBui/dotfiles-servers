#!/bin/bash
set -e

echo "==> Updating packages..."
sudo apt update

echo "==> Installing Zsh, Git, Curl..."
sudo apt install -y zsh git curl

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Installing Starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "==> Installing Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions || true
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting || true
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete || true

echo "==> Linking dotfiles..."
ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
#mkdir -p "$HOME/.config"
ln -sf "$HOME/dotfiles/.config/starship.toml" "$HOME/.config/starship.toml"

echo "==> Installation complete. To use Zsh now, run: zsh"