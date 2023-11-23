/*
DESCRIPTION:
This part of code is the practice for lec 3, relational model

EXCUTION:
- open sqlplus in sql_practice folder
- run `@create_table.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt
*/ 


Spool create_table_20231123.lst
-- show existing tables
SELECT table_name 
FROM user_tables;

-- create table
CREATE TABLE students(
    sid     CHAR(20),
    name    CHAR(30),
    login   CHAR(20),
    age     INTEGER,
    gpa     REAL,
    UNIQUE (login),
    CONSTRAINT studentKey PRIMARY KEY (sid)
);

CREATE TABLE courses(
    cid     CHAR(20),
    cname   CHAR(20),
    credits INTEGER,
    CONSTRAINT courseKey PRIMARY KEY (cid)
);

CREATE TABLE enrolled(
    sid     CHAR(20),
    cid     CHAR(20),
    grade   CHAR(10),
    PRIMARY KEY (sid, cid),
    FOREIGN KEY (sid) REFERENCES students(sid) ON UPDATE CASCADE,
    FOREIGN KEY (cid) REFERENCES courses(cid) ON UPDATE CASCADE
);

-- insert data
INSERT INTO students (sid, name, login, age, gpa)
VALUES (1588, 'OP', '123@ee', 18, 3.2);

-- show table
SELECT * FROM students;

-- delete row
DELETE FROM students s
WHERE s.name = 'Smith';

-- update row
UPDATE students S
SET S.age = S.age + 1, S.gpa = S.gpa + 0.1
WHERE S.name = 'Gavin';

UPDATE students s
SET S.gpa = S.gpa + 0.1
WHERE S.gpa < 3.5;

-- drop table
DROP TABLE students;




Spool off




