#!/usr/bin/env python
# Calculate comment=#
__module_name__ = "let me search that for you (/gog)"
__module_version__ = "1.2"
__module_description__ = "Operates search engines for you"

import xchat
import string
import urllib

TINYURL_API_URL="http://tinyurl.com/api-create.php?url=[url]"
GOOGLE_FOR_YOU="http://lmgtfy.com/?q=[term]"

print "\0034",__module_name__, __module_version__,"loading...\003"

def getTinyUrl(searchEngine, searchTerms, turlApiURL):
	finalUrl = searchEngine.replace("[term]",searchTerms)
	finalUrl = turlApiURL.replace("[url]",finalUrl)
	return finalUrl

def doWork(word, searchEngine):
	if len(word) < 2:
		print ("Very little...");
		return;
	wordStr = "+".join(word[2:])
	wordStr = string.strip(wordStr)
	tinyUrl=getTinyUrl(searchEngine,wordStr,TINYURL_API_URL)
	endUrl = urllib.urlopen(tinyUrl).read()
#	print endUrl
	xchat.command("SAY " + word[1]+ ", " + endUrl)
	

def letmegoogleit(word, word_eol, userdata):
	doWork(word, GOOGLE_FOR_YOU)

xchat.hook_command("gog", letmegoogleit, help="/gog <nick> <message> Operates search engines for user")
