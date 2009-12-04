#!/usr/bin/bash

REDMINE_DIR=/var/lib/redmine

if [[ $BASE == '' ]]
then
	BASE=`dirname $0`
	if [[ "$0" != /* ]]
	then
		BASE=`pwd`/$BASE
	fi
fi

if [ -d $REDMINE_DIR ]
then
	cd $REDMINE_DIR
	patch -p0 -i $BASE/openid.patch
else
	echo "Redmine not found."
fi
