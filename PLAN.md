# Steam Workshop Publishing via GitHub Actions

## Overview

Use the [`weilbyte/steam-workshop-upload`](https://github.com/Weilbyte/steam-workshop-upload) GitHub Action to automatically publish this mod to the Steam Workshop when a version tag is pushed. The action wraps SteamCMD and supports Steam Guard 2FA.

**Civilization VI Steam App ID:** `289070`

**SteamCMD documentation:** https://developer.valvesoftware.com/wiki/SteamCMD

SteamCMD is Valve's command-line version of the Steam client. It can install/update game servers and — relevant here — upload content to the Steam Workshop without needing the full Steam GUI. The `weilbyte` action and the raw fallback approach both use it under the hood.

---

## Workflow Design

- **Trigger:** Push a git tag matching `v*` (e.g. `v7.3.2`)
- **Target:** Release Workshop item only
- **Pre-processing:** None — upload the repo root as-is

### File to Create

**`.github/workflows/publish-steam.yml`**

```yaml
name: Publish to Steam Workshop

on:
  push:
    tags:
      - 'v*'

jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Upload to Steam Workshop
        uses: weilbyte/steam-workshop-upload@v1
        with:
          appid: 289070                    # Civilization VI
          itemid: <RELEASE_WORKSHOP_ID>    # numeric ID from Steam Workshop URL
          path: '.'                        # repo root is the mod folder
        env:
          STEAM_USERNAME: ${{ secrets.STEAM_USERNAME }}
          STEAM_PASSWORD: ${{ secrets.STEAM_PASSWORD }}
          STEAM_TFASEED: ${{ secrets.STEAM_TFASEED }}
```

---

## Setup Steps

### 1. Find the Workshop Item ID

Open the mod's Steam Workshop page and copy the numeric ID from the URL:

```
https://steamcommunity.com/sharedfiles/filedetails/?id=XXXXXXXXXX
                                                        ^^^^^^^^^^
                                                        This is the itemid
```

The mod has three Workshop slots defined in `BetterBalancedGame.modinfo`. Use the Release slot ID as `itemid`.

### 2. Add GitHub Secrets

Go to **Settings → Secrets and variables → Actions** in the GitHub repo and add:

| Secret | Value |
|--------|-------|
| `STEAM_USERNAME` | Steam account username |
| `STEAM_PASSWORD` | Steam account password |
| `STEAM_TFASEED` | Steam Guard 2FA `shared_secret` (see below) |

### 3. Get the Steam Guard 2FA Seed

The `STEAM_TFASEED` is the `shared_secret` from your Steam authenticator. Ways to obtain it:

- **[SteamDesktopAuthenticator](https://github.com/Jessecar96/SteamDesktopAuthenticator):** Can export `shared_secret` from a linked authenticator.
- **Android (rooted):** Extract from `/data/data/com.valvesoftware.android.steam.community/files/`.
- **WinAuth / other TOTP apps:** Some allow exporting the raw secret.

### 4. Trigger a Publish

```bash
git tag v7.3.2
git push origin v7.3.2
```

The workflow will fire automatically and upload to the Workshop.

---

## Key Risks and Mitigations

| Risk | Mitigation |
|------|-----------|
| Steam account credentials in CI | Use a dedicated publisher Steam account added as a Workshop contributor, not your personal account |
| Steam Guard blocking SteamCMD | Provide `STEAM_TFASEED`; without it the login will fail if Guard is enabled |
| Action is community-maintained (low star count) | Fallback option: write a raw SteamCMD `workshop_build_item` script directly in the workflow — more verbose but more control |
| Accidental publish on unintended push | Tag-based trigger ensures only intentional version tags trigger a publish |

---

## Alternative: Raw SteamCMD Approach

If the `weilbyte` action proves unreliable, the workflow can drive SteamCMD directly:

```yaml
- name: Install SteamCMD
  run: |
    sudo apt-get install -y lib32gcc-s1
    mkdir -p ~/steamcmd && cd ~/steamcmd
    curl -sSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

- name: Build VDF descriptor
  run: |
    cat > /tmp/workshop.vdf <<EOF
    "workshopitem"
    {
      "appid" "289070"
      "publishedfileid" "<RELEASE_WORKSHOP_ID>"
      "contentfolder" "${{ github.workspace }}"
      "changenote" "Release ${{ github.ref_name }}"
    }
    EOF

- name: Upload via SteamCMD
  run: |
    ~/steamcmd/steamcmd.sh \
      +login $STEAM_USERNAME $STEAM_PASSWORD \
      +workshop_build_item /tmp/workshop.vdf \
      +quit
  env:
    STEAM_USERNAME: ${{ secrets.STEAM_USERNAME }}
    STEAM_PASSWORD: ${{ secrets.STEAM_PASSWORD }}
```

Note: The raw approach does not handle Steam Guard 2FA automatically — you would need a Guard-free account or a separate TOTP step.
