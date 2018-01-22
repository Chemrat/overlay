# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="cpptoml is a header-only library for parsing TOML"
HOMEPAGE="https://github.com/skystrife/cpptoml"
EGIT_REPO_URI="https://github.com/skystrife/cpptoml.git"

LICENSE="cpptoml"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	doheader ./include/*.h
}
