-- 1. NULL 값을 0으로 일괄 변경
UPDATE `Interview2Question` 
SET `IsDeleted` = 0 
WHERE `IsDeleted` IS NULL;

UPDATE `QuestionGroup` 
SET `IsDeleted` = 0 
WHERE `IsDeleted` IS NULL;

