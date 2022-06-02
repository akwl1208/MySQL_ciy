use cookdb;

-- 1970년 이후에 출생한 사람의 아이디와 이름 조회
select userID, userName from usertbl where birthYear >= 1970;
-- 회원의 키가 180~182인 사람의 이름과 키 조회
select userName, height from usertbl where height between 180 and 182;
-- 지역이 경남이거나 충남이거나 경북인 사람의 이름과 주소 조회
select userName, addr from usertbl where addr in('경남', '충남', '경북');
-- 성이 김씨인 사람의 이름과 키 조회
select userName, height from usertbl where userName like '김%'; 
-- 1970년대에 출생한 사람의 아이디와 이름 조회
select userID, userName from usertbl where birthYear like '197_';
-- 2013년에 가입한 회원의 모든 정보 조회
select * from usertbl where mdate like '2013%';
-- KHD 회원이 구매한 제품 조회
select prodName from buytbl where userID = 'KHD';
-- 회원의 키가 180~182인 회원 중 경북에 사는 회원 정보 조회
select * from usertbl where height between 180 and 182 and addr = '경북';
-- 회원의 키가 180미만이거나 182초과인 회원 정보 조회
select * from usertbl where (height < 180 or height > 182);
select * from usertbl where !(height between 180 and 182);
-- 회원의 키가 180미만이거나 182초과인 회원 중 주소가 경남인 회원 정보 조회
select * from usertbl where (height < 180 or height > 182) and addr = '경남';
select * from usertbl where !(height between 180 and 182) and addr = '경남';

-- <서브쿼리>
-- 김영만 회원보다 키가 큰 회원정보를 조회
select * from usertbl where height > (select height from usertbl where userName = '김용만');
-- 경기 지역에 사는 회원보다 키가 큰 회원 정보 조회
-- 아래 식은 오류 발생 -> 경기에 사는 사람은 2명인데 그럼 height > 176, 180 이런 느낌으로 조건식이 세워짐
-- select * from usertbl where height > (select height from usertbl where addr = '경기');
-- All : 서브쿼리 전체를 만족해야 하는 경우 사용 -> 경기 지역에 사는 회원 중 가장 키가 큰 회원보다 키가 큰 회원 정보 조회
select * from usertbl where height > all(select height from usertbl where addr = '경기');
-- Any : 서브쿼리 중 하나를 만족해야 하는 경우 사용 -> 경기 지역에 사는 회원 중 가장 작은 회원보다 키가 큰 회원 정보 조회
select * from usertbl where height > any(select height from usertbl where addr = '경기');
-- KHD 회원이 구매한 제품과 동일한 제품을 구매한 회원 정보 조회
select * from buytbl where prodName = any(select prodName from buytbl where userID = 'KHD'); -- in(값1, 값2, 값3)과 동일
select * from buytbl where prodName in(select prodName from buytbl where userID = 'KHD'); 
-- KHD 회원이 구매한 제품과 동일한 제품을 구매한 회원아이디 조회
select userID from buytbl where userID != 'KHD' and prodName = any(select prodName from buytbl where userID = 'KHD');

-- <정렬>
-- 구매목록을 userID와 prodName 순으로 정렬하여 조회
select * from buytbl order by userID asc, prodName asc;

-- <distinct>
-- 회원들이 구매한 제품 목록 조회
select distinct prodName from buytbl;