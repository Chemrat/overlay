# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib

[ "$PV" == "9999" ] && inherit git-r3

DESCRIPTION="C++ REST SDK by Microsoft"
HOMEPAGE="https://github.com/Microsoft/cpprestsdk/"

if [ "$PV" == "9999" ]; then
	EGIT_REPO_URI="https://github.com/Microsoft/cpprestsdk.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Microsoft/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="dev-libs/boost
	dev-libs/openssl:0"
RDEPEND="${DEPEND}"
