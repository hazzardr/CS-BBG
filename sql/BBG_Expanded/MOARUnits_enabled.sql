UPDATE EnabledUniqueUnits SET Enabled = 1 WHERE Type IN ('UNIT_GERMAN_PANZER', 'UNIT_ROMAN_ONAGER', 'UNIT_ENGLISH_LONGBOWMAN' );
UPDATE EnabledUniqueUnits SET OwnerType='LEADER_BARBAROSSA' WHERE Type='UNIT_GERMAN_PANZER';
UPDATE EnabledUniqueUnits SET OwnerType='LEADER_JULIUS_CAESAR' WHERE Type='UNIT_ROMAN_ONAGER';

INSERT INTO LeaderTraits (LeaderType, TraitType) SELECT OwnerType, 'TRAIT_CIVILIZATION_'||Type FROM EnabledUniqueUnits WHERE Enabled = 1 and OwnerType like 'LEADER_%';

-- Steel & Thunder lists the Templar for both Eleanors on the leader select screen, but only grants it to Eleanor (England) in game
INSERT INTO LeaderTraits (LeaderType, TraitType)
SELECT 'LEADER_ELEANOR_FRANCE', 'TRAIT_CIVILIZATION_UNIT_ELEANOR_TEMPLAR' FROM EnabledUniqueUnits
WHERE Type = 'UNIT_ELEANOR_TEMPLAR' AND Enabled = 1
AND EXISTS (SELECT 1 FROM Leaders WHERE LeaderType = 'LEADER_ELEANOR_FRANCE')
AND EXISTS (SELECT 1 FROM Traits WHERE TraitType = 'TRAIT_CIVILIZATION_UNIT_ELEANOR_TEMPLAR')
AND NOT EXISTS (SELECT 1 FROM LeaderTraits WHERE LeaderType = 'LEADER_ELEANOR_FRANCE' AND TraitType = 'TRAIT_CIVILIZATION_UNIT_ELEANOR_TEMPLAR');

