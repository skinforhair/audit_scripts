#!/bin/bash
source /home/jeremiahj/audit/audit_scripts/common/vars
source /home/jeremiahj/audit/audit_scripts/common/functions
source /home/jeremiahj/audit/audit_scripts/common/config_variables/Tomcat_arrays

cleanGenPath tomcat
OUTPUT=$TEMPDIR/output_from_tomcat_audit
CSV_FILE=$TEMPDIR/tomcat_audit_output.csv
OUTPUT_PHP=$HTMLDIR/tomcat/tomcat_
DISPLAY_PHP=$HTMLDIR/tomcat_audit.php

for GROUP in ${TomcatFarmArray[@]}
do
                cleanup_files "$OUTPUT" "$CSV_FILE"
                serverList=

        case "$GROUP" in
        	"Testmstrat")	serverList=("${TestmstratTomcatArray[@]}")
				;;
        	"TestQMS")	serverList=("${TestQMSTomcatArray[@]}")
				;;
        	"Testshrtc")	serverList=("${TestshrtcTomcatArray[@]}")
				;;
        	"Testutltc")	serverList=("${TestutltcTomcatArray[@]}")
				;;
        	"ProdDMZ32")	serverList=("${ProdDMZ32TomcatArray[@]}")
				;;
        	"ProdInternal")	serverList=("${ProdInternalTomcatArray[@]}")
				;;
        	"ProdDMZ64")	serverList=("${ProdDMZ64TomcatArray[@]}")
				;;
        esac
echo "working on $GROUP"
        for i in ${serverList[@]}
        do
                echo "Auditing $i..."
                audit_tomcat "$i"
        done

        format_tomcat
        tomcat_csv_to_php $CSV_FILE $GROUP
        generateCheckBoxes tomcat
done
