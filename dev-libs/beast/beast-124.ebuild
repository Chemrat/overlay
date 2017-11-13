# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="Simple wrapper around libcurl inspired by the Python Requests project"
HOMEPAGE="https://github.com/boostorg/beast"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/boostorg/beast.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/boostorg/beast/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Boost-1.0"
SLOT="0"

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local mycmakeargs=(
		-DBeast_BUILD_EXAMPLES=OFF
		-DBeast_BUILD_TESTS=OFF
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	dodoc README.md LICENSE_1_0.txt

	cd include
	doheader -r boost/
}
