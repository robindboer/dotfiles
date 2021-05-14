# autostart Xorg
if command -v systemctl > /dev/null; then
	if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	  exec startx
	fi
fi
