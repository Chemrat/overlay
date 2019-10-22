# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/ishovkun/SierraBreeze"

inherit cmake-utils git-r3

DESCRIPTION="OSX-like window decoration for KDE Plasma written in C++"
HOMEPAGE="https://github.com/ishovkun/SierraBreeze"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

RDEPEND="kde-plasma/kwin"
DEPEND="${RDEPEND}"
