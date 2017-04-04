# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit cmake-utils

DESCRIPTION="Networking drawing (whiteboarding) program"
HOMEPAGE="http://drawpile.net/"
SRC_URI="http://drawpile.net/files/src/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+client server gif"

REQUIRED_USE="|| ( client server )"

DEPEND="dev-qt/qtnetwork:5
		kde-frameworks/karchive:5
		client? (
			dev-qt/qtgui:5
			dev-qt/qtcore:5
			dev-qt/qtxml:5
			dev-qt/qtconcurrent:5
			dev-qt/qtmultimedia:5
			dev-qt/qtsvg:5
			dev-qt/qtwidgets:5
			dev-qt/qtdeclarative:5
		)
		gif? ( media-libs/giflib )"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCLIENT=$(usex client)
		-DSERVER=$(usex server)
	)

	cmake-utils_src_configure
}
