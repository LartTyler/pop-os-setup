#!/usr/bin/env bash

usage() {
	echo "Usage: $0 [options] <username> <hostname>"
	echo
	echo "Options:"
	echo "  --skip-packages"
	echo "    If set, do not install any new packages."
}

skip_packages=""
positional_args=()

while [ $# -ne 0 ]; do
	key="$1"

	case "$key" in
		--skip-packages)
			skip_packages="--skip-packages"

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

if [ $# -ne 2 ]; then
	usage

	exit 1
fi

username="$1"
hostname="$2"

if [ -z "$skip_packages" ]; then
	# Get our OS as up to date as we can first
	apt-get update
	apt-get upgrade -y
	apt-get autoremove

	# Next, install the packages we know we're going to need. They'll be configured later by the main install script.
	apt-get install -y \
		alacritty \
		discord \
		docker \
		docker-compose \
		exa \
		fish \
		golang \
		libsecret-1-0 \
		libsecret-1-dev \
		neovim \
		snapd \
		tmux

	snap install \
		gh \
		spotify

	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Build the git credential helper we need to use to store secrets in the Gnome keyring
make -C /usr/share/doc/git/contrib/credential/libsecret

# Change the user's shell to Fish. We'll configure it later in the main install script.
chsh "$username" -s $(command -v fish)

# Update system hostname
hostnamectl set-hostname "$hostname"
echo "127.0.0.1		localhost $hostname ${hostname}.local
::1		localhost $hostname ${hostname}.local
" > /etc/hosts
