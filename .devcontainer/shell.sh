# 🔐 SSH KEY
SSH_KEY_DIR="$HOME/.ssh"
SSH_KEY_FILE="$SSH_KEY_DIR/github_ssh_key"
GITHUB_USER=$(gh auth status 2>&1 | grep 'Logged in to github.com as' | awk '{print $6}')
HOSTNAME=$(hostname)
KEY_COMMENT="${GITHUB_USER}@${HOSTNAME}"

# Function to check if SSH agent is running
start_ssh_agent() {
	if [[ -z ${SSH_AUTH_SOCK} ]]; then
		eval "$(ssh-agent -s)"
	fi
}

# Function to check if SSH key exists and add to the agent
manage_ssh_key() {
	if [ ! -f "$SSH_KEY_FILE" ]; then
		echo "Creating new SSH key: $SSH_KEY_FILE"
		ssh-keygen -t rsa -b 4096 -C "$KEY_COMMENT" -f "$SSH_KEY_FILE" -N ""
	fi

	# Add key to SSH agent if not already added
	ssh-add -l | grep -q "$SSH_KEY_FILE" || ssh-add "$SSH_KEY_FILE"
}

# Function to check if the SSH key is synced with GitHub
sync_ssh_key_to_github() {
	GITHUB_KEYS=$(gh ssh-key list | grep "$KEY_COMMENT")

	if [ -z "$GITHUB_KEYS" ]; then
		echo "Syncing SSH key to GitHub"
		gh ssh-key add "$SSH_KEY_FILE.pub" --title "$KEY_COMMENT"
	fi
}

validate_tooling() {
	# make sure dotenvx is installed
	if ! command -v dotenvx &>/dev/null; then
		echo "🛑 Shell Error: dotenvx could not be found. Please install it first."
		exit 1
	fi

	# make sure doppler is installed
	if ! command -v doppler &>/dev/null; then
		echo "🛑 Shell Error: doppler could not be found. Please install it first."
		exit 1
	fi

	# make sure gh is installed
	if ! command -v gh &>/dev/null; then
		echo "🛑 Shell Error: gh could not be found. Please install it first."
		exit 1
	fi
}

setup_ssh() {
	start_ssh_agent
	echo "🔑 SSH agent started."

	manage_ssh_key
	echo "🔑 SSH key managed."

	sync_ssh_key_to_github
	echo "🔑 SSH key synced to GitHub."
}

main() {
	set -e # Exit immediately if any command fails

	# validate tooling
	validate_tooling || {
		echo "🛑 Shell Error: Required tools are not installed. Please install them first."
		exit 1
	}

	# authenticate with GitHub CLI
	dotenvx run --quiet -f /home/${USER}/.env -- doppler run -- doppler secrets get GH_TOKEN --plain | gh auth login --with-token

	# setup SSH key
	setup_ssh || {
		echo "🛑 Shell Error: SSH key setup failed."
		exit 1
	}
}

main "$@"
# 🚀 SHELL
