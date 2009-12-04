#!/usr/bin/bash
BASE=`dirname $0`
if [[ "$0" != /* ]]
then
	BASE=`pwd`/$BASE
fi
bash $BASE/simple_captcha_install.sh || exit 1
bash $BASE/openid_install.sh
