#!/bin/bash

source ~/.env # GITHUB TOKEN

alias dotenvx=./dotenvx

install_trunk() {
	sudo curl https://get.trunk.io -fsSL | bash
	sudo chown -R "${USER}":"${USER}" /usr/local/bin/trunk
}

install_dotenvx() {
	curl -sfS "https://dotenvx.sh" | sh
	sudo chown -R "${USER}":"${USER}" /usr/local/bin/dotenvx
}

install_doppler() {
	(curl -Ls --tlsv1.2 --proto "=https" --retry 3 https://cli.doppler.com/install.sh || wget -t 3 -qO- https://cli.doppler.com/install.sh) | sudo sh
}

install_omp() {
	mkdir -p ~/bin &&
		curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin &&
		"${HOME}/bin/oh-my-posh" font install meslo
}

install_global_packages() {
	npm install -g nodemon
	npm install -g typescript
	npm install -g ts-node
	npm install -g tsx
}

install() {
	install_omp
	install_trunk && trunk --version
	install_dotenvx && dotenvx --version
	install_doppler && doppler --version
}

main() {
	echo "postCreate: ${HOME}"

    install && echo "Installed tools successfully."
	alias dotenvx=${HOME}/dotenvx 

	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- echo "Doppler is running"
	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- gh auth status || echo $GH_TOKEN gh auth login --with-token
	dotenvx run -f ~/.env -- doppler run -p $DOPPLER_PROJECT -c "$DOPPLER_CONFIG" -- ~/ssh.sh
}

main "$@"
# 🚀 SHELL
