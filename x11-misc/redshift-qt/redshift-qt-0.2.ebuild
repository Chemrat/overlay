# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

SRC_URI="https://github.com/Chemrat/redshift-qt/archive/v${PV}.tar.gz"
DESCRIPTION="Tray controls for redshift"
HOMEPAGE="https://github.com/Chemrat/redshift-qt/"
KEYWORDS="~x86 ~amd64"
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
