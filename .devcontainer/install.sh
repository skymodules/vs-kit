#!/bin/bash

install_trunk() {
	sudo curl https://get.trunk.io -fsSL | bash
	sudo chown -R "${USER}":"${USER}" /usr/local/bin/trunk
}

install_dotenvx() {
	curl -fsS https://dotenvx.sh | sh
}

install_omp() {
	mkdir -p ~/bin &&
		curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin &&
		/home/vscode/bin/oh-my-posh font install meslo
}

main() {
	install_omp
	install_trunk
	install_dotenvx
}

main "$@"
