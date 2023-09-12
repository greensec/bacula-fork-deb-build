# Bacula Fork Debian Repository
Debian build of the `unnamed` bacula (as its name is a registered trademark) fork.

## Currently supported debian versions:
 * stretch (only old and outdated version)
 * buster
 * bullseye
 * bookworm

## How to add this repository:

### Automatically via script
```
wget -O- https://greensec.github.io/bacula-fork-deb-build/add-repository.sh | bash
```

### Manually
```
apt-get install software-properties-common wget lsb-release ca-certificates
wget -O /usr/share/keyrings/greensec.github.io-bacula-fork.key https://greensec.github.io/bacula-fork-deb-build/public.key
apt-add-repository "deb [signed-by=/usr/share/keyrings/greensec.github.io-bacula-fork.key arch=amd64] https://greensec.github.io/bacula-fork-deb-build/repo $(lsb_release -sc) main"
```
