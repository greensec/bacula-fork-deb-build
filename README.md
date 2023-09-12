# bacula-fork-deb-build
Custom debian build of the unnamed bacula fork

## Supports:
 * buster
 * bullseye
 * bookworm

## Add Repo:
```
apt-get install software-properties-common wget lsb-release ca-certificates
wget -O /usr/share/keyrings/greensec.github.io-bacula-fork.key https://greensec.github.io/bacula-fork-deb-build/public.key
apt-add-repository "deb [signed-by=/usr/share/keyrings/greensec.github.io-bacula-fork.key arch=amd64] https://greensec.github.io/bacula-fork-deb-build/repo $(lsb_release -sc) main"
```
