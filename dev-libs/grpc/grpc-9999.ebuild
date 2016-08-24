# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
EGIT_REPO_URI="https://github.com/grpc/grpc.git"

inherit git-r3

DESCRIPTION="The C based gRPC (C++, Node.js, Python, Ruby, Objective-C, PHP, C#)"
HOMEPAGE="http://www.grpc.io/"
SRC_URI=""

LICENSE="grpc"
SLOT="0"
KEYWORDS="~x86 ~amd64"

# FIXME Can't be bothered to do it right now
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake install prefix="${D}"/usr/
}
