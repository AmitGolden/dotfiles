#!/bin/sh

NotificationID_File=/tmp/caffeine_notification_id

function get_notification_id {
  if [ -s "$NotificationID_File" ]; then
    cat $NotificationID_File
  else
    echo 0
  fi
}

nid=$(get_notification_id)

if pgrep -x sleep.sh > /dev/null; then
	notify-send -p -r $nid -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-on-symbolic.svg "Caffeine Enabled" > $NotificationID_File
  kill -9 $(pgrep swayidle | tail -1)
else
	notify-send -p -r $nid -i /usr/share/icons/Papirus-Dark/symbolic/status/my-caffeine-off-symbolic.svg "Caffeine Disabled" > $NotificationID_File
        ~/.config/hypr/scripts/sleep.sh &
fi
