# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="Discord API library for C++ using boost libraries"
HOMEPAGE="https://github.com/foxcpp/Hexicord"

EGIT_REPO_URI="https://github.com/foxcpp/Hexicord.git"
KEYWORDS=""

EGIT_SUBMODULES=( '*' )

LICENSE="MIT"
SLOT="0"
IUSE="static-libs
	debug"

DEPEND="dev-libs/boost:=
	dev-libs/openssl:="
RDEPEND="${DEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local mycmakeargs=(
		-DHEXICORD_STATIC=$(usex static-libs ON OFF)
		-DHEXICORD_SHARED=ON
		-DHEXICORD_DEBUG_LOG=$(usex debug)
	)
	cmake-utils_src_configure
}
