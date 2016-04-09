#!/bin/bash
BASEDIR=$(dirname $0)
echo $BASEDIR

database=cloudtimetest
file=cloudtimetest
passw=

if [ "$1" != "" ]; then
	mysqldump -u root -p $database > $BASEDIR/$database.sql
else
	mysqladmin -u root -p drop $database
	mysqladmin -u root -p create $database
	mysql -h localhost -u root -p $database < $BASEDIR/$file.sql
fi