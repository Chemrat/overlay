# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

SRC_URI="https://github.com/rheit/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="Standalone version of ZDoom's internal node builder"
HOMEPAGE="http://zdoom.org/"
KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-libs/zlib"
RDEPEND="$DEPEND"

src_install() {
	dobin "${BUILD_DIR}/zdbsp" || die "doins failed"
}
