#!/bin/bash

dir=$(dialog --stdout --title 'Directory' --inputbox 'Input directory to check for:' 0 60)

if [ -d "$dir" ]; then
	echo YES;
else
	echo NO;
fi

unset dir
