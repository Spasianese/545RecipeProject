/*
 In SQLDeveloper, connect with the Oracle database, load this script file, and then
 - either run the statements in file one by one
 - or run the entire script file
*/

/*
 The main purpose of this example script is to practice the following concepts in Oracle SQL:
 1. Using SELECT-FROM-WHERE statement to construct single-relation queries
*/

drop table students cascade constraints;
drop table courses cascade constraints;
drop table takecourses;

create table courses (
 cno char(6) primary key,
 name varchar2(20),
 credits number(1)
);

create table students (
 id char(9) primary key,
 name varchar2(20) not null,
 gpa number(3,2),
 major varchar2(10) default 'NA'
);

create table takecourses (
 sid char(9),
 cno char(6),
 primary key (cno, sid),
 constraint idFK foreign key (sid) references students(id) on delete cascade,
 constraint cnoFK foreign key (cno) references courses(cno) on delete cascade
);

insert into courses(cno) values ('csc500');
insert into courses values ('csc190', 'Java', 3);
insert into courses values ('csc545', 'Database Theory', 3);
insert into courses values ('mat124', 'Calculus I', 4);
insert into courses values ('aso100', 'Orientation', 1);
insert into courses values ('eng110', 'Writing', 2);

insert into students values ('111222999', 'John', 3.15, 'CS');
insert into students values ('333111666', 'Robert', 3.58, 'MATH');
insert into students values ('555222444', 'Jenny', 3.5, 'CS');
insert into students values ('212343565', 'Mike', 3.25, 'CS');
insert into students values ('666555111', 'Ellie', 3.05, 'ENG');

insert into takecourses values ('555222444', 'csc545');
insert into takecourses values ('555222444', 'mat124');
insert into takecourses values ('555222444', 'csc190');
insert into takecourses values ('111222999', 'csc190');
insert into takecourses values ('333111666', 'csc190');
insert into takecourses values ('212343565', 'mat124');

select * from courses;
select * from students;
select * from takecourses;

-- Find out who are in which major
select id, name, major
from students;

-- Find the majors of students (will see duplicates since there are many students in each major)
select major
from students;

-- Find the majors of students (each major will only appear once in the result because duplicates are eliminated by DISTINCT)
select distinct major
from students;

-- Find id and name of students who who major in CS and have a gpa of at least 3.5
(select id, name from students where major='CS') INTERSECT (select id, name from students where gpa>=3.5);
(select id, name from students where major='CS') MINUS (select id, name from students where gpa<3.5);

-- Find id and name of students who who major in CS or have a gpa of at least 3.5
(select id, name from students where major='CS') UNION (select id, name from students where gpa>=3.5);


-- Find CS students' gpa if being improved by 10%
select id, gpa * 1.1 as projectedGPA
from students
where major = 'CS';

-- Find those CS students whose GPA will exceed 3.0 if being improved by 10%
select *
from students
where gpa * 1.1 > 3.0 and major = 'CS';

-- Order query results
select * from students ORDER BY gpa;
select * from students ORDER BY major;
select * from students ORDER BY major, gpa DESC;

-- Find students who major in CS or ENG
select *
from students
where major in ('CS', 'ENG');

-- Find courses with 2, 3, or 4 credits
select *
from courses
where credits between 2 and 4;

-- Find courses with credits less than 2 or greater than 4
select *
from courses
where credits not between 2 and 4;

-- Find those students whose names include letter 'e'
select *
from students
where name like '%e%';

-- Find those students whose names end with letter 'e'
select *
from students
where name like '%e';

-- Find those students whose names use 'e' as the 4th letter
select *
from students
where name like '___e%';

-- All three queries will return an empty relation as the result of the query because of the 3-value logic in SQL
select * from courses where name = null;
select * from courses where not(name = null);
select * from courses where (name = null) or not (name = null);

-- Find courses whose names are NULL
select *
from courses
where name is null;

-- Find courses whose names are not NULL
select *
from courses
where name is not null;

select * from students;



