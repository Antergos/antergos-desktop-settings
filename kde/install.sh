#!/bin/bash
# -*- coding: utf-8 -*-
#
#  install.sh
#
# Copyright © 2013-2016 Antergos
#
# This file is part of antergos-kde-setup.
#
# antergos-kde-setup is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# antergos-kde-setup is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# The following additional terms are in effect as per Section 7 of the license:
#
# The preservation of all legal notices and author attributions in
# the material or in the Appropriate Legal Notices displayed
# by works containing it is required.
#
# You should have received a copy of the GNU General Public License
# along with antergos-kde-setup; If not, see <http://www.gnu.org/licenses/>.


_ANT_USER_NAME="${1}"

if [[ "${2}" = 'no-overwrite' ]]; then
	_ANT_OVERWRITE='-n'
else
	_ANT_OVERWRITE=' '
fi

if [ "${_ANT_USER_NAME}" = "" ]; then
	echo "Usage:"
	echo "./install.sh username"
	exit 0
fi

echo "Applying Antergos KDE configuration to user ${_ANT_USER_NAME}"

# All necessary files are in /usr/share/antergos-kde-setup
_ANT_SRCDIR=/usr/share/antergos-kde-setup
_ANT_DSTDIR="/home/${_ANT_USER_NAME}"

# Setup logo for kinfocenter's about distro screen
cp "${_ANT_SRCDIR}/antergos-logo.svg" /usr/share/about-distro
sed -i 's|archlinux|antergos|g' /etc/xdg/kcm-about-distrorc

# Copy system-wide files
cp -R "${_ANT_OVERWRITE}" -t /usr/share "${_ANT_SRCDIR}/icons" "${_ANT_SRCDIR}/skel"
cp -R "${_ANT_OVERWRITE}" -t /etc "${_ANT_SRCDIR}/skel"

# Copy user files
cp -R "${_ANT_OVERWRITE}" -t "${_ANT_DSTDIR}" "${_ANT_SRCDIR}/skel/.config"

chown -R "${_ANT_USER_NAME}:users" "${_ANT_DSTDIR}"
