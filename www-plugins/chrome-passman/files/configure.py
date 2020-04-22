#!/usr/bin/python3

import plyvel
from sjcl import SJCL
import json
import sys
import base64
from os import path

data = json.load(sys.stdin)

if len(sys.argv) < 4:
    sys.stderr.write("configure.py chrome-dir ext-id cryptpw")
    sys.exit(1)

chrome_dir = sys.argv[1]
ext_id = sys.argv[2]
cryptpw = sys.argv[3]

settings = data['settings']
accounts = settings['accounts']

encrypted_accounts = SJCL().encrypt(bytes(json.dumps(accounts),encoding='utf-8'),cryptpw, count=1000, dkLen=32)

json_accounts = json.dumps(
    {x:str(y,encoding='utf-8') if isinstance(y,bytes) else y for x,y in encrypted_accounts.items()})
settings['accounts'] = str(base64.b64encode(
    bytes(json_accounts,encoding='utf-8')), encoding='utf-8')

data['settings'] = json.dumps(settings)
data['activeTab'] = '"search"'

db_path = path.join(chrome_dir,"Default/Local Extension Settings", ext_id)
db = plyvel.DB(db_path, create_if_missing=True)
for k,v in data.items():
    db.put(bytes(k,encoding='utf-8'), bytes(v,encoding='utf-8'))
db.close()
