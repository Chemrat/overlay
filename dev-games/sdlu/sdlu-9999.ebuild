# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="The SDL Utility Library"
HOMEPAGE="https://bitbucket.org/sdlu/sdlu"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://bitbucket.org/sdlu/sdlu.git"
	KEYWORDS=""
else
	SRC_URI="https://bitbucket.org/${PN}/${PN}/downloads/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ZLIB"
SLOT="0"
IUSE="static-libs"

DEPEND="media-libs/libsdl2
	media-libs/sdl2-ttf"
RDEPEND="${DEPEND}"

multilib_src_configure() {
	local mycmakeargs=(
		-DBUILD_STATIC_LIBS=$(usex static-libs)
	)
	cmake-utils_src_configure
}
