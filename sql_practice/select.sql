/* 
DESCRIPTION:
This part of code is the practice for lec 5, SQL  

EXCUTION:
- open sqlplus in sql_practice folder
- run `@create_table.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:

*/
Spool select_20231123.lst
-- project / select columns
SELECT branch_name
FROM loan;

SELECT DISTINCT branch_name
FROM loan;

-- find the names of sailors who have reserved boat number 103
SELECT sname
FROM sailors
WHERE sid = (
    SELECT sid
    FROM reserves
    WHERE bid = 103
);

SELECT sname
FROM sailors s, reserves r
WHERE s.sid = r.sid AND r.bid = 103;

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

Spool off