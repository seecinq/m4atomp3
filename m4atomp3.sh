#!/bin/sh
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

MPLAYER="/usr/bin/mplayer"
LAME="/usr/bin/lame"

# You can change these options, but don't remove --add-id3v2
LAMEOPTS="-V 0 --vbr-new -b 256 --lowpass 15.5 -q 0 --add-id3v2"

CWD=$(pwd)

m4a2wav(){
  $MPLAYER -vc null -vo null -ao pcm:fast:file="$NAME.wav" "$FILE"
}

wav2mp3(){
  $LAME $LAMEOPTS "$NAME.wav" "$NAME.mp3"
}

addtags(){
  $CWD/addtags.py "$FILE" "$NAME.mp3"
}

convert() {
  for FILE in *.m4a; do
    NAME=$(basename "$FILE" .m4a)
    m4a2wav
    wav2mp3
    addtags
  done
}

cleanup() {
  find . -type f -name "*.wav" -delete
}


if [ -d "$1" ]; then
  cd "$1"
  convert
  cleanup
else
  echo " Hey Einstein, what about passing me an existing directory as an "
  echo " argument? Hint: it has to contain some m4a file to convert."
  echo " "
fi
