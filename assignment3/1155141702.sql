/*
Student ID: 1155141702
Name: ZHANG Haoxiang
*/


/* Query 1 */
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
SELECT appid, aname
FROM application
WHERE appid IN (
    SELECT appid
    FROM maintain
    WHERE engineerid IN (
        SELECT engineerid
        FROM engineer
        WHERE ename = 'Chan Ling Yun'
    )
) AND aprice IN (
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
    ORDER BY aprice ASC
    FETCH FIRST 3 ROWS ONLY
)
ORDER BY aprice DESC;
Spool off



/* Query 5 */
Spool result5.lst
SELECT appid, aname
FROM application
WHERE appid IN (
    SELECT appid
    FROM maintain
    GROUP BY appid
    HAVING COUNT(*) >= 2
)
ORDER BY appid DESC;
Spool off



/* Query 6 */
Spool result6.lst
SELECT officeid, oname
FROM office
WHERE officeid IN (
    SELECT officeid
    FROM project
    GROUP BY officeid
    HAVING SUM(pbudget) < 20000
)
ORDER BY officeid ASC;
Spool off




/* Query 7 */
Spool result7.lst
SELECT pcategory, AVG(head_count) AS head_count
FROM (
    SELECT pcategory, COUNT(*) AS head_count
    FROM project
    WHERE projectid IN (
        SELECT projectid
        FROM research
    )
    GROUP BY pcategory
)
GROUP BY pcategory
ORDER BY pcategory DESC;
Spool off




/* Query 8 */
Spool result8.lst
SELECT engineerid, ename
FROM engineer
WHERE engineerid IN (
    SELECT engineerid
    FROM research
    WHERE projectid IN (
        SELECT projectid
        FROM project
        WHERE pbudget - pexpenditure = (
            SELECT MAX(pbudget - pexpenditure)
            FROM project
        )
    )
)   
ORDER BY engineerid ASC;
Spool off
