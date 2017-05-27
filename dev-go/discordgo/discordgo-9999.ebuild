# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs

EGO_PN="github.com/bwmarrin/discordgo"

KEYWORDS=""

DESCRIPTION="Discord Go library"
HOMEPAGE="https://github.com/bwmarrin/discordgo"

LICENSE="BSD"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.8
	dev-go/go-crypto
	dev-go/gorilla-websocket"
