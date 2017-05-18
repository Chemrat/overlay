# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

EGIT_REPO_URI="https://github.com/crawl/crawl"

DESCRIPTION="a rogue-like game"
HOMEPAGE="http://crawl-ref.sourceforge.net/"

LICENSE="GPL-2 BSD BSD-2 public-domain CC0-1.0 MIT"
SLOT="0"
KEYWORDS=""
IUSE="debug luajit ncurses +tiles"

RDEPEND="
	dev-db/sqlite:3
	luajit? ( >=dev-lang/luajit-2.0.0 )
	sys-libs/zlib
	!ncurses? ( !tiles? ( sys-libs/ncurses:0 ) )
	ncurses? ( sys-libs/ncurses:0 )
	tiles? (
		media-fonts/dejavu
		media-libs/freetype:2
		media-libs/libpng:0
		media-libs/libsdl2[opengl,video]
		media-libs/sdl2-image[png]
		virtual/glu
		virtual/opengl
	)"
DEPEND="${RDEPEND}
	dev-lang/perl
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc
	tiles? (
		sys-libs/ncurses:0
	)"

S="${WORKDIR}/${P}/crawl-ref/source"

pkg_setup() {
	if use !ncurses && use !tiles ; then
		ewarn "Neither ncurses nor tiles frontend"
		ewarn "selected, choosing ncurses only."
		ewarn "Note that you can also enable both."
	fi
}

src_prepare() {
	eapply_user
#	epatch "${FILESDIR}"/${P}-respect-flags-and-compiler.patch

	rm -r contrib/{fonts,freetype,libpng,pcre,sdl2,sdl2-image,sdl2-mixer,sqlite,zlib} || die
}

src_compile() {
	export HOSTCXX=$(tc-getBUILD_CXX)

	# leave DATADIR at the top
	myemakeargs=(
		$(usex luajit "" "BUILD_LUA=yes") # luajit is not bundled
		USE_LUAJIT=$(usex luajit "yes" "")
		DATADIR="/usr/share/${PN}"
		V=1
		prefix="/usr"
		SAVEDIR="~/.crawl"
		$(usex debug "FULLDEBUG=y DEBUG=y" "")
		CFOPTIMIZE="${CXXFLAGS}"
		LDFLAGS="${LDFLAGS}"
		MAKEOPTS="${MAKEOPTS}"
		AR="$(tc-getAR)"
		RANLIB="$(tc-getRANLIB)"
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
		PKGCONFIG="$(tc-getPKG_CONFIG)"
		STRIP=touch
	)

	if use ncurses || (use !ncurses && use !tiles) ; then
		emake "${myemakeargs[@]}"
		# move it in case we build both variants
		use tiles && { mv crawl "${WORKDIR}"/crawl-ncurses || die ;}
	fi

	if use tiles ; then
		emake clean
		emake "${myemakeargs[@]}" "TILES=y"
	fi
}

src_install() {
	emake "${myemakeargs[@]}" $(usex tiles "TILES=y" "") DESTDIR="${D}" prefix_fp="" bin_prefix="${D}/usr/bin" install
	[[ -e "${WORKDIR}"/crawl-ncurses ]] && dobin "${WORKDIR}"/crawl-ncurses

	# don't relocate docs, needed at runtime
	rm -rf "${D}/usr/share/${PN}/docs/license"

	# icons and menu for graphical build
	if use tiles ; then
		doicon -s 48 "${S}"/debian/crawl.png
		make_desktop_entry crawl
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

	if use tiles && use ncurses ; then
		elog "Since you have enabled both tiles and ncurses frontends"
		elog "the ncurses binary is called 'crawl-ncurses' and the"
		elog "tiles binary is called 'crawl'."
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
}
