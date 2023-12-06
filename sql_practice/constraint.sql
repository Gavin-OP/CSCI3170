/* 

DESCRIPTION:
This part of code is the practice for lec 5, SQL  

EXCUTION:
- open sqlplus in sql_practice folder
- run `@constraint.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:

*/

Spool constraint_20231206.lst
CREATE TABLE SailorsTest (
    sid     INTEGER,
    sname   CHAR(20),
    rating  INTEGER,
    age     REAL,
    PRIMARY KEY (sid),
    CHECK (
        rating >= 1 AND rating <= 10
    )
);


-- !!!!!!!!!!!!!!!!!!!!!! THIS IS NOT WORKING !!!!!!!!!!!!!!!!!!!!!!
-- CREATE TABLE ReservesTest (
--     sid     INTEGER,
--     bid     INTEGER,
--     day     DATE,
--     PRIMARY KEY (sid, bid, day),
--     FOREIGN KEY (sid) REFERENCES SailorsTest(sid),
--     FOREIGN KEY (bid) REFERENCES Boats(bid),
--     CONSTRAINT noInterLakeRes
--     CHECK (
--         'Interlake' <> (
--             SELECT B.bname
--             FROM boats b
--             WHERE b.bid = bid
--         )
--     )
-- );


Spool off