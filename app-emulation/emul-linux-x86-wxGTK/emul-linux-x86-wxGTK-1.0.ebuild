# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit emul-linux-x86

BASE_PV="2.8"
SRC_URI="http://github.com/downloads/wishstudio/flora/${P}.tar.xz"

LICENSE="wxWinLL-3 GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

DEPEND=""
RDEPEND="app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-gtklibs
	app-emulation/emul-linux-x86-medialibs
	app-emulation/emul-linux-x86-opengl
	app-emulation/emul-linux-x86-sdl
	app-emulation/emul-linux-x86-xlibs"

src_prepare() {
	ALLOWED="(/usr/bin|/usr/lib32/wx)"
	emul-linux-x86_src_prepare

	rm "${S}"/usr/bin/wxrc-"${BASE_PV}"
	mv "${S}"/usr/bin/wx-config-"${BASE_PV}" "${S}"/usr/bin/wx-config-32 || die
}
