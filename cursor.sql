--Create a CURSOR in PL/SQL that fetches records from table using condition.
--Here the condition is to fetch the details of employee whose salary is greater than or equal to 60000

SET SERVEROUTPUT ON

--Create Table
CREATE TABLE employee (employee_id NUMBER , employee_name VARCHAR2(100), salary NUMBER);

--Insert Values
INSERT INTO employee VALUES(1,'John Snow', 70000);
INSERT INTO employee VALUES(2,'Ned Stark',50000);
INSERT INTO employee VALUES(3,'Aegon Targareon', 60000);
INSERT INTO employee VALUES(4,'Jamie Lannister',40000);
COMMIT;

--declare cursor
DECLARE 
	CURSOR employee_cursor IS
		SELECT employee_id, employee_name, salary FROM employee WHERE salary>=60000;

	--variables
	v_employee_id NUMBER;
	v_employee_name VARCHAR2(100);
	v_salary NUMBER;

	BEGIN
	--open cursor
	OPEN employee_cursor;

	--fetch data
	LOOP
		FETCH employee_cursor INTO v_employee_id,v_employee_name,v_salary;
		EXIT WHEN employee_cursor%NOTFOUND;

		--display
		DBMS_OUTPUT.PUT_LINE('Employee ID :' || v_employee_id);
		DBMS_OUTPUT.PUT_LINE('Employee name :' || v_employee_name);
		DBMS_OUTPUT.PUT_LINE('Employee Salary :' || v_salary);
		DBMS_OUTPUT.PUT_LINE('---------------------------------');

	END LOOP;

	--close cursor
	CLOSE employee_cursor;

END;
/

SELECT * FROM employee;