DIST := dist

MOD_FILES := \
	CS-BetterBalancedGame.modinfo \
	mod_filter.sql

MOD_DIRS := \
	config \
	data \
	lang \
	lua \
	scripts \
	sql \
	ui

MOD_FOLDER_LOC = \
	/home/brian/.var/app/com.valvesoftware.Steam/.local/share/Steam/steamapps/compatdata/289070/pfx/drive_c/users/steamuser/My\ Documents/My\ Games/Sid\ Meier\'s\ Civilization\ VI/Mods

.PHONY: build clean dev

build:
	rm -rf $(DIST)
	mkdir -p $(DIST)
	cp $(MOD_FILES) $(DIST)/
	$(foreach dir,$(MOD_DIRS),cp -r $(dir) $(DIST)/$(dir);)
	zip -r CS-BBG.zip $(DIST)/

clean:
	rm -rf $(DIST)
	rm -f CS-BBG.zip
	rm -rf $(MOD_FOLDER_LOC)/CS-BBG

dev: build
	rm -rf $(MOD_FOLDER_LOC)/CS-BBG
	mkdir -p $(MOD_FOLDER_LOC)/CS-BBG
	mv $(DIST) $(MOD_FOLDER_LOC)/CS-BBG
