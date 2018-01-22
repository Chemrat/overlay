# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs

EGO_PN="github.com/gorilla/websocket"

KEYWORDS=""

DESCRIPTION="A WebSocket implementation for Go"
HOMEPAGE="https://github.com/gorilla/websocket"

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.8"
