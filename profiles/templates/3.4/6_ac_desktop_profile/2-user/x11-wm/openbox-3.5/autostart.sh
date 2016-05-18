# Calculate comment=# path=~/.config/openbox

# You may place a similar script in $HOME/.config/openbox/autostart.d/*
# to run user-specific things.
if ls ~/.config/openbox/autostart/* &>/dev/null;then
	for f in ~/.config/openbox/autostart/*;do
		[ -d "${f}" ] && continue
		source ${f}
	done
fi
