# Calculate run=/bin/bash

for dn in /usr/lib*/python*/site-packages/portage/sync/modules
do
    [[ -d $dn ]] || continue
    [[ -d $dn/calculate ]] || mkdir -p $dn/calculate
    cat >$dn/calculate/__init__.py <<EOF
# Copyright 2014-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

doc = """Calculate plug-in module for portage.
Performs a git pull on repositories."""
__doc__ = doc[:]

from portage.localization import _
from portage.sync.config_checks import CheckSyncConfig
from portage.util import writemsg_level


module_spec = {
	'name': 'calcualte',
	'description': doc,
	'provides':{
		'calculate-module': {
			'name': "calculate",
			'sourcefile': "calculate",
			'class': "CalculateSync",
			'description': doc,
			'functions': ['sync'],
			'func_desc': {
				'sync': 'Performs a calculate overlay sychronization',
			},
			'validate_config': CheckSyncConfig,
		}
	}
}
EOF
done
