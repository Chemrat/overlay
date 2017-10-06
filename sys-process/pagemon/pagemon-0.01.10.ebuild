# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="pagemon is an interactive memory/page monitoring tool"
HOMEPAGE="https://github.com/ColinIanKing/pagemon/"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/ColinIanKing/pagemon.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ColinIanKing/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="sys-libs/ncurses:*"
RDEPEND="${DEPEND}"

src_install() {
	dosbin pagemon
	dodoc README
}
