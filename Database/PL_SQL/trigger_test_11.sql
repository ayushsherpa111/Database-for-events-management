-- GROUP MEMBER'S



-- TESTING TRIGGER'S


SET SERVEROUTPUT ON;


-- 1) TESTING 'trig_audit_user_event_logon' 

SELECT * FROM audit_user_event;

-- LOGOFF from database SCHEMA

-- LOGON into database SCHEMA

SELECT * FROM audit_user_event;




-- 2) TESTING 'trig_audit_user_event_logoff' 

--  displaying data's from table 'audit_user_event'
SELECT * FROM audit_user_event;

-- LOGOFF from database SCHEMA

-- LOGON into database SCHEMA

--  displaying data's from table 'audit_user_event'
SELECT * FROM audit_user_event;




-- 3) TESTING 'trig_audit_festival_staff' 

--  displaying data's from table 'audit_festival_staff'
SELECT * FROM audit_festival_staff;

-- INSERTING into table 'festival_staff'
EXEC proc_insert_festival_staff(1804,301,101,'29-APR-2019',9);

--  displaying data's from table 'audit_festival_staff'
SELECT * FROM audit_festival_staff;


-- UPDATING data from table 'festival_staff'
UPDATE festival_staff SET 
	staff_pay = staff_pay_varray_type(
					staff_pay_type(1801, 6),
					staff_pay_type(1805, 4),
					staff_pay_type(1809, 6),
					staff_pay_type(1818, 5),
					staff_pay_type(1810, 5),
					staff_pay_type(1813, 1))
WHERE festival_staff_id = 1804;

--  displaying data's from table 'audit_festival_staff'
SELECT * FROM audit_festival_staff;


-- DELETING from table 'festival_staff'
DELETE FROM festival_staff 
WHERE  festival_staff_id = 1804;

--  displaying data's from table 'audit_festival_staff'
SELECT * FROM audit_festival_staff;




-- 4) TESTING 'trig_staff_check_dob' 

-- staff with 'date_of_birth' exceeding today's date 
INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1822,'RICH', 'FERGUSON',	'M', 'rich78@yahoo.com', contact_type('714 753 324', '714 875 3452', '714 8475 3647'), '09-DEC-2020', 'LABOURER', 1814, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';
-- ORA-20000: ERROR - DATE OF BIRTH CANNOT EXCEED TODAY'S DATE. PLEASE INSERT VALID DATE OF BIRTH.
			
			
-- staff with 'date_of_birth' exceeding 60 year's 
INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1822,'RICH', 'FERGUSON',	'M', 'rich78@yahoo.com', contact_type('714 753 324', '714 875 3452', '714 8475 3647'), '09-DEC-1915', 'LABOURER', 1814, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';
-- ORA-20001: ERROR - INVALID APPLICANT! AGE OF STAFF SHOULD BE LESS THAN 60 YEARS OLD TO BE ENROLLED IN THE SYSTEM.
			

-- staff with valid 'date_of_birth' 			
INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1822,'RICH', 'FERGUSON',	'M', 'rich78@yahoo.com', contact_type('714 753 324', '714 875 3452', '714 8475 3647'), '09-DEC-1970', 'LABOURER', 1814, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';

			
-- deleting currently added staff
DELETE FROM staff WHERE staff_id = 1822;
			
			
			

-- 5) TESTING 'trig_show_staff_detail' 

-- staff with valid 'date_of_birth' 			
INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1822,'RICH', 'FERGUSON',	'M', 'rich78@yahoo.com', contact_type('714 753 324', '714 875 3452', '714 8475 3647'), '09-DEC-1970', 'LABOURER', 1814, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';
-- CONGRATULATION! RICH FERGUSON HAS BEEN SUCCESSFULLY ENROLLED AS A LABOURER. HE WOULD BE PAYED 18 DOLLAR'S PER HOUR.

