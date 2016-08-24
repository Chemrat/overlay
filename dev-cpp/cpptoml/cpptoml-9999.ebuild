# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-2

DESCRIPTION="cpptoml is a header-only library for parsing TOML"
HOMEPAGE="https://github.com/skystrife/cpptoml"
EGIT_REPO_URI="git://github.com/skystrife/cpptoml.git https://github.com/skystrife/cpptoml.git"

LICENSE="cpptoml"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	insinto /usr/include/
	doins ./include/*.h
}
