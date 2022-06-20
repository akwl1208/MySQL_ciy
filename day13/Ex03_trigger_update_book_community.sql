-- 예매를 취소할 때 필요한 트리거
drop trigger if exists update_book;

delimiter //
create trigger update_book
	after update on book for each row
begin
	-- 예매 취소 후 예약 가능 좌석수 증가
    if old.bo_state like 'Y' and new.bo_state like 'N'
		-- and now() < (select sh_startTime from `show` where sh_num = new.bo_sh_num) //원래 이렇게 날짜도 신경써야함
        then -- 시스템상 if문이 없어도 가능하지만 정확하게 하려면 if 필요
	update `show` set sh_posSeat = sh_posSeat + new.bo_amount where sh_num = new.bo_sh_num;
    end if;
end //
delimiter ;

-- 트리거 동작 테스트
update book set bo_state = 'N' where bo_num = 3;
