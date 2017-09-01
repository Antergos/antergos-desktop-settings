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

_ANT_USERNAME="${1}"
_ANT_NO_OVERWRITE="${2}"

if [[ -z "${_ANT_USERNAME}" ]]; then
    echo "Usage: ./install.sh username"
    exit 0
fi

# All necessary files are in /DESTDIR/usr/share/antergos-desktop-setups/enlightenment
_ANT_SRC_DIR='/usr/share/antergos-desktop-setups/enlightenment'

# Copy config files to skel folder
cp -R "${_ANT_SRC_DIR}/skel" /etc/skel

if [[ -z "${_ANT_NO_OVERWRITE}" ]]; then
    echo ">>> Antergos Enlightement configuration will be applied to new usersfor new users, root, and the following user: ${_ANT_USERNAME}."

    # Copy config files to root
    cp -R "${_ANT_SRC_DIR}/skel" /root

    # Copy config files to current user
    _ANT_DST_DIR="/home/${_ANT_USERNAME}"
    if [[ -n "${_ANT_DST_DIR}" ]] && [[ -d "${_ANT_DST_DIR}" ]]; then
        cp -R "${_ANT_SRC_DIR}/skel" "${_ANT_DST_DIR}"
        # Fix permissions
        chown -R "${_ANT_USERNAME}:users" "${_ANT_DST_DIR}"
    fi
else
    echo ">>> Antergos Enlightement configuration will be applied to new users only."
fi
