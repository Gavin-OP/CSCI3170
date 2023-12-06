/* 

DESCRIPTION:
This part of code is the practice for lec 5, SQL  

EXCUTION:
- open sqlplus in sql_practice folder
- run `@groupby.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:
- GROUP BY
- HAVING

*/

Spool groupby.lst
-- find the age of the youngest sailor for each rating level
SELECT S.rating, MIN(S.age)
FROM sailors s
GROUP BY S.rating;


-- find the age of the youngest sailor with age >=18, for each rating with at least 2 such sailors
SELECT S.rating, MIN(S.age)
FROM sailors s
WHERE S.age >= 18
GROUP BY S.rating
HAVING COUNT(*) >= 1
ORDER BY S.rating ASC;


-- for each red boat, find the number of reservations for the boat
SELECT b.bid, COUNT(*)
FROM reserves R, boats b
WHERE R.bid = b.bid
GROUP BY b.color, B.bid
HAVING b.color = 'red';

SELECT B.bid, COUNT(*) AS reservation_count
FROM reserves R, boats B
WHERE R.bid = B.bid AND B.color = 'red'
GROUP BY B.bid;


-- find the average age of sailors for each rating level that hs at least one sailors
SELECT S.rating, AVG(S.age)
FROM sailors s
GROUP BY S.rating
HAVING COUNT(*) >= 1;

SELECT S.rating, AVG(S.age) AS avg_age
FROM sailors s
GROUP BY S.rating
HAVING 1 <= (
    SELECT COUNT(*)
    FROM sailors S2
    WHERE S2.rating = S.rating
);


-- find the average age of sailors for each rating level that has at least one sailor with age >= 25
SELECT S.rating, AVG(S.age) AS avg_age
FROM sailors s
WHERE S.age >= 25
GROUP BY S.rating
HAVING 1 < (
    SELECT COUNT(*)
    FROM sailors S2
    WHERE S2.rating = S.rating
);


-- find the average age of sailors who are at least 25 years old, for each rating level that has at least one sailor with age >= 25
SELECT S.rating, AVG(S.age) AS avg_age
FROM sailors s
WHERE S.age >= 25
GROUP BY S.rating
HAVING 1 < (
    SELECT COUNT(*)
    FROM sailors S2
    WHERE S2.rating = S.rating AND S2.age >= 25
);

SELECT S.rating, AVG(S.age) AS avg_age
FROM sailors s
WHERE S.age >= 25
GROUP BY S.rating
HAVING COUNT(*) > 1;


-- find those ratings for which the average age is the minimum over all ratings
-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- SELECT Temp.rating, Temp.avgage
-- FROM (
--     SELECT S.rating, AVG(S.age) AS avgage
--     FROM sailors s
--     GROUP BY S.rating
-- ) AS Temp
-- WHERE Temp.avgage = (
--     SELECT MIN(Temp.avgage)
--     FROM Temp
-- );

Spool off