-- <트리거>
-- 1. 처음으로 추천/비추천하는 경우
-- likes 테이블에 insert를 하는 경우 -> board 테이블에서 해당 게시글에 대한 추천/비추천을 update
drop trigger if exists insert_likes;

delimiter //
create trigger insert_likes
	after insert on likes for each row
begin
	-- 추가된 likes 테이블에 추가된 정보에 추천/비추천
    -- 어떤 테이블에 수를 업데이트할지
    -- 게시글 번호
    declare _state int; -- 추천/비추천
    declare _table varchar(20); -- 테이블명
    declare _num int; -- 게시글/댓긃 번호
    -- 처음으로 추천
    set _state = new.li_state; -- 자동으로 1이 들어감
    set _table = new.li_target;
    set _num = new.li_targetNum;
    
    if _state = 1 and _table like 'board' then
		update board set bo_up = bo_up+1 where bo_num = _num;
	end if;
     if _state = -1 and _table like 'board' then
		update board set bo_down = bo_down+1 where bo_num = _num;
	end if;
    
end //
delimiter ;

-- 트리거 동작 테스트) likes 테이블에 추천 추가        
SELECT * FROM community.likes;
insert into likes(li_us_id, li_state, li_target,li_targetNum)
	values('qwer1234',1,'board',7);
    
insert into likes(li_us_id, li_state, li_target,li_targetNum)
	values('admin123',1,'board',7);
    
-- 2. 기존의 추천/비추천을 변경해서 새로 추천/비추천하는 경우
-- likes 테이블에 update를 하는 경우 -> board 테이블에 변경되기 추천/비추천의 수를 1 감소하고,
-- 변경된 후 추천/비추천의 수를 1 증가
drop trigger if exists update_likes;

delimiter //
create trigger update_likes
	after update on likes for each row
begin
	-- 수정 전 상태가 추천인 경우
	if old.li_target like 'board' and old.li_state = 1 then
		update board set bo_up = bo_up-1 where bo_num = old.li_targetNum;
    end if;
    -- 수정 전 상태가 비추천인 경우
	if old.li_target like 'board' and old.li_state = -1 then
		update board set bo_down = bo_down-1 where bo_num = old.li_targetNum;
    end if;
	
    -- 수정 후 상태가 추천인 경우
	if new.li_target like 'board' and new.li_state = 1 then
		update board set bo_up = bo_up+1 where bo_num = new.li_targetNum;
    end if;
    -- 수정 후 상태가 비추천인 경우
	if new.li_target like 'board' and new.li_state = -1 then
		update board set bo_down = bo_down+1 where bo_num = new.li_targetNum;
    end if;
end //
delimiter ;

-- 트리거 동작 테스트) 실행 후 board 테이블에 해당 게시글/댓글의 추천/비추천 수 확인 
update likes set li_state = 0 where li_num = 1;

show triggers;