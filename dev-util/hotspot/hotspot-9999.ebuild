# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="https://github.com/KDAB/hotspot"

inherit cmake eutils git-r3

DESCRIPTION="a GUI for the Linux perf profiler"
HOMEPAGE="https://github.com/KDAB/hotspot"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-libs/elfutils
	>=dev-qt/qtcore-5.7.1
	>=dev-qt/qtgui-5.7.1
	>=dev-qt/qtwidgets-5.7.1
	>=dev-qt/qtnetwork-5.7.1
	>=dev-qt/qttest-5.7.1
	kde-frameworks/extra-cmake-modules
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/ki18n
	kde-frameworks/kio
	kde-frameworks/kitemmodels
	kde-frameworks/kitemviews
	kde-frameworks/threadweaver
	sys-devel/gettext
	"
DEPEND="${RDEPEND}"

src_install() {
	cmake_src_install

	make_desktop_entry hotspot Hotspot hotspot Development;
}
