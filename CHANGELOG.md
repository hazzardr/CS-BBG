# CS-BBG Changelog

## CS-BBG 7.5.0 (Unreleased)

Rebased on **Better Balanced Game 7.5.0** (previous CS-BBG release was based on BBG 7.4.3).
Values are Standard speed unless noted. "old → new" is shown where the previous value is known.

### CS-BBG differences from upstream BBG

These carry over from the previous CS-BBG release and still apply on top of 7.5:

- **No strategic resources from buildings.** Armory, Military Academy, Barracks, Stable, Hangar, Airport, Shipyard and Seaport do not grant per-turn strategic resources. 7.5's new Seaport bonus (+1 Coal, +1 Oil) is also removed. Tooltips (English, French) updated to match.
- **Steel & Thunder units enabled.** All Steel & Thunder unique units are available; the separate Steel & Thunder mod is no longer needed.
- Removed broken modinfo references to files that don't exist (Indonesia/Khmer `Other.sql` and utils, Saladin LP file).

---

### Highlights

- **Oligarchy reworked**, and its old +4 melee bonus is now baked into every melee / anti-cavalry / naval melee / monk unit — but locked behind **Political Philosophy** for everyone.
- **Modern & Information era unit/tech path reshuffled** (Infantry at Refining, Mech Infantry at Guidance Systems, AT Crew at Advanced Ballistics, Mobile SAM at Satellites).
- **Ocean tiles cost 2 movement** until Cartography.
- **The Wheel moved to the Classical era**; Heavy Chariot reworked into a 36-strength, Iron-costing unit.
- **New policy cards**: Modern Drill, Naval Guilds, Military Standardization.
- **Autocracy nerfed**, **Communism buffed**.
- **BBG Expanded**: balance for Austria, Goths, Taíno (Anacaona) and Poland (Stanisław).

---

### Governments

- **Oligarchy (rework)**
  - Removed: +4 Combat Strength for melee / anti-cav / naval melee (moved to the units themselves, see *Unit classes*).
  - Unit XP bonus +20% → **+40%** (government and legacy card).
  - **New:** +1 Combat Strength per promotion for most military unit classes (land, naval, air; not Giant Death Robot). Government and legacy card.
  - **New (government only):** civilian and support units starting their turn in friendly territory get +1 Movement.
- **Autocracy:** the Palace no longer counts for the +1 all yields bonus (still applies to Government Plaza, Diplomatic Quarter and their buildings). Government and legacy card.
- **Communism:** now gives **+10% Science in cities with a Campus**.
- **Democracy (legacy card):** now keeps the +2 Production on ally/suzerain trade routes.
- **Third Alternative (Fascism):** Seaports now also give +4 Gold and +2 Culture.

### Policy Cards

- **Modern Drill (new, Military, Mobilization):** +50% Production toward Modern-era-and-earlier melee, anti-cav, ranged and recon units.
- **Grande Armée:** now Industrial era and earlier only (also fixed to include Classical ranged). Upgrades into Modern Drill → Military First.
- **Naval Guilds (new, Military, Civil Service):** +100% Production toward Ancient–Medieval naval melee, raider and ranged units. Chain: Maritime Industries → Naval Guilds → Press Gangs / International Waters.
- **Military Standardization (new, Military, Nationalism):** 45% Gold discount on unit upgrades.
- **Professional Army:** upgrade discount 50% → **40%**. **Force Modernization** (50%) now requires **Ideology**. Chain: Professional Army → Military Standardization → Force Modernization.
- **Military First:** now requires Ideology (was Mobilization).
- **Defense of the Motherland:** now requires Mass Media (was Ideology).
- **Scientific Vanguard:** removed.
- **Discipline:** also gives +1 Sight to recon units.
- **Caravansaries** and **Triangular Trade:** also give +1 Production on international trade routes.
- **Religious Orders:** religious units spread 50% more strongly in foreign cities.
- **Resource Management:** also gives +2 Production on improved strategic resources.
- **Simultaneum, Grand Opera, Free Market:** both bonuses (pop 13+ and high adjacency) +50% → **+100%**.
- **Revelation:** no longer goes obsolete.

### Units

#### Unit classes & promotions
- **Melee, Anti-Cavalry, Naval Melee, Warrior Monk, Nihang:** +4 base Combat Strength for all units of these classes (including uniques), but a **−4 "Lack of philosophy" penalty until Political Philosophy** is unlocked. Melee units with a ranged attack also get +4 Ranged Strength.
- **Heavy Cavalry (new ability):** +3 Combat Strength vs Melee, Nihang and Warrior Monk units.
- **All combat units (new):** +4 Combat Strength when attacking fortified cavalry.
- **Battlecry:** +7 → **+5**.
- **Thrust:** BBG's +10 override removed (now +5 vs melee per tooltip).
- **Max XP per combat:** 8 → **10**.

#### Ancient & Classical
- **Heavy Chariot (rework):** Combat 28 → **36**, Cost 65 → **90**, 2 Movement, now costs **20 Iron**. Obsolete at Ballistics.
- **Skirmisher:** Cost 150 → **120**.

#### Medieval → Industrial (obsolescence)
- **Musketman, Conquistador, Janissary:** obsolete at Refining (was Replaceable Parts).
- **Line Infantry, Redcoat, Garde Impériale:** now obsolete at Guidance Systems.
- **Pikeman:** now obsolete at Advanced Ballistics. **Pike & Shot:** now obsolete at Composites.

#### Modern & Information
- **Infantry:** unlocks at **Refining** (was Replaceable Parts).
- **Mechanized Infantry:** unlocks at **Guidance Systems** (was Satellites). 7.4.3's 5 Movement / ignore ZOC buff reverted.
- **AT Crew:** unlocks at **Advanced Ballistics** (was Chemistry). +1 Movement, Cost 460, Maintenance 6.
- **Modern AT:** +1 Movement.
- **Modern Armor:** conditional +5 bonuses replaced with flat Combat 90 → **100**.
- **Machine Gun:** loses its Anti-Air (7.4.3 buff reverted). Ranged Strength −5. Cost 600.
- **Rock Band:** 2 Movement; can no longer be captured — it is destroyed if an enemy moves onto it.

#### Naval
- **Quadrireme:** Range 1 → **2**, Ranged Strength 25 → **23**, Cost 120 → **160**. Obsolete at Refining.

#### Air & Anti-Air
- **Anti-Air Gun:** Movement 2 → **4**.
- **Mobile SAM:** unlocks at **Satellites** (was Guidance Systems).

#### Siege & Support
- **All Siege units:** +5 Combat Strength when attacking districts (was Artillery and Rocket Artillery only).
- **Battering Ram (new aura):** +1 Movement to adjacent Classical-or-earlier melee, ranged, anti-cav and Warrior Monk units.
- **Siege Tower (new aura):** +1 Movement to adjacent melee, ranged and anti-cav units up to the Renaissance era (Warrior Monks up to Classical).
- **Medic:** movement aura now also covers Warrior Monks; multiple Medics no longer stack.
- **Military Engineer:** unlocks at **Engineering** (was Military Engineering); requires a **Barracks or Stable** instead of an Armory.
- **Mountain Tunnel:** unlocks at Military Engineering (was Military Science).

### Civilizations

#### America (Lincoln)
- Industrial Zone buildings give +2 Culture.

#### Arabia
- Fixed the Campus ↔ Holy Site adjacency leaking to other civs.

#### Australia
- Digger unlocks at Refining (follows Infantry).

#### China (Yongle)
- Gold per Population in 10+ pop cities: +1 → **+0.5**.

#### Egypt
- Maryannu Chariot Archer unlocks at **Masonry** (was The Wheel).

#### England
- **Sea Dog** is now Elizabeth-only. With BBG Expanded, England gets the Longbowman instead.
- Powered building bonus moved from Victoria (Age of Steam) to the civ ability (all English leaders): +4 → **+3** extra yield per powered building.
- **Victoria (Age of Steam):** +1 Production on improved strategic resources.

#### Georgia
- Tsikhe: +1 Great Prophet point per turn.

#### Germany (Barbarossa)
- +7 Combat Strength vs City-States now also applies vs unique units.

#### Inca
- Terrace Farm: +1 Production if the city has a Water Mill.

#### India
- **Varu:** Cost 120 → **110**; adjacent enemy penalty −5 → **−3**.

#### Macedon / Mongolia
- Basilikoi Paides and Ordu count as the prereq for Military Engineers.

#### Mali
- Civ ability: −5% Production penalty **removed**.
- Suguba: purchase discount 20% → **10%**; standard Holy Site adjacency removed.
- **Mansa Musa:** Holy Site production bonus +15% → **+10%** (still +2 Gold to Suguba per adjacent Holy Site).
- **Sundiata Keita:** Theater Square adjacency to Suguba +1 → **+2** Gold; no Holy Site adjacency.

#### Māori
- Toa adjacent enemy penalty −5 → **−3**.
- Fishing Boats no longer culture-bomb.
- Pā: +1 Production, +1 Gold.

#### Norway
- Negative Rainforest start bias.
- **Harald (Konge):** early Ocean entry no longer applies to Quadriremes; Longships and Berserkers ignore Ocean movement cost.

#### Nubia
- Ta-Seti: +30% Production toward naval ranged units.

#### Ottomans
- Grand Bazaar unlocks with the **Guilds** civic.

#### Persia
- **Immortal (rework):** Ranged Strength 23 → **25**, Range 2 → **1**, no longer counts as a ranged unit for bonuses.

#### Poland
- Military → Wildcard slot conversion now requires **Early Empire** (was from the start of the game).

#### Rome
- Bath: Culture adjacency +1 per 2 districts → **+1 per district**.
- Legion: Combat 38 → **40** (nerf reverted).
- Roman Fort: +1 Production, +1 Gold; now gives era score as a unique improvement.

#### Russia
- Lavra Tundra food bonus now requires a **Temple** (was Shrine).

#### Sweden
- +50% Production now applies to **all** Campus and Industrial Zone buildings.
- Every standard Campus building gives +1 Great Scientist point; every standard Industrial Zone building gives +1 Great Engineer point (was University / Factory only).
- Queen's Bibliothèque: same-creator Great Works give 4 Culture / 4 Tourism.

#### City-States (Lahore)
- Nihang get +1 Movement from adjacent Battering Ram / Siege Tower.

### BBG Expanded (only with BBG Expanded and the relevant civ mods enabled)

#### Austria — Maria Theresa (new)
- **Diplomatic Marriage:** earn a **Great Diplomat** for each Government Plaza building (max 3). Can absorb a City-State you are Suzerain of; grants Diplomatic Favor while next to another player's Palace.
- **Theresian Reform:** each established Governor gives +15% Production toward districts and units in its city.
- Removed: Favor per governor, free melee unit, extra Diplomatic slot.
- **Grenzer** (replaces Ranger): Combat 60, Ranged 70.
- Coffee House Great Works: 4 Culture / 4 Tourism. Start biases removed.

#### Goths — Theodoric (new)
- **Gothic Migration:** after Early Empire, settling or gaining a city gives +1 Population to other Gothic cities within 6 tiles (needs spare Housing; once per city).
- **Hlaiw:** +1 Movement to land melee, ranged, anti-cav, siege and recon within 6 tiles; can buy Warrior Monks; Faith/Culture per Pop 0.5 → 0.25.
- **Militond** (replaces Swordsman): Combat 38 (+4 base bonus), costs Iron; district bonus +10 → +5.
- **Gadrauht** (replaces Pikeman): Combat 47 (+4 base bonus), Cost 180; costs Population only in cities without a Temple.
- Start biases removed.

#### Poland — Stanisław (new)
- **Leader ability (replaced):** improved tiles or visible strategic resources get +1 Food next to an Encampment, +1 Culture next to Barracks/Stable, +1 Science next to an Armory, +1 Production next to a Military Academy.
- **Uhlan:** 5 Movement, Cost 330, flanking bonus 100% → 50%.

#### Taíno — Anacaona (new)
- **Civ ability:** Great Person policy cards give +2 Food on their matching district and +1 Food per building in it; Diplomatic policies give +1 Amenity in cities with a Batéy.
- **Leader ability:** after Political Philosophy, each active Dedication gives an extra policy slot; +5/10/15% Gold in Happy/Ecstatic/Euphoric cities; Arenas get 2 Great Writing slots.
- **Batéy** (replaces Entertainment Complex): +2 Production / +3 Gold per adjacent Commercial Hub, +4 / +6 per adjacent Harbor; Theater Squares get +2 Culture next to it.
- **Unique recon unit** (replaces Warrior): Combat 19, 3 Movement, 3 Sight, +5 vs stronger units. Scouts no longer disabled.
- **Conuco:** can't be adjacent to another Conuco; buildable on Grassland/Plains/Tundra Hills; +2 Gold per adjacent Bonus/Luxury at Mercantilism; +1 Culture at Natural History.
- Start biases removed.

#### Other Expanded changes
- **English Longbowman** enabled: unlocks at Medieval Faires civic; loses +4 vs Melee/Cavalry.
- **Cog:** Combat 42.
- **Spearthrower Owl:** +1 trade route from a Consulate; +100% Production toward Diplomatic Quarter buildings.
- **Tibet (Trisong):** Dzong cost progression 35.

### Great People & Governors

- **Euclid:** replaces the random Medieval boost with **+1 district capacity** in the city.
- **Modern Great General aura:** now also affects Information-era units.
- **Liang (Agriculture / Zoning Commissioner):** +1 Food / +1 Production now only on improved resources (or a City Center on a resource).

### Districts, Buildings & Improvements

- **Neighborhood (rework):** one per city, +2 Food, +1 adjacency to adjacent districts.
- **Shipyard:** unimproved Coast/Lake Production +1 → **+2** (fisheries still +1).
- **Food Market:** Cost 290, 5 Food.
- **Fort:** +1 Production, +1 Gold.
- **Seaside Resort:** Appeal-based Tourism/Gold 150% → **100%**.

### Wonders

- **Big Ben:** moved back to its base-game tech (Capitalism civic change reverted).

### Religion

- **River Goddess:** Holy Site river Faith +2 → **+1**.
- **Drums of War (dedication):** unit maintenance discount removed.

### Espionage

- Enemy counter-spy and spy-level penalties to offensive operations **doubled**.

### Tech & Civic Tree

- **The Wheel:** moved to the **Classical** era, Cost 120.
- **Steam Power:** extra prereq is now Astronomy (was Scientific Theory).
- **Advanced Ballistics:** no longer requires Replaceable Parts.
- **Guidance Systems:** requires Nuclear Fission instead of Rocketry.
- **Composites:** also requires Nuclear Fission.
- **Cartography:** also requires Military Tactics.
- New 40% civic boosts: Cultural Hegemony (5 Spies), Information Warfare (1 Giant Death Robot), Exodus Imperative (2 Spaceports), Smart Power Doctrine (Predictive Systems), Global Warming Mitigation (3 Wind Farms).

### Map & Movement

- **Ocean tiles cost 2 Movement.** Ocean entry moved from Cartography to **Buttress**; Cartography now makes units ignore Ocean movement cost.
- **Natural wonders:** Sahara el Beyda +1 Food; Rock of Gibraltar +1 Production to adjacent tiles; Lake Victoria 3 Food.

### Culture Victory

- Same-artist / same-archaeologist Great Work theming bonuses now apply per slot type in **any** building: Art slots 4 Culture / 4 Tourism, Artifact slots 6 / 6, Palace slot 4 / 4 (was Hermitage, Art Museum and Archaeological Museum only).

### Known issues (inherited from upstream 7.5)

- Oligarchy's civilian/support +1 Movement references requirement sets that aren't defined in the mod and may not work.
- Nihang get the +4 base Combat Strength but not the matching −4 pre–Political Philosophy penalty, so they may keep the bonus from the start.
- Several tooltips are out of date: Siege Tower says "medieval or earlier" (code allows up to Renaissance); Longbowman ability text still lists +4 vs Melee/Cavalry; the German text still mentions building-granted resources.
