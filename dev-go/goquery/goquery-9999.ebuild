# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs

EGO_SRC="github.com/PuerkitoBio/${PN}"
EGO_PN=${EGO_SRC}/...

KEYWORDS=""

DESCRIPTION="A little like that j-thing, only in Go"
HOMEPAGE="https://github.com/PuerkitoBio/goquery"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.1
	dev-go/cascadia"
