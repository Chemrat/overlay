# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3

DESCRIPTION="Multiplayer game network engine, TES3MP fork"
HOMEPAGE="https://github.com/TES3MP/RakNet"

EGIT_REPO_URI="https://github.com/TES3MP/RakNet.git"
KEYWORDS=""

LICENSE="BSD"
SLOT="0"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DRAKNET_ENABLE_SAMPLES=OFF
		-DRAKNET_ENABLE_STATIC=$(usex static-libs ON OFF)
	)

	cmake-multilib_src_configure
}

multilib_src_install() {
	use static-libs && dolib.a ./lib/libRakNetLibStatic.a
	dolib.so ./lib/libraknet.so*

	doheader -r ./include/*
}
