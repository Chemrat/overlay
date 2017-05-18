# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils unpacker multilib

DESCRIPTION="TeamSpeak Client - Voice Communication Software"
HOMEPAGE="http://www.teamspeak.com/"
SRC_URI="
	amd64? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_amd64-${PV/_/-}.run )
	x86? ( http://ftp.4players.de/pub/hosted/ts3/releases/${PV}/TeamSpeak3-Client-linux_x86-${PV/_/-}.run )"

LICENSE="teamspeak3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa pulseaudio +system-openssl"

REQUIRED_USE="|| ( alsa pulseaudio )"

RDEPEND="
	dev-libs/quazip[-qt4,qt5]
	>=dev-qt/qtcore-5.6:5
	>=dev-qt/qtgui-5.6:5[accessibility,xcb,dbus]
	>=dev-qt/qtnetwork-5.6:5
	>=dev-qt/qtsql-5.6:5[sqlite]
	>=dev-qt/qtwidgets-5.6:5
	>=dev-qt/qtwebchannel-5.6:5
	>=dev-qt/qtwebengine-5.6:5[geolocation,widgets]
	>=dev-qt/qtdeclarative-5.6:5
	system-openssl? (
		>=dev-libs/openssl-1.0.2k:0
		!>=dev-libs/openssl-1.1
	)
	sys-libs/glibc
	sys-libs/zlib
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"

RESTRICT="mirror strip"

S="${WORKDIR}"

pkg_nofetch() {
	elog "Please download ${A}"
	elog "from ${HOMEPAGE}?page=downloads and place this"
	elog "file in ${DISTDIR}"
}

src_prepare() {
	# Remove the qt-libraries as they just cause trouble with the system's Qt, see bug #328807.
	rm libQt* || die "Couldn't remove bundled Qt libraries."

	rm -r platforms sqldrivers qt.conf qtwebengine_locales xcbglintegrations || die "Couldn't remove bundle Qt files."

	# Remove unwanted soundbackends.
	if ! use alsa ; then
		rm soundbackends/libalsa* || die
	fi

	if ! use pulseaudio ; then
		rm soundbackends/libpulseaudio* || die
	fi

	# Remove quazip
	rm libquazip.so || die

	# Remove libudev (previously needed for libQt5XcbQpa)
	rm libudev.so.0 || die

	# Remove libsrtp and libsnappy (previously needed for libQt5WebEngineCore and libQt5WebEngineWidgets)
	rm libsrtp.so.0 libsnappy.so.1 || die

	# Replace QtWebEngineProcess with a link to our own version.
	# See src_install.
	rm QtWebEngineProcess || die

	if use system-openssl; then
		rm libssl.so.1.0.0 libcrypto.so.1.0.0 || die
	fi

	# Rename the tsclient to its shorter version, required by the teamspeak3 script we install.
	mv ts3client_linux_* ts3client || die "Couldn't rename ts3client to its shorter version."

	default
}

src_install() {
	insinto /opt/teamspeak3-client
	doins -r *

	fperms +x /opt/teamspeak3-client/ts3client

	dobin "${FILESDIR}/teamspeak3"

	make_desktop_entry teamspeak3 TeamSpeak3 \
		"/opt/teamspeak3-client/pluginsdk/docs/client_html/images/logo.png" \
		Network

	# Might not work if this is on a separate partition and that partition is not mounted,
	# but there is nothing we can do in this situation.
	dosym /usr/$(get_libdir)/qt5/libexec/QtWebEngineProcess /opt/teamspeak3-client/QtWebEngineProcess || die
}
