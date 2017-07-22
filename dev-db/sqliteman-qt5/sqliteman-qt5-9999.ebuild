# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Powerful GUI manager for the Sqlite3 database (rough qt5 port)"
HOMEPAGE="https://sourceforge.net/projects/sqliteman/"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/Chemrat/sqliteman.git"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5[sqlite]
	x11-libs/qscintilla:=[qt5(-)]"
DEPEND="${RDEPEND}"
S=${S}/Sqliteman

src_prepare() {
	# remove bundled lib
	rm -rf "${S}"/${PN}/qscintilla2 || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWANT_INTERNAL_QSCINTILLA=0
		-DWANT_INTERNAL_SQLDRIVER=0
	)
	cmake-utils_src_configure
}
