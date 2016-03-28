#!/bin/bash
# ascope_viewer.sh - used as a short way to use usb microscopes.
# Copyright (C) 2016 Ruben Schmidt, ru.sch_gmx_net
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

CACHESIZE=32					# at least 32, could be 128
VIDEOFILTER="screenshot"
WIDTHVALUE=1600 ; HEIGHTVALUE=1200 ; FPSSIZE=5	# choose what you want
#WIDTHVALUE=1280 ; HEIGHTVALUE=960 ; FPSSIZE=9
#WIDTHVALUE=800 ; HEIGHTVALUE=600 ; FPSSIZE=20
#WIDTHVALUE=640 ; HEIGHTVALUE=480 ; FPSSIZE=30
#OUTFORMAT="rgb24"
VIDEOOUT="gl"
DEVICEID="/dev/video0"
OUTPUTDEVICE="tv://"
OUTSTRING=""

### FUNCTIONS
function Add_Option {
	if [[ $2 ]] ; then
		OUTSTRING="$OUTSTRING $1 $2"
	fi
}
function Add_Sub_Option {
	if [[ $2 ]] ; then
		OUTSTRING="$OUTSTRING:$1=$2"
	fi
}

### OPTION STRING
#Add_Option "-fps" $FPSSIZE
Add_Option "-cache" $CACHESIZE
Add_Option "-vf" $VIDEOFILTER
OUTSTRING="$OUTSTRING -zoom"
OUTSTRING="$OUTSTRING -tv noaudio"
Add_Sub_Option "outfmt" $OUTFORMAT
Add_Sub_Option "width" $WIDTHVALUE
Add_Sub_Option "height" $HEIGHTVALUE
Add_Sub_Option "fps" $FPSSIZE
Add_Sub_Option "device" $DEVICEID
Add_Option "-vo" $VIDEOOUT
OUTSTRING="$OUTSTRING $OUTPUTDEVICE"

### START MPLAYER
#echo "DEBUG:$OUTSTRING"
mplayer $OUTSTRING
