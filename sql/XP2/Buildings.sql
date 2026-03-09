--==============================================================
--******                  BUILDINGS                       ******
--==============================================================
-- flood barriers unlocked at steam power
UPDATE Buildings SET PrereqTech='TECH_STEAM_POWER' WHERE BuildingType='BUILDING_FLOOD_BARRIER';
-- 15/12/24 mili engineer give 50% prod cost of flood barriers (from 20)
UPDATE Building_BuildChargeProductions SET PercentProductionPerCharge=50 WHERE BuildingType='BUILDING_FLOOD_BARRIER';
-- 15/10/23 oil power plant unlocked at refining
UPDATE Buildings SET PrereqTech='TECH_REFINING' WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT';
UPDATE Projects SET PrereqTech='TECH_REFINING' WHERE ProjectType='PROJECT_CONVERT_REACTOR_TO_OIL';

UPDATE Building_YieldChanges SET YieldChange=6 WHERE BuildingType='BUILDING_FOSSIL_FUEL_POWER_PLANT' AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=8 WHERE BuildingType='BUILDING_POWER_PLANT' AND YieldType='YIELD_PRODUCTION';
UPDATE Building_YieldChanges SET YieldChange=6 WHERE BuildingType='BUILDING_POWER_PLANT' AND YieldType='YIELD_SCIENCE';
-- moved from buildings, because it's GS
UPDATE Building_YieldChangesBonusWithPower SET YieldChange=12 WHERE BuildingType='BUILDING_STOCK_EXCHANGE' AND YieldType='YIELD_GOLD';

-- 14/10/23 Reduced by 15% from base game
UPDATE Buildings SET Cost=320 WHERE BuildingType='BUILDING_HANGAR';
UPDATE Buildings SET Cost=400 WHERE BuildingType='BUILDING_AIRPORT';

-- 16/12/25 Research Lab Science when powered reduced to 3 from 5
UPDATE Building_YieldChangesBonusWithPower SET YieldChange=3 WHERE BuildingType='BUILDING_RESEARCH_LAB' AND YieldType='YIELD_SCIENCE';
-- 16/12/25 Research Lab Science receive +3 Science once reaching Nuclear Program Civic
INSERT INTO CivicModifiers (CivicType, ModifierId) VALUES
    ('CIVIC_NUCLEAR_PROGRAM', 'BBG_RESEARCH_LAB_SCIENCE_NUCLEAR_PROGRAM_BONUS');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
    ('BBG_RESEARCH_LAB_SCIENCE_NUCLEAR_PROGRAM_BONUS', 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_RESEARCH_LAB_SCIENCE_NUCLEAR_PROGRAM_BONUS', 'YieldType', 'YIELD_SCIENCE'),
    ('BBG_RESEARCH_LAB_SCIENCE_NUCLEAR_PROGRAM_BONUS', 'Amount', '3'),
    ('BBG_RESEARCH_LAB_SCIENCE_NUCLEAR_PROGRAM_BONUS', 'BuildingType', 'BUILDING_RESEARCH_LAB');
UPDATE Buildings SET Description='LOC_BUILDING_RESEARCH_LAB_EXPANSION2_DESCRIPTION' WHERE BuildingType='BUILDING_RESEARCH_LAB';
UPDATE Civics SET Description='LOC_CIVIC_NUCLEAR_PROGRAM_DESCRIPTION' WHERE CivicType='CIVIC_NUCLEAR_PROGRAM';

--==============================================================
--*****                  WONDERS(Built)                   ******
--==============================================================
-- Golden Gate Bridge: Fixed Bug, where one side of the Bridge is impassible
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
    ('BBG_REQUIRES_PLOT_IS_ADJACENT_TO_GOLDENGATE', 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
    ('BBG_REQUIRES_PLOT_IS_ADJACENT_TO_GOLDENGATE', 'BuildingType', 'BUILDING_GOLDEN_GATE_BRIDGE'),
    ('BBG_REQUIRES_PLOT_IS_ADJACENT_TO_GOLDENGATE', 'MinRange', '0'),
    ('BBG_REQUIRES_PLOT_IS_ADJACENT_TO_GOLDENGATE', 'MaxRange', '1');
INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
    ('BBG_GOLDENGATE_REQSET', 'REQUIREMENTSET_TEST_ALL'),
    ('BBG_PLAYER_HAS_TECH_ADVANCED_FLIGHT_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('BBG_GOLDENGATE_REQSET', 'BBG_REQUIRES_PLOT_IS_ADJACENT_TO_GOLDENGATE'),
    ('BBG_GOLDENGATE_REQSET', 'AOE_REQUIRES_LAND_DOMAIN');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_GOLDENGATE_IGNORE_CLIFF', 'MODIFIER_ALL_UNITS_ATTACH_MODIFIER', 'BBG_GOLDENGATE_REQSET');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_GOLDENGATE_IGNORE_CLIFF', 'ModifierId', 'COMMANDO_BONUS_IGNORE_CLIFF_WALLS');
INSERT INTO GameModifiers(ModifierId) VALUES ('BBG_GOLDENGATE_IGNORE_CLIFF');
--Panama Custom Placement
INSERT INTO CustomPlacement(ObjectType, Hash, PlacementFunction)
    SELECT Types.Type, Types.Hash, 'BBG_PANAMA_CANAL_CUSTOM_PLACEMENT'
    FROM Types WHERE Type = 'BUILDING_PANAMA_CANAL';

-- University of Sankore - new bonus : Add +1 trader capacity AND add +1science +2gold for your all your traders (internal/external)
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_UNIVERSITY_SANKORE' AND ModifierId='SANKORE_TRADE_OFFER_SCIENCE';
INSERT INTO Modifiers (ModifierId , ModifierType) VALUES
    ('UNIVERSITY_SANKORE_ADD_SCIENCE_TO_TRADEROUTE', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD'),
    ('UNIVERSITY_SANKORE_ADD_GOLD_TO_TRADEROUTE', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD'),
    ('UNIVERSITY_SANKORE_ADD_TRADER_CAPACITY', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_CAPACITY');  
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('UNIVERSITY_SANKORE_ADD_SCIENCE_TO_TRADEROUTE', 'YieldType', 'YIELD_SCIENCE'),
    ('UNIVERSITY_SANKORE_ADD_SCIENCE_TO_TRADEROUTE', 'Amount', '1'),
    ('UNIVERSITY_SANKORE_ADD_GOLD_TO_TRADEROUTE', 'YieldType', 'YIELD_GOLD'),
    ('UNIVERSITY_SANKORE_ADD_GOLD_TO_TRADEROUTE', 'Amount', '2'),
    ('UNIVERSITY_SANKORE_ADD_TRADER_CAPACITY', 'Amount', '1');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
    ('BUILDING_UNIVERSITY_SANKORE', 'UNIVERSITY_SANKORE_ADD_SCIENCE_TO_TRADEROUTE'),
    ('BUILDING_UNIVERSITY_SANKORE', 'UNIVERSITY_SANKORE_ADD_GOLD_TO_TRADEROUTE'),
    ('BUILDING_UNIVERSITY_SANKORE', 'UNIVERSITY_SANKORE_ADD_TRADER_CAPACITY');

-- Meenakshi Temple - Grant 2 apostles instead of 2guru + Apostles/Guru cost 25% less
DELETE FROM BuildingModifiers WHERE BuildingType='BUILDING_MEENAKSHI_TEMPLE' AND ModifierId='MEENAKSHITEMPLE_FREE_GURU';
INSERT OR REPLACE INTO Modifiers (ModifierId, ModifierType) VALUES
    ('MEENAKSHI_TEMPLE_GRANT_FREE_APOSTLES', 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('MEENAKSHI_TEMPLE_GRANT_FREE_APOSTLES', 'UnitType', 'UNIT_APOSTLE'),
    ('MEENAKSHI_TEMPLE_GRANT_FREE_APOSTLES', 'Amount', '2');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
    ('BUILDING_MEENAKSHI_TEMPLE', 'MEENAKSHI_TEMPLE_GRANT_FREE_APOSTLES');
-- 30/06/25 Meenakshi Temple : 2 apostle Give 2 faith on every forest and jungle tile of your land
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
    ('BBG_PLOT_HAS_FOREST_REQSET', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
    ('BBG_PLOT_HAS_FOREST_REQSET', 'PLOT_IS_FOREST_REQUIREMENT');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_MEENAKSHI_FAITH_JUNGLE', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'PLOT_HAS_JUNGLE_REQUIREMENTS'),
    ('BBG_MEENAKSHI_FAITH_FOREST', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 'BBG_PLOT_HAS_FOREST_REQSET');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('BBG_MEENAKSHI_FAITH_JUNGLE', 'YieldType', 'YIELD_FAITH'),
    ('BBG_MEENAKSHI_FAITH_JUNGLE', 'Amount', 1),
    ('BBG_MEENAKSHI_FAITH_FOREST', 'YieldType', 'YIELD_FAITH'),
    ('BBG_MEENAKSHI_FAITH_FOREST', 'Amount', 1);
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
    ('BUILDING_MEENAKSHI_TEMPLE', 'BBG_MEENAKSHI_FAITH_JUNGLE'),
    ('BUILDING_MEENAKSHI_TEMPLE', 'BBG_MEENAKSHI_FAITH_FOREST');


-- statue of liberty text fix
UPDATE Buildings SET Description='LOC_BUILDING_STATUE_LIBERTY_EXPANSION2_DESCRIPTION' WHERE BuildingType='BUILDING_STATUE_LIBERTY';

-- 28/11/24 BUILDING_ORSZAGHAZ gets +50% influence point epr turn and 2 envoys
-- 15/12/24 reduced to +25%
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
    ('BUILDING_ORSZAGHAZ', 'MONARCHY_ENVOYS'),
    ('BUILDING_ORSZAGHAZ', 'CIVIC_AWARD_TWO_INFLUENCE_TOKENS');

INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
    ('ORSZAGHAZ_INFLUENCE_POINTS_BONUS', 'MODIFIER_PLAYER_GOVERNMENT_FLAT_BONUS'),
    ('ORSZAGHAZ_ENVOYS_BONUS', 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
    ('ORSZAGHAZ_INFLUENCE_POINTS_BONUS', 'BonusType', 'GOVERNMENTBONUS_ENVOYS'),
    ('ORSZAGHAZ_INFLUENCE_POINTS_BONUS', 'Amount', 25),
    ('ORSZAGHAZ_ENVOYS_BONUS', 'Amount', 2);
