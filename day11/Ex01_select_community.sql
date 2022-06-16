use community;

-- 일반 게시글 조회 -> 게시글 번호, 게시글 제목과 댓글 수 조회
select bo_num, bo_title, count(co_bo_num) as 댓글수 from board 
	left join comment on co_bo_num = bo_num
    where bo_ca_name = '일반'
    group by bo_num;
    
-- 각 카테고리별 게시글수 조회
select ca_name, count(bo_num) as 게시글수 from category
	left join board on ca_name = bo_ca_name
    group by ca_name;

-- case 사용
select likes.*,
	case 
		when li_state = 1 then '추천'
		when li_state = -1 then '비추천'
		when li_state = 0 then '미추천'
	end as 추천여부
from likes;

-- 일반 게시글에 대해 게시글 번호, 게시글 제목, 추천수와 비추천수 조회
-- 개수를 셀 때, case를 사용하는 방법
select bo_num as 번호, bo_title as 제목, 
	count(case when li_state = 1 then li_state end) as 추천,
    count(case when li_state = -1 then li_state end) as 비추천
    from board
	left join (select * from likes where li_target = 'board') as li
		on li_targetNum = bo_num
    where bo_ca_name = '일반'
    group by bo_num;
-- sum 사용 -> 없는 경우 null -> ifnull 사용
select bo_num as 번호, bo_title as 제목,
	ifnull(sum(li_state = 1),0) as 추천,
	ifnull(sum(li_state = -1),0) as 비추천
    from board
	left join (select * from likes where li_target = 'board') as li
		on li_targetNum = bo_num
    where bo_ca_name = '일반'
    group by bo_num;



