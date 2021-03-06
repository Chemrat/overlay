# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs eutils

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="An IRC client for desktop environments"
HOMEPAGE="https://github.com/lakinduakash/linux-wifi-hotspot"
SLOT=0

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/lakinduakash/linux-wifi-hotspot.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/lakinduakash/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="BSD"

src_install() {
	emake DESTDIR="${D}" install
}
