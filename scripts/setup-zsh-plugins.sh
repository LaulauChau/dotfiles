#!/bin/bash

ZSH_DIR="$HOME/.zsh"

mkdir -p "$ZSH_DIR"

git clone https://github.com/Aloxaf/fzf-tab "$ZSH_DIR/fzf-tab"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_DIR/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_DIR/zsh-syntax-highlighting"
