use company;

-- 홍길동 직원의 월급 내역서 조회
select * from pay
	where pa_em_num = (select em_num from employee where em_name = '홍길동');
select em_num, em_name, pa_salary, pa_date from pay
	join employee on pa_em_num = em_num
    where em_name = '홍길동';
    
-- 개발부 직원 명단 조회
select em_num, em_name from employee where em_de_name = '개발부';

-- 회사내의 모든 차장 사번과 이름조회
select em_num, em_name from employee where em_ra_name = '차장';

-- 월급 300이상인 직원들의 이름 조회
select distinct em_name from pay 
	join employee on pa_em_num = em_num
	where pa_salary >= 300;
-- group by로
select pa_em_num, em_name, max(pa_salary) as 월급 from pay 
	join employee on pa_em_num = em_num
	group by pa_em_num having 월급 >= 300;
    
-- 직급별 인원수 조회
select ra_name, count(em_num) from `rank`
	left join employee on ra_name = em_ra_name
    group by ra_name;