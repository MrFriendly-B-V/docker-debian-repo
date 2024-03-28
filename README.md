# debian-repo
Forked from [casperklein/docker-debian-repo](https://github.com/casperklein/docker-debian-repo)

Modified for use by Mr.Friendly:
- Debian 12
- Experimental reprepro 5.4 to support multiple versions of any one package

Docker image for running a Debian repository based on [this](https://wiki.debian.org/DebianRepository/SetupWithReprepro) wiki page.

## Run a demo repository

    # Passphrase for GPG key: insecure
    docker run --rm -it -p 80:80 -v $PWD/repo-demo:/mnt:ro -e RELEASE=bookworm casperklein/debian-repo

## Build Docker image (optional)

    ./build.sh

## Create and serve repository

1. Copy repo-demo

    `cp -a repo-demo myrepo`

2. Create/Export new GPG key

    `gpg --gen-key`

    `gpg -a -o myrepo/key.gpg --export-secret-keys <ID>`

3. Edit *myrepo/distributions* to your needs

    At least, you have to set *SignWith* to your GPG subkey ID

    `gpg --list-secret-key --with-subkey-fingerprint # show subkey ID`

    If you change "Codename", you have to adjust `-e RELEASE=` below accordingly.

4. Serve repository via HTTP

    `docker run --rm -it -p 80:80 -v $PWD/myrepo:/mnt:ro -e RELEASE=bookworm casperklein/debian-repo`

## Setup client

### Import repository public key

    wget -O - http://HOSTNAME/repos/apt/debian/repo.gpg | apt-key add -

### Add repository to apt sources

    echo "deb http://HOSTNAME/repos/apt/debian/ $(lsb_release -cs) main" >> /etc/apt/sources.list

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-blue.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-blue.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-blue.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-blue.svg
[version-shield]: https://img.shields.io/github/v/release/casperklein/docker-debian-repo
[image-size-shield]: https://img.shields.io/docker/image-size/casperklein/debian-repo/latest
