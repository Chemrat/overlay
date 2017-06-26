# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="Simple wrapper around libcurl inspired by the Python Requests project"
HOMEPAGE="https://github.com/whoshuu/cpr"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="git://github.com/whoshuu/cpr.git https://github.com/whoshuu/cpr.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/whoshuu/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

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
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
	)
	cmake-utils_src_configure
}

multilib_src_install() {
	use static-libs && dolib.a ./lib/libcpr.a
	use static-libs || dolib.so ./lib/libcpr.so
	dodoc README.md AUTHORS VERSION CONTRIBUTING.md
	insinto /usr/share/${PN}/
	sed -i -e '14s/cpr.h/include\/cpr.h/' cpr-config.cmake
	doins cpr-config.cmake

	doheader -r ./include/cpr
}
