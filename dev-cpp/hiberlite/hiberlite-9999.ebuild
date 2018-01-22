# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="C++ ORM for SQLite"
HOMEPAGE="https://github.com/paulftw/hiberlite"
EGIT_REPO_URI="git@github.com:paulftw/hiberlite.git https://github.com/paulftw/hiberlite.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	emake INSTALL_PREFIX="${D}/usr" install
}
