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
	`th_addr`	varchar(20)	NULL
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