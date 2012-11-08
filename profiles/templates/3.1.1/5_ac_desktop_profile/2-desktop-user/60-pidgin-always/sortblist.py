#Calculate exec=/usr/bin/python path=/tmp name=sortblist_#-ur_login-#.py

# -*- coding: utf-8 -*-

import os,sys

try:
    from xml.dom import minidom
    homedir = "#-ur_home_path-#"
    blistfile="/.purple/blist.xml"
    
    if os.path.exists(homedir+blistfile) :
        #Buddy list file opening and get groups-list
        blist=minidom.parse(homedir+blistfile)
        elements=blist.getElementsByTagName("group")
        #Groups sorting
        elements.sort(key=lambda elements:elements.getAttribute('name'))
        #Deleting groups from source xml
        for n in blist.childNodes[0].childNodes[1].getElementsByTagName('group'):
            blist.childNodes[0].childNodes[1].removeChild(n)
        #Add sorted groups
        for n in elements:
            blist.childNodes[0].childNodes[1].appendChild(n)
        #Write to Buddy list file
        blistout=open(homedir+blistfile,"w")
        blistout.write(blist.toxml().encode("utf-8"))
        blistout.close()
except Exception as e:
    sys.stderr.write(str(e))
