create database case_study;
use case_study;
create table Location (
Location_ID int primary key,
City varchar (10));

create table Department (
Department_ID int primary key,
Name varchar (10),
Location_ID INT,
FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID));

create table Job (
Job_ID int PRIMARY KEY,
Designation VARCHAR(15));

Drop table Job;

create table Employee(
Employee_Id INT,
Last_name VARCHAR(15),
First_Name VARCHAR (15),
Middle_Name VARCHAR (15), 
Job_Id INT,  
Manager_Id INT,
Hire_Date DATE,
Salary INT,
Comm VARCHAR(15) NULL,
Department_Id INT,
Foreign Key (Job_ID) REFERENCES Job(Job_ID),
Foreign Key (Department_ID) REFERENCES Department(Department_ID));

/*
Index (Department_Id), INDEX (Job_ID),
Foreign Key (Job_ID) REFERENCES Job(Job_ID),
Foreign Key (Department_ID) REFERENCES Department(Department_ID) */

Drop table employee;

alter table department
drop foreign key department_ibfk_1;

INSERT into location values
(122,'New York'),
(123,'Dallas'),
(124,'Chicago'),
(167,'Biston');

INSERT into department values
(10,'Accounting',122),
(20,'Sales',124),
(30,'Research',123),
(40,'Operations',167);

INSERT into Job values
(667,'Clerk'),
(668,'Staff'),
(669,'Analyst'),
(670,'Sales Person'),
(671,'Manager'),
(672,'President');

INSERT into Employee values
(7369,'SMITH','JOHN','Q',667,7902,'1984-12-17',800,'NULL',20),
(7499,'ALLEN','KEVIN','J',670,7698,'1985-02-20',1600,'300',30),
(7505,'DOYLE','JEAN','K',671,7839,'1985-04-04',2850,'NULL',30),
(7506,'DENNIS','LYNN','S',671,7839,'1985-05-15',2750,'NULL',30),
(7507,'BAKER','LESLIE','D',671,7839,'1985-06-10',2200,'NULL',40),
(7521,'WARK','CYNTHIA','D',670,7698,'1985-02-22',1250,'500',30);

-- 1. LIST ALL THE EMPLOYEE DETAILS.
select * from Employee;

-- 2. LIST ALL THE DEPARTMENT DETAILS
select * from Department;

-- 3. LIST ALL JOB DETAILS.
select * from Job;

-- 4. LIST ALL THE LOCATIONS.
select * from Location;

-- 5. LIST OUT THE FIRSTNAME, LASTNAME, SALARY, COMMISSION FOR ALL EMPLOYEES.
SELECT First_Name,Last_name,Salary,Comm from employee;

/* 6. LIST OUT EMPLOYEEID,LAST NAME, DEPARTMENT ID FOR ALL EMPLOYEES AND ALIAS EMPLOYEE_ID AS "ID OF THE EMPLOYEE", 
LAST NAME AS "NAME OF THE EMPLOYEE", DEPARTMENTID AS "DEP_ID"*/
select Employee_Id as ID_of_the_employee,Last_name as name_of_the_employee,Department_Id as Dep_ID from employee;

-- 7. LIST OUT THE EMPLOYEES ANNUAL SALARY WITH THEIR NAMES ONLY.
Select concat(First_Name,' ',Middle_Name,' ',Last_name) AS Names, salary as annual_salary from employee;


-- WHERE

-- 1. LIST THE DETAILS ABOUT "SMITH"
select * from employee where last_name = 'smith';

-- 2. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 20.
SELECT * from employee where Department_ID = 20;

-- 3. LIST OUT THE EMPLOYEES WHO ARE EARNING SALARY BETWEEN 3000 AND 4500.
SELECT * from employee where salary BETWEEN 3000 AND 4500;

-- 4. LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 OR 20.
SELECT * from employee where Department_ID IN(10,20);

-- 5. FIND OUT THE EMPLOYEES WHO ARE NOT WORKING IN DEPARTMENT 10 OR 30. 
SELECT * from employee where Department_ID NOT IN(10,30);

-- 6. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S'. 
SELECT * from employee where First_Name LIKE ('s%');

-- 7. LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S' AND ENDS WITH 'H'. 
SELECT * from employee where First_Name LIKE ('S%H');

-- 8. LIST OUT THE EMPLOYEES WHOSE NAME LENGTH IS 4 AND START WITH 'S'.
SELECT * from employee where First_Name LIKE ('s____');

-- 9. LIST OUT EMPLOYEES WHO ARE WORKING IN DEPARRTMENT 10 AND DRAW THE SALARIES MORE THAN 3500.
SELECT * from employee where Department_ID = 10 AND salary>3500;

-- 10. LIST OUT THE EMPLOYEES WHO ARE NOT RECEVING COMMISSION
SELECT * FROM Employee WHERE Comm = 'NULL';


-- ORDER BY

-- 1. LIST OUT THE EMPLOYEE ID, LAST NAME IN ASCENDING ORDER BASED ON THE EMPLOYEE ID.
SELECT Employee_ID,Last_name FROM Employee ORDER BY Employee_ID;

-- 2. LIST OUT THE EMPLOYEE ID, NAME IN DESCENDING ORDER BASED ON SALARY.
SELECT Employee_ID,First_Name FROM Employee ORDER BY Salary DESC;

-- 3. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER AND
SELECT * FROM Employee ORDER BY Last_name;

-- 4. LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST-NAME IN ASCENDING ORDER AND THEN ON DEPARTMENT_ID IN DESCENDING ORDER.
SELECT * FROM Employee ORDER BY Last_name, Department_ID DESC;

-- GROUP BY & HAVING CLAUSE
-- 1. HOW MANY EMPLOYEES WHO ARE IN DIFFERENT DEPARTMENTS WISE IN THE ORGANIZATION.
SELECT Department_ID,count(Department_ID) as No_of_Employees FROM Employee GROUP BY Department_ID;

-- 2. LIST OUT THE DEPARTMENT WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARY OF THE EMPLOYEES.
SELECT Department_ID,max(salary) max_salary,min(salary) min_salary,round(avg(salary),2) avg_salary from employee GROUP BY Department_ID;

-- 3. LIST OUT JOB WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARIES OF THE EMPLOYEES.
SELECT Job_ID,max(salary) max_salary,min(salary) min_salary,round(avg(salary),2) avg_salary from employee GROUP BY Job_ID;

-- 4. LIST OUT THE NUMBER OF EMPLOYEES JOINED IN EVERY MONTH IN ASCENDING ORDER.
SELECT mid(hire_date,6,2) months,count(hire_date) no_of_employees from employee GROUP BY mid(hire_date,6,2);

-- 5. LIST OUT THE NUMBER OF EMPLOYEES FOR EACH MONTH AND YEAR, IN THE ASCENDING ORDER BASED ON THE YEAR, MONTH.
SELECT mid(hire_date,1,4) Years,mid(hire_date,6,2) months,count(hire_date) no_of_employees from employee GROUP BY mid(hire_date,1,4),mid(hire_date,6,2);

-- 6. LIST OUT THE DEPARTMENT ID HAVING ATLEAST FOUR EMPLOYEES.
select Department_ID,count(*) NO_OF_EMPLOYEES FROM Employee GROUP BY Department_ID HAVING count(*)>4;

-- 7. HOW MANY EMPLOYEES JOINED IN JANUARY MONTH.
SELECT month(hire_date) month,count( month(hire_date)) no_of_employees from employee WHERE month(hire_date)=01 GROUP BY month(hire_date);
SELECT month(hire_date) month,count(*) no_of_employees from employee WHERE month(hire_date)=01 GROUP BY month(hire_date);

-- 8. HOW MANY EMPLOYEES JOINED IN JANUARY OR SEPTEMBER MONTH.
SELECT month(hire_date) month,count( month(hire_date)) no_of_employees from employee WHERE month(hire_date) IN (01,09) GROUP BY month(hire_date);

-- 9. HOW MANY EMPLOYEES WERE JOINED IN 1985.
SELECT * FROM employee WHERE hire_date BETWEEN '1985-01-01' AND '1985-12-30';
SELECT * FROM employee WHERE hire_date LIKE ('__85%');
SELECT year(hire_date) Year,count(*) no_of_employees from employee WHERE year(hire_date)=1985 GROUP BY year(hire_date);

-- 10. HOW MANY EMPLOYEES WERE JOINED EACH MONTH IN 1985.
SELECT count(*) No_of_employees,year(hire_date) year,month(hire_date) month FROM employee WHERE year(hire_date)=1985 GROUP BY year(hire_date),month(hire_date);

-- 11. HOW MANY EMPLOYEES WERE JOINED IN MARCH 1985?
SELECT year(hire_date) Year, month(hire_date) month,count(*) no_of_employees from employee 
	WHERE year(hire_date)=1985 AND month(hire_date)=03 GROUP BY year(hire_date), month(hire_date);

-- 12. WHICH IS THE DEPARTMENT ID, HAVING GREATER THAN OR EQUAL TO 3 EMPLOYEES JOINED IN APRIL 1985?
SELECT count(*) No_of_employees,Department_ID from employee 
	WHERE year(hire_date)=1985 AND month(hire_date)=04 GROUP BY department_ID HAVING count(*)>=3;
SELECT count(*) No_of_employees,Department_ID from employee 
	WHERE hire_date LIKE '1985-04%' GROUP BY department_ID HAVING count(*)>=3; 
    
    
    
-- JOINS

-- 1. LIST OUT EMPLOYEES WITH THEIR DEPARTMENT NAMES.        
SELECT * FROM employee e
	INNER JOIN department d
    ON e.department_ID = d.department_ID;
    
  SELECT * FROM Employee e
        LEFT OUTER JOIN department d 
		ON e.department_id = d.department_id;
    
-- 2. DISPLAY EMPLOYEES WITH THEIR DESIGNATIONS.
SELECT * FROM employee e
	INNER JOIN Job j
    ON e.Job_ID = j.Job_ID;

SELECT e.Job_ID,e.First_name,e.Middle_Name,e.Last_Name,j.Designation FROM employee e
	INNER JOIN Job j
    ON e.Job_ID = j.Job_ID;

-- 3. DISPLAY THE EMPLOYEES WITH THEIR DEPARTMENT NAMES AND REGIONAL GROUPS.
    
SELECT Employee_ID,Last_Name,Salary,e.Department_ID,Name,City FROM Employee e,Department d,Location l 
WHERE e.Department_ID = d.Department_ID AND d.Location_ID = l.Location_ID;
select a.*,l.city from (select e.*,d.name,d.location_id from Employee e, Department d where e.department_id=d.department_id) a,location l 
where a.location_id=l.location_id;

-- 4. HOW MANY EMPLOYEES WHO ARE WORKING IN DIFFERENT DEPARTMENTS AND DISPLAY WITH DEPARTMENT NAMES.
SELECT count(*) no_of_employees,d.Name Dept_name from employee e
INNER JOIN Department d
ON e.Department_id = d.Department_id
GROUP BY name;

SELECT count(*) no_of_employees,d.Name Dept_name from employee e
LEFT OUTER JOIN Department d
ON e.Department_id = d.Department_id
GROUP BY name;

-- 5. HOW MANY EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
SELECT count(*) no_of_employees,d.Name Dept_name from department d
CROSS JOIN employee e
ON d.department_Id = e.department_ID
GROUP BY Name HAVING name = 'sales';

-- 6. WHICH IS THE DEPARTMENT HAVING GREATER THAN OR EQUAL TO 5 EMPLOYEES AND DISPLAY THE DEPARTMENT NAMES IN ASCENDING ORDER.
SELECT count(*) no_of_employees,d.Name Dept_name from department d
CROSS JOIN employee e
ON d.department_Id = e.department_ID
GROUP BY Name HAVING count(*)>5;

-- 7. HOW MANY JOBS IN THE ORGANIZATION WITH DESIGNATIONS.
SELECT count(*) no_of_jobs,e.Job_ID,j.Designation from employee e
INNER JOIN Job j
ON e.job_Id = j.Job_ID
GROUP BY j.Job_ID;

-- 8. HOW MANY EMPLOYEES ARE WORKING IN "NEW YORK".
SELECT count(*) no_of_employees,l.City FROM employee e
	INNER JOIN department d
    ON e.Department_ID = d.Department_ID
    INNER JOIN location l
    ON l.location_ID = d.location_ID
    GROUP BY l.location_ID HAVING l.City = 'New York';

-- 9. DISPLAY THE EMPLOYEE DETAILS WITH SALARY GRADES.
-- 10. LIST OUT THE NO. OF EMPLOYEES ON GRADE WISE.
-- 11.DISPLAY THE EMPLOYEE SALARY GRADES AND NO. OF EMPLOYEES BETWEEN 2000 TO 5000 RANGE OF SALARY.
-- 12. DISPLAY THE EMPLOYEE DETAILS WITH THEIR MANAGER NAMES.
-- 13. DISPLAY THE EMPLOYEE DETAILS WHO EARN MORE THAN THEIR MANAGERS SALARIES.
-- 14. SHOW THE NO. OF EMPLOYEES WORKING UNDER EVERY MANAGER.
-- 15. DISPLAY EMPLOYEE DETAILS WITH THEIR MANAGER NAMES.

-- 16. DISPLAY ALL EMPLOYEES IN SALES OR OPERATION DEPARTMENTS.
SELECT * FROM employee e
        JOIN department d
		ON e.department_ID = d.Department_ID
		WHERE d.Name = 'sales' OR d.Name = 'operations';
        

-- SET OPERATORS
-- 1. LIST OUT THE DISTINCT JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'sales'))
UNION
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'accounting'));

-- 2. LIST OUT ALL THE JOBS IN SALES AND ACCOUNTING DEPARTMENTS.
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'sales'))
UNION ALL
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'accounting'));

-- 3. LIST OUT THE COMMON JOBS IN RESEARCH AND ACCOUNTING DEPARTMENTS IN ASCENDING ORDER.
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'research' order by name))
UNION ALL
select * from job where job_id IN(select job_id from employee 
where department_id = (select department_id from department where name = 'accounting' ORDER BY name));

-- SUB QUERIES
-- 1. DISPLAY THE EMPLOYEES LIST WHO GOT THE MAXIMUM SALARY.
SELECT * FROM Employee WHERE salary = (SELECT max(salary) FROM employee);

-- 2. DISPLAY THE EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT.
SELECT * FROM Employee WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Sales');

-- 3. DISPLAY THE EMPLOYEES WHO ARE WORKING AS 'CLERCK'.
SELECT * FROM Employee WHERE Job_ID = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');

-- 4. DISPLAY THE LIST OF EMPLOYEES WHO ARE LIVING IN "NEW YORK".
SELECT * FROM Employee WHERE Job_ID IN 
	(SELECT Department_ID FROM Department 
		WHERE Location_ID = (SELECT Location_ID from Location WHERE City = 'New York'));

-- 5. FIND OUT NO. OF EMPLOYEES WORKING IN "SALES" DEPARTMENT.
SELECT * FROM Employee WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Sales');

-- 6. UPDATE THE EMPLOYEES SALARIES, WHO ARE WORKING AS CLERK ON THE BASIS OF 10%.
UPDATE Employee
SET Salary = salary+salary*0.1
WHERE Job_ID = (SELECT Job_ID FROM Job WHERE Designation = 'Clerk');

-- 7. DELETE THE EMPLOYEES WHO ARE WORKING IN ACCOUNTING DEPARTMENT.
DELETE FROM Employee WHERE Department_ID = (SELECT Department_ID FROM Department WHERE Name = 'Accounting');

-- 8. DISPLAY THE SECOND HIGHEST SALARY DRAWING EMPLOYEE DETAILS.
SELECT * FROM Employee 
	WHERE salary = (SELECT max(salary) FROM employee WHERE salary < 
			(SELECT max(salary) FROM Employee));
-- 9. DISPLAY THE N'TH HIGHEST SALARY DRAWING EMPLOYEE DETAILS.

-- 10. LIST OUT THE EMPLOYEES WHO EARN MORE THAN EVERY EMPLOYEE IN DEPARTMENT 30.
SELECT * FROM Employee 
	WHERE salary =(SELECT max(salary) FROM employee 
		WHERE Department_ID = 30);
-- 11. LIST OUT THE EMPLOYEES WHO EARN MORE THAN THE LOWEST SALARY IN DEPARTMENT 30.
SELECT * FROM Employee 
	WHERE salary =(SELECT min(salary) FROM employee 
		WHERE Department_ID = 30);

-- 12. FIND OUT WHOSE DEPARTMENT HAS NO EMPLOYEES.
SELECT Department_ID FROM Department WHERE Department_ID NOT IN ( select department_id  from employee);

-- 13. FIND OUT WHICH DEPARTMENT DOES NOT HAVE ANY EMPLOYEES.
SELECT Name FROM Department WHERE Department_ID NOT IN ( select department_id  from employee);

-- 14. FIND OUT THE EMPLOYEES WHO EARN GREATER THAN THE AVERAGE SALARY FOR THEIR DEPARTMENT
SELECT department_Id,first_name,sum(salary) FROM Employee  group by department_id,first_name 
having sum(salary) > (select avg(salary),Department_ID FROM Employee GROUP BY Department_ID);
