drop database if exists shoppingmall;
create database if not exists shoppingmall;
use shoppingmall;

drop table if exists user;
CREATE TABLE if not exists `user` (
	`us_id`	varchar(20)	NOT NULL,
	`us_pw`	varchar(16)	NULL,
	`us_birth`	date	NULL,
	`us_address`	varchar(100)	NULL,
	`us_authority`	varchar(5)	not NULL default 'USER'
);

drop table if exists product;
CREATE TABLE if not exists `product` (
	`pr_code`	char(6)	NOT NULL,
	`pr_title`	varchar(30)	NULL,
	`pr_detail`	longtext	NULL,
	`pr_price`	int	NULL,
	`pr_type`	varchar(10)	NULL
);

drop table if exists `option`;
CREATE TABLE if not exists `option` (
	`op_num`	int	NOT NULL auto_increment,
	`op_size`	varchar(10)	NULL,
	`op_amount`	int	NULL,
	`op_pr_code`	char(6)	NOT NULL,
    primary key(op_num)
);

drop table if exists buy;
CREATE TABLE if not exists `buy` (
	`bu_num`	int	NOT NULL auto_increment,
	`bu_address`	varchar(100)	NULL,
	`bu_us_id`	varchar(20)	NOT NULL,
	`bu_op_num`	int	NOT NULL,
    primary key(bu_num)
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`us_id`
);

ALTER TABLE `product` ADD CONSTRAINT `PK_PRODUCT` PRIMARY KEY (
	`pr_code`
);

ALTER TABLE `option` ADD CONSTRAINT `FK_product_TO_option_1` FOREIGN KEY (
	`op_pr_code`
)
REFERENCES `product` (
	`pr_code`
);

ALTER TABLE `buy` ADD CONSTRAINT `FK_user_TO_buy_1` FOREIGN KEY (
	`bu_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `buy` ADD CONSTRAINT `FK_option_TO_buy_1` FOREIGN KEY (
	`bu_op_num`
)
REFERENCES `option` (
	`op_num`
);

-- 관리자 정보를 등록하는 쿼리 작성
insert user values('admin','admin',null,null,'ADMIN');

-- 제품 등록 : 셔츠
insert product values('ABC001','셔츠','셔츠입니다', 10000 ,'상의');
insert `option`(op_size, op_amount, op_pr_code) 
values('xs',10,'ABC001'),('s',10,'ABC001'),('m',10,'ABC001'),('l',10,'ABC001'),('xl',10,'ABC001');

-- 회원 등록
insert user value('abc123','abc123','2000-01-01','청주시','USER');

-- abc123 회원이 ABC001 제품의 xl를 1개 구매했을 때 쿼리문 작성
insert buy(bu_us_id, bu_op_num, bu_address) 
	select 'abc123', op_num, '청주시' from `option` 
		where op_pr_code = 'ABC001' and op_size = 'xl'; 
update `option`
	set op_amount = op_amount - 1
    where op_pr_code = 'ABC001' and op_size = 'xl';
    
-- 제품 등록: 운동화
insert product value('DEF001','신상운동화','신상운동화입니다', 20000 ,'신발');
insert `option`(op_size, op_amount, op_pr_code) 
values('220',10,'DEF001'),('230',10,'DEF001'),('240',10,'DEF001'),('250',10,'DEF001'),('260',10,'DEF001');

-- abc123 회원이 DEF001 제품을 220과 260을 각각 1개씩 구매하는 쿼리 작성
insert buy(bu_us_id, bu_op_num, bu_address) 
		select 'abc123', op_num, '청주시' from `option` 
		where op_pr_code = 'DEF001' and (op_size = '220' or op_size = '260');
update `option`
	set op_amount = op_amount - 1
    where op_pr_code = 'DEF001' and op_size in('220', '260');
    
-- 제품 등록 : 니트
insert product values('ABC002','니트','니트입니다', 30000 ,'상의');
insert `option`(op_size, op_amount, op_pr_code) 
	values('l',10,'ABC002');