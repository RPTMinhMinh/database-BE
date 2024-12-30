create database qlsinhvien_khoahoc;
use qlsinhvien_khoahoc;

-- 1
create table students(
    id INT primary key auto_increment,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    email VARCHAR(100)
);

create table courses (
    id INT primary key auto_increment,
    course_name VARCHAR(100),
    course_description TEXT
);

create table enrollments(
    id INT primary key auto_increment,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    foreign key (student_id) references students(id),
    foreign key (course_id) references courses(id)
);

-- 2
insert into students (first_name, last_name, birth_date, email) VALUES
('Minh', 'Nhat', '2003-12-07', 'abc@example.com'),
('A', 'Nguyen', '2000-08-09', 'nguyena@hehe.vn'),
('B', 'Bui', '1999-12-01', 'buib@example.vn'),
('C', 'Vu', '1998-06-10', 'vuc@yahoo.com'),
('D', 'Le', '2002-02-20', 'led@icloud.com');

insert into students (first_name, last_name, birth_date, email) VALUE
('E','Hoang','2024-11-23','hoange@yahoo.vn');

insert into courses (course_name, course_description) VALUES
('FE-T3H', 'Lập Trình Cơ Bản Front-end'),
('BE-T3H', 'Lập Trình Cơ Bản Back-end'),
('TESTER-T3H', 'Khoa hoc tester');

insert into courses (course_name, course_description) VALUE
('Lập Trình Cơ Bản','Buoc dau de tro thanh super dev =))');

insert into courses (course_name, course_description) VALUE
('Khoa hoc abc', 'khoa hoc nay de test');

insert into enrollments (student_id, course_id, enrollment_date) VALUES
(1,2,'2024-11-11'),
(1,1,'2024-07-12'),
(2,3,'2024-08-19'),
(3,2,'2024-02-20'),
(4,1,'2023-12-29'),
(5,3,'2024-06-10');

insert into enrollments (student_id, course_id, enrollment_date) values
(2,4,'2024-01-02'),
(5,4,'2023-11-09');

-- 3
select * from students;

select * from courses;

select * from enrollments
join students s on enrollments.student_id = s.id
join courses c on c.id = enrollments.course_id;

select * from enrollments
join students s on enrollments.student_id = s.id
join courses c on c.id = enrollments.course_id
where c.course_name = 'Lập Trình Cơ Bản';

select * from students where birth_date > '2000-01-01' and email like '%example%';

-- 4
update students set email = 'ngnhatminh@example.vn' where id = 1;
update courses set course_description = 'mo ta moi cua lap trinh co ban' where course_name = 'Lập Trình Cơ Bản';

-- 5
delete from students where id = 6 and not exists( select 1 from enrollments where student_id = 6);
delete from courses where id = 5 and not exists( select 1 from enrollments where course_id = 5);

-- 6
select * from students where birth_date > '2000-01-01';
select * from students where last_name like 'Nguyen';

select * from enrollments
join students s on s.id = enrollments.student_id
join courses c on c.id = enrollments.course_id
where s.birth_date > '2000-01-01' and c.course_name like '%Toán Học%';

select * from enrollments
join students s on enrollments.student_id = s.id
join courses c on c.id = enrollments.course_id
where c.id in (1,2);

select * from courses where id between 2 and 4;
