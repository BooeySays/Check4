#!/bin/bash

function2check=$(dialog --stdout --title 'Function' --inputbox 'Input function to check for:' 0 60)

if [ $function2check ]; then
	echo YES;
else
	echo NO;
fi

unset function2check
