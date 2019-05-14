-- GROUP MEMBER'S



-- PROCEDURE COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\PL_SQL\procedure_11.sql


SET SERVEROUTPUT ON;

-- 1) displaying staff detail according to 'male' or 'female' staff
-- (using CASE, EXCEPTION) 

CREATE OR REPLACE PROCEDURE proc_show_staff_detail(staff_id staff.staff_id%TYPE, in_staff_f_name staff.staff_first_name%TYPE, in_staff_l_name staff.staff_last_name%TYPE, in_gender staff.gender%TYPE, in_role staff.role%TYPE, in_pay_rate staff.pay_rate%TYPE) 
IS
	
	ex_invalid_gender EXCEPTION;
		
BEGIN
	
	CASE in_gender
		WHEN 'M' THEN
			DBMS_OUTPUT.PUT_LINE('CONGRATULATION! ' || in_staff_f_name || ' ' || in_staff_l_name || ' HAS BEEN SUCCESSFULLY ENROLLED AS A ' || in_role || '. HE WOULD BE PAYED ' || in_pay_rate || ' DOLLAR''S PER HOUR.');
		WHEN 'F' THEN
			DBMS_OUTPUT.PUT_LINE('CONGRATULATION! ' || in_staff_f_name || ' ' || in_staff_l_name || ' HAS BEEN SUCCESSFULLY ENROLLED AS A ' || in_role || '. SHE WOULD BE PAYED ' || in_pay_rate || ' DOLLAR''S PER HOUR.');
		ELSE 
			RAISE ex_invalid_gender;
	END CASE;

	EXCEPTION
		WHEN ex_invalid_gender THEN
			DBMS_OUTPUT.PUT_LINE('INVALID GENDER! PLEASE ENTER A STAFF WITH VALID GENDER.');
			
END proc_show_staff_detail;
/
SHOW ERRORS;




-- 2) displaying total number of staff enrolled in different role 
-- (using DISTINCT, FOR LOOP CURSOR, PACKAGE) [using PACKAGE (2)]

CREATE OR REPLACE PROCEDURE proc_no_of_staff_in_a_role
IS
	
	CURSOR cur_staff_role IS
		SELECT DISTINCT(role)
		FROM staff;
	
	role staff.role%TYPE;
	
BEGIN 
	
	DBMS_OUTPUT.PUT_LINE('DIFFERENT TYPES OF ROLE' || pkg_table.func_space('DIFFERENT TYPES OF ROLE') || 'NO OF STAFF');
	DBMS_OUTPUT.PUT_LINE('-----------------------' || pkg_table.func_space('-----------------------') || '-----------');
	
	FOR rec_cur_staff_role IN cur_staff_role LOOP	
		role := rec_cur_staff_role.role;
		DBMS_OUTPUT.PUT_LINE(role || pkg_table.func_space(role) || func_no_of_staff_in_a_role(role));
	END LOOP;                                                                 
END proc_no_of_staff_in_a_role;
/
SHOW ERRORS;




-- 3) The following procedure is used to insert into the table festival_staff. This table contains the information about all the events that are being organised 
-- () [using FUNCTION (6)]

CREATE OR REPLACE PROCEDURE proc_insert_festival_staff(in_staff_id festival_staff.staff_id%TYPE, in_nature_id festival_staff.nature_id%TYPE, in_ward_id festival_staff.ward_id%TYPE , in_festival_staff_date festival_staff.festival_staff_date%TYPE,in_hrs_worked NUMBER) 
IS
	vn_todays_date DATE := SYSDATE;
	vn_result VARCHAR2(10);
BEGIN 
	IF in_festival_staff_date > vn_todays_date OR in_hrs_worked = 0 THEN 
		INSERT INTO festival_staff(festival_staff_id,staff_id,nature_id ,ward_id ,festival_staff_date) VALUES(SEQ_FETIVAL_STAFF.NEXTVAL,in_staff_id,in_nature_id,in_ward_id,in_festival_staff_date);
		vn_result:= func_insert_all_staffs_varray(in_staff_id,SEQ_FETIVAL_STAFF.CURRVAL,in_hrs_worked);
		DBMS_OUTPUT.PUT_LINE(vn_result);
	ELSE
		DBMS_OUTPUT.PUT_LINE('EVENT DATE HAS ALREADY PASSED');
		DBMS_OUTPUT.PUT_LINE('HOURS WORKED CANNOT BE 0');
	END IF;
END proc_insert_festival_staff;
/
SHOW ERRORS;




-- 4) get details of an event and the staffs that are managing it 
-- (using JOIN, CURSOR FOR LOOP, NESTED TABLE)

CREATE OR REPLACE PROCEDURE proc_get_details(in_festival_date festival_staff.festival_staff_date%TYPE) 
IS

	CURSOR cur_manage_festival IS 
		SELECT t.festival_staff_id, t.staff_id as id, t.nature_id, t.ward_id, f.festival_name
		FROM festival_staff t 
		JOIN festivals f ON f.nature_id = t.nature_id AND f.ward_id = t.ward_id
		WHERE t.festival_staff_date = in_festival_date;

	rec_cur_manage_festival cur_manage_festival%ROWTYPE;

	CURSOR cur_staffs IS
		SELECT DISTINCT(f.staff_id) as sid,r.hours_worked as hrs
		FROM festival_staff f, TABLE(f.staff_pay) r;

	CURSOR cur_sts IS 
		SELECT s.staff_id, s.instructor_id, s.staff_first_name, s.staff_last_name, s.role, s.pay_rate
		FROM staff s;

	rec_cur_staffs cur_staffs%ROWTYPE;

	vn_salary NUMBER(6);
	
BEGIN

	OPEN cur_manage_festival;
	FETCH cur_manage_festival INTO rec_cur_manage_festival;
	
	IF cur_manage_festival%FOUND THEN 
		WHILE cur_manage_festival%FOUND LOOP
			DBMS_OUTPUT.PUT_LINE(rec_cur_manage_festival.festival_name||chr(10)||'-----------'||chr(10)||'Managed By '||chr(10)||'--------');
			FOR rec_cur_sts IN cur_sts LOOP
				IF (rec_cur_sts.instructor_id = rec_cur_manage_festival.id) THEN
					FOR rec_cur_staffs IN cur_staffs LOOP
						IF rec_cur_staffs.sid = rec_cur_manage_festival.id THEN 
							vn_salary := rec_cur_sts.pay_rate * rec_cur_staffs.hrs;
							EXIT;
						END IF;
					END LOOP;
					DBMS_OUTPUT.PUT_LINE(rec_cur_sts.staff_first_name||' '|| rec_cur_sts.staff_last_name ||' '||rec_cur_sts.role||' Salary Rs.'||vn_salary||chr(10));	
				END IF;
			END LOOP;
			FETCH cur_manage_festival INTO rec_cur_manage_festival;
		END LOOP;
	ELSE
	DBMS_OUTPUT.PUT_LINE('NO ROWS FOUND');
	END IF;

END proc_get_details;
/
SHOW ERRORS;




-- 5) get details of an event and the staffs that are managing it 
-- (using ROWTYPE, CURSOR WHILE LOOP, %ROWCOUNT, %FOUND)

CREATE OR REPLACE PROCEDURE proc_staff_details(in_staff_address addresses.street%TYPE) 
IS

	CURSOR cur_staff_match IS
		SELECT s.staff_id,s.staff_first_name, s.staff_last_name, s.gender, s.email_id,s.role,s.instructor_id,i.staff_first_name as instructor_first,i.staff_last_name as instructor_last
		FROM staff s 
		JOIN staff i ON s.instructor_id = i.staff_id
		WHERE s.address.street = in_staff_address OR s.address.city = in_staff_address OR s.address.country = in_staff_address;
	
	rec_cur_staff_match cur_staff_match%ROWTYPE;
	
BEGIN

	OPEN cur_staff_match;
	FETCH cur_staff_match INTO rec_cur_staff_match;
	
	IF cur_staff_match%ROWCOUNT > 0 THEN
		WHILE cur_staff_match%FOUND LOOP
			DBMS_OUTPUT.PUT_LINE(rec_cur_staff_match.staff_id||' NAME: '||rec_cur_staff_match.staff_first_name||' '||rec_cur_staff_match.staff_last_name||'.'||chr(10)||'GENDER: '||rec_cur_staff_match.gender||chr(10)||'ROLE: '||rec_cur_staff_match.role||chr(10)||'MANAGED BY: '||rec_cur_staff_match.instructor_first||' '||rec_cur_staff_match.instructor_last||chr(10));
			FETCH cur_staff_match INTO rec_cur_staff_match;
		END LOOP;
	ELSE
		DBMS_OUTPUT.PUT_LINE('NO ROWS FOUND');
	END IF;
	
END proc_staff_details;
/
SHOW ERRORS;




-- 6) get details of a festival(festival name, location, description, etc) according to thier name
-- (using 2 JOIN, COLUMS ALIAS, CURSOR FOR LOOP, %ISOPEN)

CREATE OR REPLACE PROCEDURE proc_festival_details(in_festival_name festivals.festival_name%TYPE) 
AS

	CURSOR cur_festival IS
		SELECT f.ward_id,f.nature_id,f.festival_name, f.date_description, n.nature_type AS nature,n.category AS category,l.ward.address as ward
		FROM festivals f JOIN locations l ON l.ward_id = f.ward_id JOIN festival_natures n ON n.nature_id = f.nature_id
		WHERE f.festival_name = in_festival_name;

	CURSOR cur_locations IS
		SELECT l.ward_id, h.address.street AS strt, h.hall.capacity as cpt, h.hall.description AS descpt, l.rent
		FROM locations l, TABLE(l.hall) h;

	vn_natureid festival_natures.nature_id%TYPE;
	rec_cur_locations cur_locations%ROWTYPE;
	rec_cur_festival cur_festival%ROWTYPE;

BEGIN

	OPEN cur_locations;
	OPEN cur_festival;
	FETCH cur_festival INTO rec_cur_festival;
	
	IF cur_festival%FOUND THEN
		FETCH cur_locations INTO rec_cur_locations;
		SELECT n.nature_id into vn_natureid
		FROM festival_natures n
		WHERE n.nature_id = rec_cur_festival.nature_id;

		WHILE cur_locations%FOUND LOOP
			IF(rec_cur_festival.ward_id = rec_cur_locations.ward_id AND rec_cur_festival.nature_id = vn_natureid) THEN
				DBMS_OUTPUT.PUT_LINE(rec_cur_locations.ward_id||' The festival '||rec_cur_festival.festival_name||' is a type of '||rec_cur_festival.nature ||'.'||chr(10)||'Which is a '||rec_cur_festival.category||' festival. The celebration Time '||rec_cur_festival.date_description||' at '||rec_cur_locations.strt||' which is a '||rec_cur_locations.descpt||' with the capacity of '||rec_cur_locations.cpt||' people');
				EXIT;
			END IF;
			FETCH cur_locations INTO rec_cur_locations;
			FETCH cur_festival INTO  rec_cur_festival;
		END LOOP;
	ELSE
		DBMS_OUTPUT.PUT_LINE('THE FESTIVAL IS CURRENTLY NOT REGISTERED');
	END IF;	
	
	IF cur_locations%ISOPEN THEN 
		CLOSE cur_locations;
	END IF;		
	
END proc_festival_details;
/
SHOW ERRORS;




-- 7) days left until an event
-- (using CURSOR, user defined RECORD TYPE, CURSOR FOR LOOP) [using FUNCTION (2) and (3)]

CREATE OR REPLACE PROCEDURE proc_days_left 
IS

	CURSOR cur_days_left IS
		SELECT f.festival_name,s.festival_staff_date,s.nature_id,s.ward_id
		FROM festival_staff s
		JOIN festivals f
		ON f.nature_id = s.nature_id AND f.ward_id = s.ward_id;
		
	vn_days_left NUMBER(3);
	
	TYPE vt_locations IS RECORD(
		vc_city VARCHAR2(50)
	);
	
	event_location vt_locations;
	vn_row NUMBER(2) := 0;
	
BEGIN 

	FOR rec_cur_days_left IN cur_days_left LOOP
		vn_days_left := func_days_left(rec_cur_days_left.nature_id,rec_cur_days_left.ward_id);
		IF vn_days_left > 0 THEN 
			vn_row := vn_row + 1;
			
			SELECT l.ward.address
			INTO event_location
			FROM locations l
			WHERE l.ward_id = rec_cur_days_left.ward_id;
			
			DBMS_OUTPUT.PUT_LINE(rec_cur_days_left.festival_name||' is '||vn_days_left ||' days away. Celebrated at '|| func_event_location(rec_cur_days_left.ward_id));
		END IF;
	END LOOP;
	
	IF vn_row = 0 THEN 
		DBMS_OUTPUT.PUT_LINE('NO UPCOMING EVENTS');
	END IF;
	
END proc_days_left;
/
SHOW ERRORS;




-- 8) events that are yet to be organised
-- (using CURSOR, %ROWTYPE, CURSOR FOR LOOP, %FOUND, MINUS)

CREATE OR REPLACE PROCEDURE proc_not_organised 
IS

	CURSOR cur_org_events IS
		SELECT f.nature_id, f.ward_id
		FROM festivals f
		MINUS
		SELECT s.nature_id, s.ward_id
		FROM festival_staff s;

	CURSOR cur_festivals IS
		SELECT f.nature_id, f.ward_id, f.festival_name
		FROM festivals f;
		
	rec_cur_festivals cur_festivals%ROWTYPE;
	
BEGIN

	OPEN cur_festivals;
	FETCH cur_festivals INTO rec_cur_festivals;
	
	WHILE cur_festivals%FOUND LOOP
		FOR rec_cur_org_events IN cur_org_events LOOP
			IF rec_cur_org_events.ward_id = rec_cur_festivals.ward_id AND rec_cur_org_events.nature_id = rec_cur_festivals.nature_id THEN
				DBMS_OUTPUT.PUT_LINE(rec_cur_festivals.festival_name||' is yet to be organised');
			END IF;
		END LOOP;
		FETCH cur_festivals INTO rec_cur_festivals;
	END LOOP;
	
END proc_not_organised;
/
SHOW ERRORS;




-- 9) Calaclate total expense on any event 
-- (using CURSOR, %ROWTYPE, %ISOPEN, JOIN) [using FUNCTION (4)]

CREATE OR REPLACE PROCEDURE proc_expense(in_festival_staff_id festival_staff.festival_staff_id%TYPE) 
IS

	vn_expense NUMBER(9,2);
	
	CURSOR cur_fest_detail IS
		SELECT f.festival_name, s.ward_id , s.nature_id
		FROM festival_staff s 
		JOIN festivals f 
		ON f.ward_id = s.ward_id AND f.nature_id = s.nature_id
		WHERE s.festival_staff_id = in_festival_staff_id;
		
	rec_cur_fest_detail cur_fest_detail%ROWTYPE;
	
BEGIN 

	OPEN cur_fest_detail;
	FETCH cur_fest_detail INTO rec_cur_fest_detail;
	
	IF cur_fest_detail%NOTFOUND THEN 
		DBMS_OUTPUT.PUT_LINE('NO RECORDS FOUND');
	ELSE
		vn_expense := func_calc_expense(in_festival_staff_id);
		DBMS_OUTPUT.PUT_LINE('THE TOTAL REVENUE FOR THE EVENT '||in_festival_staff_id||' is $'||vn_expense||'. THE EVENT IS'||rec_cur_fest_detail.festival_name);
		
		IF cur_fest_detail%ISOPEN THEN
			CLOSE cur_fest_detail;
		END IF;
	END IF;
	
END proc_expense;
/
SHOW ERRORS;




-- 10) calcule total expenditure on an event along with total salary for staffs
-- (using CURSOR, %ROWTYPE, %ISOPEN, JOIN, %FOUND) [using FUNCTION (5)]
 
CREATE OR REPLACE PROCEDURE proc_calaculate_total_exp(in_festival_staff_id festival_staff.festival_staff_id%TYPE) 
IS

	vn_salary NUMBER(9,2);
	vn_rent NUMBER(9,2);
	vn_expense NUMBER(9,2);
	
	CURSOR cur_expense IS
		SELECT f.festival_name, s.ward_id , s.nature_id
		FROM festival_staff s 
		JOIN festivals f 
		ON f.ward_id = s.ward_id AND f.nature_id = s.nature_id
		WHERE s.festival_staff_id = in_festival_staff_id;

	rec_cur_expense cur_expense%ROWTYPE;

BEGIN 

	OPEN cur_expense;
	FETCH cur_expense INTO rec_cur_expense;
	
	IF cur_expense%FOUND THEN
		vn_salary := func_total_salary(in_festival_staff_id);
		vn_rent := func_calc_expense(in_festival_staff_id);
		vn_expense := vn_rent + vn_salary;
		DBMS_OUTPUT.PUT_LINE('AMOUNT SPENT ON STAFF SALARY FOR EVENT '||in_festival_staff_id||' $'||vn_salary||'\- TOTAL RENT FOR THE LOCATION IS $'||vn_rent||'\- TOTAL COST FOR THIS EVENT IS $'||vn_expense||'\-');
	ELSE 
		DBMS_OUTPUT.PUT_LINE('NO SUCH EVENT HAS BEEN FOUND');
	END IF;
	
	IF cur_expense%ISOPEN THEN
		CLOSE cur_expense;
	END IF;
	
END proc_calaculate_total_exp;
/
SHOW ERRORS;




-- 11) insert data's into festival_nature table

CREATE OR REPLACE PROCEDURE proc_insert_nature(in_festival_nature_name festival_natures.nature_type%TYPE, in_category festival_natures.category%TYPE) 
IS

BEGIN

	INSERT INTO festival_natures VALUES(seq_festival_natures.NEXTVAL,in_festival_nature_name,in_category);
	DBMS_OUTPUT.PUT_LINE(in_festival_nature_name||' WAS SUCCESSFULLY ADDED.');

END proc_insert_nature;
/
SHOW ERRORS;




-- 12) delete events from festival_staff
-- (using %NOTFOUND)

CREATE OR REPLACE PROCEDURE proc_delete_event(in_festival_staff_id festival_staff.festival_staff_id%TYPE) 
IS

BEGIN

	DELETE FROM festival_staff 
	WHERE festival_staff_id = in_festival_staff_id;
	
	IF SQL%NOTFOUND THEN
		DBMS_OUTPUT.PUT_LINE('NO RECORDS DELETED');
	ELSE
		DBMS_OUTPUT.PUT_LINE('THE EVENT WITH ID '||in_festival_staff_id||' WAS DELETED');
	END IF;
	
END proc_delete_event; 
/
SHOW ERRORS;




-- 13) calculating the monthly revenue for a festival 
-- (using EXCEPTION) [using FUNCTION (7)]

CREATE OR REPLACE PROCEDURE proc_calc_monthly_revenue(in_month NUMBER, in_year NUMBER) 
AS
	ex_invalid_date EXCEPTION;
BEGIN
	
	IF in_month < 1 OR in_month > 12 OR in_year < 1000 OR in_year > 9999  THEN
		RAISE ex_invalid_date;
	END IF;
	
	IF func_calc_monthly_revenue(in_month, in_year) > 0 THEN
		DBMS_OUTPUT.PUT_LINE('The total revenue generated in the month ' || in_month || ', year ' || in_year || ' is ' || func_calc_monthly_revenue(in_month, in_year) || '.'); 	
	ELSE
		DBMS_OUTPUT.PUT_LINE('You didn''t had any festival''s organised in the month ' || in_month || ', year ' || in_year || '.'); 	
	END IF;

	EXCEPTION
		WHEN ex_invalid_date THEN
			DBMS_OUTPUT.PUT_LINE('INVALID DATE! PLEASE ENTER A VALID DATE.');
	
END proc_calc_monthly_revenue;
/
SHOW ERRORS;

