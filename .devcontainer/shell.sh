#!/bin/bash

source ~/.env # GITHUB TOKEN

main() {
	set -e # Exit immediately if any command fails

	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- echo "Doppler is running"
	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- gh auth status || echo "Not authenticated to GitHub CLI. Please authenticate first."
	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- ~/ssh.sh
}

main "$@"
# 🚀 SHELL
