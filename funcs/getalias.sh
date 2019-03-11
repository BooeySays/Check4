#!/bin/bash

alias=$(dialog --stdout --title 'Alias' --inputbox 'Input alias to check for:' 0 60)

aliasstat=$(alias "$alias" | grep -qe "$alias"; echo $?)
if [ $aliasstat == '0' ]; then
	echo YES;
else
	echo NO;
fi

unset alias aliasstat
