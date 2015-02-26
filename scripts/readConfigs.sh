#!/bin/bash
source common/vars

CONF=()
GroupArray=()
ENV=
TYPE=
OUTPUT=
counter=0

displayAlert() {
 echo ""
 echo "-------------"
 echo "$1"
 echo "-------------"
 echo ""
} #end displayAlert


# Read the file in parameter and fill the array named "array"
getArray() {
    i=0
    unset CONF
    while read line # Read a line
    do
        CONF[i]=$line # Put it into the array
        i=$(($i + 1))
    done < $1
} #end getArray


getOutput() {
	for i in ${CONF[@]}
	do
		if [ "${i:0:4}" = "TYPE" ]; then
			OUTPUT="${i:5}_arrays"	
		fi
	done
} #end getOutput


createArrays() {
getOutput
if [ -a $OUTPUT ]; then
	rm -f $OUTPUT
fi
counter=0
for i in "${CONF[@]}"
do

	firstChar=${i:0:1}
	firstWord=${i:0:4}
	curGroup=
	#ignore comments,blank lines, and Variables
	if [ "$firstChar" != "#" ] && [ "$i" != "" ]; then
		if [ "$firstWord" = "TYPE" ]; then
			TYPE="${i:5}"
		fi #if type
		if [ "$firstWord" = "ENV=" ]; then
			ENV="${i:4}"
		fi #if env

		if [ "$firstWord" != "TYPE" ] && [ "$firstWord" != "ENV=" ]; then
			#if not a node, then it is a group
			if [ "$firstChar" != "-" ]; then
				curGroup=$i
#displayAlert "$ENV $curGroup $TYPE"
				GroupArray[$counter]=$ENV$curGroup
				counter=$((counter+1))
				if [ "$counter" != "1" ]; then
					echo ")" >> $OUTPUT
				fi #if not first line
				echo -n "declare -a "$ENV$curGroup$TYPE"Array=(" >> $OUTPUT
			else
			#it is a node
				echo -n "'"${i:1}"' " >> $OUTPUT
			fi #if not node
		fi #if not type or env
	fi #if not comment
done
	echo ")" >> $OUTPUT
	echo "" >> $OUTPUT

echo -n "declare -a "$TYPE"FarmArray=(" >> $OUTPUT
for j in ${GroupArray[@]} 
do
	echo -n "'"$j"' " >> $OUTPUT	
done
	echo ")" >> $OUTPUT

echo -n "declare -a Full"$TYPE"FarmArray=(" >> $OUTPUT
for j in ${GroupArray[@]}
do
        echo -n "\${"$j$TYPE"Array[@]} " >> $OUTPUT
done
        echo ")" >> $OUTPUT
chmod 775 $OUTPUT
} #end createArrays


function createScript() {

ltype="${TYPE,,}"

so="generated_scripts/"$ltype"_audit.sh"
if [ -a $so ]; then
	rm $so
fi

## this clears out all the php files in /html/generated_menu/type
#isEmpty=`find $HTMLMenu/$ltype/ -type f -exec echo Found file {} \;`
# if [ "$isEmpty" != "" ]; then
#	rm $HTMLMenu/$ltype/*
# fi

echo "#!/bin/bash" >> $so
echo "source $SCRIPTS/common/vars" >> $so
echo "source $SCRIPTS/common/functions" >> $so
echo "source $SCRIPTS/config_variables/"$TYPE"_arrays" >> $so
echo "source $SCRIPTS/common/"${TYPE,,}".functions" >> $so
echo "" >> $so
echo "cleanGenPath "$ltype >> $so
echo "OUTPUT=$""TEMPDIR/output_from_"$ltype"_audit" >> $so
echo "CSV_FILE=$""TEMPDIR/"$ltype"_audit_output.csv" >> $so
echo "OUTPUT_PHP=$""DATADir/$ltype/"$ltype"_" >> $so
echo "DISPLAY_PHP=$""DATADir/"$ltype"_audit.php" >> $so
echo "" >> $so

echo "for GROUP in $""{"$TYPE"FarmArray[@]}" >> $so
echo "do" >> $so
echo "                cleanup_files \"$""OUTPUT\" \"$""CSV_FILE"\" >> $so
echo "                serverList=" >> $so
echo "" >> $so
echo "        case \"$""GROUP\" in" >> $so

for GROUP in ${GroupArray[@]}; do
	echo "        	\"$GROUP\")	serverList=(\"\${"$GROUP$TYPE"Array[@]}\")" >> $so
	echo "				;;" >> $so	
done

echo "        esac" >> $so
echo "echo \"working on $""GROUP\"" >> $so
echo "        for i in $""{serverList[@]}" >> $so
echo "        do" >> $so
echo "                echo \"Auditing $""i...\"" >> $so
echo "                audit_$ltype \"$""i\"" >> $so
echo "        done" >> $so
echo "" >> $so
echo "        format_$ltype" >> $so
echo "        "$ltype"_csv_to_php $""CSV_FILE $""GROUP" >> $so
echo "        generateCheckBoxes "$ltype >> $so
echo " fixPerms" >> $so
echo "done" >> $so

chmod 755 $so
} #end createScript

function readConf() {
if [ "$1" != "" ]; then
  getArray $1
  createArrays
  mv $OUTPUT $SCRIPTS/config_variables
  createScript
else
  echo "Please specify a config file!"
fi
} #end readConf

if [ "$1" == "" ]; then
 checkPath=$CONFDIR
else
 checkPath=$1
fi

fileBeingModified=`find $checkPath -name *.swp -exec echo {} \;`
 if [ "$fileBeingModified" == "" ]; then
  isEmpty=`find $checkPath -type f -exec echo Found file {} \;`
  if [ "$isEmpty" != "" ]; then
  	for i in $checkPath/*.conf; do
  		readConf "$i"
  	done
  else
 	echo "No config files found in path $checkPath"
  fi #if isEmtpy
 else
    fileBeingModified=${fileBeingModified:$((${#checkPath}+2))}
    fileBeingModified=${fileBeingModified:0:$((${#fileBeingModified}-4))}
    fileBeingModified=$checkPath/$fileBeingModified
    echo $fileBeingModified" is being modified. Please try again later."
 fi #if fileBeingModified
