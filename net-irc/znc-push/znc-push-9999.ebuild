# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Push notification service module for ZNC"
HOMEPAGE="https://noswap.com/projects/znc-push"
EGIT_REPO_URI="https://github.com/jreese/znc-push.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

src_install() {
	insinto /usr/$(get_libdir)/znc/
	doins *.so
}
