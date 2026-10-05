#!/bin/bash
read -r BRITD < $(dirname $0)/brightness_diff.ini
cd /sys/class/backlight/nvidia_wmi_ec_backlight/
MINBRIT=0
read -r cur < brightness
cur=$((cur - BRITD))
if [ $cur -lt $MINBRIT ]; then
    echo $MINBRIT > brightness
else
    echo $cur > brightness
fi
