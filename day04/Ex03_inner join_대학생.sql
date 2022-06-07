-- <inner join>
use 대학생;

-- 각 학생들의 지도교수님 이름 조회
select 학번, 학생.이름, 교수.이름 as 지도교수 from 학생 
	join 교수 
		on 학생.교번 = 교수.교번;
        
-- 고길동 학생이 수강하는 강좌코드 조회
select 이름, 강좌코드 from 수강
	join 학생
		on 수강.학번 = 학생.학번
	where 이름 = '고길동';

-- 고길동 학생이 수강하는 강좌들 이름
-- join 이용
select 이름, 강좌명 from 수강
	join 강좌
		on 수강.강좌코드 = 강좌.강좌코드
	join 학생
		on 수강.학번 = 학생.학번
	where 이름 = '고길동';
-- 서브쿼리 이용
select '고길동' as 이름, 강좌.강좌코드, 강좌.강좌명 from 수강
   join 강좌
      on 수강.강좌코드 = 강좌.강좌코드
   where 학번 = (select 학번 from 학생 where 이름 = '고길동');
   
-- 나영석 교수가 강의하는 강좌 코드 조회
select 강좌코드 from 강좌
	join 교수
		on 강좌.교번 = 교수.교번
	where 이름 = '나영석';
    
-- 나영석 교수가 강의하는 강좌명 조회
select 강좌명 from 강좌
	join 교수
		on 강좌.교번 = 교수.교번
	where 이름 = '나영석';

-- 나영석 교수가 강의하는 강의를 듣는 학번 조회
select distinct 학번 from 강좌
	join 교수 on 강좌.교번 = 교수.교번 
	join 수강 on 수강.강좌코드 = 강좌.강좌코드
	where 이름 = '나영석';
    
-- 나영석 교수가 강의하는 강의를 듣는 학생 이름 조회
select distinct 학생.이름 from 강좌
	join 교수 on 강좌.교번 = 교수.교번 
	join 수강 on 수강.강좌코드 = 강좌.강좌코드
	join 학생 on 수강.학번 = 학생.학번
	where 교수.이름 = '나영석';
    
-- 컴퓨터 개론을 수강하는 학생들의 수 조회
select 강좌명, count(강좌명) as 학생수 from 수강
	join 강좌 on 수강.강좌코드 = 강좌.강좌코드
	where 강좌명 = '컴퓨터개론';

-- 컴퓨터개론을 수강하는 학생 명단 조회
select 강좌명, 이름 from 수강
	join 강좌 on 수강.강좌코드 = 강좌.강좌코드
	join 학생 on 수강.학번 = 학생.학번
    where 강좌명 = '컴퓨터개론';
    
-- 나영석 교수의 지도 학생 이름 조회
select 교수.이름, 학생.이름 from 학생
	join 교수 on 학생.교번 = 교수.교번
    where 교수.이름 = '나영석';
    
-- 두 테이블 연결 시 on이 없는 경우
-- 테이블 A의 행의 수가 m, 테이블 B의 행의 수가 n일 경우, m*n개의 행으로 된 결과가 나옴
-- 테이블 A의 한 개의 행과 테이블 B의 한 개의 행이 서로 합쳐진 전체 결과
select * from 학생 join 교수;