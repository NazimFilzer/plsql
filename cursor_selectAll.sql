DECLARE
    CURSOR emp_cursor IS
        SELECT * FROM employees ;
    
    -- Declare a record to match the structure of the cursor's query result
    emp_rec employees%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_rec;
        
        EXIT WHEN emp_cursor%NOTFOUND;
        
        -- Use specific columns or concatenate them in the output
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_rec.employee_id || ', Name: ' || emp_rec.employee_name || ', Salary: ' || emp_rec.salary);
    END LOOP;
    
    CLOSE emp_cursor;
END;
/   
