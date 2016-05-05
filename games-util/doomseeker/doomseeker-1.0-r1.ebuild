# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils

DESCRIPTION="Internet Doom server browser"
HOMEPAGE="http://doomseeker.drdteam.org/"
SRC_URI="http://doomseeker.drdteam.org/files/${P}_src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fake-plugins legacy-plugins"

DEPEND="app-arch/bzip2
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}_src"

src_prepare() {
	#libs go into libdir, not share
	sed -i -e "s:DESTINATION share/:DESTINATION /usr/lib/:" src/plugins/PluginFooter.txt
	sed -i -e "s:INSTALL_PREFIX \"/share/doomseeker/\":\"/usr/lib/doomseeker/\":" src/core/main.cpp

	#fix some paths
	sed -i -e "s:LIBRARY DESTINATION lib:LIBRARY DESTINATION /usr/lib:" src/wadseeker/CMakeLists.txt
	sed -i -e "s:Icon=/usr/local:Icon=/usr:" media/Doomseeker.desktop
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="/usr"
		$(cmake-utils_use_build fake-plugins FAKE_PLUGINS)
		$(cmake-utils_use_build legacy-plugins LEGACY_PLUGINS)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
