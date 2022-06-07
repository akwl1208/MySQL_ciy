use 대학생;

-- 강좌코드가 MSC003인 이산수학을 2022160001 교수님 강의 추가
INSERT INTO `대학생`.`강좌` (`강좌코드`, `강좌명`, `교번`) VALUES ('MSC003', '이산수학', '2022160001');

-- 각 강좌의 수강생 수 조회
select 강좌명, count(학번) as 학생수 from 수강 
	right join 강좌 on 수강.강좌코드 = 강좌.강좌코드
group by 수강.강좌코드;

select 강좌명, count(학번) as 학생수 from 강좌
	left join 수강 on 강좌.강좌코드 = 수강.강좌코드
    group by 강좌명;