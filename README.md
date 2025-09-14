This project contains a curated set of SQL exercises designed to demonstrate intermediate-level proficiency in MySQL. 
It covers essential database programming concepts including triggers, stored procedures, cursors, and user-defined functions, 
organized into four sections. Each task is practical and reflects real-world scenarios involving employee and sales data.

Sections Overview

Section A: Triggers
Prevent Invalid Sales Entries

A BEFORE INSERT trigger on the sales table that blocks any attempt to insert a sale with a zero or negative amount.

Uses SIGNAL SQLSTATE to raise a custom error message.

Salary Change Audit

An AFTER UPDATE trigger on the employees table that logs salary changes into a salary_audit table.

Captures old and new salary values, along with employee details and timestamp.

Section B: Cursors
Employee Listing Procedure

A cursor-based stored procedure that loops through all employees and displays their emp_id and first_name.

Implements a CONTINUE HANDLER for graceful loop termination.

Total Salary Calculation

A cursor-based procedure that calculates the total salary of all employees.

Accumulates salary values into a variable and displays the final result.

Section D: Functions
Employee Tenure in Months

A function that returns the number of months an employee has worked since their hire date.

Uses TIMESTAMPDIFF for precise calculation.

Annual Bonus Calculation

A function that calculates a bonus equal to 10% of an employee’s salary.

Useful for payroll and performance reward systems.

🛠️ How to Use
Import the schema and sample data for employees and sales tables.

Run the SQL script containing all triggers, procedures, and functions.

Use CALL and SELECT statements to test each component:

File Structure

IntermediateTest.sql — Contains all SQL definitions for triggers, procedures, and functions.
README.md — Project overview and usage instructions.

📚 Requirements
MySQL 5.7 or higher

Basic schema with employees and sales tables





