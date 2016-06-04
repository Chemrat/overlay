# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

EGIT_REPO_URI="https://github.com/CLD2Owners/${PN}"

inherit git-r3

DESCRIPTION="CLD2 probabilistically detects over 80 languages in Unicode text"
HOMEPAGE="https://github.com/CLD2Owners/cld2"
KEYWORDS=""
SLOT="0"
LICENSE="Apache-2.0"
IUSE=""

#DEPEND=""
#RDEPEND="${DEPEND}"

src_compile() {
	cd internal
	./compile_libs.sh || die "compile_libs.sh failed"
}

src_install() {
	dolib internal/*.so

	insinto /usr/include/cld2/public
	doins public/*.h
	insinto /usr/include/cld2/private
	doins private/*.h
}
