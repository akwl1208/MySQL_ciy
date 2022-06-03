use score;

-- 1학년 1반 2번 학생의 1학년 1학기 국어 성적 조회
select * from 보유 where 
	학생번호 = (select 학생번호 from 학생 where 학년 = 1 and 반 = 1 and 번호 = 2) and 
    성적번호 = (select 성적번호 from 성적 where 학년 = 1 && 학기 = 1 && 과목명 = '국어');