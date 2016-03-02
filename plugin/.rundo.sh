#!/bin/bash

# needs wmctrl, xte and xsel
# to get them run
# sudo apt-get install wmctrl xautomation xsel
# in debian/ubuntu linux

#copy to clipboard "do filename"
# echo 'do ' '"'$1'"' | xsel -b
# echo  '"'$1'"' | xsel -b
# echo $1 | xsel -b

# get current window id
winid = $(xprop -root | awk "/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}")
# check for stata window, if found activate else execute
# use correct version here

if [ "$(pgrep stata)" ] 
then
    wmctrl -a 'Stata/SE 14.0'
else
    xstata &
    sleep .1 
fi

# delay depends on window manager etc
# .1 ok with xmonad in 10.04
sleep .1 

# switch to command line, ctrl-4 in stata 10, ctrl-1 in 11/12
# and select existing text via ctrl-a
# xte 'keydown Control_L' 'key 1' 'key A' 'usleep 100' \
#     'key V' 'keyup Control_L' 
xte 'keydown Control_L' 'key 1' 'key A' 'keyup Control_L' \
    'str do '$1'' 'key Return'
# sleep .1

# go back to editor window
# wmctrl -i -a $winid 
wmctrl -a '.do' 

