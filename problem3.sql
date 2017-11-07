-- Homework for class Advanced Database Systems
-- Copyright 2017 Taikun Guo and Yi Zhang
-- following code are tested in MySQL

SELECT
  f.person1 AS p1, -- person 1
  f.person2 AS p2, -- person 2
  l.artist AS a -- the artist that person 2 likes but person 1 doesn't like
FROM
  `friend` AS f
  JOIN `like` AS l
    ON f.person2 = l.person
WHERE
  l.artist NOT IN ( -- a list of artists that person 1 likes
    SELECT artist FROM `like`
    WHERE person = f.person1
  );