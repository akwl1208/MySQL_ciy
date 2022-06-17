use university;

-- university에서 현재 등록된 학생수를 알려주는 프로시저를 만들고 호출해서 사용해보세요.
drop procedure if exists count_student;
-- 방법1 
delimiter //  
create procedure count_student()
begin
	select count(st_num) as 학생수 from student;
end//
delimiter ;
-- 프로시저 호출
call count_student();

-- 방법2: out 활용
delimiter //  
create procedure count_student(
	out o_count int
)
begin
	set o_count = (select count(st_num) as 학생수 from student);
end//
delimiter ;
-- 전역변수 생성
set @count = 0;
-- 프로시서 호출
call count_student(@count);
select @count;


