EAPI="5"

SRC_URI="https://github.com/Chemrat/openjazz/archive/${PV}.tar.gz"
DESCRIPTION="Free engine for Jazz Jackrabbit game"
HOMEPAGE="http://alister.eu/jazz/oj/"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/openjazz-${PV}"

DEPEND="media-libs/libsdl
  media-libs/libmodplug"
RDEPEND="$DEPEND"

inherit games
inherit cmake-utils

src_configure() {
    cmake-utils_src_configure
}

src_install() {
dogamesbin "../"${P}"_build/OpenJazz" || die "dogamesbin failed"

insinto "${GAMES_DATADIR}"/${PN}
doins "openjazz.000" || die "doins failed"

ewarn ""
ewarn "You need to put original Jazz Jackrabbit game files in ${GAMES_DATADIR}/${PN}"
ewarn ""

# optional
#doicon ${PN}.xpm
#make_desktop_entry ${PN} KickBall ${PN}.xpm

prepgamesdirs
}
