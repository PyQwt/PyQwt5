"""Qwt5 -- a Python interface to the Qwt library.
"""
#
# Copyright (C) 2003-2009 Gerard Vermeulen
#
# This file is part of PyQwt.
#
# PyQwt is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# PyQwt is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# In addition, as a special exception, Gerard Vermeulen gives permission
# to link PyQwt dynamically with non-free versions of Qt and PyQt,
# and to distribute PyQwt in this form, provided that equally powerful
# versions of Qt and PyQt have been released under the terms of the GNU
# General Public License.
#
# If PyQwt is dynamically linked with non-free versions of Qt and PyQt,
# PyQwt becomes a free plug-in for a non-free program.


from Qwt import *

try:
    to_na_array = toNumarray
except NameError:
    pass

try:
    to_np_array = toNumeric
except NameError:
    pass

# Local Variables: ***
# mode: python ***
# End: ***

