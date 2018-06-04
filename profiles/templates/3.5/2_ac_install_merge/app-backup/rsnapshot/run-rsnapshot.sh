# Calculate chmod=0755 path=/usr/libexec
#!/bin/bash

# Copyright (C) 2018 Mir Calculate Ltd.

#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#
#  The script allows you to create daily, weekly (from Monday), and monthly
#  (every 4 weeks) backups automatically, with a single daily startup.

weekseconds="$(( 60 * 60 * 24 * 7 ))"

get_value() {
    awk -F"\t" "{if (\$1 == \"$1\") print \$2}" | tail -1
}

get_retain_value() {
    awk -F"\t" "{if (\$1 == \"retain\" && \$2 == \"$1\") print \$3}" | tail -1
}

base_configfile=/etc/rsnapshot.conf
configfile=${1:-$base_configfile}

snapshot_root="$(cat $base_configfile $configfile | get_value snapshot_root)"
retain_daily="$(cat $base_configfile $configfile | get_retain_value daily)"

# prepare backup snapshot
rsnapshot -c $configfile sync
res=$?

# calculating the day of the week when need to do rotation, so that a copy
# comes in weekly from Monday
if [[ $(date +"%w") -eq $(( ($retain_daily + 1) % 7 )) ]]
then
    # it's time to make a monthly backup
    if [[ $(( $(date +"%s") / $weekseconds % 4 )) -eq 0 ]]
    then
        rsnapshot -c $configfile monthly
    fi
    rsnapshot -c $configfile weekly
fi
# fix the backup as daily if there was no error
if [[ $res -ne 1 ]]
then
    rsnapshot $configfile daily
    # write current time to backup for reference
    date >${snapshot_root}/daily.0/timestamp
    exit 0
else
    exit 1
fi
