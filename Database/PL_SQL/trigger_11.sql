-- GROUP MEMBER'S



-- TRIGGER COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\PL_SQL\trigger_11.sql


SET SERVEROUTPUT ON;

-- 1) auditing user login events
-- (using USER EVENT like LOGON, SCHEMA, ORA_SYSEVENT)

CREATE OR REPLACE TRIGGER trig_audit_user_event_logon
AFTER LOGON ON SCHEMA

BEGIN
	
	-- DBMS_OUTPUT.PUT_LINE('WEL-COME TO YOUR WORKSPACE ' || USER || '!!!');
	
	INSERT INTO audit_user_event (event_type, logon_date, logon_time, logoff_date, logoff_time)
	VALUES (ORA_SYSEVENT, SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI:SS'), NULL, NULL);
	
END trig_audit_user_event_logon;
/
SHOW ERRORS;




-- 2) auditing user loggoff events
-- (using USER EVENT like LOGOFF, SCHEMA, ORA_SYSEVENT)

CREATE OR REPLACE TRIGGER trig_audit_user_event_logoff
BEFORE LOGOFF ON SCHEMA

BEGIN
	
	-- DBMS_OUTPUT.PUT_LINE('HAVE A GOOD DAY ' || USER || '!!!');
	
	INSERT INTO audit_user_event (event_type, logon_date, logon_time, logoff_date, logoff_time)
	VALUES (ORA_SYSEVENT, NULL, NULL, SYSDATE, TO_CHAR(SYSDATE, 'HH24:MI:SS'));
	
END trig_audit_user_event_logoff;
/
SHOW ERRORS;




-- 3) auditing table 'festival_staff' for INSERTING, UPDATING OR DELETING

CREATE OR REPLACE TRIGGER trig_audit_festival_staff
BEFORE INSERT OR UPDATE OR DELETE ON festival_staff
FOR EACH ROW 

DECLARE 
	vc_user audit_festival_staff.user_name%TYPE;
	vc_date audit_festival_staff.audit_date%TYPE;

BEGIN

	SELECT USER, TO_CHAR(SYSDATE, 'DD/MON/YYYY HH24:MI:SS') 
	INTO vc_user, vc_date 
	FROM DUAL;
	
	IF INSERTING THEN
		INSERT INTO audit_festival_staff(user_name, audit_date, audit_operation)
		VALUES (vc_user, vc_date, 'INSERT');
	ELSIF UPDATING THEN
		INSERT INTO audit_festival_staff(user_name, audit_date, audit_operation)
		VALUES (vc_user, vc_date, 'UPDATE');
	ELSIF DELETING THEN
		INSERT INTO audit_festival_staff(user_name, audit_date, audit_operation)
		VALUES (vc_user, vc_date, 'DELETE');	
	END IF;
	
END trig_audit_festival_staff;
/
SHOW ERRORS;






-- 4) verifying whether 'date_of_birth' column is greater than SYSDATE or greater than the required age ie, 60 years old

CREATE OR REPLACE TRIGGER trig_staff_check_dob 
BEFORE INSERT OR UPDATE OF date_of_birth ON staff
FOR EACH ROW 
WHEN (NEW.date_of_birth > SYSDATE OR NEW.date_of_birth < (SYSDATE - 60 * 365))

BEGIN

	IF :NEW.date_of_birth > SYSDATE THEN
		RAISE_APPLICATION_ERROR(-20000, 'ERROR - DATE OF BIRTH CANNOT EXCEED TODAY''S DATE. PLEASE INSERT VALID DATE OF BIRTH.');
	ELSIF :NEW.date_of_birth < (SYSDATE - 60 * 365) THEN 
		RAISE_APPLICATION_ERROR(-20001, 'ERROR - INVALID APPLICANT! AGE OF STAFF SHOULD BE LESS THAN 60 YEARS OLD TO BE ENROLLED IN THE SYSTEM.');
	END IF;
	
END trig_staff_check_dob;
/
SHOW ERRORS;






-- 5) auto updating 'pay_rate' column according to the role of staff 
-- (using CASE) [using PROCEDURE (1)]

CREATE OR REPLACE TRIGGER trig_show_staff_detail
AFTER INSERT ON staff
FOR EACH ROW 

DECLARE 
	vc_role VARCHAR2(10) := :NEW.role;
	
BEGIN
	
	CASE 
		WHEN vc_role = 'LABOURER' THEN
			proc_show_staff_detail(:NEW.staff_id, :NEW.staff_first_name, :NEW.staff_last_name, :NEW.gender, vc_role, :NEW.pay_rate);
		WHEN vc_role = 'MENTOR' THEN
			proc_show_staff_detail(:NEW.staff_id, :NEW.staff_first_name, :NEW.staff_last_name, :NEW.gender, vc_role, :NEW.pay_rate);
		WHEN vc_role = 'ASSISTANT' THEN
			proc_show_staff_detail(:NEW.staff_id, :NEW.staff_first_name, :NEW.staff_last_name, :NEW.gender, vc_role, :NEW.pay_rate);
		WHEN vc_role = 'CATERER' THEN
			proc_show_staff_detail(:NEW.staff_id, :NEW.staff_first_name, :NEW.staff_last_name, :NEW.gender, vc_role, :NEW.pay_rate);
		WHEN vc_role = 'SCHEDULER' THEN
			proc_show_staff_detail(:NEW.staff_id, :NEW.staff_first_name, :NEW.staff_last_name, :NEW.gender, vc_role, :NEW.pay_rate);
	END CASE;
	
END trig_show_staff_detail;
/
SHOW ERRORS;

