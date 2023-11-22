/*
Student ID: 1155141702
Name: ZHANG Haoxiang
*/


/* Query 1 */
/* Find the number of the engineers who work at the office named “Advanced Computer Vision Institute” and whose salary is greater than or equal to 10000. */
Spool result1.lst
SELECT COUNT(*)
FROM ENGINEER
WHERE ESALARY >= 10000 AND OFFICEID = (
    SELECT OFFICEID 
    FROM OFFICE 
    WHERE ONAME = 'Advanced Computer Vision Institute'
    );
Spool off


/* Query 2 */
Spool result2.lst

Spool off
