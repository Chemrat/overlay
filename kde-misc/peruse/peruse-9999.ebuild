# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="A comic book viewer based on Frameworks 5, for use on multiple form factors"
HOMEPAGE="https://peruse.kde.org/"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep kfilemetadata)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep baloo)
	$(add_frameworks_dep karchive)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtopengl)
	$(add_qt_dep qtsql)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"
