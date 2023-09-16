#!/bin/sh
# To add this repository please do:

if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

${SUDO} apt-get update
${SUDO} apt-get -y install software-properties-common lsb-release ca-certificates wget
${SUDO} wget -O /usr/share/keyrings/greensec.github.io-bacula-fork.key https://greensec.github.io/bacula-fork-deb-build/public.key
${SUDO} apt-add-repository "deb [signed-by=/usr/share/keyrings/greensec.github.io-bacula-fork.key arch=amd64] https://greensec.github.io/bacula-fork-deb-build/repo $(lsb_release -sc) main"
${SUDO} apt-get update
