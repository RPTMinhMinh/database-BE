-- tao database
create database qlhs;
-- su dung database
use qlhs;
-- tao bang hoc sinh de luu tru cac thong tin hoc sinh
create table student (
    id integer primary key auto_increment,
    full_name nvarchar(50), -- luu tieng viet
    date_of_birth date, -- luu kieu du lieu date
    code varchar(50),    -- luu ky tu k co dau utf-8
    deleted bit, -- luu gia tri true, false cua boolean
    las_modify_time datetime, -- luu tru du lieu dang ngay thang co gio
    description longtext, -- luu tru thong tin dai vai ti ki tu
    -- avartar blob, -- luu tru dang file
    point float -- luu tru so le
);

-- khoa chinh, giup xac dinh tinh duy nhat doc lap du lieu trong bang
-- cau lenh them du kieu vao bang
insert into
    student
    (id, full_name, date_of_birth, code, deleted, description, point)
value
(1, 'Nguyen Van A', '2021-01-01', 'S001', 0, 'Sv que QN', 7.6);

insert into
    student
( full_name, date_of_birth, code, deleted, description, point)
    value
    ('Nguyen Van A', '2021-01-01', 'S001', 0, 'Sv que QN', 7.6);
-- hien thi toan bo du lieu trong bang
select * from student;

-- cau lenh chinh sua table , them cot id lam khoa chinh
use qlhs;
create table class (
    id integer primary key auto_increment,
    code varchar(30),
    open_date date,
    deleted bit,
    description longtext
);

insert into class (code, open_date, deleted, description) value
('TechStack2411-Database', '2024-12-23', 0, 'Lop hoc Database');

insert into class (code, open_date, deleted, description) value
    ('TechStack2411-Java', '2024-12-24', 0, 'Lop hoc java');

select * from class;


-- ---------
-- cau lenh chinh sua kieu du lieu cua cot
-- alter table class modify open_date datetime;
-- xac dinh moi qhe giua cac bang: su dung khoa ngoai
/*
 xu ly moi qhe:
    1 sv co the hoc dc nhieu lop hoc:
        1 sv - n class
    1 lop hoc co the co nhieu sinh vien:
        1 class - n sv
    => moi qhe n - n
tao table student_class voi cac cot:
    id_class : la khoa ngoai tham chieu toi cot id cua bang class
    id_student : la khoa ngoai tham chieu toi cot id cua bang student
Luu y:
 -  khoa ngoai phai cung kieu du lieu voi cot no tham chieu toi
 -  du lieu cua khoa ngoai phai ton tai trong danh sach cot tham chieu toi
 */

use qlhs;
create table student_class (
    id_class integer,
    id_student integer
);

alter table student_class -- sua table student_class
    add foreign key (id_class) -- chi dinh id_class thanh khoa ngoai
        references
            class(id);

alter table student_class
    add foreign key (id_student) references
        student(id);

/*
 them 1 ban ghi trong bang student_class de the hien hoc sinh nguyen van a hoc lop database
 -> id_student = id cua sinh vien nguyen van a
 -> id_class = id cua lop hoc database
 */

 insert into student_class (id_class, id_student)
 values
        (1,1),
        (1,2);
insert into student_class (id_class, id_student) VALUE (2, 2);

select * from student where code = 'S001';
select * from student where full_name like '%Van%';

/*
 cau lenh like neu:
    k co % -> tim kiem nhu dau =
    neu co %
        -   neu % nam phia truoc -> bo qua toan bo ky tu phia truoc
        -   neu % nam phia sau -> bo qua toan bo ky tu phia sau
 */

select * from student where point >= 1 and full_name like 'B';
select * from student where point >= 1 or full_name = 'C';