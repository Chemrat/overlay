# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3

DESCRIPTION="Simple wrapper around libcurl inspired by the Python Requests project"
HOMEPAGE="https://github.com/whoshuu/cpr"
EGIT_REPO_URI="git://github.com/whoshuu/cpr.git https://github.com/whoshuu/cpr.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_CURL=ON
		-DBUILD_CPR_TESTS=OFF
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	dolib.a ./lib/libcpr.a
	dodoc ./README.md ./AUTHORS

	doheader -r ./include/cpr
}
