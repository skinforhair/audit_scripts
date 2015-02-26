#!/bin/bash
source common/vars
source common/functions

isEmpty=`find $GeneratedScripts -type f -exec echo {} \;`


if [ "$isEmpty" != "" ]; then
#	maintenance_page start
	for i in $GeneratedScripts/*.sh
	do 
		$i
	done
#        maintenance_page stop
else
	echo "$GeneratedScripts is empty. Please run readConfigs.sh"
fi
