-- GROUP MEMBER'S



-- INSERT INTO TABLE COMMANDS
-- @C:\Temp\CSY2038(RM)\ASSIGNMENT\insert_11.sql


-- INSERTING INTO addresses

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('BAY ROAD', 'BOSTON', 'UK','+44');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('456 CHAMPS', 'PARIS', 'FRANCE', '+33');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('ALL LANE', 'SEATTLE', 'USA', '+1');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('IMPERIAL BLVD', 'LOS ANGLES', 'USA', '+1');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('VALLEY WAY', 'HULL', 'UK', '+44');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('ELM STREET', 'TORONTO', 'CANADA', '+1');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('WISCONSIN', 'MILTON', 'UK', '+44');

INSERT INTO addresses(city, street,country, postal_code)
VALUES ('KEUNGSGATAN', 'STOCKHOLM', 'SWEDEN', '+46');




-- INSERTING INTO festival_natures

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'CULTURAL', 'CULTURAL');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'FILM FESTIVAL', 'ENTERTAINMENT');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'MUSIC FESTIVAL', 'ENTERTAINMENT');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'GAMING FESTIVAL', 'ENTERTAINMENT');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'NATIONAL', 'CULTURAL');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'SCIENCE FESTIVAL', 'EDUCATIONAL');

INSERT INTO festival_natures(nature_id, nature_type, category)
VALUES (seq_festival_natures.NEXTVAL,'SPORTS FESTIVAL', 'SPORTS');




-- INSERTING INTO locations
				
INSERT INTO locations(ward_id, ward, hall, rent)
VALUES (seq_locations.NEXTVAL , ward_type('3686 50 A', 'JERUSALEM'), 
			location_table_type(
				location_type(address_type('MANAGER SQUARE', 'JERUSALEM', 'ISRAEL', '91000'), hall_type('101', 500, 'MOSTLY DINING'), 'BUFFET',1),
				location_type(address_type('CASA NOVA PALACE', 'JERUSALEM', 'ISRAEL', '91000'), hall_type('801', 300, 'GATHERING AND CELEBRATION'), 'GATHERING',1.5)), 
		10000.00);
															
INSERT INTO locations(ward_id, ward, hall, rent) 
VALUES (seq_locations.NEXTVAL, ward_type('CA 90028', 'HOLLYHOOD'), 
			location_table_type(
				location_type(address_type('6801 HOLLYHOOD BLVD', 'HOLLYHOOD', 'USA', '+1'), hall_type('301', 1500, 'ORGANISING EVENTS'), 'THEATRE', 0.8)), 
		30000.00);

INSERT INTO locations(ward_id, ward, hall, rent) 
VALUES (seq_locations.NEXTVAL, ward_type('111', 'CALIFORNIA'), 
			location_table_type(
				location_type(address_type('JACKSON ST', 'CALIFORNIA', 'USA', '+1'), hall_type('A1', 30000,  'CONCERTS AND MELAS'), 'ENTERTAINMENT', 2),
				location_type(address_type('AVENUE 50', 'CALIFORNIA', 'USA', '+1'), hall_type('A2', 10000, 'LUCNH AND DINNER'), 'BUFFET', 1),
				location_type(address_type('VAN BUREN ST', 'CALIFORNIA', 'USA', '+1'), hall_type('A3', 50000, 'CONCERTS'), 'ENTERTAINMENT', 2.5)), 
		15000.00);

INSERT INTO locations(ward_id, ward, hall, rent) 
VALUES (seq_locations.NEXTVAL, ward_type('CA 90015', 'LOS ANGELES'),
			location_table_type(
				location_type(address_type('1201 S FIGUEROA ST', 'LOS ANGELES', 'USA', '+1'), hall_type('01', 500, 'CONVENTION CENTER'), 'CONVENTION CENTER', 1),
				location_type(address_type('1201 S BOLUVARD ST', 'LOS ANGELES', 'USA', '+1'), hall_type('01', 500, 'CONVENTION CENTER'), 'CONVENTION CENTER', 1)), 
		15500);

INSERT INTO locations(ward_id, ward, hall, rent) 
VALUES (seq_locations.NEXTVAL, ward_type('P828+92', 'KATHMANDU'), 
			location_table_type(
				location_type(address_type('TUNDHIKEHL', 'KATHMANDU', 'NEPAL', '+977'), hall_type('K1', 50000, 'MELAS AND CELEBRATIOIN'), 'ENTERTAINMENT', 3),
				location_type(address_type('JAMAL', 'KATHMANDU', 'NEPAL', '+977'), hall_type('K1', 50000, 'ORGANISING EVENTS'), 'THEATRE', 1.5)), 
		8000);

INSERT INTO locations(ward_id, ward, hall, rent) 
VALUES (seq_locations.NEXTVAL, ward_type('VIC 3000', 'MELBOURNE'), 
			location_table_type(
				location_type(address_type('LA TROBE ST', 'MELBOURNE', 'AUSTRALIA', '2818'), hall_type('05A', 10000, 'ORGANISING EVENTS'), 'THEATRE', 1.5),
				location_type(address_type('LITTLE LONSDALE ST', 'MELBOURNE', 'AUSTRALIA', '2818'), hall_type('05B', 3000, 'CONCERTS'), 'THEATRE', 1.2),
				location_type(address_type('LA TROBE ST', 'MELBOURNE', 'AUSTRALIA', '2818'), hall_type('05C', 5000, 'LUNCH AND DINING'), 'DINING', 1)), 
		25000);

		

-- INSERTING INTO festivals
INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (301, 101, 'CHRISTMAS', '25TH DECEMBER', 1);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (302, 202, 'OSCAR', 'DEPENDS UPON THE YEAR', 1);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (303, 303, 'COACHELLA', 'DURING THE MONTH OF APRIL', 10);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (304, 404, 'E3', 'DURING THE MONTH OF JUNE', 3);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (305, 101, 'THANKS GIVING', 'BETWEEN OCTOBER AND NOVEMBER (DEPENDS UPON COUNTRY)', 1);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (301, 505, 'DASHAIN', 'DURING THE MONTH OF OCTOBER', 10);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (301, 606, 'TIHAR', 'DURING THE MONTH OF NOVEMBER', 5);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (306, 404, 'GLASSGOW SCIENCE FESTIVAL', 'ACCORDING TO ORGANISER', 3);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (302, 303, 'IIFA AWARDS', 'DURING TO MONTH OF JUNE AND JULY', 2);

INSERT INTO festivals(nature_id, ward_id, festival_name, date_description, duration)
VALUES (307, 606, 'ARNOLD SPORTS FESTIVAL', '23RD FEBRUARY TO 3RD MARCH', 9);



-- INSERTING INTO staff

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1804,'AMENDA', 'WHITE',	'F', 'white984@hotmail.com', contact_type('617 256 549', '617 256 549', '617 256 549'), '7-JUL-1988', 'MENTOR', 1804, 35, 
			REF (a) 
			FROM addresses a 
			WHERE city = 'BAY ROAD' AND street = 'BOSTON';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1807,'ALMA', 'ANDREW', 'F', 'andrewALM@gmail.com', contact_type('713 726 3862', '713 726 3862', '713 726 3862'), '13-AUG-1983', 'MENTOR', 1807, 35, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'ELM STREET' AND street = 'TORONTO';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1814,'KEYOSHI', 'LEE', 'F', 'keyoshi.90@hotmail.com', contact_type('01604 962136', '01604 962136', '01604 962136'), '21-MAR-1982', 'MENTOR', 1814, 35, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'WISCONSIN' AND street = 'MILTON';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1801,'JOHN', 'PETERSEN', 'M', 'john.peterson@gmail.com', contact_type('213 337 8288', '213 337 8288', '213 337 8288'), '2-FEB-2002', 'LABOURER', 1804, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'ALL LANE' AND street = 'SEATTLE';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1802,'ADAMS', 'JOHNSON', 'M', 'adam321@yahoo.com', contact_type('05064 923787', '05064 923787', '05064 923787'), '8-JAN-1981', 'LABOURER', 1807, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = '456 CHAMPS' AND street = 'PARIS';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1803,'ANDREA', 'DON', 'F', 'don924_and@gmail.com', contact_type('01604 962136', '01604 962136', '01604 962136'), '23-JAN-1995', 'LABOURER', 1814, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'WISCONSIN' AND street = 'MILTON';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1805,'DANIEL', 'MATHEW', 'M', 'daneil_mat@089gmail.com', contact_type('714 356 1273', '714 356 1273', '714 356 1273'), '16-DEC-1997', 'ASSISTANT', 1804, 25, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1806,'HARRY', 'WATSON',	'M', 'watsonWat@yahoo.com', contact_type('09318 912773', '09318 912773', '09318 912773'), '28-NOV-1999', 'CATERER', 1807, 28, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'KEUNGSGATAN' AND street = 'STOCKHOLM';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1808,'ANGELA', 'JUNIOR', 'F', 'junior@yahoo.com', contact_type('213 335 8493', '213 335 8493', '213 335 8493'), '19-MAR-1991', 'CATERER', 1814, 28, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'IMPERIAL BLVD' AND street = 'LOS ANGLES';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1809,'RICKY', 'MARTIN', 'M', 'ricky1040@gmail.com', contact_type('617 256 549', '617 256 549', '617 256 549'), '6-FEB-1997', 'LABOURER', 1804, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'BAY ROAD' AND street = 'BOSTON';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1810,'WILL', 'SMITH', 'M', 'will.smith@gmail.com', contact_type('617 256 549', '617 256 549', '617 256 549'), '9-OCT-1989', 'CATERER', 1804, 28, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1811, 'SARA', 'CAROLL',	'F', 'Sara146@gmail.com', contact_type('213 337 8288', '213 337 8288', '213 337 8288'), '17-NOV-1999', 'SCHEDULER', 1807, 22, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'ALL LANE' AND street = 'SEATTLE';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1812,'JACK', 'WILLAM', 'M', 'Jack56@hotmail.com', contact_type('713 726 3862', '713 726 3862', '713 726 3862'), '22-FEB-1992', 'ASSISTANT', 1814, 25,
			REF(a) 
			FROM addresses a 
			WHERE city = 'ELM STREET' AND street = 'TORONTO';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1813,'ALEX', 'FERNANDEZ', 'M', 'alex98@yahoo.com', contact_type('714 356 1273', '714 356 1273', '714 356 1273'), '26-JAN-1994', 'SCHEDULER', 1804, 22, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1815,'JAE', 'BONG', 'M', 'jae876@gmail.com', contact_type('714 356 1273', '714 356 1273', '714 356 1273'), '16-AUG-1991', 'ASSISTANT', 1807, 25, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'ALL LANE' AND street = 'SEATTLE';
			
INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1816,'CHUL', 'SOON', 'M', 'chulsoon94@hotmail.com', contact_type('05064 923787', '05064 923787', '05064 923787'), '19-SEP-1990', 'LABOURER', 1807, 18, 
			REF(a) 
			FROM addresses a 
			WHERE city = '456 CHAMPS' AND street = 'PARIS';

INSERT INTO staff(staff_id, staff_first_name, staff_last_name, gender, email_id, contact, date_of_birth, role, instructor_id, pay_rate, address)
SELECT 1817,'JAWED', 'AKTHAR',	'M', 'jawed78@yahoo.com', contact_type('714 356 1273', '714 356 1273', '714 356 1273'), '4-OCT-1995', 'SCHEDULER', 1814, 22, 
			REF(a) 
			FROM addresses a 
			WHERE city = 'VALLEY WAY' AND street = 'HULL';

update 

-- INSERTING INTO festival_staff

INSERT INTO festival_staff(festival_staff_id, staff_id, nature_id, ward_id, festival_staff_date, staff_pay)
VALUES (seq_fetival_staff.NEXTVAL, 1804, 301, 101, '20-MAR-2019',
	staff_pay_varray_type(
	staff_pay_type(1801, 6),
	staff_pay_type(1805, 4),
	staff_pay_type(1809, 6),
	staff_pay_type(1810, 5),
	staff_pay_type(1813, 1)));
	
COMMIT;

