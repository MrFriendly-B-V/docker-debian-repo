#!/bin/bash

if [ -z "$RELEASE" ]; then
	echo "Error: RELEASE not set."
	echo
	exit 1
fi >&2

set -ueo pipefail

# import gpg key
echo "Importing GPG Key"
gpg --yes --batch  --import /mnt/key.gpg

cd /var/www/repos/apt/debian

# copy repo information
cp /mnt/distributions conf/

# export repo public key
gpg --no-tty -a --export -o repo.gpg

# import packages
reprepro includedeb "$RELEASE" /mnt/*.deb
kill $(pidof gpg-agent)
echo
echo

echo 'Serving packages:'
reprepro list "$RELEASE"
echo
echo

# start apache2
apachectl start

# show logs
tail -F /var/log/apache2/error.log /var/log/apache2/access.log
