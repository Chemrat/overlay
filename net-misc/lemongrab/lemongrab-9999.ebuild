# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3 user

DESCRIPTION="Simple XMPP bot"
HOMEPAGE="https://github.com/Chemrat/lemongrab"
EGIT_REPO_URI="git://github.com/Chemrat/lemongrab.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

DEPEND="net-libs/gloox
		dev-cpp/cpr
		dev-libs/leveldb
		dev-libs/libevent
		dev-libs/jsoncpp
		dev-libs/boost
		dev-cpp/glog
		dev-cpp/cpptoml
		dev-libs/pugixml"

RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup lemongrab
	enewuser lemongrab -1 -1 -1 lemongrab
}

src_install() {
	default
	cmake-utils_src_install

	newinitd "${FILESDIR}"/initd lemongrab
	insinto /etc/lemongrab
	newins config.toml.default config.toml

	keepdir \
		/var/log/lemongrab \
		/var/lib/lemongrab

	fowners lemongrab:lemongrab /usr/bin/lemongrab || die "fowners failed"
	fowners lemongrab:lemongrab /var/{log,lib}/lemongrab || die "fowners failed"
	fowners lemongrab:lemongrab /etc/lemongrab || die "fowners failed"

	fperms 775 /usr/bin/lemongrab || die "fperms failed"
	fperms 770 /var/{log,lib}/lemongrab || die "fperms failed"
	fperms 770 /etc/lemongrab || die "fperms failed"
}
