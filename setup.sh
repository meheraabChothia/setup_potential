#!/usr/bin/env bash
set -e

# Packages
sudo apt update
sudo apt upgrade
sudo apt install git
sudo apt install tmux
sudo apt install stow
sudo apt install curl

# dotfiles and configs
cd

REPO_URL=https://github.com/meheraabChothia/.dotfiles.git
DEST=~/.dotfiles

if [ -d "$DEST" ]; then
  echo "Directory $DEST already exists – skipping clone."
else
  git clone "$REPO_URL" "$DEST"
fi

cd .dotfiles
cp bash/.bashrc bash/.bash_aliases ..
cd

# uv and aider
cd
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.bashrc
mkdir -p aider
cd aider
uv init
uv add aider-install
uv run aider-install
cd

# nvim
cd
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
cd
cd .dotfiles
stow lazy_nvim/

# tmux configs:
cd

REPO_URL=https://github.com/tmux-plugins/tpm
DEST=~/.tmux/plugins/tpm

if [ -d "$DEST" ]; then
  echo "Directory $DEST already exists – skipping clone."
else
  git clone "$REPO_URL" "$DEST"
fi

cd .dotfiles
cp tmux/.tmux.conf ~/
cd

# Edits to bashrc
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >>~/.bashrc
