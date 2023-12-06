/* 

DESCRIPTION:
This part of code is the practice for lec 5, SQL  

EXCUTION:
- open sqlplus in sql_practice folder
- run `@select.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:
- select columns
- select A
- select at least
- select A or B
- select A and B
- select A but not (A given B)
- select A or B or C
- select some A
- select A better than B
- select the most
- select all

*/

Spool select.lst
-- project / select columns
SELECT branch_name
FROM loan;

SELECT DISTINCT branch_name
FROM loan;

-- find the names of sailors who have reserved boat number 103
SELECT s.sname
FROM sailors s
WHERE s.sid IN (
    SELECT r.sid
    FROM reserves r
    WHERE r.bid = 103
);

SELECT sname
FROM sailors s, reserves r
WHERE s.sid = r.sid AND r.bid = 103;

SELECT s.sname
FROM sailors s
WHERE EXISTS (
    SELECT *
    FROM reserves R
    WHERE R.bid = 103 AND R.sid = s.sid
);

-- it is not the same as the above one
SELECT s.sname
FROM sailors S
WHERE s.sid NOT IN (
    SELECT DISTINCT r.sid
    FROM reserves r
    WHERE r.bid <> 103
);

-- only reserve once, !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- SELECT s.sname
-- FROM sailors s
-- WHERE EXISTS (  
--     SELECT UNIQUE R.sid
--     FROM reserves R
--     WHERE R.bid = 103 AND R.sid = s.sid
-- );


-- find the names of sailors who have reserved a red boat
SELECT sname
FROM sailors
WHERE sid IN (
    SELECT sid
    FROM reserves
    WHERE bid IN (
        SELECT bid
        FROM boats
        WHERE color = 'red'
    )
);

SELECT sname
FROM sailors s, boats b, reserves r
WHERE s.sid = r.sid AND r.bid = b.bid AND b.color = 'red';

-- find a color of boat reserved by John
SELECT DISTINCT color
FROM boats
WHERE bid IN (
    SELECT bid
    FROM reserves
    WHERE sid IN (
        SELECT sid
        FROM sailors
        WHERE sname = 'John'
    )
);

SELECT DISTINCT color
FROM sailors s, boats b, reserves r
WHERE s.sid = r.sid AND r.bid = b.bid AND s.sname = 'John';

-- find the name of sailors who have reserved at least one boat
SELECT DISTINCT sname
FROM sailors s, reserves r
WHERE s.sid = r.sid;

SELECT DISTINCT sname
FROM sailors
WHERE sid IN (
    SELECT sid
    FROM reserves
);

-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- find the sailor whose name begin and end with B 
-- SELECT S.age, S.age + 1 AS age1, age1 * 2 AS age2
-- FROM sailors s
-- WHERE s.sname LIKE 'B_%B';


-- find sid's of sailors who've reserved a red or a green boat
SELECT DISTINCT S.sid
FROM sailors S, reserves R, boats B
WHERE S.sid = R.sid AND R.bid = B.bid AND (B.color = 'red' OR B.color = 'green');

SELECT DISTINCT S.sid
FROM sailors S, reserves R, boats B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red'
UNION
SELECT DISTINCT S.sid
FROM sailors S, reserves R, boats B
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'green';

-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- SELECT DISTINCT S.sid
-- FROM sailors S, reserves R, boats B
-- WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red'
-- EXCEPT 
-- SELECT DISTINCT S.sid
-- FROM sailors S, reserves R, boats B
-- WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'green';


-- find sid's of sailors who've reserved a red and a green boat, !!! DO BE CAREFUL ABOUT B1, B2, R1, R2 !!!
SELECT DISTINCT S.sid
FROM sailors S, boats B1, boats B2, reserves R1, reserves R2
WHERE (S.sid = R1.sid AND S.sid = R2.sid) AND (R1.bid = B1.bid AND R2.bid = B2.bid) AND (B1.color = 'red' AND B2.color = 'green');

SELECT DISTINCT s.sid
FROM sailors S, boats B, reserves r
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red' AND S.sid IN (
    SELECT DISTINCT S.sid
    FROM sailors S, boats B, reserves r
    WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'green'
);

SELECT DISTINCT S.sid
FROM sailors S, boats B, reserves r
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red'
INTERSECT
SELECT DISTINCT S.sid
FROM sailors S, boats B, reserves r
WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'green';

-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- find sid's of sailors who've reserved a red but not a green boat
-- SELECT DISTINCT S.sid
-- FROM sailors S, boats B, reserves r
-- WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'red' 
-- EXCEPT
-- SELECT DISTINCT S.sid
-- FROM sailors S, boats B, reserves r
-- WHERE S.sid = R.sid AND R.bid = B.bid AND B.color = 'green';

SELECT DISTINCT R.sid
FROM reserves R, boats b
WHERE B.bid = R.bid AND B.color = 'red' AND R.sid NOT IN (
    SELECT DISTINCT R.sid
    FROM reserves R, boats b
    WHERE B.bid = R.bid AND B.color = 'green'
);


-- find sid's of sailors who've a rating of 5 or have reserved boat 103
-- the first one is wrong
-- SELECT DISTINCT S.sid
-- FROM sailors S, reserves r
-- WHERE S.sid = R.sid AND S.rating > 8 OR R.bid = 103;

SELECT S.sid
FROM sailors s
WHERE s.rating > 8
UNION
SELECT R.sid
FROM reserves r
WHERE R.bid = 103;


-- find boat names which are red, green or blue
SELECT DISTINCT B.bname
FROM boats b
WHERE b.color IN ('red', 'green', 'blue');


-- find sailors whose rating is better than some sailor named John
SELECT * 
FROM sailors S
WHERE S.rating < ANY (
    SELECT S2.rating
    FROM sailors S2
    WHERE S2.sname = 'John'
);
    

-- find sailors whose rating is better than every sailor called John
SELECT * 
FROM sailors S
WHERE S.rating < ALL (
    SELECT S2.rating
    FROM sailors S2
    WHERE S2.sname = 'John'
);


-- find sailors with the highest rating
SELECT * 
FROM sailors s
WHERE s.rating >= ALL (
    SELECT S2.rating
    FROM sailors S2
);


-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- find sailors who reserved all boats
-- SELECT S.sid
-- FROM sailors s
-- WHERE NOT EXISTS (
--     (SELECT DISTINCT B.bid
--     FROM boats b)
--     EXCEPT
--     (SELECT DISTINCT R.bid
--     FROM reserves r
--     WHERE r.sid = s.sid)
-- );

-- find sailors who reserved all boats
SELECT S.sid
FROM sailors s
WHERE NOT EXISTS (
    SELECT DISTINCT B.bid
    FROM boats b
    WHERE NOT EXISTS (
        SELECT R.bid
        FROM reserves r
        WHERE r.sid = s.sid AND r.bid = b.bid
    )
);

Spool off