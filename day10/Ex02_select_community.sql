use community;

-- 문의사항 게시글을 최신순으로 조회
select * from board where bo_ca_name = '문의사항'
	order by bo_oriNum desc, bo_depth asc;

-- 3번 게시글 내용을 확인했을 때 필요한 쿼리
-- 조회수 1증가
update board set bo_views = bo_views+1 where bo_num =3;
-- 게시글 제목, 작성자, 작성일, 조회수, 내용 보여주기
select bo_ca_name, bo_title, bo_us_id, bo_regDate, bo_views, bo_content from board;

-- 문의 게시글을 1페이지에 대한 게시글 조회 한 페이지당 보여지는 게시글 개수 2개
select * from board where bo_ca_name = '문의사항'
	order by bo_oriNum desc, bo_depth asc
    limit 0,2;
    
-- 문의 게시글을 2페이지에 대한 게시글 조회 한 페이지당 보여지는 게시글 개수 2개   
select * from board where bo_ca_name = '문의사항'
	order by bo_oriNum desc, bo_depth asc
    limit 2,2;
    
-- 1번 게시글에 qwer1234 회원이 추천했을 때 쿼리문
insert likes(li_us_id,li_state,li_target,li_targetNum)
	values('qwer1234', 1, 'board', 1);

-- qwer1234 1번 게시글에 추천을 한번 더 눌러 추천을 취소했을 때 쿼리문
update likes set li_state = 0
    where li_us_id = 'qwer1234' and li_target = 'board' and li_targetNum = 1;
-- delete로 했을 때
delete from likes where li_us_id = 'qwer1234' and li_target = 'board' and li_targetNum = 1;

-- 1번 게시글의 추천수 조회
select  count(*) as 추천 from likes where li_state = 1 and li_targetNum = 1 and li_target = 'board';
-- 1번 게시글의 비추천수 조회 
select count(*) as 비추천 from likes where li_state = -1 and li_targetNum = 1 and li_target = 'board'; 