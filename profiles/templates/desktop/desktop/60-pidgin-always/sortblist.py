#Calculate exec=/usr/bin/python path=/tmp name=sortblist.py
# -*- coding: utf-8 -*-

import os,sys
from xml.dom import minidom

homedir = os.path.expanduser('~')
blistfile="/.purple/blist.xml"

#открываем файл списка контактов и получаем элементы групп
blist=minidom.parse(homedir+blistfile)
elements=blist.getElementsByTagName("group")
#сортируем группы
elements.sort(key=lambda elements:elements.getAttribute('name'))
#удаляем все группы из исходного xml
for n in blist.childNodes[0].childNodes[1].getElementsByTagName('group'):
    blist.childNodes[0].childNodes[1].removeChild(n)
#добавляем отсортированные группы
for n in elements:
    blist.childNodes[0].childNodes[1].appendChild(n)
#выводим отсортированный список в исходный файл
blistout=open(homedir+blistfile,"w")
blistout.write(blist.toxml().encode("utf-8"))
blistout.close()
