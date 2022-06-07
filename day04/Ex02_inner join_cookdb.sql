-- <inner join>
use cookdb;

-- 구매 테이블과 사용자 테이블을 join 쿼리
select * from usertbl
	join buytbl 
		on usertbl.userID = buytbl.userID;

-- 강호동 회원이 구매한 제품 목록 조회
-- join 이용
select usertbl.userID, userName, prodName from usertbl
	join buytbl 
		on usertbl.userID = buytbl.userID
	where usertbl.userName = '강호동';
-- 서브쿼리 이용
select userID, '강호동' as userName, prodName from buytbl
	where userID = (select userID from usertbl where userName = '강호동');
    
-- 운동화를 구매한 회원이 사는 지역
select distinct prodName, addr from buytbl
	join usertbl 
		on buytbl.userID = usertbl.userID
	where prodName = '운동화';
    
-- 운동화를 구매한 회원의 아이디 조회
select distinct prodName, userID from buytbl
	where buytbl.prodName = '운동화';

