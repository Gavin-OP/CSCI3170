/*
Student ID: 1155141702
Name: ZHANG Haoxiang
*/


/* Query 1 */
/* Find the number of the engineers who work at the office named “Advanced Computer Vision Institute” and whose salary is greater than or equal to 10000. */
Spool result1.lst
SELECT COUNT(*)
FROM engineer
WHERE esalary >= 10000 AND officeid IN (
    SELECT officeid 
    FROM office 
    WHERE oname = 'Advanced Computer Vision Institute'
    );
Spool off


/* Query 2 */
Spool result2.lst
SELECT engineerid, ename
FROM engineer
WHERE engineerid IN (
    SELECT engineerid
    FROM research
    WHERE projectid IN (
        SELECT projectid
        FROM project
        WHERE pcategory = 'Security'
    )
)
ORDER BY engineerid DESC;
Spool off


/* Query 3 */
Spool result3.lst
SELECT ename
FROM engineer
WHERE officeid IN (
    SELECT officeid
    FROM office
    WHERE oname = 'Compatibility Tools Group'
) AND esalary NOT IN (
    SELECT e.esalary
    FROM engineer e, engineer tempe
    WHERE e.officeid = tempe.officeid AND e.officeid IN (
        SELECT officeid
        FROM office
        WHERE oname = 'Compatibility Tools Group'
    ) AND e.esalary < tempe.esalary
)
ORDER BY esalary ASC;
Spool off


/* Query 4 */
Spool result4.lst
-- check the cheapest 3 applications
SELECT aprice
FROM application
WHERE appid IN (
    SELECT appid
    FROM maintain
    WHERE engineerid IN (
        SELECT engineerid
        FROM engineer
        WHERE ename = 'Chan Ling Yun'
    )
)
ORDER BY aprice ASC;

-- cheapest: 19936, 20880, 24900

SELECT aname, aprice
FROM application
WHERE appid IN (
    SELECT appid
    FROM maintain
    WHERE engineerid IN (
        SELECT engineerid
        FROM engineer
        WHERE ename = 'Chan Ling Yun'
    )
) AND aprice NOT IN (
    SELECTXXC

)
ORDER BY aprice DESC;

    SELECT temp1.aprice
    FROM application temp1, (
        SELECT temp4.aprice
        FROM application temp4, (
            SELECT temp5.aprice
            FROM application temp5, 
        ) AS temp3
        WHERE temp4.aprice < temp3.aprice
    ) temp2
    WHERE temp1.aprice > temp2.aprice AND appid IN (
        SELECT appid
        FROM maintain
        WHERE engineerid IN (
            SELECT engineerid
            FROM engineer
            WHERE ename = 'Chan Ling Yun'
        )
    )


Spool off

