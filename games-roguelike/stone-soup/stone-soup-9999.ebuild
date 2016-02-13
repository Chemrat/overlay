# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit games eutils git-2 autotools

EGIT_REPO_URI="https://github.com/crawl/crawl"

DESCRIPTION="a rogue-like game"
HOMEPAGE="http://crawl-ref.sourceforge.net/"

LICENSE="crawl"
SLOT="0"
KEYWORDS=""
IUSE="tiles"

DEPEND="sys-libs/ncurses
	tiles? ( media-gfx/pngcrush app-arch/advancecomp )"
RDEPEND="sys-libs/ncurses dev-lang/lua \
	>=dev-db/sqlite-3 sys-devel/bison \
	sys-devel/flex sys-libs/zlib \
	dev-util/pkgconfig \
	>=media-libs/sdl-image-1.2 >=media-libs/libsdl-1.2 \
	media-libs/freetype"

S="${WORKDIR}"

src_unpack() {
	git-2_src_unpack
}

src_compile() {
	cd crawl-ref/source
	use tiles && export TILES="y"
	emake prefix="${D}/${GAMES_PREFIX}" DATADIR="${D}/${GAMES_DATADIR}/crawl"
}

src_install() {
# Apparently, src_install ignores defined prefix. I'm too lazy to fix it right now
	cd crawl-ref/source
	use tiles && export TILES="y"
	emake prefix="${D}/${GAMES_PREFIX}" DATADIR="${D}/${GAMES_DATADIR}/crawl" install
	prepgamesdirs
}
