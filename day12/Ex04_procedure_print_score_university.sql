-- 학생들의 총점을 이용하여 학점을 출력하는 프로시저 작성
drop procedure if exists print_score;
-- 방법1 : case
delimiter //  
create procedure print_score()
begin
	select *,
	case 
		when co_total >= 90 then 'A'
        when co_total >= 80 then 'B'
        when co_total >= 70 then 'C'
        when co_total >= 60 then 'D'
        when co_total >= 0 then 'F' -- else 'F'로 해도 됨
	end as 학점
    from course;
end//
delimiter ;
-- 프로시저 호출
call print_score();

-- 방법2 : 반복문 while과 조건식 if 사용
drop procedure if exists print_score2;
delimiter //  
create procedure print_score2()
begin
	-- 변수 선언은 위에 모아서 선언 
	declare i int default 0;
    declare _count int; -- 수강하는 학생수
    declare _num char(10); -- 학생 번호
    declare _total int; -- 학생 성적
    declare _grade char(1); -- 학생 학점
    set _count = (select count(*) from course);
    while(i < _count) do
		set _num = (select co_st_num from course limit i,1);
        set _total = (select co_total from course limit i,1);
		if _total >= 90 and _total <= 100 then  
			set _grade = 'A';
		end if;
        if _total >= 80 and _total <90 then  
			set _grade = 'B';
		end if;
        if _total >= 70 and _total < 80 then  
			set _grade = 'C';
		end if;
        if _total >= 60 and _total < 70 then  
			set _grade = 'D';
		end if;
        if _total >= 0 and _total < 60 then  
			set _grade = 'F';
		end if;
        select _num as 학번, _grade as 학점;
        set i = i + 1;
    end while;
end//
delimiter ;
-- 프로시저 호출
call print_score2();

