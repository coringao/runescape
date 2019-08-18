#!/bin/bash
#
#	Copyright (c) 2016-2019, Carlos Donizete Froes <coringao@riseup.net>
#	Use of this script is governed by a BSD 2-clause license
#	that can be found in the LICENSE file.
#	Source code and contact info at https://gitlab.com/coringao/runescape
#
#	Game Terms and Conditions: Copyright (c) 1999-2019, Jagex Ltd
#	Use of this website is subject to our Terms & Conditions[1],
#	Privacy Policy[2] and Cookie Policy[3].
#
#	[1] https://www.jagex.com/terms
#	[2] https://www.jagex.com/terms/privacy
#	[3] https://www.jagex.com/terms/cookies
#
# Script Name:	runescape.sh
# Update Date:	August/2019
# Edited version: '0.6'
#
# Download Client - Old School Runescape
LINK="https://oldschool.runescape.com/downloads/jagexappletviewer.jar"

# Hidden directory Runescape
GAME="$HOME/.local/share/runescape"

# Temporary directory will be created and after installation
# this directory will be deleted
TEMP="$(mktemp -d /tmp/runescape.XXXXX)"

if [ ! -d $GAME ]; then
	mkdir -p $GAME
	cd $TEMP

# Downloading the file in the temporary directory
	LANG=C wget $LINK 2>/dev/null
	mv jagexappletviewer.jar $GAME
fi

# Preparing sandbox environment and running the game
	java -Duser.home="$GAME" --add-opens java.base/java.lang=ALL-UNNAMED \
	-Xmx512m -Xms512m -Djava.class.path="$GAME/jagexappletviewer.jar" \
	-Dcom.jagex.config=http://oldschool.runescape.com/jav_config.ws \
	jagexappletviewer "$GAME" > /dev/null 2>&1

# Removing temporary directory
	rm -rf $TEMP

exit 0
