#!/bin/zsh

case "$(echo -e 'off\nreboot\nsleep\nlock' | dmenu -p 'select')" in
		off) exec systemctl poweroff;;
		reboot) exec systemctl reboot;;
		sleep) exec systemctl suspend;;
		lock) exec slock;;
esac
