# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

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

inherit cmake-utils

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	dobin "../"${P}"_build/OpenJazz" || die "dobin failed"

	insinto /usr/share/${PN}
	doins "openjazz.000" || die "doins failed"

	# optional
	#doicon ${PN}.xpm
	#make_desktop_entry ${PN} KickBall ${PN}.xpm
}
