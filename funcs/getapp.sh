#!/bin/bash

app=$(dialog --stdout --title 'App / Command' --inputbox 'Input the name of the App / Command to check for:' 0 60)

if hash "$app" 2>/dev/null; then
	echo YES;
else
	inapt=$(apt show "$app" | grep -qe "$app"; echo $?)
	case $inapt in
	0)
		dialog --title 'Install?' --yesno 'App was not found on system, but it exists in apt/pkg.\n\n\nDo you want to install it?'	0 0

		retval=$?
		case $retval in
		0)
			apt install "$app"
			;;
		1)
			echo OK
			;;
		*)
			echo error
			;;
		esac
		;;
	100)
		echo -e "No such app exists on the system or the apt"
		;;
	*)
		echo error
		;;
	esac
fi

unset app installyn retval inapt
