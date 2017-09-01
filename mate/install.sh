#!/usr/bin/bash
# -*- coding: utf-8 -*-
#
#  install.sh
#
#  Copyright © 2013-2016 Antergos
#
#  This file is part of Antergos.
#
#  Antergos is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  Antergos is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Antergos; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

_ANT_USER_NAME="$1"

{ [[ "$2" = 'no-overwrite' ]] && _ANT_OVERWRITE='-n'; } || _ANT_OVERWRITE=' '

if [[ -z "${_ANT_USER_NAME}" ]]; then
	echo "Usage:"
	echo "./install.sh username"
	exit 1
fi

echo "Applying Antergos MATE setup to user: ${_ANT_USER_NAME}"

# All necessary files are in /usr/share/antergos-mate-setup
_ANT_SRCDIR=/usr/share/antergos-mate-setup
_ANT_DSTDIR="/home/${_ANT_USER_NAME}"

# Copy system files
cp -R "${_ANT_OVERWRITE}" -t /usr/share "${_ANT_SRCDIR}/icons"
cp -R "${_ANT_OVERWRITE}" -t /etc "${_ANT_SRCDIR}/skel"

# Copy user files
cp -R "${_ANT_OVERWRITE}" -t "${_ANT_DSTDIR}" /etc/skel/***

chown -R "${_ANT_USER_NAME}:users" "${_ANT_DSTDIR}"
