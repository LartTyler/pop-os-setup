#!/usr/bin/env bash

usage() {
	echo "$0 [options]"
	echo
	echo "Options:"
	echo "  --skip-packages"
	echo "    Do not install any new packages."
	echo
	echo "  --skip-keypair"
	echo "    Do not generate a new keypair"
	echo
	echo "  --hostname <hostname>"
	echo "    Set the system hostname to the specified value"
}

positional_args=()

while [ $# -ne 0 ]; do
	key="$1"

	case "$key" in
		--hostname)
			hostname="$2"
			shift

			;;

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

if [ $# -ne 0 ]; then
	echo "Unrecognized argument(s)"

	usage

	exit 1
fi

if [ -z "$skip_keypair" ]; then
	keypair_hostname="$hostname"

	if [ -z "$keypair_hostname" ]; then
		keypair_hostname="$(hostname)"
	fi

	ssh-keygen -t rsa -b 4096 -C "$(whoami)@${keypair_hostname}" -f "$HOME/.ssh/id_rsa"
fi

project_root=`dirname "$0"`

if [ -n "$hostname" ]; then
	hostname_arg="--hostname '$hostname'"
fi

sudo "$project_root"/privileged.sh "$(whoami)" $skip_packages $hostname_arg

"$project_root"/configs.sh

