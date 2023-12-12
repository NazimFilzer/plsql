--Create a PL/SQL package that consist of a procedure to add a new employee and a function to calculate annual bonus.

SET SERVEROUTPUT ON



CREATE TABLE employees (employee_id NUMBER PRIMARY KEY, employee_name VARCHAR2(100), salary NUMBER);

CREATE OR REPLACE PACKAGE EmployeePackage AS
	PROCEDURE add_employee(p_employee_id IN NUMBER, p_employee_name IN VARCHAR2, p_salary IN NUMBER);
	FUNCTION calculate_annual_bonus(p_employee_id IN NUMBER) RETURN NUMBER;
END EmployeePackage;
/

CREATE OR REPLACE PACKAGE BODY EmployeePackage AS
	PROCEDURE add_employee(p_employee_id IN NUMBER, p_employee_name IN VARCHAR2, p_salary IN NUMBER) IS
	BEGIN
		INSERT INTO employees(employee_id,employee_name,salary) VALUES (p_employee_id,p_employee_name,p_salary);
		COMMIT;
		DBMS_OUTPUT.PUT_LINE('Employee added successfully');
	END add_employee;

	FUNCTION calculate_annual_bonus(p_employee_id IN NUMBER) RETURN NUMBER IS
	v_base_salary NUMBER;
	v_bonus_percentage NUMBER := 0.15; --15% bonus
	v_annual_bonus NUMBER;
	BEGIN
		SELECT salary INTO v_base_salary FROM employees WHERE employee_id = p_employee_id ;
		v_annual_bonus := v_base_salary*v_bonus_percentage;
		RETURN v_annual_bonus;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN NULL;
		WHEN OTHERS THEN
			RETURN NULL;
	END calculate_annual_bonus;

	

END EmployeePackage;
/

--adding employee
BEGIN
EmployeePackage.add_employee(1,'Althaf Nazeer',90000);
EmployeePackage.add_employee(2,'Zayn Malik',70000);
END;
/

--calculating annual bonus
DECLARE
	v_bonus NUMBER;
BEGIN
	v_bonus := EmployeePackage.calculate_annual_bonus(1);
	DBMS_OUTPUT.PUT_LINE('Annual Bonus Is : ' || v_bonus);
END;
/

SELECT * FROM employees;