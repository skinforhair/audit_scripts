#!/bin/bash
source /home/jeremiahj/audit/audit_scripts/common/vars
source /home/jeremiahj/audit/audit_scripts/common/functions
source /home/jeremiahj/audit/audit_scripts/common/config_variables/Apache_arrays

cleanGenPath apache
OUTPUT=$TEMPDIR/output_from_apache_audit
CSV_FILE=$TEMPDIR/apache_audit_output.csv
OUTPUT_PHP=$HTMLDIR/apache/apache_
DISPLAY_PHP=$HTMLDIR/apache_audit.php

for GROUP in ${ApacheFarmArray[@]}
do
                cleanup_files "$OUTPUT" "$CSV_FILE"
                serverList=

        case "$GROUP" in
        	"DevInternal")	serverList=("${DevInternalApacheArray[@]}")
				;;
        	"TestDMZ32")	serverList=("${TestDMZ32ApacheArray[@]}")
				;;
        	"TestInternal")	serverList=("${TestInternalApacheArray[@]}")
				;;
        	"TestDMZ64")	serverList=("${TestDMZ64ApacheArray[@]}")
				;;
        	"ProdDMZ32")	serverList=("${ProdDMZ32ApacheArray[@]}")
				;;
        	"ProdInternal")	serverList=("${ProdInternalApacheArray[@]}")
				;;
        	"ProdDMZ64")	serverList=("${ProdDMZ64ApacheArray[@]}")
				;;
        esac
echo "working on $GROUP"
        for i in ${serverList[@]}
        do
                echo "Auditing $i..."
                audit_apache "$i"
        done

        format_apache
        apache_csv_to_php $CSV_FILE $GROUP
        generateCheckBoxes apache
done
