# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/Chemrat/${PN}"

inherit qmake-utils git-r3

DESCRIPTION="Tray controls for redshift"
HOMEPAGE="https://github.com/Chemrat/redshift-qt/"
KEYWORDS=""
SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	x11-misc/redshift"

src_configure() {
	eqmake5 redshift-qt.pro
}

src_install() {
	dobin redshift-qt
}
