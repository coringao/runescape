#!/bin/bash
#
#	Copyright (C) 2016-2017 Carlos Donizete Froes <coringao@riseup.net>
#	Use of this script is governed by a BSD 2-clause license
#	that can be found in the LICENSE file.
#	Source code and contact info at https://github.com/coringao/runescape
#
# Game:     Runescape
# Date:     October/2017
#
# Download Mac Client
LINK="https://www.runescape.com/downloads/runescape.dmg"

# Directory Runescape
GAME="$HOME/jagexcache/runescape/bin"

# Temporary directory will be created and after installation this directory will be deleted
TEMP="$HOME/.rs-temp"

if [ ! -d $GAME ]; then
	mkdir -p $GAME
	mkdir $TEMP
	cd $TEMP

# Downloading the file in the temporary directory	
	LANG=C wget $LINK --progress=bar:force:noscroll --limit-rate 100k 2>&1 \
	| stdbuf -i0 -o0 -e0 tr '>' '\n' \
	| stdbuf -i0 -o0 -e0 sed -rn 's/^.*\<([0-9]+)%\[.*$/\1/p' \
	| zenity --progress --auto-close --auto-kill 2>/dev/null

# Uncompressing the file in the temporary directory
	7z e runescape.dmg > /dev/null
	mv jagexappletviewer.jar $GAME
        cd
	rm -rf $TEMP
fi

# Running the language selection window to start the game
LANG=C SELECT=`zenity --title=RuneScape --list \
--width=250 --height=250 --radiolist --column "AT" \
--column "Select the language" \
	TRUE  "English" \
	FALSE "French" \
	FALSE "German"\
	FALSE "Portuguese"\
	FALSE "Spanish" 2>/dev/null `

if echo "$SELECT" | grep $"English"; then
	java -Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://www.runescape.com/k=3/l=en/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null
fi
if echo "$SELECT" | grep $"French"; then
	java -Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://www.runescape.com/l=2/l=en/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null
fi
if echo "$SELECT" | grep $"German"; then
	java -Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://www.runescape.com/l=1/l=en/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null
fi
if echo "$SELECT" | grep $"Portuguese"; then
	java -Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://www.runescape.com/l=3/l=en/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null
fi
if echo "$SELECT" | grep $"Spanish"; then
	java -Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://www.runescape.com/l=6/l=en/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null
fi
exit 0
