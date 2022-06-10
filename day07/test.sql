drop database if exists university;
create database if not exists university;
use university;

drop tables if exists professor, `subject`, student, course;
create table if not exists professor(
	pr_num		char(10),
    pr_name 	varchar(10) 	not null,
    primary key(pr_num)
);

create table if not exists `subject`(
	su_code 	char(6),
    su_name 	varchar(15) 	not null,
    su_pr_num 	char(10) 		not null,
    primary key(su_code),
    foreign key(su_pr_num) references professor(pr_num)
);

create table if not exists student(
	st_num 		char(10),
    st_name 	varchar(10) 	not null,
    st_pr_num 	char(10) 		not null,
    primary key(st_num),
    foreign key(st_pr_num) references professor(pr_num)
);

create table if not exists course(
	co_num 			char(10),
    co_st_num 		char(10) 	not null,
    co_su_code 		char(6) 	not null,
    co_mid 			int 		not null 	default 0,
	co_final 		int 		not null 	default 0,
	co_homework 	int 		not null 	default 0,
    co_attendance 	int 		not null 	default 0,
    co_total 		int 		not null 	default 0,
    primary key(co_num),
    foreign key(co_st_num) references student(st_num),
    foreign key(co_su_code) references `subject`(su_code)
);



