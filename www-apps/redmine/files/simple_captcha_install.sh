#!/usr/bin/bash

REDMINE_DIR="/var/lib/redmine"
PLUGIN_REP="svn://rubyforge.org/var/svn/expressica/plugins/simple_captcha"

if [[ $BASE == '' ]]
then
	BASE=`dirname $0`
	if [[ "$0" != /* ]]
	then
		BASE=`pwd`/$BASE
	fi
fi
echo $BASE

if [ -d $REDMINE_DIR ]
then
	cd $REDMINE_DIR
	ruby script/plugin install $PLUGIN_REP || exit 1
	rake simple_captcha:setup || exit 1
	rake db:migrate || exit 1
	patch -p0 -i $BASE/simple_captcha.patch
else
	echo "Redmine not found."
fi
