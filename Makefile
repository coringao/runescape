PACKAGE = Old School Runescape
VERSION = 0.5
EXE = runescape

SRCDIR = src
PREFIX = $(DESTDIR)/usr
GAMEDIR = $(PREFIX)/games
STARTUP = $(GAMEDIR)/$(EXE)
ICNDIR = $(PREFIX)/share/pixmaps
APPDIR = $(PREFIX)/share/applications

SCRIPT = runescape.sh
ICON = runescape.png
DESKTOP = runescape.desktop

CP = cp -r
RM = rm -r
MD = mkdir -p
ECHO = echo
CHMOD = chmod 755 -R

all:
	@$(CP) "$(SRCDIR)/$(SCRIPT)" "$(EXE)"
	@$(CHMOD) "$(EXE)"
	@$(ECHO) "Created executable script successfully"

clean:
	rm -f runescape
	@$(ECHO) "Removed script executable successfully"

install: all
	@$(ECHO) "Copying executable script to directory $(GAMEDIR)"
	@$(MD) "$(GAMEDIR)"
	@$(CP) "$(EXE)" "$(GAMEDIR)"
	@$(ECHO) "Copying files in application menu entry"
	@$(MD) "$(ICNDIR)"
	@$(CP) "$(SRCDIR)/$(ICON)" "$(ICNDIR)"
	@$(MD) "$(APPDIR)"
	@$(CP) "$(SRCDIR)/$(DESKTOP)" "$(APPDIR)"
	@$(ECHO) "Installed the files successfully"

uninstall: clean
	@$(ECHO) "Removing files application menu entry"
	@$(RM) "$(STARTUP)"
	@$(RM) "$(ICNDIR)/$(ICON)" "$(APPDIR)/$(DESKTOP)"
	@$(ECHO) "Successfully removed"

.PHONY: all clean install uninstall
