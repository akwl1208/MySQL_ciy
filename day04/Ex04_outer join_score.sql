-- <outer join>
use score;

-- 각 학생들의 성적 조회
-- inner join을 이용해서 모든 학생들의 성적을 조회할 수 없음
-- 아직 성적이 등록 안 된 학생이 있을 수 있어서
-- inner 조인은 성적이 등록된(보유) 학생들만 조회 가능
select * from 보유
	join 학생 on 보유.학생번호 = 학생.학생번호
    join 성적 on 보유.성적번호 = 성적.성적번호;
    
-- outer join을 이용하면 성적이 아직 등록되지 않은 학생도 조회할 수 있음
select * from 학생
	left join 보유 on 학생.학생번호 = 보유.학생번호
    left join 성적 on 보유.성적번호 = 성적.성적번호;
    
-- right join과 left join은 기준점 차이
select 학생.*, 성적.*, 보유.* from 보유
	right join 학생 on 학생.학생번호 = 보유.학생번호
    left join 성적 on 보유.성적번호 = 성적.성적번호;