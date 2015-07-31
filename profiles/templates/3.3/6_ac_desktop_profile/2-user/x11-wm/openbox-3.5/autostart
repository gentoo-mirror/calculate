# Calculate comment=# path=~/.config/openbox

# You may place a similar script in $HOME/.config/openbox/autostart.d/*
# to run user-specific things.
if ls ~/.config/openbox/autostart.d/* &>/dev/null;then
	for f in ~/.config/openbox/autostart.d/*;do
		[ -d "${f}" ] && continue
		source ${f}
	done
fi
