# vim: set syntax=sh
#
# Copyright 2014 Calculate Ltd. http://www.calculate-linux.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0

for fn in /etc/calculate/profile.bashrc.d/*;do
	[[ -f $fn ]] && source ${fn} && PROFILE_BASHRC_D=1
done
[[ -z ${PROFILE_BASHRC_D} ]] && source ${BASH_SOURCE}.old
