create DATABASE quanlynhansu_1;
use quanlynhansu_1;
CREATE TABLE departments
(
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location        VARCHAR(100) NOT NULL
);

INSERT INTO departments (department_id, department_name, location)
VALUES (1, 'IT', 'Hà Nội'),
       (2, 'HR', 'TP. Hồ Chí Minh'),
       (3, 'Finance', 'Đà Nẵng');

CREATE TABLE employees
(
    employee_id   INT PRIMARY KEY,
    name          VARCHAR(100)   NOT NULL,
    position      VARCHAR(50)    NOT NULL,
    salary        DECIMAL(10, 2) NOT NULL,
    department_id INT,
    hire_date     DATE           NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

INSERT INTO employees (employee_id, name, position, salary, department_id, hire_date)
VALUES (1, 'Nguyễn Văn A', 'Developer', 1500, 1, '2020-05-01'),
       (2, 'Trần Thị B', 'Tester', 1200, 1, '2021-03-15'),
       (3, 'Lê Văn C', 'Developer', 1500, 2, '2019-08-10'),
       (4, 'Nguyễn Thị D', 'Project Manager', 2500, 2, '2020-01-20'),
       (5, 'Phạm Văn E', 'Tester', 1300, 3, '2021-07-12'),
       (6, 'Hoàng Thị F', 'Developer', 1400, 3, '2022-09-01'),
       (7, 'Đặng Văn G', 'Developer', 1500, 1, '2022-05-20'),
       (8, 'Nguyễn Văn H', 'Developer', 2000, 2, '2018-12-15');


/*
 1. GROUP BY:
Tính tổng lương của mỗi phòng ban:
 */

select d.department_name, sum(e.salary) as total
from departments
         join employees e on departments.department_id = e.department_id
         join departments d on d.department_id = e.department_id
group by d.department_name;

/*
 2. HAVING:
Lọc các phòng ban có tổng lương lớn hơn 3000:
 */

select d.department_name, sum(e.salary) as total
from departments d
         join employees e on d.department_id = e.department_id
group by d.department_name
having sum(e.salary) > 3000;

/*
 3. DISTINCT:
Lấy danh sách vị trí công việc duy nhất:
 */

select distinct position
from employees;

/*
 4. LIMIT & OFFSET:
Lấy 3 nhân viên đầu tiên, bỏ qua 2 nhân viên đầu tiên:
 */

select *
from employees
limit 3 offset 2;

/*
 5. LIKE:
Tìm nhân viên có tên chứa “Nguyễn”:
 */

select *
from employees
where name like '%Nguyễn%';

/*
 6. SUM và AVG:
Tính tổng và trung bình lương của toàn bộ nhân viên:
 */

select sum(salary), avg(salary)
from employees;

/*
 7. INNER JOIN:
Lấy danh sách nhân viên và tên phòng ban của họ:
 */

select e.name, d.department_name
from employees e
         inner join departments d on e.department_id = d.department_id;

/*
 8. LEFT JOIN:
Lấy danh sách tất cả phòng ban và nhân viên của phòng ban đó (nếu có):
 */

select d.department_name, e.name
from departments d
         left join employees e on d.department_id = e.department_id;

/*
 9. RIGHT JOIN:
Lấy danh sách tất cả nhân viên và thông tin phòng ban của họ (nếu có):
 */

select e.name, d.department_name
from employees e
         right join departments d on d.department_id = e.department_id;

/*
 10. SELF JOIN:
Tìm các nhân viên có cùng mức lương
 */

select e1.name, e2.name, e1.salary
from employees e1
         join employees e2 on e1.salary = e2.salary
where e1.employee_id <> e2.employee_id;

/*
11. Tìm phòng ban có nhiều nhân viên nhất và tổng lương của phòng ban đó
 */

select max(d.department_name) as department, sum(e.salary) as total
from departments d
         join employees e on d.department_id = e.department_id;

/*
12. Tìm nhân viên có mức lương cao nhất trong mỗi phòng ban
 */

select d.department_name, max(e.salary) as max_salary from employees e
         join departments d on d.department_id = e.department_id
        group by d.department_name;

/*
 13. Tính mức lương trung bình của từng vị trí công việc, chỉ hiển thị các vị trí có lương trung bình lớn hơn 1500
 */

select position, avg(salary) from employees
    group by position
    having avg(salary) > 1500;

/*
 14. Lấy danh sách nhân viên và đồng nghiệp cùng phòng ban (không bao gồm chính họ)
 */

select distinct d.department_name, e1.name, e2.name from employees e1
    join departments d on d.department_id = e1.department_id
    join employees e2 on e1.position = e2.position
    where e1.position = e2.position;

/*
 15. Tính tổng số năm kinh nghiệm của mỗi phòng ban
 */

select d.department_name,sum(DATEDIFF('2024-12-30', e.hire_date)) from employees e
    join departments d on d.department_id = e.department_id
    group by d.department_name;

/*
 16. Tìm nhân viên được tuyển dụng sớm nhất trong mỗi phòng ban, bao gồm cả tên và ngày tuyển dụng
 */
-- chua in dc ten
select d.department_name, min(e.hire_date) from employees e
    join departments d on d.department_id = e.department_id
    group by d.department_name;

/*
 17. Tìm phòng ban có tổng lương lớn nhất và hiển thị tên nhân viên, lương và phòng ban đó
 */