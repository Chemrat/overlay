EAPI="5"

EGIT_REPO_URI="https://github.com/JosephP91/${PN}"

inherit qmake-utils git-r3

DESCRIPTION="Tray controls for redshift"
HOMEPAGE="https://github.com/Chemrat/redshift-qt/"
KEYWORDS=""
SLOT="0"
LICENSE="MIT"
IUSE=""

DEPEND="dev-qt/qtgui
  dev-qt/qtcore
  dev-qt/qtwidgets"
RDEPEND="${DEPEND}
  x11-misc/redshift"

src_configure() {
    eqmake5 redshift-qt.pro
}

src_install() {
    dobin redshift-qt
}
