#!/bin/bash

if [ $# == '0' ]; then
    read -p 'Enter function to check for: ' -r func2check
else
    func2check="$1"
fi

checking=$(declare -F "$func2check" | grep -qe "$func2check"; echo $?)

if [ $checking == '0' ]; then
	echo -e "\n\033[01;37mFunction \033[32mFOUND\033[m\n";
else
	echo -e "\n\033[01;37mFunction \033[31mNOT \033[37mfound\033[m\n";
fi

unset checking func2check
