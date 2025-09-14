select * from employees

-- Section A: Triggers (2 Questions) 
-- Q1. Create a trigger on the sales table that prevents inserting a sale with a negative or zero amount. 

DELIMITER //
create trigger trg_no_0_in_sales_amount
before insert on sales 
FOR EACH ROW 
begin 
if new.amount <= 0 
THEN 
SIGNAL sqlstate '45000'
SET MESSAGE_TEXT = ' Sales Amount should be positive ';
end if;
end//

-- Q2. Create an AFTER UPDATE trigger on the employees table that logs old and new salary values into a separate salary_audit table whenever an employee’s salary changes. 
create table salary_audit (
audit_id int auto_increment primary key,
first_name VARCHAR(20),
las_name  VARCHAR(20),
hire_date date,
old_salary decimal(12,2),
new_salary decimal (12,2),
dept_id INT,
changed_at timestamp default current_timestamp,
action varchar(20) );

-- Section B: Cursors (2 Questions) 

-- Q3. Write a stored procedure using a cursor that goes through all employees in the employees table 
-- and displays their emp_id and first_name. 
DELIMITER //
CREATE PROCEDURE emp_id_and_name()
BEGIN
DECLARE Temp_emp_id INT;
DECLARE Temp_first_name VARCHAR (50);
DECLARE done INT DEFAULT 0;
    
  DECLARE cur CURSOR FOR 
    SELECT emp_id, first_name FROM employees;

     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
     
OPEN cur;
  loop_rows: LOOP
    FETCH cur INTO temp_emp_id, temp_first_name;
    IF done = 1 THEN
      LEAVE loop_rows;
    END IF;
        SELECT Temp_emp_id AS emp_id, Temp_first_name AS first_name;
    END LOOP;
    CLOSE cur;
END //

DELIMITER //


call  emp_id_and_name ()

-- Q4. Write a cursor-based procedure to calculate the total salary of all employees. The result should 
-- be displayed as a single value. 

DELIMITER //
CREATE PROCEDURE emp_salary()
BEGIN
DECLARE temp1_emp_id INT;
DECLARE temp1_first_name VARCHAR (50);
DECLARE temp_salary INT;
DECLARE done INT DEFAULT 0;

DECLARE cur CURSOR FOR 
select emp_id, first_name, salary from employees;

     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN cur;
  loop_rows: LOOP
    FETCH cur INTO temp1_emp_id , temp1_first_name,temp_salary ;
    IF done = 1 THEN
      LEAVE loop_rows;
    END IF;
SELECT Temp1_emp_id AS emp_id, Temp1_first_name AS first_name, temp_salary as salary;
END LOOP;
    CLOSE cur;
END //

DELIMITER //

call emp_salary()

-- Section C: Procedures (2 Questions) 
--  Q5. Write a procedure increase_salary that takes two inputs: a department ID and a percentage. It 
-- should increase the salary of all employees in that department by the given percentage. 

DELIMITER //
CREATE PROCEDURE increase_salary (
    IN input_dept_id INT,
    IN input_percentage DECIMAL(10,2)
)
BEGIN
    UPDATE employees
    SET salary = salary + (salary * input_percentage / 100)
    WHERE dept_id = input_dept_id;
END //

DELIMITER ;

-- Q6. Write a procedure delete_old_sales that deletes all sales records older than 2023. 

DELIMITER //
create procedure delete_old_sales ()
BEGIN
    DELETE FROM sales
    WHERE sale_date < '2023-01-01';
END //

DELIMITER //


-- Section D: Functions (2 Questions) 
-- Q7. Create a function tenure_months(emp_id) that returns the total number of months an employee 
-- has worked since their hire date. 

DELIMITER //
CREATE FUNCTION tenure_months(emp_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE months_worked INT;
    SELECT TIMESTAMPDIFF(MONTH, hire_date, CURRENT_DATE)
        INTO months_worked
        FROM employees
    WHERE employees.emp_id = emp_id;
    RETURN months_worked;
END //

DELIMITER //

SELECT tenure_months(1);


-- Q8. Create a function annual_bonus(salary) that calculates and returns a bonus amount equal to 10% 
--  of the salary. 
DELIMITER //
CREATE FUNCTION annual_bonus(salary decimal(12,2))
RETURNS decimal(12,2)
DETERMINISTIC
BEGIN
RETURN salary * 0.10;
END //

DELIMITER ;

