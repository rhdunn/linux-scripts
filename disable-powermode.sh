#!/bin/bash
#
# Copyright (C) Reece H. Dunn
# License: LGPLv3+
#
# Helper script to prevent the screen going black after 10 min while watching a video in Gnome 3.

##### disable screensaver:

gconftool-2 -s -t bool /apps/gnome_settings_daemon/screensaver/start_screensaver false
gconftool-2 -s -t bool /apps/gnome-screensaver/lock_enabled false
gconftool-2 -s -t bool /apps/gnome-screensaver/idle_activation_enabled false
gconftool-2 -s -t integer /apps/gnome-screensaver/idle_delay 600

##### disable screen blank:

gconftool-2 -s -t string /apps/gnome-power-manager/ac_dpms_sleep_method off
gconftool-2 -s -t string /apps/gnome-power-manager/battery_dpms_sleep_method off 

##### disable computer sleep:

gconftool-2 -s -t integer /apps/gnome-power-manager/ac_sleep_computer 0
gconftool-2 -s -t integer /apps/gnome-power-manager/battery_sleep_computer 0

##### disable display sleep:

gconftool-2 -s -t integer /apps/gnome-power-manager/ac_sleep_display 0
gconftool-2 -s -t integer /apps/gnome-power-manager/battery_sleep_display 0

##### disable dim on idle:

gconftool-2 -s -t bool /apps/gnome-power-manager/dim_on_idle false

##### disable screen blanking:

# setterm -powersave off -blank 0
xset dpms 0 0 0
xset s noblank
xset s off
