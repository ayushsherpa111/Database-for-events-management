-- GROUP MEMBER'S



-- CREATE TABLE COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\create_11.sql


-- CREATING TYPE'S

CREATE OR REPLACE TYPE hall_type AS OBJECT (
	hall_no VARCHAR2(5),
	capacity NUMBER(5),
	description VARCHAR2(150));
/
SHOW ERRORS;

CREATE OR REPLACE TYPE address_type AS OBJECT (
	street VARCHAR2(150),
	city VARCHAR2(150),
	country VARCHAR2(150),
	postal_code VARCHAR2(5));
/
SHOW ERRORS;

CREATE OR REPLACE TYPE location_type AS OBJECT (
	address address_type,
	hall hall_type,
	theme VARCHAR2(50),
	area NUMBER(7,2));
/
SHOW ERRORS;

CREATE OR REPLACE TYPE ward_type AS OBJECT (
	ward_no VARCHAR2(25),
	address VARCHAR2(50));
/
SHOW ERRORS;

CREATE OR REPLACE TYPE contact_type AS OBJECT (
	phone_number1 VARCHAR2(20),
	phone_number2 VARCHAR2(20),
	fax_no VARCHAR2(20));
/
SHOW ERRORS;

CREATE OR REPLACE TYPE staff_pay_type AS OBJECT (
	staff_id NUMBER(5),
	hours_worked NUMBER(2));
/
SHOW ERRORS;



-- CREATING CBJECT TYPE'S

CREATE TABLE addresses OF address_type;



-- CREATING VARRAY TYPE'S

CREATE TYPE staff_pay_varray_type AS VARRAY(5) OF staff_pay_type;
/
SHOW ERRORS;



-- CREATING NESTED TABLE TYPE'S

CREATE TYPE location_table_type AS TABLE OF location_type;
/
SHOW ERRORS;




-- CREATING TABLE'S

CREATE TABLE festival_natures (
	nature_id NUMBER(5),
	nature_type VARCHAR2(150),
	category VARCHAR2(30));


CREATE TABLE locations (
	ward_id NUMBER(5),
	ward ward_type,
	hall location_table_type,
	rent NUMBER(9,2))
NESTED TABLE hall STORE AS location_table;


CREATE TABLE festivals ( 
	nature_id NUMBER(5) NOT NULL, 
	ward_id NUMBER(5) NOT NULL,
	festival_name VARCHAR2(50),
	date_description CLOB,
	duration NUMBER(2) DEFAULT 1);

CREATE TABLE festival_staff (
	festival_staff_id NUMBER(5),
	staff_id NUMBER(5) NOT NULL,
	nature_id NUMBER(5) NOT NULL,
	ward_id NUMBER(5) NOT NULL,
	festival_staff_date DATE, 
	staff_pay staff_pay_varray_type );


CREATE TABLE staff ( 
	staff_id NUMBER(5),
	staff_first_name VARCHAR2(50),
	staff_last_name VARCHAR2(50),
	gender CHAR(1) DEFAULT 'F',
	email_id VARCHAR2(30) NOT NULL,
	contact contact_type,
	date_of_birth DATE,
	role VARCHAR2(10),
	staff_image BLOB,
	instructor_id NUMBER(5) NOT NULL,
	pay_rate NUMBER(4) DEFAULT 18,
	address REF address_type SCOPE IS addresses);



-- auditing login or loggoff events

CREATE TABLE audit_user_event (
	event_type VARCHAR2(20),
	logon_date DATE,
	logon_time VARCHAR2(20),
	logoff_date DATE,
	logoff_time VARCHAR2(20)
);	
	
	
-- auditing DML events for table 'festival_staff'

CREATE TABLE audit_festival_staff (
	user_name VARCHAR2(30),
	audit_date VARCHAR2(30),
	audit_operation VARCHAR2(20)
);	
	
	
	
-- CREATING SEQUENCE'S

CREATE SEQUENCE seq_festival_natures
INCREMENT BY 1
START WITH 301;

CREATE SEQUENCE seq_locations
INCREMENT BY 101
START WITH 101;

CREATE SEQUENCE seq_fetival_staff
INCREMENT BY 1
START WITH 1101;

