#!/usr/bin/bash
# -*- coding: utf-8 -*-
#
#  install.sh
#
#  Copyright © 2013-2017 Antergos
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

_ANT_DESKTOP="${1}"
_ANT_USERNAME="${2}"
_ANT_OVERWRITE="${3}"

if [[ -z "${_ANT_USERNAME}" ]]; then
    echo "Usage: ./install.sh desktop username [no-overwrite]"
    exit 0
fi

# All necessary files are here
_ANT_SRC_DIR='/usr/share/antergos/desktop/${_ANT_DESKTOP}'

# User's home destination folder (won't be used if no-overwrite is used)
_ANT_DST_DIR="/home/${_ANT_USERNAME}"

# Copy config files to skel folder
cp -R "${_ANT_SRC_DIR}/skel" /etc/skel

if [[ "${_ANT_OVERWRITE}" != "no-overwrite" ]]; then
    echo ">>> Antergos ${_ANT_DESKTOP} configuration will be applied to new users, root, and the following user: ${_ANT_USERNAME}."

    # Copy config files to root
    cp -R "${_ANT_SRC_DIR}/skel" /root

    if [[ -n "${_ANT_DST_DIR}" ]] && [[ -d "${_ANT_DST_DIR}" ]]; then
        # Copy config files to current user
        cp -R "${_ANT_SRC_DIR}/skel" "${_ANT_DST_DIR}"
        # Fix permissions
        chown -R "${_ANT_USERNAME}:users" "${_ANT_DST_DIR}"
    fi
else
    echo ">>> Antergos ${_ANT_DESKTOP} configuration will be applied to new users only."
fi

# Copy global files (/etc)
if [ -d "${_ANT_SRC_DIR}/etc" ]; then
    cp -R "${_ANT_SRC_DIR}/etc/." /etc
fi

# Copy global files (/usr)
if [ -d "${_ANT_SRC_DIR}/usr" ]; then
    cp -R "${_ANT_SRC_DIR}/usr/." /usr
fi

# Desktop specific setup

if [[ ${_ANT_DESKTOP} == "kde" ]] || [[ ${_ANT_DESKTOP} == "plasma" ]]; then
    # Setup logo for kinfocenter's about distro screen
    cp "${_ANT_SRC_DIR}/antergos-logo.svg" /usr/share/about-distro
    sed -i 's|archlinux|antergos|g' /etc/xdg/kcm-about-distrorc
fi
