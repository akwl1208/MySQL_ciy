drop database if exists cgv;
create database if not exists cgv;
use cgv;

DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie` (
	`mo_num`	int	NOT NULL,
	`mo_title`	varchar(30)	NULL,
	`mo_genre`	varchar(10)	NULL,
	`mo_age`	varchar(10)	NULL,
	`mo_runtime`	int	NULL,
	`mo_country`	varchar(20)	NULL,
	`mo_opendate`	date	NULL,
	`mo_detail`	longtext	NULL,
	`mo_site`	varchar(30)	NULL,
	`mo_thumb`	varchar(50)	NULL
);

DROP TABLE IF EXISTS `movieman`;
CREATE TABLE `movieman` (
	`mm_num`	int	NOT NULL,
	`mm_name`	varchar(30)	NULL,
	`mm_birth`	date	NULL,
	`mm_nation`	varchar(30)	NULL,
	`mm_job`	varchar(10)	NULL,
	`mm_education`	varchar(30)	NULL,
	`mm_family`	varchar(30)	NULL,
	`mm_habby`	varchar(30)	NULL,
	`mm_physical`	varchar(30)	NULL,
	`mm_site`	varchar(30)	NULL,
	`mm_thumb`	varchar(30)	NULL
);

DROP TABLE IF EXISTS `act`;
CREATE TABLE `act` (
	`ac_num`	int	NOT NULL,
	`ac_mo_num`	int	NOT NULL,
	`ac_mm_num`	int	NOT NULL,
	`ac_role`	varchar(10)	NULL
);

DROP TABLE IF EXISTS `theater`;
CREATE TABLE `theater` (
	`th_name`	varchar(20)	NOT NULL,
	`th_region`	varchar(10)	NULL,
	`th_addr`	varchar(100)NULL
);

DROP TABLE IF EXISTS `screen`;
CREATE TABLE `screen` (
	`sc_num`	int	NOT NULL,
	`sc_name`	varchar(20)	NULL,
	`sc_type`	varchar(10)	NULL,
	`sc_th_name`	varchar(20)	NOT NULL,
	`sc_maxSeat`	int	NULL
);

DROP TABLE IF EXISTS `show`;
CREATE TABLE `show` (
	`sh_num`	int	NOT NULL,
	`sh_mo_num`	int	NOT NULL,
	`sh_sc_num`	int	NOT NULL,
	`sh_startTime`	datetime	NULL,
	`sh_endTime`	datetime	NULL,
	`sh_posSeat`	int	NULL
);

DROP TABLE IF EXISTS `seat`;
CREATE TABLE `seat` (
	`se_num`	int	NOT NULL,
	`se_sc_num`	int	NOT NULL,
	`se_name`	varchar(3)	NULL,
	`se_type`	varchar(10)	NULL,
	`se_use`	char(1)	NULL
);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`us_id`	varchar(15)	NOT NULL,
	`us_pw`	varchar(20)	NULL
);

DROP TABLE IF EXISTS `book`;
CREATE TABLE `book` (
	`bo_num`	int	NOT NULL,
	`bo_us_id`	varchar(15)	NOT NULL,
	`bo_sh_num`	int	NOT NULL,
	`bo_date`	datetime	NULL,
	`bo_state`	char(1)	NULL,
	`bo_amount`	int	NULL,
	`bo_totalPrice`	int	NULL
);

DROP TABLE IF EXISTS `bookdetail`;
CREATE TABLE `bookdetail` (
	`bd_num`	int	NOT NULL,
	`bd_bo_num`	int	NOT NULL,
	`bd_se_num`	int	NOT NULL,
	`bd_price`	int	NULL
);

ALTER TABLE `movie` ADD CONSTRAINT `PK_MOVIE` PRIMARY KEY (
	`mo_num`
);

ALTER TABLE `movieman` ADD CONSTRAINT `PK_MOVIEMAN` PRIMARY KEY (
	`mm_num`
);

ALTER TABLE `act` ADD CONSTRAINT `PK_ACT` PRIMARY KEY (
	`ac_num`
);

ALTER TABLE `theater` ADD CONSTRAINT `PK_THEATER` PRIMARY KEY (
	`th_name`
);

ALTER TABLE `screen` ADD CONSTRAINT `PK_SCREEN` PRIMARY KEY (
	`sc_num`
);

ALTER TABLE `show` ADD CONSTRAINT `PK_SHOW` PRIMARY KEY (
	`sh_num`
);

ALTER TABLE `seat` ADD CONSTRAINT `PK_SEAT` PRIMARY KEY (
	`se_num`
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`us_id`
);

ALTER TABLE `book` ADD CONSTRAINT `PK_BOOK` PRIMARY KEY (
	`bo_num`
);

ALTER TABLE `bookdetail` ADD CONSTRAINT `PK_BOOKDETAIL` PRIMARY KEY (
	`bd_num`
);

alter table movie	 	change mo_num mo_num int not null auto_increment;
alter table movieman 	change mm_num mm_num int not null auto_increment;
alter table act 		change ac_num ac_num int not null auto_increment;
alter table screen 		change sc_num sc_num int not null auto_increment;
alter table `show` 		change sh_num sh_num int not null auto_increment;
alter table seat 		change se_num se_num int not null auto_increment;
alter table book 		change bo_num bo_num int not null auto_increment;
alter table bookdetail 	change bd_num bd_num int not null auto_increment;

ALTER TABLE `act` ADD CONSTRAINT `FK_movie_TO_act_1` FOREIGN KEY (
	`ac_mo_num`
)
REFERENCES `movie` (
	`mo_num`
);

ALTER TABLE `act` ADD CONSTRAINT `FK_movieman_TO_act_1` FOREIGN KEY (
	`ac_mm_num`
)
REFERENCES `movieman` (
	`mm_num`
);

ALTER TABLE `screen` ADD CONSTRAINT `FK_theater_TO_screen_1` FOREIGN KEY (
	`sc_th_name`
)
REFERENCES `theater` (
	`th_name`
);

ALTER TABLE `show` ADD CONSTRAINT `FK_movie_TO_show_1` FOREIGN KEY (
	`sh_mo_num`
)
REFERENCES `movie` (
	`mo_num`
);

ALTER TABLE `show` ADD CONSTRAINT `FK_screen_TO_show_1` FOREIGN KEY (
	`sh_sc_num`
)
REFERENCES `screen` (
	`sc_num`
);

ALTER TABLE `seat` ADD CONSTRAINT `FK_screen_TO_seat_1` FOREIGN KEY (
	`se_sc_num`
)
REFERENCES `screen` (
	`sc_num`
);

ALTER TABLE `book` ADD CONSTRAINT `FK_user_TO_book_1` FOREIGN KEY (
	`bo_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `book` ADD CONSTRAINT `FK_show_TO_book_1` FOREIGN KEY (
	`bo_sh_num`
)
REFERENCES `show` (
	`sh_num`
);

ALTER TABLE `bookdetail` ADD CONSTRAINT `FK_book_TO_bookdetail_1` FOREIGN KEY (
	`bd_bo_num`
)
REFERENCES `book` (
	`bo_num`
);

ALTER TABLE `bookdetail` ADD CONSTRAINT `FK_seat_TO_bookdetail_1` FOREIGN KEY (
	`bd_se_num`
)
REFERENCES `seat` (
	`se_num`
);

-- 영화정보 입력
insert movie(mo_title,mo_genre,mo_age,mo_runtime,mo_country,mo_opendate,mo_detail)
	values('브로커', '드라마', '12세 이상', 129,'한국','2022-06-08','예기치 못한 특별한 여정');
    
-- 배우 정보 입력
insert movieman(mm_name,mm_nation,mm_job) values('고레에다 히로카즈', '일본', '감독');
insert movieman(mm_name,mm_birth,mm_nation,mm_job) values('송강호', '1967-01-17', '한국', '배우');
insert movieman(mm_name,mm_birth,mm_nation) values('강동원', '1981-01-18', '한국');
insert movieman(mm_name,mm_birth,mm_nation,mm_job) values('배두나', '1979-10-11', '한국', '배우');
insert movieman(mm_name,mm_birth,mm_job) values('이지은', '1993-05-16', '가수');
insert movieman(mm_name,mm_birth,mm_nation,mm_job) values('이주영', '1992-02-14', '한국', '배우');

-- 출연 정보 입력
insert act(ac_mo_num,ac_mm_num,ac_role) values
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '고레에다 히로카즈'), '감독'),
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '송강호'), '배우'),
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '강동원'), '배우'),
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '배두나'), '배우'),
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '이지은'), '배우'),
    ((select mo_num from movie where mo_title = '브로커'), (select mm_num from movieman where mm_name = '이주영'), '베우');
    
-- 청주성안길 영화관 추가
insert theater values('cgv청주성안길','대전/충청','충청북도 청주시 상당구 북문로1가 170-1');
-- 청주성안길 상영관 추가
insert screen(sc_name,sc_type,sc_th_name,sc_maxSeat)
	values('1관', '2D', 'cgv청주성안길', 10),('2관', '2D', 'cgv청주성안길', 10),('3관', '2D', 'cgv청주성안길', 10),
    ('4관', '2D', 'cgv청주성안길', 10),('5관', '2D', 'cgv청주성안길', 10);
-- 청주성안길 좌석 추가
insert seat(se_sc_num, se_name, se_type, se_use)
	values(1, 'A1', '일반', 'Y'), (1, 'A2', '일반', 'Y'), (1, 'B1', '일반', 'Y'), (1, 'B2', '일반', 'Y'), (1, 'C1', '일반', 'Y'),
    (1, 'C2', '일반', 'Y'), (1, 'D1', '일반', 'Y'), (1, 'D2', '일반', 'Y'), (1, 'E1', '일반', 'Y'), (1, 'E2', '일반', 'Y'),
    (2, 'A1', '일반', 'Y'), (2, 'A2', '일반', 'Y'), (2, 'B1', '일반', 'Y'), (2, 'B2', '일반', 'Y'), (2, 'C1', '일반', 'Y'),
    (2, 'C2', '일반', 'Y'), (2, 'D1', '일반', 'Y'), (2, 'D2', '일반', 'Y'), (2, 'E1', '일반', 'Y'), (2, 'E2', '일반', 'Y'),
    (3, 'A1', '일반', 'Y'), (3, 'A2', '일반', 'Y'), (3, 'B1', '일반', 'Y'), (3, 'B2', '일반', 'Y'), (3, 'C1', '일반', 'Y'),
    (3, 'C2', '일반', 'Y'), (3, 'D1', '일반', 'Y'), (3, 'D2', '일반', 'Y'), (3, 'E1', '일반', 'Y'), (3, 'E2', '일반', 'Y'),
    (4, 'A1', '일반', 'Y'), (4, 'A2', '일반', 'Y'), (4, 'B1', '일반', 'Y'), (4, 'B2', '일반', 'Y'), (4, 'C1', '일반', 'Y'),
    (4, 'C2', '일반', 'Y'), (4, 'D1', '일반', 'Y'), (4, 'D2', '일반', 'Y'), (4, 'E1', '일반', 'Y'), (4, 'E2', '일반', 'Y'),
    (5, 'A1', '일반', 'Y'), (5, 'A2', '일반', 'Y'), (5, 'B1', '일반', 'Y'), (5, 'B2', '일반', 'Y'), (5, 'C1', '일반', 'Y'),
    (5, 'C2', '일반', 'Y'), (5, 'D1', '일반', 'Y'), (5, 'D2', '일반', 'Y'), (5, 'E1', '일반', 'Y'), (5, 'E2', '일반', 'Y');

-- 제주 영화관 추가
insert theater values('cgv제주','광주/전라/제주','제주특별자치도 제주시 이도2동 메카플러스 3~7층');
-- 제주 상영관 추가
insert screen(sc_name,sc_type,sc_th_name,sc_maxSeat)
	values('1관', '2D', 'cgv제주', 8),('2관', '2D', 'cgv제주', 8),('3관', '2D', 'cgv제주', 8);
-- 제주 좌석 추가
insert seat(se_sc_num, se_name, se_type, se_use)
	values(6, 'A1', '일반', 'Y'), (6, 'A2', '일반', 'Y'), (6, 'A3', '일반', 'Y'), (6, 'B1', '일반', 'Y'), (6, 'B2', '일반', 'Y'),
    (6, 'B3', '일반', 'Y'), (6, 'C1', '일반', 'Y'), (6, 'C2', '일반', 'Y'),
    (7, 'A1', '일반', 'Y'), (7, 'A2', '일반', 'Y'), (7, 'A3', '일반', 'Y'), (7, 'B1', '일반', 'Y'), (7, 'B2', '일반', 'Y'),
    (7, 'B3', '일반', 'Y'), (7, 'C1', '일반', 'Y'), (7, 'C2', '일반', 'Y'),
    (8, 'A1', '일반', 'Y'), (8, 'A2', '일반', 'Y'), (8, 'A3', '일반', 'Y'), (8, 'B1', '일반', 'Y'), (8, 'B2', '일반', 'Y'),
    (8, 'B3', '일반', 'Y'), (8, 'C1', '일반', 'Y'), (8, 'C2', '일반', 'Y');

-- 브로커 6월 14일 cgv성안길 일정 추가    
insert `show`(sh_mo_num,sh_sc_num,sh_startTime,sh_endTime,sh_posSeat)
	values (1,1,'2022-06-14 11:30', '2022-06-14 13:49', 10),
	(1,1,'2022-06-14 14:05', '2022-06-14 16:24', 10),
	(1,1,'2022-06-14 16:40', '2022-06-14 18:59', 10),
	(1,2,'2022-06-14 10:25', '2022-06-14 12:44', 10),
	(1,2,'2022-06-14 13:00', '2022-06-14 15:19', 10),
	(1,2,'2022-06-14 15:35', '2022-06-14 17:54', 10),
	(1,2,'2022-06-14 18:10', '2022-06-14 20:29', 10),
	(1,2,'2022-06-14 20:45', '2022-06-14 23:04', 10),
	(1,2,'2022-06-14 23:20', '2022-06-15 01:39', 10),
	(1,3,'2022-06-14 11:00', '2022-06-14 13:19', 10),
	(1,3,'2022-06-14 13:35', '2022-06-14 15:54', 10),
	(1,3,'2022-06-14 16:10', '2022-06-14 18:29', 10),
	(1,3,'2022-06-14 21:15', '2022-06-14 23:34', 10),
	(1,3,'2022-06-14 23:45', '2022-06-15 02:04', 10);
    
-- 회원 추가
insert `user` values('abc123','abc123');

-- abc123 회원이 6/14일 cgv성안길 11:30분에 하는 영화 브로커 A1,A2 좌석을 예매, 가격은 자리당 10000원 
insert book(bo_us_id,bo_sh_num,bo_date,bo_state,bo_amount,bo_totalPrice)
	select 'abc123', sh_num, now(),'Y', 2 , 20000 from `show`
	join movie on sh_mo_num = mo_num
    where sh_startTime = '2022-06-14 11:30'
		and mo_title = '브로커';
        
insert bookdetail(bd_bo_num, bd_se_num, bd_price)
	select 1, se_num, 10000 from `show`
		join moive on sc_mo_num - mo_num
        join seat on se_sc_num = sh_sc_num
        where mo_title = '브로커'
			and sh_startTime = '2022-06-14 11:30'
            and se_name in('A1','A2')
            and se_use = 'Y';