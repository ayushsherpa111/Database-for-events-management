-- GROUP MEMBER'S



-- DROP COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\drop_11.sql


-- DROPPING FOREIGN KEY'S

ALTER TABLE festivals
DROP CONSTRAINT fk_f_festival_natures;

ALTER TABLE festivals
DROP CONSTRAINT fk_f_locations;

ALTER TABLE festival_staff
DROP CONSTRAINT fk_f_staff;

ALTER TABLE festival_staff
DROP CONSTRAINT fk_f_festivals;

ALTER TABLE staff
DROP CONSTRAINT fk_s_staff;



-- DROPPING PRIMARY KEY'S

ALTER TABLE festival_natures
DROP CONSTRAINT pk_festival_natures;

ALTER TABLE locations
DROP CONSTRAINT pk_locations;

ALTER TABLE festivals
DROP CONSTRAINT pk_festivals;

ALTER TABLE festival_staff
DROP CONSTRAINT pk_festival_staff;

ALTER TABLE staff
DROP CONSTRAINT pk_staff;


-- DROPPING CHECK CONSTRAINT'S

ALTER TABLE festival_natures
DROP CONSTRAINT ck_nature_type;

ALTER TABLE festival_natures
DROP CONSTRAINT ck_category;

ALTER TABLE staff
DROP CONSTRAINT ck_staff_first_name;

ALTER TABLE staff
DROP CONSTRAINT ck_staff_last_name;

ALTER TABLE staff
DROP CONSTRAINT ck_gender;

ALTER TABLE staff
DROP CONSTRAINT ck_role;

ALTER TABLE staff
DROP CONSTRAINT uc_email_id;



-- DROPPING SEQUENCE'S

DROP SEQUENCE seq_festival_natures;
DROP SEQUENCE seq_locations;
DROP SEQUENCE seq_fetival_staff;




-- DROPPING TABLE'S

DROP TABLE festival_natures;
DROP TABLE locations;
DROP TABLE festivals;
DROP TABLE staff;
DROP TABLE festival_staff;


-- DROPPING AUDIT TABLE'S

DROP TABLE audit_user_event;
DROP TABLE audit_festival_staff;




-- DROPPING OBJECT TABLE

DROP TABLE addresses;



-- DROPPING OBJECT TYPE

DROP TYPE location_table_type;
DROP TYPE staff_pay_varray_type;
DROP TYPE location_type;
DROP TYPE hall_type;
DROP TYPE address_type;
DROP TYPE staff_pay_type;
DROP TYPE ward_type;
DROP TYPE contact_type;

PURGE RECYCLEBIN;



-- DROPPING FUNCTION'S

DROP FUNCTION func_no_of_staff_in_a_role;
DROP FUNCTION func_days_left;
DROP FUNCTION func_event_location;
DROP FUNCTION func_calc_expense;
DROP FUNCTION func_total_salary;
DROP FUNCTION func_insert_all_staffs_varray;
DROP FUNCTION func_calc_monthly_revenue;





-- DROPPING PROCEDURE'S

DROP PROCEDURE proc_show_staff_detail;
DROP PROCEDURE proc_no_of_staff_in_a_role;
DROP PROCEDURE proc_insert_festival_staff;
DROP PROCEDURE proc_get_details;
DROP PROCEDURE proc_staff_details;
DROP PROCEDURE proc_festival_details;
DROP PROCEDURE proc_days_left;
DROP PROCEDURE proc_not_organised;
DROP PROCEDURE proc_expense;
DROP PROCEDURE proc_calaculate_total_exp;
DROP PROCEDURE proc_insert_nature;
DROP PROCEDURE proc_delete_event;
DROP PROCEDURE proc_calc_monthly_revenue;




-- DROPPING TRIGGER'S

DROP TRIGGER trig_audit_user_event_logon;
DROP TRIGGER trig_audit_user_event_logoff;
-- DROP TRIGGER trig_audit_festival_staff;
-- DROP TRIGGER trig_staff_check_dob;
-- DROP TRIGGER trig_trig_show_staff_detail;



-- DROPPING PACKAGE'S

DROP PACKAGE pkg_retirement;
DROP PACKAGE pkg_table;





