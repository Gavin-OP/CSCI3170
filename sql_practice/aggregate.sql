/* 

DESCRIPTION:
This part of code is the practice for lec 5, SQL  

EXCUTION:
- open sqlplus in sql_practice folder
- run `@aggregate.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:
- average
- count
- max

*/

Spool aggregate.lst
-- select average age of all sailors
SELECT AVG(age) as avg_age
FROM sailors;

-- select average age of sailors with rating of 10
SELECT AVG(S.age) as avg_age
FROM sailors S
WHERE S.rating = 10;

-- select the name and age of the oldest sailor
SELECT S1.sname, S1.age
FROM sailors S1
WHERE s1.age = (
    SELECT MAX(S2.age)
    FROM sailors S2
);


-- count the number of sailors
SELECT COUNT(*) as num_sailors
FROM sailors;


-- count the number of different sailor names
SELECT COUNT(DISTINCT sname) as num_sailors
FROM sailors;


-- find the names of sailors who are older than the oldest sailor with a rating of 7
SELECT S.sname
FROM sailors s
WHERE S.age > (
    SELECT MAX(S2.age)
    FROM sailors S2
    WHERE S2.rating = 7 
);


Spool off