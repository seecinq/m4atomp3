#!/usr/bin/env python
#
# Copyright (c) 2009 Andreas Liebschner
#
# Permission is hereby granted, free of charge, to any person obtaining 
# a copy of this software and associated documentation files (the 
# "Software"), to deal in the Software without restriction, including 
# without limitation the rights to use, copy, modify, merge, publish, 
# distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to 
# the following conditions:
#
# The above copyright notice and this permission notice shall be 
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,  
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import sys
try:
    from mutagen.easymp4 import EasyMP4
    from mutagen.id3 import ID3, TIT2, TRCK, TPE1, TALB, TSSE
except ImportError:
    print "FFFFFFFFFFFFFFFUU"
    print "You need mutagen: http://code.google.com/p/mutagen/"

file_m4a = sys.argv[1]
file_mp3 = sys.argv[2]

m4a = EasyMP4(file_m4a)
mp3 = ID3(file_mp3)

mp3.add(TPE1(encoding=3, text=m4a["artist"]))
mp3.add(TALB(encoding=3, text=m4a["album"]))
mp3.add(TIT2(encoding=3, text=m4a["title"]))
mp3.add(TRCK(encoding=3, text=m4a["tracknumber"]))
mp3.add(TSSE(encoding=3, text=u"FFFFFFFFFFFFFFFUU"))

mp3.save()
