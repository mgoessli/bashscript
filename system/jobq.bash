#!/bin/bash
DATUM=`date '+%m%d%y%M%S'`
LOGFILE=/appl/system/log/jobq_$DATUM.log
exec >> $LOGFILE 2>&1
echo "Jobq startet fuer User $USER"
echo "Ich bin `whoami`"


if [ -d ~/jobq ]
then
	if [ `ls ~/jobq  | wc -l` -eq 0 ]
	then	
		echo "keine Jobs gefunden"
		exit
	else
		echo "Anzahl der Jobs" `ls ~/jobq | grep -v "." | wc -l `
		echo "folgende Jobs gefunden: "
		ls -a ~/jobq
		cd ~/jobq
		pwd
	fi
else

	echo "keine Jobq gefunden"
	echo "Verzeichnis ~/jobq wird angelegt"
	mkdir ~/jobq
	echo "Verzeichnis ~/jobq wird angelegt"
	mkdir ~/jobq
	exit
fi


ls | while read file
do
	echo "Bearbeite Job $file"
	chmod 755 $file
	./$file
	returncode=$?
	echo "Return-Code von Job $file: $returncode"
	if [ $returncode -eq 0 ]
	then
		rm $file
	fi
done

