# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BRAVE_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr sv
	sw ta te th tr uk vi zh-CN zh-TW"

inherit chromium-2 desktop pax-utils unpacker xdg-utils

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-nightly_${PV}_amd64.deb"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="selinux"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-arch/bzip2
	app-accessibility/at-spi2-core
	app-accessibility/at-spi2-atk
	dev-libs/atk
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/gmp
	dev-libs/gobject-introspection
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	dev-libs/libpthread-stubs
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nss
	dev-libs/nspr
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libepoxy
	>=media-libs/libpng-1.6.34:0
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	x11-libs/libxshmfence
	x11-libs/libXxf86vm
	x11-libs/pango
	x11-libs/pixman
	selinux? ( sec-policy/selinux-chromium )"
DEPEND="${RDEPEND}"

QA_PREBUILT="*"
BRAVE_HOME="opt/${BRAVE_PN}.com/${BRAVE_PN}-nightly"
QA_DESKTOP_FILE="usr/share/applications/brave-browser.*\\.desktop"
S="${WORKDIR}"

pkg_pretend() {
	use amd64 || die "This package is available for 64-bit only."
}

src_unpack() {
	unpack_deb ${A}
}

src_prepare() {
	pushd "${BRAVE_HOME}/locales" > /dev/null || die
		chromium_remove_language_paks
	popd > /dev/null || die

	mv usr/share/appdata usr/share/metainfo || die

	rm -rf usr/share/{gnome-control-center,menu} etc || die

	# mv usr/share/doc/${BRAVE_PN}-browser usr/share/doc/${PF}

	default
}

src_install() {
	# gzip -d usr/share/doc/${PF}/changelog.gz || die
	# gzip -d usr/share/man/man1/${BRAVE_PN}-browser-stable.1.gz || die
	# if [[ -L usr/share/man/man1/brave-browser.1.gz ]]; then
	# 	rm usr/share/man/man1/${BRAVE_PN}-browser.1.gz || die
	# 	dosym ${BRAVE_PN}-browser-stable.1 \
	# 		usr/share/man/man1/${BRAVE_PN}-browser.1
	# fi

	cp -r . "${ED}"

	for size in 128; do
		newicon -s ${size} ${BRAVE_HOME}/product_logo_${size}_nightly.png \
			${BRAVE_PN}-browser.png
	done

	pax-mark m "${BRAVE_HOME}/brave"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	elog "If upgrading from an 0.25.x release or earlier, note that Brave has changed configuration folders."
	elog "you will have to import your browser data from Settings -> People -> Import Bookmarks and Settings"
	elog "then choose \"Brave (old)\". All your settings, bookmarks, and passwords should return."
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
