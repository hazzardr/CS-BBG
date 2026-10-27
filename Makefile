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

# Civ VI runs under Proton: Mods live in Documents, Logs (and Mods.sqlite cache) in AppData/Local
PROTON_USER_DIR ?= $(HOME)/.local/share/Steam/steamapps/compatdata/289070/pfx/drive_c/users/steamuser
CIV_USER_DIR ?= $(PROTON_USER_DIR)/My\ Documents/My\ Games/Sid\ Meier\'s\ Civilization\ VI
CIV_APPDATA_DIR ?= $(PROTON_USER_DIR)/AppData/Local/Firaxis\ Games/Sid\ Meier\'s\ Civilization\ VI

MOD_FOLDER_LOC ?= $(CIV_USER_DIR)/Mods
LOGS_DIR ?= $(CIV_APPDATA_DIR)/Logs

# Logs opened by `make logs` (:n / :p in less to switch); override with LOGS="GameCore.log ..."
LOGS ?= Modding.log Database.log Lua.log

# This mod's own id (the <Mod id="..." version="..."> header), used to find old installs
MOD_ID := $(shell sed -n 's/^[[:space:]]*<Mod id="\([^"]*\)" version=.*/\1/p' CS-BetterBalancedGame.modinfo)

.PHONY: build clean dev uninstall logs

build:
	rm -rf $(DIST)
	mkdir -p $(DIST)
	cp $(MOD_FILES) $(DIST)/
	$(foreach dir,$(MOD_DIRS),cp -r $(dir) $(DIST)/$(dir);)
	zip -r CS-BBG.zip $(DIST)/

# Remove every installed copy of this mod, whatever its folder is named
uninstall:
	@test -n "$(MOD_ID)" || { echo "could not read mod id from modinfo"; exit 1; }
	@for d in $(MOD_FOLDER_LOC)/*/; do \
		[ -d "$$d" ] || continue; \
		if grep -rqs --include='*.modinfo' '<Mod id="$(MOD_ID)" version=' "$$d"; then \
			echo "removing $$d"; rm -rf "$$d"; \
		fi; \
	done

clean: uninstall
	rm -rf $(DIST)
	rm -f CS-BBG.zip

dev: build uninstall
	mkdir -p $(MOD_FOLDER_LOC)/CS-BBG
	mv $(DIST) $(MOD_FOLDER_LOC)/CS-BBG

logs:
	@cd $(LOGS_DIR) 2>/dev/null || { echo "no Logs folder at $(LOGS_DIR); launch the game once first"; exit 1; }; \
	files=""; for f in $(LOGS); do [ -f "$$f" ] && files="$$files $$f"; done; \
	[ -n "$$files" ] || { echo "none of $(LOGS) found in $(LOGS_DIR)"; ls; exit 1; }; \
	less +G $$files
