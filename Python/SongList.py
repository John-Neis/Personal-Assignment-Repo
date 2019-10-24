_songs = {}
_songs["title"] = None

def addSong(title, time):
	
	_songs[title] = time


def removeSong(title):
	
	if(isSongInList(title)):
		del _songs[title]
		return True
	else:
		return False


def isSongInList(title):
	
	title = title.lower()
	for key in _songs.keys():
		if(key.lower() == title):
			return True
	return False


def numberOfSongs():
	
	return len(_songs) - 1

	
def clear():
	
	tmp = _songs["title"]
	del _songs
	_songs["title"] = tmp

	
def printSongs():
	
	for key in _songs.keys():
		if(not(key == "title")):
			print("%-20s -> %6s" % (key, _songs[key]))
	
#def saveList():
#def loadList():
def setTitle(title):
	
	_songs["title"] = title


#def getTitle():
#def matchingSongs():