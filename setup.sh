#!/bin/bash

echo "#!/bin/bash
chmod a+w /sys/class/backlight/nvidia_wmi_ec_backlight/brightness" > /usr/local/sbin/monitor_brightness_writable.sh
chmod +x /usr/local/sbin/monitor_brightness_writable.sh

echo "[Unit]
Description=Chmod brightness of the monitor writable.
After=default.target

[Service]
Type=oneshot
User=root
ExecStart=/usr/local/sbin/monitor_brightness_writable.sh

[Install]
WantedBy=default.target" > /etc/systemd/system/monitor-brightness.service

systemctl daemon-reload
systemctl enable monitor-brightness.service
systemctl start monitor-brightness.service


read -p "请输入用户名：" usr
read -p "请输入初始屏幕亮度：" ini_brit
echo "
# 初始屏幕亮度
INI_BRIT=$ini_brit
sleep 3 && echo \$INI_BRIT > /sys/class/backlight/nvidia_wmi_ec_backlight/brightness &" >> /home/$usr/.bash_profile
source /home/$usr/.bash_profile


read -p "请输入每次调节的亮度差距值：" brit_d
echo $brit_d > $(dirname $0)/brightness_diff.ini
chmod a+w $(dirname $0)/brightness_diff.ini
echo "您可以通过修改./brightness_diff.ini来修改该值。"

chmod +x $(dirname $0)/monitor_brightness_down.sh $(dirname $0)/monitor_brightness_up.sh

# schema="org.gnome.settings-daemon.plugins.media-keys"
# base="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
# path="$base/monitor-brightness0/"
# gsettings set "$schema.custom-keybinding:$path" name "Monitor Brightness Down Slightly"
# gsettings set "$schema.custom-keybinding:$path" command "bash $(dirname $0)/monitor_brightness_down.sh"
# gsettings set "$schema.custom-keybinding:$path" binding "<Control>MonBrightnessDown"
# current="$(gsettings get "$schema" custom-keybindings)"
# if [ "$current" = "@as []" ]; then
#     new="['$path']"
# else
#     new="${current%]}, '$path']"
# fi
# gsettings set "$schema" custom-keybindings "$new"

# path="$base/monitor-brightness1/"
# gsettings set "$schema.custom-keybinding:$path" name "Monitor Brightness Up Slightly"
# gsettings set "$schema.custom-keybinding:$path" command "bash $(dirname $0)/monitor_brightness_up.sh"
# gsettings set "$schema.custom-keybinding:$path" binding "<Control>MonBrightnessUp"
# current="$(gsettings get "$schema" custom-keybindings)"
# gsettings set "$schema" custom-keybindings "${current%]}, '$path']"
