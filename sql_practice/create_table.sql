/*
DESCRIPTION:
This part of code is the practice for lec 3, relational model

EXCUTION:
- open sqlplus in sql_practice folder
- run `@create_table.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt
*/ 


Spool create_table_20231122.lst
-- create table
CREATE TABLE students(
    sid     CHAR(20),
    name    CHAR(30),
    login   CHAR(20),
    age     INTEGER,
    gpa     REAL
);

-- insert data
INSERT INTO students (sid, name, login, age, gpa)
VALUES (5688, 'Gavin', 'smith@ee', 18, 3.2);

-- show table
SELECT * FROM students;

-- delete row
DELETE FROM students s
WHERE s.name = 'Smith';

-- update row
Spool off



