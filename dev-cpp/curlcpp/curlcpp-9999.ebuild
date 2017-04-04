# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/JosephP91/${PN}"

inherit cmake-utils git-r3

DESCRIPTION="An object-oriented C++ wrapper for cURL tool"
HOMEPAGE="https://github.com/JosephP91/curlcpp/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=1
	)
	cmake-utils_src_configure
}
