#!/usr/bin/env bash

usage() {
	echo "$0 [options] <hostname>"
	echo
	echo "Arguments:"
	echo "  hostname"
	echo "    The hostname to assign to this system."
	echo
	echo "Options:"
	echo "  --skip-packages"
	echo "    Do not install any new packages."
	echo
	echo "  --skip-keypair"
	echo "    Do not generate a new keypair"
}

positional_args=()

while [ $# -ne 0 ]; do
	key="$1"

	case "$key" in
		--skip-packages)
			skip_packages="--skip-packages"

			;;

		--skip-keypair)
			skip_keypair="--skip-keypair"

			;;

		-h|--help)
			usage

			exit 0

			;;

		-*)
			echo "Unrecognized option: $key"
			usage

			exit 1

			;;

		*)
			positional_args+=("$key")

			;;
	esac

	shift
done

set -- "${positional_args[@]}"

if [ $# -ne 1 ]; then
	usage

	exit 1
fi

hostname="$1"

if [ -z "$skip_keypair" ]; then
	ssh-keygen -t rsa -b 4096 -C "$(whoami)@${hostname}" -f "$HOME/.ssh/id_rsa"
fi

project_root=`dirname "$0"`

sudo ./privileged.sh "$(whoami)" "$hostname" $skip_packages

# Copy config files
cp -r "$project_root"/configs/shell/.config/* "$HOME/.config"
cp -r "$project_root"/configs/gui/.config/* "$HOME/.config"
cp -r "$project_root"/configs/editor/.config/* "$HOME/.config"

# Set up neovim
sh -c 'curl --silent -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim +'PlugInstall --sync' +qa
