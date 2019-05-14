-- GROUP MEMBER'S



-- ALTER COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\alter_11.sql


-- PRIMARY KEY CONSTRAINT'S

ALTER TABLE festival_natures
ADD CONSTRAINT pk_festival_natures
PRIMARY KEY (nature_id);

ALTER TABLE locations
ADD CONSTRAINT pk_locations
PRIMARY KEY (ward_id);

ALTER TABLE festivals
ADD CONSTRAINT pk_festivals
PRIMARY KEY (nature_id, ward_id);

ALTER TABLE staff
ADD CONSTRAINT pk_staff
PRIMARY KEY (staff_id);

ALTER TABLE festival_staff
ADD CONSTRAINT pk_festival_staff
PRIMARY KEY (festival_staff_id, staff_id, nature_id, ward_id);




-- FOREIGN KEY CONSTRAINT'S

ALTER TABLE festivals 
ADD CONSTRAINT fk_f_festival_natures 
FOREIGN KEY (nature_id) 
REFERENCES festival_natures(nature_id); 

ALTER TABLE festivals
ADD CONSTRAINT fk_f_locations
FOREIGN KEY (ward_id)
REFERENCES locations(ward_id);

ALTER TABLE festival_staff
ADD CONSTRAINT fk_f_staff
FOREIGN KEY (staff_id)
REFERENCES staff(staff_id);

ALTER TABLE staff
ADD CONSTRAINT fk_s_staff
FOREIGN KEY (instructor_id)
REFERENCES staff(staff_id);

ALTER TABLE festival_staff
ADD CONSTRAINT fk_f_festivals
FOREIGN KEY (ward_id, nature_id)
REFERENCES festivals(ward_id, nature_id);



-- CHECK CONSTRAINT'S

ALTER TABLE festival_natures
ADD CONSTRAINT ck_nature_type
CHECK (nature_type =UPPER(nature_type));

ALTER TABLE festival_natures
ADD CONSTRAINT ck_category
CHECK (category =UPPER(category));

ALTER TABLE staff
ADD CONSTRAINT ck_staff_first_name
CHECK (staff_first_name =UPPER(staff_First_name));

ALTER TABLE staff
ADD CONSTRAINT ck_staff_last_name
CHECK (staff_last_name =UPPER(staff_Last_name));

ALTER TABLE staff
ADD CONSTRAINT ck_gender
CHECK (gender IN ('M','F'));

ALTER TABLE staff
ADD CONSTRAINT ck_role
CHECK (role IN ('LABOURER','MENTOR', 'ASSISTANT', 'CATERER', 'SCHEDULER'));

ALTER TABLE staff
ADD CONSTRAINT uc_email_id
UNIQUE (email_id);

