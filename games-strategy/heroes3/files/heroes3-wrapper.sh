#!/bin/sh

# fixes bug #93604
DIR="${HOME}/.loki/heroes3"
[ ! -d "${DIR}" ] && mkdir -p "${DIR}"
cd "${DIR}"

if [ -n "GAMES_PREFIX_OPT/heroes3" ] ; then
	if [ "${LD_LIBRARY_PATH+set}" = "set" ] ; then
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:GAMES_PREFIX_OPT/heroes3"
	else
		export LD_LIBRARY_PATH="GAMES_PREFIX_OPT/heroes3"
	fi
fi

exec GAMES_PREFIX_OPT/heroes3/heroes3.dynamic "${@}"
