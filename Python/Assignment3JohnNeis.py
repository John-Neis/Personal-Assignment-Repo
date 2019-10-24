#!/usr/bin/python
from SongList import *

setTitle("My Spotify playlist")

addSong("Howdiz Songo?", "7:10")
addSong("Race to the Bridge", "6:11")
addSong("Moten Swing", "4:50")
addSong("Samba Ti Kaye", "5:18")
addSong("Bug Catcher", "5:10")
printSongs()

print("")
removeSong("Howdiz Songo?")
removeSong("Moten Swing")
printSongs()
