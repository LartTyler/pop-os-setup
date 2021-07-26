#!/usr/bin/env bash

copy_configs() {
	cp "$1"/.* ~ 2>/dev/null
	cp -r "$1"/.config/* ~/.config 2>/dev/null
}

project_root=`dirname "$0"`

# Copy config files
copy_configs "$project_root"/configs/shell
copy_configs "$project_root"/configs/gui
copy_configs "$project_root"/configs/editor
copy_configs "$project_root"/configs/env

# Set up neovim
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then 
	sh -c 'curl --silent -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

nvim +'PlugInstall --sync' +qa

# Install rust-analyzer
mkdir -p "$HOME"/.local/bin

if [ ! -f "$HOME"/.local/bin/rust-analyzer ]; then
	curl --silent -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | \
		gunzip -c - > "$HOME"/.local/bin/rust-analyzer

	chmod +x "$HOME"/.local/bin/rust-analyzer
fi

