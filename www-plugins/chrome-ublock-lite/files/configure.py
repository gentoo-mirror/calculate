#!/usr/bin/python3

import plyvel
import json
import sys
from os import path

chrome_dir = sys.argv[1]
ext_id = sys.argv[2]

db_path = path.join(chrome_dir,"Default/Local Extension Settings", ext_id)
db = plyvel.DB(db_path, create_if_missing=True)
db.close()
