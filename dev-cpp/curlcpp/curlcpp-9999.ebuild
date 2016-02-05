EAPI=5

EGIT_REPO_URI="https://github.com/JosephP91/${PN}"

inherit cmake-utils git-r3

DESCRIPTION="An object-oriented C++ wrapper for cURL tool"
HOMEPAGE="https://github.com/JosephP91/curlcpp/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}"

src_prepare() {
  epatch "${FILESDIR}/fix_install.patch"
}
