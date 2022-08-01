-- 컴퓨터공학과 학생(160)들 조회 
select student.* from student where st_num like '____160%';
select * from student where substr(st_num, 5, 3) like '160';
-- 대학수학기초 또는 대학영어를 수강하는 학생들 조회
select su_name, student.* from student
	join course on st_num = co_st_num
    join subject on  su_code = co_su_code
    where su_name in('대학수학기초', '대학영어');
-- 대학수학기초와 대학영어 모두를 수강하는 학생들 조회
select student.* from student 
	join course on st_num = co_st_num
    join subject on su_code = co_su_code
    where su_name in('대학수학기초', '대학영어')
    group by st_num
    having count(st_num) = 2;
    
-- 유재석 교수가 강의하는 강좌들을 수강하는 학생들 조회
select distinct student.* from student
	join course on st_num = co_st_num
    join subject on  su_code = co_su_code
    join professor on pr_num = su_pr_num
    where pr_name = '유재석'; 
-- 학과별 학생들 수 조회
select
	count(case when st_num like '____160%' then '컴퓨터공학과' end) as 컴공학생수,
	count(case when st_num like '____123%' then '기계공학과' end) as 기계공학생수,
	count(case when st_num like '____135%' then '전자공학과' end) as 전자공학생수
from student;

select substr(st_num, 5, 3) as 학과, count(*) as 학생수 from student
	group by 학과;
    
-- 2022년에 입학한 학생들을 조회
select 2022 as 입학년도,  student.* from student
	where st_num like '2022%';
    

