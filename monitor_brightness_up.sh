#!/bin/bash
read -r BRITD < $(dirname $0)/brightness_diff.ini
cd /sys/class/backlight/nvidia_wmi_ec_backlight/
read -r MAXBRIT < max_brightness
read -r cur < brightness
cur=$((cur + BRITD))
if [ $cur -gt $MAXBRIT ]; then
    echo $MAXBRIT > brightness
else
    echo $cur > brightness
fi
