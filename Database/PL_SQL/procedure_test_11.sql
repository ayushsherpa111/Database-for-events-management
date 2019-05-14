-- GROUP MEMBER'S



-- TESTING PROCEDURE'S


SET SERVEROUTPUT ON;

-- 1) TESTING 'proc_show_staff_detail'

-- as female staff
EXECUTE proc_show_staff_detail(1811, 'SARA', 'CAROLL', 'F', 'SCHEDULER', 22);
-- CONGRATULATION! SARA CAROLL HAS BEEN SUCCESSFULLY ENROLLED AS A SCHEDULER. SHE WOULD BE PAYED 22 DOLLAR'S PER HOUR.


-- as male staff
EXECUTE proc_show_staff_detail(1811, 'KEYOSHI', 'LEE', 'M', 'MENTOR', 35);
-- CONGRATULATION! KEYOSHI LEE HAS BEEN SUCCESSFULLY ENROLLED AS A MENTOR. HE WOULD BE PAYED 35 DOLLAR'S PER HOUR.


-- as invalid gender
EXECUTE proc_show_staff_detail(1811, 'KEYOSHI', 'LEE', 'K', 'MENTOR', 35);
-- INVALID GENDER! PLEASE ENTER A STAFF WITH VALID GENDER.




-- 2) TESTING 'proc_no_of_staff_in_a_role'

-- displaying data's from table 'staff'
SELECT * FROM staff;

-- executing the procedure
EXEC proc_no_of_staff_in_a_role();
-- DIFFERENT TYPES OF ROLE    NO OF STAFF
-- -----------------------    -----------
-- MENTOR                     3
-- SCHEDULER                  3
-- LABOURER                   5
-- ASSISTANT                  3
-- CATERER                    3




-- 3) TESTING 'proc_insert_festival_staff'

-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 0 rows returned
-- NO ROWS PREVIOUSLY ADDED


-- correct parameter
EXEC proc_insert_festival_staff(1804,301,101,'20-APR-2019',9);
-- EVENT SUCCESSFULLY ADDED


-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 1 rows returned
-- ROW SUCCESSFULLY ADDED


-- wrong parameter
EXEC proc_insert_festival_staff(1804,301,101,'12-APR-2019',0);
-- EVENT DATE HAS ALREADY PASSED
-- HOURS WORKED CANNOT BE 0


-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 1 rows returned
-- NO CHANGES IN THE DATABASE




-- 4) TESTING 'proc_get_details'

-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff
-- 1 ROW RETURNED


-- existing date
EXEC proc_get_details('22-APR-2019');
-- OUTPUT
/*
COACHELLA
-----------
Managed By
--------
ALMA ANDREW MENTOR Salary Rs.315

ADAMS JOHNSON LABOURER Salary Rs.162

HARRY WATSON CATERER Salary Rs.252

SARA CAROLL SCHEDULER Salary Rs.198

JAE BONG ASSISTANT Salary Rs.225

CHUL SOON LABOURER Salary Rs.162
*/


-- date that doesnt exit
EXEC proc_get_details('1-JAN-2019'); 
-- NO ROWS FOUND;




-- 5) TESTING 'proc_staff_details'

-- city
EXEC proc_staff_details('HULL');
-- COUTPUT 
/*
1813 NAME: ALEX FERNANDEZ.
GENDER: M
ROLE: SCHEDULER
MANAGED BY: AMENDA WHITE

1805 NAME: DANIEL MATHEW.
GENDER: M
ROLE: ASSISTANT
MANAGED BY: AMENDA WHITE

1810 NAME: WILL SMITH.
GENDER: M
ROLE: CATERER
MANAGED BY: AMENDA WHITE

1823 NAME: JAWED AKTHAR.
GENDER: M
ROLE: SCHEDULER
MANAGED BY: KEYOSHI LEE

1817 NAME: JAWED AKTHAR.
GENDER: M
ROLE: SCHEDULER
MANAGED BY: KEYOSHI LEE
*/


-- street
EXEC proc_staff_details('BOSTON');
-- OUTPUT
/*
1804 NAME: AMENDA WHITE.
GENDER: F
ROLE: MENTOR
MANAGED BY: AMENDA WHITE

1809 NAME: RICKY MARTIN.
GENDER: M
ROLE: LABOURER
MANAGED BY: AMENDA WHITE
*/


-- country 
EXEC proc_staff_details('CANADA');
-- OUTPUT
/*
1807 NAME: ALMA ANDREW.
GENDER: F
ROLE: MENTOR
MANAGED BY: ALMA ANDREW

1812 NAME: JACK WILLAM.
GENDER: M
ROLE: ASSISTANT
MANAGED BY: KEYOSHI LEE
*/




-- 6) TESTING 'proc_festival_details'

-- executing the procedure
EXEC proc_festival_details('OSCAR');
-- OUTPUT
/*
202 The festival OSCAR is a type of FILM FESTIVAL.
Which is a ENTERTAINMENT festival. The celebration Time DEPENDS UPON THE YEAR at 6801 HOLLYHOOD BLVD which is a ORGANISING EVENTS
with the capacity of 1500 people
*/


-- executing the procedure
EXEC proc_festival_details('HOLI');
-- THE FESTIVAL IS CURRENTLY NOT REGISTERED




-- 7) TESTING 'proc_days_left'

-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 0 rows returned


-- executing the procedure
EXEC proc_days_left;
-- NO UPCOMING EVENTS


-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 3 rows returned


-- executing the procedure
EXEC proc_days_left;
-- COACHELLA is 5 days away. Celebrated at VAN BUREN ST, CALIFORNIA, USA




-- 8) TESTING 'proc_not_organised'

-- executing the procedure
EXEC proc_not_organised;
-- OUTPUT
/*
OSCAR is yet to be organised
E3 is yet to be organised
THANKS GIVING is yet to be organised
DASHAIN is yet to be organised
TIHAR is yet to be organised
GLASSGOW SCIENCE FESTIVAL is yet to be organised
ARNOLD SPORTS FESTIVAL is yet to be organised
*/




-- 9) TESTING 'proc_expense'

-- valid id
EXEC proc_expense(1002);
-- THE TOTAL EXPENSE FOR IIFA AWARDS is Rs.30000


-- invalid id
EXEC proc_expense(1);
-- NO RECORDS FOUND




-- 10) TESTING 'proc_calaculate_total_exp'

-- valid id
EXEC proc_calaculate_total_exp(1002);
-- AMOUNT SPENT ON STAFF SALARY FOR EVENT 1002 Rs.620\- TOTAL RENT FOR THE LOCATION IS Rs.30000\- TOTAL COST FOR THIS EVENT IS Rs.30620\-


-- invalid id
EXEC proc_calaculate_total_exp(1);
-- NO SUCH EVENT HAS BEEN FOUND




-- 11) TESTING 'proc_insert_nature'

-- displaying data's from table 'festival_natures'
SELECT * FROM festival_natures;
-- 0 ROWS RETURNED


-- correct input
EXEC proc_insert_nature('SCIENCE','EDUCATION');
-- SCIENCE WAS SUCCESSFULLY ADDED


-- displaying data's from table 'festival_natures'
SELECT * FROM festival_natures;
-- 1 ROWS RETURNED




-- 12) TESTING 'proc_delete_event'

-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 1 ROW RETURNED


-- valid id
EXEC proc_delete_event(1002);
-- THE EVENT WITH ID 1002 WAS DELETED


-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
--	0 ROWS RETURNED;


-- invalid id
EXEC proc_delete_event(1);
-- NO RECORDS DELETED


-- displaying data's from table 'festival_staff'
SELECT * FROM festival_staff;
-- 0 ROWS RETURNED;
-- NO CHANGES




-- 13) TESTING 'proc_calc_monthly_revenue'

-- invalid date 
EXEC proc_calc_monthly_revenue(0, 2019); 
EXEC proc_calc_monthly_revenue(13, 2019);
EXEC proc_calc_monthly_revenue(03, 101);
EXEC proc_calc_monthly_revenue(-1, 20999);
-- INVALID DATE! PLEASE ENTER A VALID DATE.


-- valid date
EXEC proc_calc_monthly_revenue(03, 2019);
-- The total revenue generated in the month 3, year 2019 is 10000.


-- user's choice
EXEC proc_calc_monthly_revenue(&month_in_digit, &festival_year);

