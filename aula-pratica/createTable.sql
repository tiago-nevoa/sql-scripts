create table STUDENT(
	s_name varchar(15) unique,
	student_number integer primary key,
	s_class integer,
	s_major varchar(2)
);

create table COURSE(
	c_Course_name varchar(25) unique,
	c_Course_number varchar(8) primary key,
	c_Credit_hours integer,
	c_Department varchar(4)
);


create table "SECTION"(
	s_Section_identifier integer primary key,
	s_Course_number varchar(8),
	s_Semester varchar(6),
	"s_year" integer,
	s_Instructor varchar(10)
);

create table GRADE_REPORT(
	gr_Student_number integer,
	gr_Section_identifier integer primary key,
	gr_Grade char
);

create table PREREQUISITE(
	p_Course_number varchar(6),
	p_Prerequisite_number varchar(8) primary key
);

