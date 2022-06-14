use cgv;
-- 송강호가 출연한 영화 제목 리스트 조회
select mo_title from act
	join movieman on mm_num = ac_mm_num
	join movie on mo_num = ac_mo_num
	where mm_name = '송강호';
    
select mo_title from movie
	join act on ac_mo_num = mo_num
    join (select * from movieman where mm_name = '송강호') as mm on mm_num = ac_mm_num;

-- 고레에다 히로카즈가 감독한 영화 제목 리스트 조회
select mo_title from act
	join movieman on mm_num = ac_mm_num
	join movie on mo_num = ac_mo_num
	where mm_name = '고레에다 히로카즈';

select mo_title from movie
	join (select * from act where ac_role = '감독') as ac on ac_mo_num = mo_num
    join (select * from movieman where mm_name = '고레에다 히로카즈') as mm on mm_num = ac_mm_num;
    
-- 장르가 드라마인 영화 조회
select * from movie where mo_genre like '%드라마%';

-- 6/14일 cgv성안길에서 상영하는 브로커의 상영시간표
select sc_th_name, sc_name, mo_title, sh_startTime from `show`
	join (select * from screen where sc_th_name = 'cgv청주성안길') as sc on sh_sc_num = sc_num
	join (select * from movie where mo_title = '브로커') as mo on sh_mo_num = mo_num
    where sh_startTime like '2022-06-14%';
    
-- 6/14일 cgv성안길에서 11:30에 시작하는 영화 브로커를 상영하는 관의 좌석 조회
select sc_th_name, mo_title, sh_startTime, sc_name, se_name from seat
	join (select * from screen where sc_th_name = 'cgv청주성안길' ) as sc on se_sc_num = sc_num
    join (select * from `show` where sh_startTime = '2022-06-14 11:30') as sh on sh_sc_num = sc_num
	join (select * from movie where mo_title = '브로커') as mo on sh_mo_num = mo_num;
    

-- 6/14일 cgv성안길에서 11:30에 시작하는 영화 브로커에 예매 가능한 좌석 표시
select se_name from seat
	join (select * from screen where sc_th_name = 'cgv청주성안길' ) as sc on se_sc_num = sc_num
    join (select * from `show` where sh_startTime = '2022-06-14 11:30') as sh on sh_sc_num = sc_num
	join (select * from movie where mo_title = '브로커') as mo on sh_mo_num = mo_num
    left join (select * from book where bo_state = null) as bo on bo_sh_num = sh_num;

select mo_title as 제목, sc_th_name as 영화관, sc_name as 상영관, sh_startTime as 상영시간,
	se_name as 좌석명, count(bd_bo_num) as 예약수 
    from `show`
	join movie on sh_mo_num = mo_num
    join screen on sh_sc_num = sc_num
    join seat on se_sc_num = sc_num
    left join book on sh_num = bo_sh_num
    left join bookdetail on bo_num = bd_bo_num and bd_se_num = se_num
    where mo_title = '브로커'
		and sc_th_name = 'cgv청주성안길'
        and sh_startTime = '2022-06-14 11:30'
	group by 좌석명
    having 예약수 = 0;

-- 브로커를 상영하는 모든 극장들을 조회
select distinct sc_th_name from screen
	join `show` on sh_sc_num = sc_num
    join movie on sh_mo_num = mo_num
    where mo_title = '브로커';
-- 내가 푼거
select mo_title, sc_th_name from `show`
	join movie on sh_mo_num = mo_num
    join screen on sh_sc_num = sc_num
    where mo_title = '브로커'
    group by sc_th_name;

-- cgv성안길에서 상영하는 모든 영화 제목 조회
select distinct mo_title from screen
	join `show` on sh_sc_num = sc_num
    join movie on sh_mo_num = mo_num
    where sc_th_name = 'cgv청주성안길';
-- 내가푼거
select sc_th_name, mo_title from `show`
	join screen on sh_sc_num = sc_num
    join movie on sh_mo_num = mo_num
    where sc_th_name = 'cgv청주성안길'
    group by mo_title;

-- 2022년 6월 14일에 상영하는 모든 영화관과 영화 제목들 조회
select distinct sc_th_name, mo_title from screen
	join `show` on sh_sc_num = sc_num
    join movie on sh_mo_num = mo_num
    where sh_startTime like '2022-06-14%';
-- 내가 푼거
select '2022-06-14' as 상영일, sc_th_name,mo_title from `show`
	join screen on sh_sc_num = sc_num
    join movie on sh_mo_num = mo_num
	where sh_startTime like '2022-06-14%'
    group by sc_th_name and mo_title;