# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KDE_HANDBOOK="forceoptional"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="KDE Plasma panel applet for managing virtual desktops"
HOMEPAGE="https://github.com/wsdfhjxc/virtual-desktop-bar"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/wsdfhjxc/virtual-desktop-bar.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/wsdfhjxc/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
KEYWORDS=""
IUSE=""

CDEPEND="
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
