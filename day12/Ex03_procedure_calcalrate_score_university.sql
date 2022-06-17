-- 학생 성적을 계산하는 프로시저 작성
drop procedure if exists calculate_score;
-- 방법1
delimiter //  
create procedure calculate_score(
	in i_rate_m int,
    in i_rate_f int,
    in i_rate_h int,
    in i_rate_a int
)
begin
	update course
		set co_total = (co_mid*i_rate_m + co_final*i_rate_f + co_homework*i_rate_h + co_attendance*i_rate_a)/100;
end//
delimiter ;

-- 방법2 : 변수 사용
delimiter //  
create procedure calculate_score(
	in i_rate_m int,
    in i_rate_f int,
    in i_rate_h int,
    in i_rate_a int
)
begin
	declare _mid float; -- 비율 0이상 1이하
    declare _final float;
    declare _homework float;
    declare _att float;
    
    set _mid = i_rate_m/100;
    set _final = i_rate_f/100;
    set _homework = i_rate_h/100;
    set _att = i_rate_a/100;
    
	update course
		set co_total = co_mid*_mid + co_final*_final + co_homework*_homework + co_attendance*_att;
end//
delimiter ;

-- 프로시저 호출
call calculate_score(40,40,10,10);
select * from course;
