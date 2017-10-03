# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3

DESCRIPTION="CallFF library allows to making foreign functions calls."
HOMEPAGE="https://github.com/Koncord/CallFF"

EGIT_REPO_URI="https://github.com/Koncord/CallFF.git"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	use static-libs && dolib.a  ./src/libcallff.a
	use static-libs || dolib.so ./src/libcallff.so
	dodoc README.md
	doheader -r ./include/*
}
