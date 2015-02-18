#!/bin/bash
source common/vars


isEmpty=`find $GeneratedScripts -type f -exec echo {} \;`


if [ "$isEmpty" != "" ]; then
	for i in $GeneratedScripts/*.sh
	do 
		$i
	done
else
	echo "$GeneratedScripts is empty. Please run readConfigs.sh"
fi
