-- 예매하면 해당 상영 좌석수가 감소하는 트리거 생성
drop trigger if exists insert_book;

delimiter //
create trigger insert_book
	after insert on book for each row
begin
	-- 예매 후 가능 좌석 수 감소
	update `show` set sh_posSeat = sh_posSeat - new.bo_amount where sh_num = new.bo_sh_num;
end //
delimiter ;

-- 트리거 동작 테스트
insert into book(bo_us_id,bo_sh_num,bo_amount,bo_totalPrice) 
	values('abc123',2,3,30000);

insert into bookdetail(bd_bo_num, bd_se_num, bd_price)
	values(3,1,10000),(3,2,10000),(3,3,10000);
