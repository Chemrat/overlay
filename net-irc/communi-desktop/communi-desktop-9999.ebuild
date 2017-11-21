# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="An IRC client for desktop environments"
HOMEPAGE="https://github.com/communi/communi-desktop"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/communi/communi-desktop.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/communi/communi-desktop/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"
SLOT="0"

DEPEND="net-irc/libcommuni[qt5]"
RDEPEND="${DEPEND}"

src_configure() {
	default
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
