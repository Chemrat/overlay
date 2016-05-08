# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit git-r3

EGIT_REPO_URI="https://chemrat@bitbucket.org/Torr_Samaho/acc.git"

DESCRIPTION="Zandronum Action Code script Compiler"
HOMEPAGE="https://bitbucket.org/Torr_Samaho/acc/"

LICENSE="ACC"

SLOT="0"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin acc

	insinto /usr/share/acc
	doins *.acs
}
