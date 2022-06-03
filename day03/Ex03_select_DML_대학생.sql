use 대학생;

-- 나영석 교수가 강의하는 강좌명 조회 
select 강좌명 from 강좌 where 교번 = (select 교번 from 교수 where 이름 = '나영석');
-- MSC001 강좌를 듣는 학생들 이름 조회
 select 이름 from 학생 where 학번 in(select 학번 from 수강 where 강좌코드 = 'MSC001');
 select 이름 from 학생 where 학번 = any(select 학번 from 수강 where 강좌코드 = 'MSC001');