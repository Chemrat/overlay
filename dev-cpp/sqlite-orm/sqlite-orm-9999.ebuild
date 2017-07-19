# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="SQLite ORM light header only library for modern C++"
HOMEPAGE="https://github.com/fnc12/sqlite_orm"
EGIT_REPO_URI="https://github.com/fnc12/sqlite_orm.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""

src_install() {
	doheader -r ./include/
}
