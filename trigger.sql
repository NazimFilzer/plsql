--Define a trigger in PL/SQL that automatically updates last modified column with current timestamp whenever a row modified in a specific table. 

SET SERVEROUTPUT ON

-- Create a sample table
CREATE TABLE example_table (
    id NUMBER PRIMARY KEY,
    data VARCHAR2(100),
    last_modified TIMESTAMP
);

-- Insert some sample values
INSERT INTO example_table VALUES (1, 'Sample Data 1', NULL);
INSERT INTO example_table VALUES (2, 'Sample Data 2', NULL);
COMMIT;

-- Create a trigger to update last_modified column on modification
CREATE OR REPLACE TRIGGER update_last_modified
BEFORE UPDATE ON example_table
FOR EACH ROW
BEGIN
    :NEW.last_modified := CURRENT_TIMESTAMP;
END update_last_modified;
/
-- Update the data in the table
UPDATE example_table SET data = 'Updated Data' WHERE id = 1;