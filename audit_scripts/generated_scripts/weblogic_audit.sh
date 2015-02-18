#!/bin/bash
source /home/jeremiahj/audit/audit_scripts/common/vars
source /home/jeremiahj/audit/audit_scripts/common/functions
source /home/jeremiahj/audit/audit_scripts/common/config_variables/Weblogic_arrays

cleanGenPath weblogic
OUTPUT=$TEMPDIR/output_from_weblogic_audit
CSV_FILE=$TEMPDIR/weblogic_audit_output.csv
OUTPUT_PHP=$HTMLDIR/weblogic/weblogic_
DISPLAY_PHP=$HTMLDIR/weblogic_audit.php

for GROUP in ${WeblogicFarmArray[@]}
do
                cleanup_files "$OUTPUT" "$CSV_FILE"
                serverList=

        case "$GROUP" in
        	"TesteCommerce")	serverList=("${TesteCommerceWeblogicArray[@]}")
				;;
        	"TestEJB")	serverList=("${TestEJBWeblogicArray[@]}")
				;;
        	"TestEXT")	serverList=("${TestEXTWeblogicArray[@]}")
				;;
        	"TestSabrix")	serverList=("${TestSabrixWeblogicArray[@]}")
				;;
        	"TestVG")	serverList=("${TestVGWeblogicArray[@]}")
				;;
        	"TestWelcomeScreen")	serverList=("${TestWelcomeScreenWeblogicArray[@]}")
				;;
        	"ProdeCommerce")	serverList=("${ProdeCommerceWeblogicArray[@]}")
				;;
        	"ProdEXT")	serverList=("${ProdEXTWeblogicArray[@]}")
				;;
        	"ProdSabrix")	serverList=("${ProdSabrixWeblogicArray[@]}")
				;;
        	"ProdVG")	serverList=("${ProdVGWeblogicArray[@]}")
				;;
        	"ProdWelcomeScreen")	serverList=("${ProdWelcomeScreenWeblogicArray[@]}")
				;;
        esac
echo "working on $GROUP"
        for i in ${serverList[@]}
        do
                echo "Auditing $i..."
                audit_weblogic "$i"
        done

        format_weblogic
        weblogic_csv_to_php $CSV_FILE $GROUP
        generateCheckBoxes weblogic
done
