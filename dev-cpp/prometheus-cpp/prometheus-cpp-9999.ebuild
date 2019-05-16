# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/jupp0r/${PN}"

inherit cmake-utils git-r3

DESCRIPTION="Prometheus Client Library for Modern C++"
HOMEPAGE="https://github.com/jupp0r/prometheus-cpp"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_configure() {
	cmake-utils_src_configure
}
