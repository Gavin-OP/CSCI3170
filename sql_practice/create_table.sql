/*

DESCRIPTION:
This part of code is the practice for lec 3, relational model

EXCUTION:
- open sqlplus in sql_practice folder
- run `@create_table.sql` or copy the code below to the terminal
- the result will be shown in the terminal, and save in xxx.slt

CONTENT:
- create table
- delete row
- drop table
- insert data
- show existing table
- show table
- update row

*/ 


Spool create_table.lst
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
    FOREIGN KEY (sid) REFERENCES students(sid),
    FOREIGN KEY (cid) REFERENCES courses(cid)
);

CREATE TABLE employees(
    id      CHAR(20),
    name    CHAR(30),
    lot     INTEGER, 
    PRIMARY KEY (id)
);

CREATE TABLE loan(
    branch_name CHAR(20),
    loan_number INTEGER,
    amount      INTEGER
);

CREATE TABLE sailors(
    sid    INTEGER,
    sname  CHAR(20),
    rating INTEGER,
    age    REAL,
    PRIMARY KEY (sid)
);

CREATE TABLE boats(
    bid    INTEGER,
    bname  CHAR(20),
    color  CHAR(20),
    PRIMARY KEY (bid)
);

CREATE TABLE reserves(
    sid    INTEGER,
    bid    INTEGER,
    day    DATE,
    UNIQUE (sid, bid, day),
    FOREIGN KEY (sid) REFERENCES sailors(sid),
    FOREIGN KEY (bid) REFERENCES boats(bid)
);

-- show table
SELECT * 
FROM students;

-- insert data
INSERT INTO students (sid, name, login, age, gpa)
VALUES (1588, 'OP', '123@ee', 18, 3.2);

INSERT INTO loan (branch_name, loan_number, amount)
VALUES ('CUHK', 222, 2);
INSERT INTO loan (branch_name, loan_number, amount)
VALUES ('CMTR', 333, 1);
INSERT INTO loan (branch_name, loan_number, amount)
VALUES ('CUHK', 777, 2);

INSERT INTO sailors (sid, sname, rating, age)
VALUES (22, 'Gavin', 7, 22);
INSERT INTO sailors (sid, sname, rating, age)
VALUES (33, 'Smith', 8, 33);
INSERT INTO sailors (sid, sname, rating, age)
VALUES (44, 'John', 9, 44);
INSERT INTO sailors (sid, sname, rating, age)
VALUES (55, 'Bob', 10, 55);

INSERT INTO boats (bid, bname, color)
VALUES (11, 'A', 'red');
INSERT INTO boats (bid, bname, color)
VALUES (22, 'B', 'blue');
INSERT INTO boats (bid, bname, color)
VALUES (33, 'C', 'green');
INSERT INTO boats (bid, bname, color)
VALUES (103, 'C', 'green');

INSERT INTO reserves (sid, bid, day)
VALUES (22, 11, TO_DATE('2020-11-11', 'YYYY-MM-DD'));
INSERT INTO reserves (sid, bid, day)
VALUES (33, 22, TO_DATE('2020-11-12', 'YYYY-MM-DD'));
INSERT INTO reserves (sid, bid, day)
VALUES (44, 33, TO_DATE('2020-11-13', 'YYYY-MM-DD'));
INSERT INTO reserves (sid, bid, day)
VALUES (44, 103, TO_DATE('2020-12-13', 'YYYY-MM-DD'));
INSERT INTO reserves (sid, bid, day)
VALUES (55, 103, TO_DATE('2020-12-14', 'YYYY-MM-DD'));

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
