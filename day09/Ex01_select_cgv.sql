use cgv;

-- -- 6/14일 cgv성안길에서 11:30에 시작하는 영화 브로커에 예매 가능한 좌석 표시(예매된 좌석도 조회)
select se_name as 좌석명, count(bd_bo_num) as 예약가능여부 from seat
    join (select * from screen where sc_th_name = 'cgv청주성안길') as sc on se_sc_num = sc_num
	join (select * from `show` where sh_startTime = '2022-06-14 11:30') as sh on se_sc_num = sc_num
    join (select * from movie where mo_title = '브로커') as mo on sh_mo_num = mo_num
    left join book on sh_num = bo_sh_num
    left join bookdetail on bo_num = bd_bo_num and bd_se_num = se_num
	where se_use = 'Y'
    group by 좌석명;
    
-- 현재(6/14) 상영중인 영화 중(개봉된) 개봉일 기준으로 최신영화 10개 조회
select mo_title from movie
	join `show` on sh_mo_num = mo_num
    where sh_startTime >= now() and mo_opendate <= now()
    group by mo_num
    order by mo_opendate desc 
    limit 10;

-- 서울에 있는 모든 영화관 정보 조회
select * from theater where th_region = '서울';

-- 예매가 높은 순으로 영화 10개 조회
select mo_title, sum(bo_amount) as 예매수 from movie
	join (select * from `show` where sh_startTime > now()) as sh on sh_mo_num = mo_num
    join book on bo_sh_num = sh_num
    where bo_state ='Y'
    group by mo_num
    order by 예매수 desc
    limit 10;
    
-- cgv에서 영화를 관람한 영화별 관람객 수
select mo_title as 제목, sum(bo_amount) as 관람객수 from book
	join (select * from `show` where sh_startTime <= now()) on sh_num = bo_sh_num
    join movie on mo_num = sh_mo_num
    where bo_state = 'Y'
    group by mo_num
    order by 관람객수 desc;

