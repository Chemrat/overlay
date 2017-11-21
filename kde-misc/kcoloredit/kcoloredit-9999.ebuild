# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_DOC_DIR="doc/user"
EGIT_BRANCH="frameworks"

inherit kde5

DESCRIPTION="Tool for editing color palettes"
HOMEPAGE="https://www.kde.org/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~x86"

CDEPEND="
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdoctools)
	$(add_frameworks_dep kconfig)

	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
DEPEND="${CDEPEND}
"
RDEPEND="${CDEPEND}
	!media-gfx/kcoloredit:4
"
