# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 user eutils webapp

DESCRIPTION="Tiny Tiny RSS - A web-based news feed (RSS/Atom) aggregator using AJAX"
HOMEPAGE="http://tt-rss.org/"
EGIT_REPO_URI="https://tt-rss.org/git/tt-rss.git"

LICENSE="GPL-3"
KEYWORDS=""
IUSE="daemon +mysqli postgres"

DEPEND="
	daemon? ( dev-lang/php:*[mysqli?,postgres?,pcntl,curl] )
	!daemon? ( dev-lang/php:*[mysqli?,postgres?,curl] )
	virtual/httpd-php:*"

RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( mysqli postgres )"

pkg_setup() {
	webapp_pkg_setup

	if use daemon; then
			enewgroup ttrssd
			enewuser ttrssd -1 /bin/sh /dev/null ttrssd
	fi
}

src_prepare() {
	# Customize config.php-dist so that the right 'DB_TYPE' is already set (according to the USE flag)
	einfo "Customizing config.php-dist..."

	if use mysqli && ! use postgres; then
			sed -i \
				-e "/define('DB_TYPE',/{s:pgsql:mysql:}" \
				config.php-dist || die
	fi

	sed -i \
		-e "/define('DB_TYPE',/{s:// \(or mysql\):// pgsql \1:}" \
		config.php-dist || die

	default
}

src_install() {
	webapp_src_preinst

	insinto "/${MY_HTDOCSDIR}"
	doins -r *
	keepdir "/${MY_HTDOCSDIR}"/feed-icons

	for DIR in cache lock feed-icons; do
			webapp_serverowned -R "${MY_HTDOCSDIR}/${DIR}"
	done

	if use daemon; then
			webapp_postinst_txt en "${FILESDIR}"/postinstall-en-with-daemon.txt
			newinitd "${FILESDIR}"/ttrssd.initd-r2 ttrssd
			newconfd "${FILESDIR}"/ttrssd.confd-r1 ttrssd
			insinto /etc/logrotate.d/
			newins "${FILESDIR}"/ttrssd.logrotated ttrssd

			elog "After upgrading, please restart ttrssd"
	else
			webapp_postinst_txt en "${FILESDIR}"/postinstall-en.txt
	fi

	webapp_src_install
}
