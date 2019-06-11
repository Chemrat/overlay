# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils pax-utils

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="https://vscode-update.azurewebsites.net/${PV}/linux-x64/stable -> ${P}_amd64.tar.gz"
RESTRICT="mirror strip"

LICENSE="Microsoft"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	media-libs/libpng:0/16
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	gnome-base/gconf
	sys-apps/ripgrep
"

RDEPEND="${DEPEND}"

pkg_setup(){
	use amd64 && S="${WORKDIR}/VSCode-linux-x64" || S="${WORKDIR}/VSCode-linux-ia32"
}

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "/opt/${PN}/code" "/usr/bin/visual-studio-code"
	make_wrapper "${PN}" "/opt/${PN}/code"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon "${FILESDIR}/${PN}.png"
	fperms +x "/opt/${PN}/code"
	fperms +x "/opt/${PN}/libnode.so"
	fperms +x "/opt/${PN}/libffmpeg.so"
	insinto "/usr/share/licenses/${PN}"
	newins "resources/app/LICENSE.rtf" "LICENSE.rtf"
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
}
