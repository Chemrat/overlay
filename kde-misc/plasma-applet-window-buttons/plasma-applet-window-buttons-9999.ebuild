# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

KDE_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

EGIT_REPO_URI="https://github.com/psifidotos/applet-window-buttons"

DESCRIPTION="Plasma 5 applet in order to show window buttons in your panels"
HOMEPAGE="https://github.com/psifidotos/applet-window-buttons"

LICENSE="GPL-2"
KEYWORDS=""
IUSE=""

CDEPEND="
	$(add_frameworks_dep kdecoration)
	$(add_frameworks_dep kdeclarative)
	$(add_frameworks_dep plasma)
	$(add_frameworks_dep ki18n)
	$(add_qt_dep qtqml)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtquick)
"
DEPEND="${CDEPEND}
	sys-devel/gettext
"
