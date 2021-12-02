# autostart Xorg
if command -v systemctl > /dev/null; then
	if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	  exec startx
	fi
fi

# Add pyenv to path
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
