-- GROUP MEMBER'S



-- PACKAGE COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\PL_SQL\package_11.sql


SET SERVEROUTPUT ON;

-- 1) creating package 'pkg_retirement'

-- package specification

CREATE OR REPLACE PACKAGE pkg_retirement 
IS

	FUNCTION func_days_left_before_retirement(in_dob staff.date_of_birth%TYPE) RETURN VARCHAR2;
	PROCEDURE proc_days_left_before_retirement(in_staff_id staff.staff_id%TYPE);

END pkg_retirement;
/
SHOW ERRORS;


-- package body
CREATE OR REPLACE PACKAGE BODY pkg_retirement 
IS

-- 1) calculating the days left for staff before retirement 
-- (using CONSTANT, NOT NULL, DEFAULT, TRUNC, SUBSTR, CONCAT, TO_CHAR)

	FUNCTION func_days_left_before_retirement(in_dob staff.date_of_birth%TYPE) 
	RETURN VARCHAR2 IS 
		
		vn_retirement_age NUMBER(2) NOT NULL DEFAULT 60;
		vn_no_of_days_in_a_year CONSTANT NUMBER(3) := 365;
		
		vn_instructor_ct NUMBER(3);
		vn_time NUMBER(4,2);
		vn_years NUMBER(2);
		vn_days_in_percent NUMBER(2);
		vn_days NUMBER(3);
		vc_time VARCHAR2(25); 
		
	BEGIN 
			
		vn_time := ((in_dob + (vn_no_of_days_in_a_year * vn_retirement_age)) - SYSDATE) / vn_no_of_days_in_a_year; 
		vn_years := TRUNC(vn_time); 
		vn_days_in_percent := SUBSTR(vn_time, -2, 2);
		
		vn_days := (vn_days_in_percent / 100) * vn_no_of_days_in_a_year;
		
		vc_time := CONCAT(CONCAT(TO_CHAR(vn_years), ' years, '), CONCAT(TO_CHAR(vn_days), ' days'));
		RETURN vc_time;
		
	END func_days_left_before_retirement;

-- 2) displaying retirement age for a given staff using thier id 
-- (using user defined RECORD TYPE, EXCEPTION) [using FUNCTION (1)]

	PROCEDURE proc_days_left_before_retirement(in_staff_id staff.staff_id%TYPE)
	IS
		
		TYPE rec_staff IS RECORD (
			staff_id staff.staff_id%TYPE,
			staff_first_name staff.staff_first_name%TYPE,
			staff_last_name staff.staff_last_name%TYPE,
			date_of_birth staff.date_of_birth%TYPE
		);
				
		staff_details rec_staff;
		
	BEGIN
		
		SELECT staff_id, staff_first_name, staff_last_name, date_of_birth
		INTO staff_details
		FROM staff
		WHERE staff_id = in_staff_id;
		
		DBMS_OUTPUT.PUT_LINE(staff_details.staff_first_name || ' ' || staff_details.staff_last_name || ' with Staff Id ' || staff_details.staff_id || ' has ' ||  func_days_left_before_retirement(staff_details.date_of_birth) || ' left before retirement.');

		
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('THE STAFF ID YOU ENTERED IS NOT FOUND! PLEASE ENTER VALID STAFF ID.');
				
	END proc_days_left_before_retirement;

END pkg_retirement;
/
SHOW ERRORS;




-- 2) creating package 'pkg_table'
-- (using CONSTANT, LENGTH)

-- package specification

CREATE OR REPLACE PACKAGE pkg_table 
IS

	FUNCTION func_space(in_role staff.role%TYPE) RETURN VARCHAR2;
	
END pkg_table;
/
SHOW ERRORS;

-- package body
CREATE OR REPLACE PACKAGE BODY pkg_table 
IS

	FUNCTION func_space(in_role staff.role%TYPE) 
	RETURN VARCHAR2 IS 
		
		vc_global_space CONSTANT NUMBER(3) := 25;
		vn_space_no NUMBER(4);
		vn_space VARCHAR2(50) := ' ';
		
	BEGIN 
		
		vn_space_no := vc_global_space - LENGTH(in_role);
			FOR vn_spaces IN 0 .. vn_space_no LOOP
				vn_space := CONCAT(vn_space, ' ');
			END LOOP;

		RETURN vn_space;
		
	END func_space;

END pkg_table;
/
SHOW ERRORS;

