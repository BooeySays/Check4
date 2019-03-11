#!/bin/bash

if ! hash dialog 2>/dev/null; then
	apt update -y && apt install dialog -y
fi

if [ $DIALOGGENERATOR ]; then
	unset DIALOGGENERATOR;
fi
DIALOGGENERATOR=$PWD

if [ $DIALOGfiles ]; then
	unset DIALOGfiles;
fi
DIALOGfiles=$DIALOGGENERATOR/funcs

clear;
DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

#newdialogfilename=$($DIALOG --stdout --title 'filename' --clear \
#	--inputbox '\ninput filename\n\n' 0 0 newfilename )

$DIALOG --visit-items --colors --no-tags --item-help --extra-button --help-button --hfile './tetfile.txt' --hline 'etataet' --extra-label 'About' --cancel-label ' NEXT PAGE ' --title 'Check 4 _____ script' --clear \
	--menu 'Check options menu' 0 0 0 'getfunc' '1. Function' 'Checks the current system for the specified function'\
	'getalias' '2. Alias' 'Checks the current system for the specified alias'\
	'getdir' '3. Directory' 'Checks the current location to see if the specified directory exists'\
	'fselect' '4. File' 'Checks the current location to see if the specified file exists'\
	'getapp' '5. App' 'Checks the current location to see if the specified file exists'\
	'var' '6. Variable' 'Checks the current system for the specified variable' 2> $tempfile
	
retval=$?

case $retval in
0)
#	DOPTION="$DIALOGGENERATOR/funcs/`cat $tempfile`/`cat $tempfile`.sh"
	DOPTION="$DIALOGGENERATOR/funcs/`cat $tempfile`.sh"
#	DOPTION="`cat $tempfile`.sh"
	if [ ! -f $DOPTION ]; then
		dialog --clear --title 'SORRY !' --msgbox "The option is not currently online. I just haven't finished writing the script yet. Come back later on and it should be finished" 0 0;
	else
		. "$DIALOGGENERATOR/funcs/`cat $tempfile`.sh"
#		. "`cat $tempfile`.sh";
	fi
	;;
1)
	unset DIALOGGENERATOR DIALOGfiles
	echo "canceled"
	;;
3)
	echo "ABOUT"
	;;
255)
	unset DIALOGGENERATOR DIALOGfiles
	echo "ESC"
	;;
esac

# CHANGES

# 1.3
#	- 	found out about --no-tags, so no I can hide the tag column and name the tags whatever
#		I want to.
#		- 	I can name the tag the name of the dir and have the exec script inside the dir share
#			the same name. So on exit 0, I can have dialog execute something like:
#				. ./.files/`cat $tempfile`/`cat $tempfile`.sh;

# 1.3
#	- added --item-help

# 1.2
#	- used tags to execute a script in .files, which then redirects to the proper directory

# 1.1
