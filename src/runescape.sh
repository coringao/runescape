#!/bin/bash
#
#	Copyright (C) 2016 Carlos Donizete Froes <coringao@riseup.net>
#	Use of this script is governed by a BSD 2-clause license
#	that can be found in the LICENSE file.
#	Source code and contact info at https://github.com/coringao/runescape
#
# Game:     Runescape
# Date:     July/2016
#
# Download Mac Client
LINK="https://www.runescape.com/downloads/runescape.dmg"

# Directory Runescape
GAME="$HOME/jagexcache/runescape/bin"

# Temporary directory used by the script: its contents will be deleted.
TEMP="$HOME/.rs-temp"

if [ ! -d $GAME ]; then
	mkdir -p $GAME
	mkdir $TEMP
	cd $TEMP	
	wget -c -q $LINK
	7z e runescape.dmg > /dev/null
	7z e 0.hfs -y > /dev/null
	mv jagexappletviewer.jar $GAME
        cd
	rm -rf $TEMP
fi
SELECT=`zenity --title=RuneScape --list \
--window-icon=/usr/share/pixmaps/runescape.xpm \
--width=250 --height=250 --radiolist --column "AT" \
--column "Select the language" \
	TRUE  "English" \
	FALSE "French" \
	FALSE "German"\
	FALSE "Portuguese"\
	FALSE "Spanish"`
	   
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
