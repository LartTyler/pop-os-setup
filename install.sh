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

sudo "$project_root"/privileged.sh "$(whoami)" "$hostname" $skip_packages

"$project_root"/configs.sh

