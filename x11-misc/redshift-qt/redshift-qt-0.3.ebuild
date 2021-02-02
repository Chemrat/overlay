# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

SRC_URI="https://github.com/Chemrat/redshift-qt/archive/v${PV}.tar.gz"
DESCRIPTION="Tray controls for redshift"
HOMEPAGE="https://github.com/Chemrat/redshift-qt/"
KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-qt/qtgui:5
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}
	x11-misc/redshift"

inherit qmake-utils

src_configure() {
	eqmake5 redshift-qt.pro
}

src_install() {
	dobin redshift-qt
}
