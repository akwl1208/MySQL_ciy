use university;

-- 학생이 추가되면 해당 학생의 담당 교수님이 자동으로 배정하는 프로시저 생성
drop procedure if exists insert_student;
-- delimiter : 쿼리의 마지막을 ; 대신 //로 사용하겠다는 의미
delimiter //  
create procedure insert_student(
in i_st_num char(10),
in i_st_name varchar(10) 
)
begin
	-- _department_code라는 변수 선언
	declare _department_code char(3); 
    -- 학생 정보 추가
	insert student(st_num, st_name) values (i_st_num, i_st_name);
	-- 학과 코드 추출
    -- substr(문자열, 시작번지, 개수) :  시작번지부터 개수만큼 문자열을 가져옴
    -- substr(문자열, 시작번지) :  시작번지부터 끝까지 문자열을 가져옴
    -- 시작번지 1부터
    set _department_code = substr(i_st_num, 5, 3); -- department 변수에 '160' 문자열 저장
    -- 학과 코드와 일치하는 교수님을 찾아 지도 교수에 교수 번호 입력
    -- concat(문자열,...) : 문자열들을 하나의 문자열로 이어붙일 때 사용
    update student
		set 
			st_pr_num = (select pr_num from professor 
							where pr_num like concat('____',_department_code,'%') limit 1)
		where st_num = i_st_num; 
end//
delimiter ;
-- insert_student 프로시서 호출
call insert_student('2022160006', '다길동');
show procedure status;
show create procedure sakila.film_in_stock;