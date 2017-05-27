# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit golang-build golang-vcs user

EGO_VENDOR=( "github.com/bwmarrin/discordgo" )

EGO_PN="github.com/Chemrat/discordPromptBot"

KEYWORDS=""

DESCRIPTION="Simple discord prompt bot"
HOMEPAGE="https://github.com/Chemrat/discordPromptBot"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/go-1.8
	dev-go/discordgo"

pkg_setup() {
	enewgroup discordbot
	enewuser discordbot -1 -1 -1 discordbot
}

src_install() {
	default

	newinitd "${FILESDIR}"/initd discordbot
	newconfd "${FILESDIR}"/confd discordbot

	dobin discordPromptBot

	keepdir \
		/var/log/discordbot \
		/var/lib/discordbot

	fowners discordbot:discordbot /usr/bin/discordPromptBot || die "fowners failed"
	fowners discordbot:discordbot /var/{log,lib}/discordbot || die "fowners failed"

	fperms 770 /var/{log,lib}/discordbot || die "fperms failed"
}
