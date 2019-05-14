-- GROUP MEMBER'S



-- FUNCTION COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\PL_SQL\function_11.sql


-- 1) calculating total number of staff enrolled in different role 
-- (using COUNT)

CREATE OR REPLACE FUNCTION func_no_of_staff_in_a_role(in_role staff.role%TYPE) 
RETURN NUMBER IS 
	
	vn_count_role NUMBER(4) := 0;
	
BEGIN 
	
	SELECT COUNT(role) 
	INTO vn_count_role
	FROM staff
	WHERE role = in_role;
	
	RETURN vn_count_role;
	
END func_no_of_staff_in_a_role;
/
SHOW ERRORS;




-- 2) The following function calculates the number of days left for an upcoming event
-- (using CURSOR, %ROWTYPE, CEIL)

CREATE OR REPLACE FUNCTION func_days_left(in_nature_id festivals.nature_id%TYPE, in_ward_id festivals.ward_id%TYPE) 
RETURN NUMBER IS 

	vn_days_left NUMBER(5);
	
	CURSOR cur_days_left IS
		SELECT s.festival_staff_date,s.nature_id,s.ward_id
		FROM festival_staff s
		WHERE s.nature_id = in_nature_id AND s.ward_id = in_ward_id;
	
	vn_todays_date DATE := SYSDATE;
	rec_cur_days_left cur_days_left%ROWTYPE;
	
BEGIN 

	OPEN cur_days_left;
	FETCH cur_days_left INTO rec_cur_days_left;
		IF rec_cur_days_left.festival_staff_date > vn_todays_date THEN
			vn_days_left := CEIL(rec_cur_days_left.festival_staff_date - vn_todays_date);
		END IF;
	CLOSE cur_days_left;
	
	RETURN vn_days_left;
		
END func_days_left;
/
SHOW ERRORS;




-- 3) function to get the location at which a particular event is celebrated
-- (using CURSOR, CURSOR FOR LOOP)

CREATE OR REPLACE FUNCTION func_event_location(in_ward_id locations.ward_id%TYPE)
RETURN VARCHAR2 IS

	CURSOR cur_locations IS 
		SELECT h.address.street AS street,h.address.city AS city, h.address.country AS country
		FROM locations l, TABLE(l.hall) h
		WHERE l.ward_id = in_ward_id;
	
	vn_street VARCHAR2(150);
	vn_city VARCHAR2(150);
	vn_country VARCHAR2(150);

BEGIN

	FOR rec_cur_locations IN cur_locations LOOP
		vn_street := rec_cur_locations.street;
		vn_city := rec_cur_locations.city;
		vn_country := rec_cur_locations.country;
	END LOOP;

	RETURN CONCAT(CONCAT(vn_street,', '),CONCAT(vn_city,CONCAT(', ',vn_country)));

END func_event_location;
/
SHOW ERRORS;




-- 4) function to calculate total amount spent on rent for the location used by an event
-- (using CURSOR, %ROWTYPE, 2 JOIN'S, %ISOPEN)

CREATE OR REPLACE FUNCTION func_calc_expense(in_festival_staff_id festival_staff.festival_staff_id%TYPE) 
RETURN NUMBER IS 

	CURSOR cur_event IS 
		SELECT f.festival_staff_id, f.nature_id, f.ward_id, l.rent as rent, e.duration as days, e.festival_name as name
		FROM festival_staff f 
		JOIN festivals e
		ON e.nature_id = f.nature_id AND e.ward_id = f.ward_id
		JOIN locations l 
		ON e.ward_id = l.ward_id
		WHERE f.festival_staff_id = in_festival_staff_id;
	
	rec_cur_salaries cur_event%ROWTYPE;
	vn_expense NUMBER(9,2);

BEGIN

	OPEN cur_event;
	FETCH cur_event INTO rec_cur_salaries;
		vn_expense := rec_cur_salaries.rent * rec_cur_salaries.days;
	
	IF cur_event%ISOPEN THEN
		CLOSE cur_event;
	END IF;
	
	RETURN vn_expense;

END func_calc_expense;
/
SHOW ERRORS;




-- 5) total amount of salary taken by all the staff working at any event
-- (using CURSOR, JOIN, CURSOR FOR LOOP)


CREATE OR REPLACE FUNCTION func_total_salary(in_festival_staff_id festival_staff.festival_staff_id%TYPE) 
RETURN NUMBER IS

	CURSOR cur_total_salary IS
		SELECT f.festival_staff_id, i.hours_worked as hrs, i.staff_id as id, w.pay_rate as pay
		FROM festival_staff f, TABLE(f.staff_pay) i
		JOIN staff w 
		ON w.staff_id = i.staff_id
		WHERE f.festival_staff_id = in_festival_staff_id;

	vn_salary NUMBER(9,2) :=0;

BEGIN

	FOR rec_cur_total_salary IN cur_total_salary LOOP
		vn_salary := vn_salary + rec_cur_total_salary.pay * rec_cur_total_salary.hrs;
	END LOOP; 
	
	RETURN vn_salary;

END func_total_salary;
/
SHOW ERRORS;




-- 6) inserting data's into 'festival_staff' table 
-- (using BULK COLLECT, simple VARRAY) 

CREATE OR REPLACE FUNCTION func_insert_all_staffs_varray(in_staff_id festival_staff.staff_id%TYPE,in_festival_staff_id festival_staff.festival_staff_id%TYPE,in_hrs_worked NUMBER) 
RETURN VARCHAR2 IS   

	vn_staff_id VARCHAR2(100);

	TYPE staff_array IS VARRAY(6) OF festival_staff.staff_id%TYPE;
	ids staff_array;

BEGIN

	SELECT staff_id BULK COLLECT INTO ids
	FROM staff 	
	WHERE instructor_id = in_staff_id; 
	
	UPDATE festival_staff SET 
		staff_pay = staff_pay_varray_type(
				staff_pay_type(ids(1), in_hrs_worked),
				staff_pay_type(ids(2), in_hrs_worked),
				staff_pay_type(ids(3), in_hrs_worked),
				staff_pay_type(ids(4), in_hrs_worked),
				staff_pay_type(ids(5), in_hrs_worked)
			)
		WHERE festival_staff_id = in_festival_staff_id; 
	
	vn_staff_id := 'EVENT SUCCESSFULLY ADDED';

	RETURN vn_staff_id;
	
END func_insert_all_staffs_varray;
/
SHOW ERRORS;



-- 7) calculating the monthly revenue for a festival 
-- (using CASE, CURSOR, JOIN, CURSOR FOR LOOP)

CREATE OR REPLACE FUNCTION func_calc_monthly_revenue(in_month NUMBER, in_year NUMBER) 
RETURN VARCHAR IS 
	
	vc_month_lower_limit festival_staff.festival_staff_date%TYPE;
	vc_month_upper_limit festival_staff.festival_staff_date%TYPE;
	vn_total NUMBER(9,2) := 0;
	
	CURSOR cur_expenses IS
		SELECT l.rent as rent, e.duration as days,f.festival_staff_date as d
		FROM festival_staff f 
		JOIN festivals e
		ON e.nature_id = f.nature_id AND e.ward_id = f.ward_id
		JOIN locations l 
		ON e.ward_id = l.ward_id;
	
BEGIN 
	
	CASE in_month
		WHEN 1 THEN
			vc_month_lower_limit := CONCAT('01-JAN-', in_year);
			vc_month_upper_limit := CONCAT('31-JAN-', in_year);
		WHEN 2 THEN
			vc_month_lower_limit := CONCAT('01-FEB-', in_year);
			vc_month_upper_limit := CONCAT('28-FEB-', in_year);
		WHEN 3 THEN
			vc_month_lower_limit := CONCAT('01-MAR-', in_year);
			vc_month_upper_limit := CONCAT('31-MAR-', in_year);
		WHEN 4 THEN
			vc_month_lower_limit := CONCAT('01-APR-', in_year);
			vc_month_upper_limit := CONCAT('30-APR-', in_year);
		WHEN 5 THEN
			vc_month_lower_limit := CONCAT('01-MAY-', in_year);
			vc_month_upper_limit := CONCAT('31-MAY-', in_year);
		WHEN 6 THEN
			vc_month_lower_limit := CONCAT('01-JUN-', in_year);
			vc_month_upper_limit := CONCAT('30-JUN-', in_year);
		WHEN 7 THEN
			vc_month_lower_limit := CONCAT('01-JUL-', in_year);
			vc_month_upper_limit := CONCAT('31-JUL-', in_year);
		WHEN 8 THEN
			vc_month_lower_limit := CONCAT('01-AUG-', in_year);
			vc_month_upper_limit := CONCAT('31-AUG-', in_year);
		WHEN 9 THEN
			vc_month_lower_limit := CONCAT('01-SEP-', in_year);
			vc_month_upper_limit := CONCAT('30-SEP-', in_year);
		WHEN 10 THEN
			vc_month_lower_limit := CONCAT('01-OCT-', in_year);
			vc_month_upper_limit := CONCAT('31-OCT-', in_year);	
		WHEN 11 THEN
			vc_month_lower_limit := CONCAT('01-NOV-', in_year);
			vc_month_upper_limit := CONCAT('30-NOV-', in_year);	
		WHEN 12 THEN
			vc_month_lower_limit := CONCAT('01-DEC-', in_year);
			vc_month_upper_limit := CONCAT('31-DEC-', in_year);	
	END CASE;

	FOR rec_cur_exp IN cur_expenses LOOP
		IF(rec_cur_exp.d >= vc_month_lower_limit AND rec_cur_exp.d <= vc_month_upper_limit) THEN
		 vn_total := vn_total + rec_cur_exp.rent * rec_cur_exp.days;
		END IF;
	END LOOP;	
	RETURN vn_total;
	
END func_calc_monthly_revenue;
/
SHOW ERRORS;

