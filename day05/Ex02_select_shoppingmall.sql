use shoppingmall;

-- abc123회원의 누적 구매액 조회
select bu_us_id, sum(pr_price) as 누적금액 from buy
	join `option` on bu_op_num = op_num
	join product on op_pr_code = pr_code
	where bu_us_id = 'abc123';
-- 좀 더 효율적인 쿼리 -> abc123 회원에 대해서만 join
select bu_us_id, sum(pr_price) 
	from (select * from buy where bu_us_id = 'abc123') as tmp
 	join `option` on bu_op_num = op_num
	join product on op_pr_code = pr_code;
    
-- 모든 제품에 대해 각 제품별 구매 횟수
select op_pr_code as 제품, count(bu_num) as 구매횟수 from buy
	right join `option` on bu_op_num = op_num
    group by op_pr_code;
    
-- 모든 제품에 대해 각 제품별, 옵션별 구매 횟수
select op_pr_code as 제품코드, op_size as 옵션, count(bu_num) as 구매횟수 from `option`
	left join buy on bu_op_num = op_num
	group by op_num;
    
-- 제품코드가 ABC001인 제품 정보 조회(제품코드, 제품명, 제품상세, 가격, 구매 가능한 사이즈)
select pr_code, pr_title, pr_detail, pr_price, op_amount from product
	join `option` on pr_code = op_pr_code
	where pr_code = 'ABC001' and op_amount > 0;

-- abc123 회원이 구매한 제품 목록(제품명) 조회(중복X)
select pr_title as 제품명 from buy
	join `option` on bu_op_num = op_num
    join product on op_pr_code = pr_code
	where bu_us_id = 'abc123'
    group by pr_code;
    
-- 2000년생 회원 구매 제품 목록(제품코드) 조회
select distinct op_pr_code from buy	
	join `option` on bu_op_num = op_num
    join user on bu_us_id = us_id
	where us_birth like '2000%';
-- between 사용
select distinct op_pr_code from buy	
	join `option` on bu_op_num = op_num
    join user on bu_us_id = us_id
	where us_birth between '2000-01-01' and '2000-12-31';