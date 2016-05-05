# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="multiplayer game, port of Amiga Knights"
HOMEPAGE="http://www.knightsgame.org.uk/"
SRC_URI="http://www.knightsgame.org.uk/files/${PN}_${PV}_src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +game server"

S=${WORKDIR}/${PN}_${PV}_src

DEPEND="dev-libs/boost
	media-libs/libsdl
	game? ( media-libs/fontconfig
	media-libs/freetype
	( || ( net-misc/curl[gnutls] net-misc/curl[ssl] ) ) )"
RDEPEND="${DEPEND}"

src_compile() {
	emake PREFIX="${D}" BIN_DIR=/usr/bin DATA_DIR=/usr/share/"${PN}" DOC_DIR=/usr/share/doc/"${P}"
}

src_install() {
	if use game ; then
		emake install_knights PREFIX="${D}" BIN_DIR="${D}/usr/bin" DATA_DIR="${D}/usr/share/${PN}" DOC_DIR="${D}"/usr/share/doc/"${P}"
	fi

	if use server; then
		emake install_server PREFIX="${D}" BIN_DIR="${D}/usr/bin" DATA_DIR="${D}/usr/share/${PN}" DOC_DIR="${D}"/usr/share/doc/"${P}"
	fi

	if use doc; then
		dohtml -r docs/manual || die "dohtml failed"
		dohtml docs/style_new.css || die "dohtml failed"
	fi

	dodoc docs/ACKNOWLEDGMENTS.txt docs/CHANGELOG.txt docs/README.txt README.txt docs/third_party_licences/README.txt || die "dodoc failed"
	doicon docs/manual/images/pentagram.png
	make_desktop_entry knights "Knights" pentagram "Games;ActionGame;"
	make_desktop_entry knights_server "Knights server" pentagram "Games;ActionGame;"
	prepgamesdirs
}
