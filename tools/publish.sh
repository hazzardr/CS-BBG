#!/usr/bin/env bash
# Publish a CS-BBG release: upload dist/ to the Steam Workshop with SteamCMD,
# then tag the commit and create a GitHub release with CS-BBG.zip attached.
#
# Usage (via make): make publish VERSION=v1.3.0 [NOTES=notes.md] STEAM_USERNAME=you
#
# SteamCMD reuses its cached login; the first run prompts for your password and
# Steam Guard code interactively, so no credentials are stored in this repo.
set -euo pipefail

VERSION=${1:-}
NOTES_FILE=${2:-}
STEAMCMD=${STEAMCMD:-steamcmd}
APP_ID=289070          # Civilization VI
ITEM_ID=3682506078     # CS-BBG Workshop item
REPO=hazzardr/CS-BBG
MODINFO=CS-BetterBalancedGame.modinfo

die() { echo "error: $*" >&2; exit 1; }
vdf_escape() { local s=${1//\\/\\\\}; printf '%s' "${s//\"/\\\"}"; }
modinfo_version() { sed -n 's/^[[:space:]]*<Mod id="[^"]*" version="\([^"]*\)".*/\1/p'; }

# --- preflight: fail before anything is uploaded --------------------------------
[[ $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "VERSION must look like v1.2.3 (got '$VERSION')"
[[ -n ${STEAM_USERNAME:-} ]] || die "set STEAM_USERNAME to your Steam login name"
[[ -z $NOTES_FILE || -f $NOTES_FILE ]] || die "notes file '$NOTES_FILE' not found"
command -v "$STEAMCMD" >/dev/null || die "'$STEAMCMD' not found; install steamcmd or set STEAMCMD=/path/to/steamcmd.sh"
command -v gh >/dev/null || die "gh (GitHub CLI) not found"
gh auth status >/dev/null 2>&1 || die "gh is not logged in; run 'gh auth login'"

[[ $(git branch --show-current) == main ]] || die "publish from main"
[[ -z $(git status --porcelain) ]] || die "working tree has uncommitted changes"
git fetch -q origin main --tags
[[ $(git rev-parse HEAD) == $(git rev-parse origin/main) ]] || die "local main differs from origin/main; pull or push first"
! git rev-parse -q --verify "refs/tags/$VERSION" >/dev/null || die "tag $VERSION already exists"

name=$(sed -n 's:.*<Name>\(.*\)</Name>.*:\1:p' "$MODINFO" | head -1)
mod_version=$(modinfo_version < "$MODINFO")
last_tag=$(git describe --tags --abbrev=0 2>/dev/null || true)
last_mod_version=$( [[ -n $last_tag ]] && git show "$last_tag:$MODINFO" 2>/dev/null | modinfo_version || true)

echo "About to publish:"
echo "  release:   $VERSION at $(git rev-parse --short HEAD) (previous: ${last_tag:-none})"
echo "  mod:       $name, modinfo version $mod_version"
echo "  workshop:  item $ITEM_ID as Steam user $STEAM_USERNAME"
echo "  notes:     ${NOTES_FILE:-auto-generated from commits}"
if [[ -n $last_mod_version && $mod_version == "$last_mod_version" ]]; then
  echo "  WARNING:   modinfo version is unchanged since $last_tag; Civ may keep showing cached mod info"
fi
read -r -p "Continue? [y/N] " answer
[[ $answer == [yY] ]] || die "aborted"

# --- build ---------------------------------------------------------------------
make build

# --- Steam Workshop --------------------------------------------------------------
if [[ -n $NOTES_FILE ]]; then
  changenote="$VERSION"$'\n\n'"$(cat "$NOTES_FILE")"
else
  changenote="$VERSION - release notes: https://github.com/$REPO/releases/tag/$VERSION"
fi

vdf=$(mktemp)
trap 'rm -f "$vdf"' EXIT
cat > "$vdf" <<EOF
"workshopitem"
{
  "appid" "$APP_ID"
  "publishedfileid" "$ITEM_ID"
  "contentfolder" "$(vdf_escape "$PWD/dist")"
  "changenote" "$(vdf_escape "$changenote")"
}
EOF

echo "Uploading to the Steam Workshop (you may be prompted for your password / Steam Guard code)..."
"$STEAMCMD" +@ShutdownOnFailedCommand 1 +login "$STEAM_USERNAME" +workshop_build_item "$vdf" +quit \
  || die "SteamCMD upload failed; nothing was tagged or released"

# --- git tag + GitHub release ------------------------------------------------------
git tag -a "$VERSION" -m "CS-BBG $VERSION"
git push origin "$VERSION"

notes_args=(--generate-notes)
[[ -n $NOTES_FILE ]] && notes_args=(--notes-file "$NOTES_FILE")
gh release create "$VERSION" CS-BBG.zip -R "$REPO" --verify-tag --title "CS-BBG $VERSION" "${notes_args[@]}"

echo "Published $VERSION to the Workshop and https://github.com/$REPO/releases/tag/$VERSION"
