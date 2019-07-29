#!/bin/sh

set -e

build_and_install() {
    local dir="$1"
    local prefix="$2"
    local opts="$3"
    local ldflags="$4"
    local cppflags="$5"
    local build_target="$6"
    local install_target="${7:-install}"

    if ! [ -d "${dir}" ]
    then
	echo "${dir} does not exist, skipping"
	return 0
    fi

    echo "Build ${dir}"
    cd "${dir}"
    gmake distclean >/dev/null || true

    ./configure --prefix="${prefix}" ${opts} LDFLAGS="${ldflags}" CPPFLAGS="${cppflags}" > /dev/null
    gmake ${build_target} >/dev/null

    rm -rf "${prefix}"
    gmake ${install_target} >/dev/null
    echo "Done with ${dir}"
}

package_software() {
    echo 'Packaging software'
    cd /usr/local
    rm -f software.tar
    tar -cf software.tar /usr/local/amanda /usr/local/nrpe /usr/local/agentsmith
    echo 'Done packaging software'
}

build_and_install /usr/local/src/amanda-3.3.9 /usr/local/amanda "--libexecdir=/usr/local/amanda/libexec --localstatedir=/var --with-user=operator --with-group=operator --with-bsdtcp-security --with-bsdudp-security --with-ipv6 --with-amandates=/etc/amandadates --without-server --with-gnutar=/usr/local/bin/gtar --with-fqdn" "-L/usr/local/lib -R/usr/local/lib -L/usr/local/amanda/lib -R/usr/local/amanda/lib"

build_and_install /usr/local/src/nrpe-3.2.1 /usr/local/nrpe "--sysconfdir=/etc --with-piddir=/var/run/nrpe --with-nrpe-user=_nrpe --with-nrpe-group=_nrpe" "" "" nrpe install-daemon

build_and_install /usr/local/src/agentsmith-0.3 /usr/local/agentsmith "--sysconfdir=/etc --localstatedir=/var" -L/usr/local/lib -I/usr/local/include

package_software
