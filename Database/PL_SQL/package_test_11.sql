-- GROUP MEMBER'S



-- TESTING FUNCTION'S


SET SERVEROUTPUT ON;

-- 1) TESTING PACKAGE 'pkg_retirement' AND PROCEDURE 'proc_days_left_before_retirement'

-- valid staff id
EXEC pkg_retirement.proc_days_left_before_retirement(1811);
-- SARA CAROLL with Staff Id 1811 has 40 years, 208 days left before retirement.


-- invalid staff id
EXEC pkg_retirement.proc_days_left_before_retirement(123456);
-- THE STAFF ID YOU ENTERED IS NOT FOUND! PLEASE ENTER VALID STAFF ID.


-- user's choice
EXEC pkg_retirement.proc_days_left_before_retirement(&staff_id);