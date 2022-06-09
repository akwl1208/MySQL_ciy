drop database if exists company;
create database if not exists company;
use company;

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
	`em_num`	int	NOT NULL,
	`em_name`	varchar(20)	NULL,
	`em_birth`	date	NULL,
	`em_addr`	varchar(100)	NULL,
	`em_phone`	varchar(13)	NULL,
	`em_de_name`	varchar(6)	NOT NULL,
	`em_ra_name`	varchar(20)	NOT NULL,
	`em_year`	int	NULL,
	`em_enter`	date	NULL
);

DROP TABLE IF EXISTS `department`;

CREATE TABLE `department` (
	`de_name`	varchar(6)	NOT NULL,
	`de_location`	varchar(20)	NULL
);

DROP TABLE IF EXISTS `rank`;

CREATE TABLE `rank` (
	`ra_name`	varchar(20)	NOT NULL,
	`ra_base`	int	NULL,
	`ra_add`	int	NULL
);

DROP TABLE IF EXISTS `pay`;

CREATE TABLE `pay` (
	`pa_num`	int	NOT NULL ,
	`pa_em_num`	int	NOT NULL,
	`pa_date`	date	NULL,
	`pa_salary`	int	NULL,
	`pa_rank`	varchar(20)	NULL,
	`pa_year`	int	NULL
);

ALTER TABLE `employee` ADD CONSTRAINT `PK_EMPLOYEE` PRIMARY KEY (
	`em_num`
);

ALTER TABLE `department` ADD CONSTRAINT `PK_DEPARTMENT` PRIMARY KEY (
	`de_name`
);

ALTER TABLE `rank` ADD CONSTRAINT `PK_RANK` PRIMARY KEY (
	`ra_name`
);

ALTER TABLE `pay` ADD CONSTRAINT `PK_PAY` PRIMARY KEY (
	`pa_num`
);

alter table pay change pa_num pa_num int not null auto_increment;

ALTER TABLE `employee` ADD CONSTRAINT `FK_department_TO_employee_1` FOREIGN KEY (
	`em_de_name`
)
REFERENCES `department` (
	`de_name`
);

ALTER TABLE `employee` ADD CONSTRAINT `FK_rank_TO_employee_1` FOREIGN KEY (
	`em_ra_name`
)
REFERENCES `rank` (
	`ra_name`
);

ALTER TABLE `pay` ADD CONSTRAINT `FK_employee_TO_pay_1` FOREIGN KEY (
	`pa_em_num`
)
REFERENCES `employee` (
	`em_num`
);

-- 부서 정보 입력
insert department 
	values('개발부','본관 3층 301호'), ('영업부','본관 2층 201호'),
		('마케팅부','본관 2층 202호'), ('디자인부','본관 3층 302호'), ('기타',null);

-- 직급 정보 입력
insert `rank` 
	values('사원', '240', '10'), ('대리', '280', '10'), ('과장', '320', '15'),
		('차장', '370', '18'), ('이사', '400', '20'), ('대표이사', '440', '30');
        
-- 직원 정보 입력
insert employee 
	values(2000001, '홍길동', '1980-01-01', '청주시', '010-1234-5678', '개발부', '차장', 1, '2000-03-02'), 
	(2000002, '임꺽정', '1980-03-01', '청주시', '010-1234-5679', '개발부', '차장', 2, '2000-03-02'),
    (2020001, '이순신', '1995-05-01', '청주시', '010-1254-5678', '마케팅부', '대리', 1, '2020-03-02'),
    (2022001, '고길동', '1998-12-31', '청주시', '010-3234-5678', '영업부', '사원', 0, '2022-03-02');
    
-- 2022년 1월 5일에 등록된 모든 직원들의 월급 지급
insert pay(pa_date, pa_em_num, pa_rank, pa_year, pa_salary)
	select '2022-01-05', em_num, em_ra_name, em_year, ra_base + (ra_add * em_year)
    from employee join `rank` on em_ra_name = ra_name
    where em_enter <= '2022-01-05';
-- 2022년 2월 5일에 등록된 모든 직원들의 월급 지급
insert pay(pa_date, pa_em_num, pa_rank, pa_year, pa_salary)
	select '2022-02-05', em_num, em_ra_name, em_year, ra_base + (ra_add * em_year)
    from employee join `rank` on em_ra_name = ra_name
    where em_enter <= '2022-02-05';
-- 2022년 3월 5일에 등록된 모든 직원들의 월급 지급
insert pay(pa_date, pa_em_num, pa_rank, pa_year, pa_salary)
	select '2022-03-05', em_num, em_ra_name, em_year, ra_base + (ra_add * em_year)
    from employee join `rank` on em_ra_name = ra_name
    where em_enter <= '2022-03-05';
-- 2022년 4월 5일에 등록된 모든 직원들의 월급 지급
insert pay(pa_date, pa_em_num, pa_rank, pa_year, pa_salary)
	select '2022-04-05', em_num, em_ra_name, em_year, ra_base + (ra_add * em_year)
    from employee join `rank` on em_ra_name = ra_name
    where em_enter <= '2022-04-05';
    
-- 월급 내역에 직급부분에 개발부 대신 직급이 들어가도록 수정
/*update pay 
	set pa_rank = (select em_ra_name from employee where pa_em_num = em_num);*/