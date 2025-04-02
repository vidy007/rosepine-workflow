#!/bin/zsh

case "$(echo -e 'off\nreboot\nsleep\nlock' | dmenu -p 'select')" in
		off) exec st -e sudo shutdown;;
		reboot) exec st -e sudo reboot;;
		lock) exec slock;;
esac
