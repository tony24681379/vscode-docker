#!/bin/bash
xrdb -merge ./.Xresources
/usr/bin/code "$@"
/usr/bin/urxvt -title "Shell"
