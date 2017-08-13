# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs

EGO_SRC="github.com/andybalholm/${PN}"
EGO_PN=${EGO_SRC}/...

KEYWORDS=""

DESCRIPTION="CSS selector library in Go"
HOMEPAGE="https://github.com/andybalholm/cascadia"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.1
	dev-go/go-net"
