#!/bin/bash

# set default install directory
DEFAULT_INSTALL_DIR="/home/vscode/hashicorp"
product=${1:-terraform}
version=${2-}

reset_install_dir() {
	# create the DEFAULT_INSTALL_DIR if not already exists
	mkdir -p "${DEFAULT_INSTALL_DIR}"
}

install() {
	# Get the latest release version
	version=$(curl -s "https://releases.hashicorp.com/${product}/index.json" | jq -r ".versions[].version" | grep -E "^[0-9.]+$" | sort -V | tail -1 || true)
	PRODUCT_INSTALL_DIR="${DEFAULT_INSTALL_DIR}/${product}/${version}"
	PRODUCT_ZIP="${PRODUCT_INSTALL_DIR}/${product}_${version}_linux_amd64.zip"

	rm -rf "${PRODUCT_INSTALL_DIR}" && mkdir -p "${PRODUCT_INSTALL_DIR}"
	curl -sLo "${PRODUCT_ZIP}" "https://releases.hashicorp.com/${product}/${version}/${product}_${version}_linux_amd64.zip"

	# unzip all contents in the ${PRODUCT_INSTALL_DIR}
	unzip -o "${PRODUCT_ZIP}" -d "${PRODUCT_INSTALL_DIR}"
	sudo cp "${PRODUCT_INSTALL_DIR}/${product}" "/usr/local/bin/${product}"

	# make sure the new binary is in the PATH
	# and update any existing PATH entries present
	if ! grep -q "/usr/local/bin/${product}" ~/.bashrc; then
		echo "${product} binary not found in PATH, adding..."
		echo "export PATH=\$PATH:/usr/local/bin/${product}" >>~/.bashrc
	elif
		echo "Updating PATH to include /usr/local/bin/${product}"
		grep -q "/usr/local/bin/${product}" ~/.bashrc
	then
		echo "PATH already includes /usr/local/bin/${product}"
		sed -i "s|/usr/local/bin/${product}|/usr/local/bin/${product}|" ~/.bashrc
	fi

	# as a backup setup a proper alias for the product
	if ! grep -q "${product}" ~/.bashrc; then
		echo "alias ${product}=/usr/local/bin/${product}" >>~/.bashrc
	fi

	echo "Install Complete."
}

clean() {
	# clean up
	rm -rf "${PRODUCT_INSTALL_DIR}"
	rm -rf "${PRODUCT_ZIP}"
	echo "Clean up Complete."
}

main() {
	# install sequence
	reset_install_dir && install && tree -L 4 "${DEFAULT_INSTALL_DIR}" && clean
}

main "$@"
