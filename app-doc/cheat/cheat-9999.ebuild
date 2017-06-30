# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 )

EGIT_REPO_URI="https://github.com/chrisallenlane/${PN}"

inherit git-r3 distutils-r1

DESCRIPTION="cheat allows you to create and view interactive cheatsheets on the command-line"
HOMEPAGE="https://github.com/chrisallenlane/cheat/"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
