# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=2

LANGS="de en es fr it pl ru"
LANGPACKPREFIX="babelize-${PN}"
LANGPACKBASE="https://babelize.org/download/"
LANGPACKPATHPREFIX="${LANGPACKBASE}/${LANGPACKPREFIX}/${LANGPACKPREFIX}"
LANGPACKVERSION="1.0.0"

inherit eutils games

DESCRIPTION="Linux port of Heroes of Might and Magic 3"
HOMEPAGE="http://www.lokigames.com/products/heroes3/"

# PPC is still not tested!
SRC_URI="x86? ( mirror://lokigames/${PN}/${P}-cdrom-x86.run )
	amd64? ( mirror://lokigames/${PN}/${P}-cdrom-x86.run )
	ppc? ( mirror://lokigames/${PN}/${P}-ppc.run
		http://mirrors.dotsrc.org/lokigames/patches/${PN}/${PN}-1.3.1-ppc.run )
"

IUSE="nocd maps music sounds videos"

for lang in $LANGS ; do
	if [ ${lang} != "en" ] ; then
		SRC_URI="${SRC_URI}
			linguas_${lang}? ( ${LANGPACKPATHPREFIX}-${lang}-${LANGPACKVERSION}.tar.bz2 )"
	fi
	IUSE="${IUSE} linguas_${lang}"
done

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
RESTRICT="strip"
PROPERTIES="interactive"

DEPEND="dev-util/xdelta:0
	games-util/loki_patch"
RDEPEND="!ppc? ( sys-libs/lib-compat-loki )
	x86? (
		media-libs/libsdl
		media-libs/sdl-mixer
		x11-libs/libXext
		x11-libs/libX11
	)
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
	)
"

S=${WORKDIR}

GAMES_CHECK_LICENSE="yes"
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	strip-linguas ${LANGS}

	if [[ ${#LINGUAS} > 2 ]] ; then
		ewarn
		ewarn "Heroes3 only supports one localization at once!"
		ewarn "The game will be installed unlocalized (i. e. in English)."
		ewarn
	fi

	if [[ ${#LINGUAS} = 2 ]] && [ $LINGUAS != "en" ] ; then
		LOCALIZE=1
		if ! ( use maps && use music && use sounds && use videos || use nocd ) ; then
			ewarn
			ewarn "Full installation (nocd flag or maps + music + sounds + videos flags)"
			ewarn "is needed for localization! The game's going to be installed fully."
			ewarn
		fi
	fi
}

src_unpack() {
	cdrom_get_cds hiscore.tar.gz
	if use ppc ; then
		unpack_makeself ${P}-ppc.run
		unpack_makeself ${PN}-1.3.1-ppc.run
	else
		unpack_makeself ${P}-cdrom-x86.run
	fi

	if [[ -n $LOCALIZE ]] ; then
		mkdir -p localize/tmp
		cd localize/tmp
		unpack ${LANGPACKPREFIX}-${LINGUAS}-${LANGPACKVERSION}.tar.bz2
		cd ..
		unpack ./tmp/${LANGPACKPREFIX}-${LINGUAS}-${LANGPACKVERSION}/share/babelize/langpacks/${PN}-lang-${LINGUAS}.tar.gz
	fi
}

src_install() {
	exeinto "${dir}"
	insinto "${dir}"
	einfo "Copying files; this may take a while..."

	# On PPC the 1.3.1a patch works only on the 1.3.1 patched version!
	if use ppc ; then
		xdelta patch heroes3.ppc "${CDROM_ROOT}"/bin/x86/${PN} heroes3
		doexe heroes3
	else
		doexe "${CDROM_ROOT}"/bin/x86/${PN}
	fi

	doins "${CDROM_ROOT}"/{Heroes_III_Tutorial.pdf,README,icon.{bmp,xpm}}

	if use nocd || [[ -n $LOCALIZE ]] ; then
		doins -r "${CDROM_ROOT}"/{data,maps,mp3} || die "copying data"
	else
		if use maps ; then
			doins -r "${CDROM_ROOT}"/maps || die "copying maps"
		fi

		if use music ; then
			doins -r "${CDROM_ROOT}"/mp3 || die "copying music"
		fi

		if use videos ; then
			doins -r "${CDROM_ROOT}"/data/video || die "copying videos"
		fi

		if use sounds ; then
			doins "${CDROM_ROOT}"/data/{*.lod,*.snd} || die "copying sounds"
		fi
	fi

	if [[ -n $LOCALIZE ]] ; then
		einfo "Applying l10n: ${LINGUAS} ..."
		find "${S}/localize/${LINGUAS}" -type f | while read xfile
		do
			local file=$(echo "${xfile}" | sed "s#^${S}/localize/${LINGUAS}/##;s#\.1\.xdelta\$##")
			ebegin "Localizing ${file}"
				xdelta patch "${xfile}" "${Ddir}/${file}" "${Ddir}/${file}.xdp"
				local retval=$?
					if [[ $retval == 0 ]] ; then
					mv -f  "${Ddir}/${file}.xdp" "${Ddir}/${file}"
				else
					rm -f "${Ddir}/${file}.xdp"
				fi
			eend $retval "File $file could not be localized/patched! Original english version untouched..."
		done
	fi

	tar zxf "${CDROM_ROOT}"/hiscore.tar.gz -C "${Ddir}" || die "unpacking hiscore"

	cd "${S}"
	loki_patch --verify patch.dat
	loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching"

	# Now, since these files are coming off a cd, the times/sizes/md5sums won't
	# be different... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find "${Ddir}" -exec touch '{}' \;

	newicon "${CDROM_ROOT}"/icon.xpm heroes3.xpm
	prepgamesdirs
	make_desktop_entry heroes3 "Heroes of Might and Magic III" "heroes3"

	if ! use ppc ; then
		einfo "Linking libs provided by 'sys-libs/lib-compat-loki' to '${dir}'."
		dosym /usr/lib/loki_libsmpeg-0.4.so.0 "${dir}"/libsmpeg-0.4.so.0 || die "dosym failed"
		dosym /usr/lib/loki_libsmjpeg-0.2.so.0 "${dir}"/libsmjpeg-0.2.so.0 || die "dosym failed"
	fi

	if [ -r "${dir}/data/hiscore.dat" ] ; then
		elog "Keeping previous hiscore.dat file"
		cp "${dir}/data/hiscore.dat" "${Ddir}/data"
	fi

	elog "Changing 'hiscore.dat' to be writeable for group 'games'."
	fperms g+w "${dir}/data/hiscore.dat" || die "fperms failed"

	einfo "Preparing wrappers."
	cp "${FILESDIR}"/heroes3-wrapper.sh "${T}"/heroes3 || die "copying wrapper failed"
	sed -i -e "s:GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" "${T}"/heroes3 || die "sed failed"
	dogamesbin "${T}"/heroes3 || die "doexe failed"
}

pkg_postinst() {
	games_pkg_postinst
}
