#!/bin/bash

main() {

	# check that dotenvx is installed if it is not fail and throw a crab error message
	if ! command -v dotenvx &> /dev/null; then
		echo "🦀 dotenvx is not installed"
		exit 1
	fi

	# check if doppler is actually installed if it isnt fail and throw a crab error message
	if ! command -v doppler &> /dev/null; then
		echo "🦀 Doppler is not installed"
		exit 1
	fi

	dotenvx run -f ~/.env -- doppler run -p "${DOPPLER_PROJECT}" -c "${DOPPLER_CONFIG}" -- echo "Doppler is running" || {
		echo "🦐 Failed to run Doppler"
	}
	
	dotenvx run -f ~/.env -- doppler run -p "${DOPPLER_PROJECT}" -c "${DOPPLER_CONFIG}" -- echo $GH_TOKEN gh auth login --with-token || {
		echo "🦐 Failed to authenticate GitHub"
	}

	dotenvx run -f ~/.env -- doppler run -p "${DOPPLER_PROJECT}" -c "${DOPPLER_CONFIG}" -- ~/ssh.sh || {
		echo "🦐 Failed to run SSH"
	}
}

main "$@"
# 🚀 SHELL
