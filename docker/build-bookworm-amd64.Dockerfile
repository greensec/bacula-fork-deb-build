FROM debian:bookworm-slim

ADD assets/dpkg_nodoc /etc/dpkg/dpkg.cfg.d/90_nodoc
ADD assets/dpkg_nolocale /etc/dpkg/dpkg.cfg.d/90_nolocale
ADD assets/apt_nocache /etc/apt/apt.conf.d/90_nocache
ADD assets/apt_mindeps /etc/apt/apt.conf.d/90_mindeps

ARG DEBIAN_FRONTEND=noninteractive

# default dependencies
RUN	set -e \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget ca-certificates gnupg quilt ccache distcc dpkg-cross \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/* /var/log/*

# install package deps
RUN set -e \
    && echo "deb-src http://deb.debian.org/debian bookworm main" >/etc/apt/sources.list.d/bookworm-source.list \
    && echo "deb http://http.debian.net/debian bookworm-backports main" >/etc/apt/sources.list.d/bookworm-backports.list \
    && wget -O- http://download.bareos.org/current/Debian_12/add_bareos_repositories.sh | bash \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y git git-buildpackage cmake \
    && DEBIAN_FRONTEND=noninteractive apt-get build-dep -y bareos \
    && DEBIAN_FRONTEND=noninteractive apt-get build-dep -y python-bareos \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/* /var/log/*
