--create a PL/SQL procedure that takes in a employees salary and updates it by 10%. Create a function that calculates the net salary by reducing 5% tax.

SET SERVEROUTPUT ON

-- Create Employees table
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    employee_name VARCHAR2(100),
    salary NUMBER
);

-- Insert sample values
INSERT INTO employees VALUES (1, 'John Doe', 50000);
INSERT INTO employees VALUES (2, 'Jane Smith', 60000);
COMMIT;

-- Create PL/SQL procedure to update salary by 10%
CREATE OR REPLACE PROCEDURE update_salary(p_employee_id IN NUMBER) IS
    v_original_salary NUMBER;
BEGIN
    -- Get the original salary
    SELECT salary INTO v_original_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    -- Update the salary by 10%
    UPDATE employees
    SET salary = v_original_salary * 1.1
    WHERE employee_id = p_employee_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully.');
	DBMS_OUTPUT.PUT_LINE('Updated Salary: ' || v_original_salary * 1.1);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error updating salary: ' || SQLERRM);
END update_salary;
/

-- Create PL/SQL function to calculate net salary after reducing 5% tax
CREATE OR REPLACE FUNCTION calculate_net_salary(p_employee_id IN NUMBER) RETURN NUMBER IS
    v_gross_salary NUMBER;
    v_net_salary NUMBER;
BEGIN
    -- Get the gross salary
    SELECT salary INTO v_gross_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    -- Calculate net salary after deducting 5% tax
    v_net_salary := v_gross_salary * 0.95;

    RETURN v_net_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL; -- or handle accordingly
    WHEN OTHERS THEN
        RETURN NULL; -- or handle accordingly
END calculate_net_salary;
/
-- Test the update_salary procedure
EXEC update_salary(2);

-- Test the calculate_net_salary function
DECLARE
    v_net_salary NUMBER;
BEGIN
    v_net_salary := calculate_net_salary(2);
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_net_salary);
END;
/