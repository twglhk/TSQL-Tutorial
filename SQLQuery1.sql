SELECT nameFirst AS name, nameLast, weight, height, deathDay, birthCity
FROM players
WHERE (nameFirst = 'Bill' AND weight > 180) OR height < 80 AND deathDay IS NULL AND birthCity LIKE 'NEW ____';
