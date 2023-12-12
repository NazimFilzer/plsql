Declare
 cursor emp_cursor(id in employees.employee_id%type) IS
    select employee_name from employees where employee_id=id;

employee_name employees.employee_name%type;
id employees.employee_id%type :=&i;

BEGIN
open emp_cursor(id);
loop
fetch emp_cursor into employee_name;
    if(emp_cursor%found) then
    dbms_output.put_line('Emp name is  '|| employee_name);
    exit;
    else
    dbms_output.put_line('No EMp exists');
    exit;
    end if;
end loop;
CLOSE emp_cursor;
end;
/