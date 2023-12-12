-- Create source table
CREATE TABLE source_table (
    id NUMBER PRIMARY KEY,
    value VARCHAR2(100)
);

-- Insert some sample values into the source table
INSERT INTO source_table VALUES (1, 'Data A');
INSERT INTO source_table VALUES (2, 'Data B');
INSERT INTO source_table VALUES (3, 'Data C');
COMMIT;

-- Create target table
CREATE TABLE target_table (
    id NUMBER PRIMARY KEY,
    value VARCHAR2(100)
);

-- Create PL/SQL block with cursor
DECLARE
    -- Declare a cursor
    CURSOR data_cursor IS
        SELECT id, value
        FROM source_table
        WHERE id > 1;

    -- Variables to store fetched data
    v_id NUMBER;
    v_value VARCHAR2(100);
BEGIN
    -- Open the cursor
    OPEN data_cursor;

    -- Fetch and insert records
    LOOP
        FETCH data_cursor INTO v_id, v_value;
        EXIT WHEN data_cursor%NOTFOUND;

        -- Insert into the target table based on a condition
        IF v_id > 2 THEN
            INSERT INTO target_table (id, value)
            VALUES (v_id, v_value);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE data_cursor;

    DBMS_OUTPUT.PUT_LINE('Rows inserted into target_table successfully.');
END;
/