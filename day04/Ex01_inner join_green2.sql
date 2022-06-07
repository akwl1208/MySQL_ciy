-- <inner join>
use green2;

-- 각 학생들이 가야할 학부 사무실 위치 조회
-- 지금처럼 속성 이름이 다른 경우, 테이블명과 .을 생략해도 됨
-- 기본 inner join이라 inner 생략 가능
select * from 학생 join 학부 on 학생.학부 = 학부.학부명;
select 학생.*, 학부위치 from 학생 
	join 학부 
		on 학생.학부 = 학부.학부명 
	order by 학생번호 asc;