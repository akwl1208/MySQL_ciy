drop database if exists community;
create database if not exists community;
use community; 

DROP TABLE IF EXISTS `user`;
CREATE TABLE if not exists `user` (
	`us_id`			varchar(20)		NOT NULL,
	`us_pw`			varchar(15)		not NULL,
	`us_name`		varchar(100)	not NULL,
	`us_addr`		varchar(200)	not NULL 	default "",
	`us_phone`		varchar(13)		not NULL,
	`us_authority`	int				not NULL 	default 1
);

DROP TABLE IF EXISTS `board`;
CREATE TABLE if not exists `board` (
	`bo_num`		int				NOT NULL,
	`bo_ca_name`	varchar(10)		NOT NULL,
	`bo_title`		varchar(100)	not NULL,
	`bo_content`	longtext		not NULL,
	`bo_us_id`		varchar(10)		NOT NULL,
	`bo_regDate`	datetime		not NULL	default current_timestamp,
	`bo_update`		datetime		NULL,
	`bo_views`		int				not NULL	default 0,
	`bo_delete`		int				not NULL	default 0, -- 0 삭제가 안된 상태
	`bo_oriNum`		int				NULL,
	`bo_depth`		int				not NULL	default 1, -- 1 본인인 상태
	`bo_secret`		int				not NULL	default 0
);

DROP TABLE IF EXISTS `comment`;
CREATE TABLE if not exists `comment` (
	`co_num`		int			NOT NULL,
	`co_content`	longtext	not NULL,
	`co_us_id`		varchar(20)	NOT NULL,
	`co_bo_num`		int			NOT NULL,
	`co_date`		datetime	not NULL	default now(),
	`co_secret`		int			not NULL	default 0,
	`co_oriNum`		int			NULL,
	`co_depth`		int			not NULL	default 1,
	`co_delete`		int			not NULL	default 0
);

DROP TABLE IF EXISTS likes;
CREATE TABLE if not exists likes (
	`li_num`		int			NOT NULL,
	`li_us_id`		varchar(20)	NOT NULL,
	`li_state`		int	 		not NULL,
	`li_target`		varchar(10)	not NULL 	default 'board',
	`li_targetNum`	int			not NULL
);

DROP TABLE IF EXISTS `file`;
CREATE TABLE if not exists `file` (
	`fi_num`		int				NOT NULL,
	`fi_oriName`	varchar(100)	not NULL,
	`fi_name`		varchar(50)		not NULL,
	`fi_bo_num`		int				NOT NULL
);

DROP TABLE IF EXISTS `category`;
CREATE TABLE if not exists `category` (
	`ca_name`	varchar(10)	NOT NULL,
	`ca_read`	int			not	NULL 	default 0, -- 비회원도 게시글 읽기 가능
	`ca_write`	int			not NULL	default 1, -- 회원부터 게시글 작성 가능
	`ca_secret`	int			not NULL	default 0 -- 전체공개
);

ALTER TABLE `user` ADD CONSTRAINT `PK_USER` PRIMARY KEY (
	`us_id`
);

ALTER TABLE `board` ADD CONSTRAINT `PK_BOARD` PRIMARY KEY (
	`bo_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `PK_COMMENT` PRIMARY KEY (
	`co_num`
);

ALTER TABLE likes ADD CONSTRAINT `PK_LIKE` PRIMARY KEY (
	`li_num`
);

ALTER TABLE `file` ADD CONSTRAINT `PK_FILE` PRIMARY KEY (
	`fi_num`
);

ALTER TABLE `category` ADD CONSTRAINT `PK_CATEGORY` PRIMARY KEY (
	`ca_name`
);

-- 외래키로 지정된 기본키들은 속성을 바꾸기 힘듬 ->  외래키 지정 전에 쿼리문 작성
-- auto_increment 추가
alter table board change bo_num bo_num int not null auto_increment;
alter table file change fi_num fi_num int not null auto_increment;
alter table likes change li_num li_num int not null auto_increment;
alter table comment change co_num co_num int not null auto_increment;

ALTER TABLE `board` ADD CONSTRAINT `FK_category_TO_board_1` FOREIGN KEY (
	`bo_ca_name`
)
REFERENCES `category` (
	`ca_name`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_user_TO_board_1` FOREIGN KEY (
	`bo_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `board` ADD CONSTRAINT `FK_board_TO_board_1` FOREIGN KEY (
	`bo_oriNum`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_user_TO_comment_1` FOREIGN KEY (
	`co_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_board_TO_comment_1` FOREIGN KEY (
	`co_bo_num`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `comment` ADD CONSTRAINT `FK_comment_TO_comment_1` FOREIGN KEY (
	`co_oriNum`
)
REFERENCES `comment` (
	`co_num`
);

ALTER TABLE likes ADD CONSTRAINT `FK_user_TO_likes_1` FOREIGN KEY (
	`li_us_id`
)
REFERENCES `user` (
	`us_id`
);

ALTER TABLE `file` ADD CONSTRAINT `FK_board_TO_file_1` FOREIGN KEY (
	`fi_bo_num`
)
REFERENCES `board` (
	`bo_num`
);

ALTER TABLE `community`.`board` 
ADD COLUMN `bo_up` INT NOT NULL default 0 AFTER `bo_secret`,
ADD COLUMN `bo_down` INT NOT NULL default 0 AFTER `bo_up`;

-- 최고관리자 등록
insert user(us_id,us_pw,us_name,us_phone,us_authority)
	values('admin123','admin123','관리자', '000-0000-0000', 10);
    
-- 일반 회원 등록
insert user(us_id,us_pw,us_name,us_phone)
	values('abcd1234','abcd1234','홍길동', '020-1234-1234'), 
		('qwer1234','qwer1234','임꺽정', '030-1234-1234'); 
        
-- 관리자가 게시글 종류 등록
insert category(ca_name,ca_read,ca_write,ca_secret) 
	values('공지사항', 1, 10,0),('일반', 0, 1,0),('문의사항', 1, 1,1);
    
-- abcd1234회원이 일반게시글 작성
-- 최고관리자가 공지사항 작성
-- qwer1234 회원이 문의게시글 작성
insert board(bo_ca_name, bo_title, bo_content, bo_us_id,bo_secret)
	values('일반','안녕하세요','만나서 반갑습니다','abcd1234',0),
    ('공지사항','공지사항1','공지사항입니다','admin123',0),
    ('문의사항','문의합니다','비번을 바꾸고 싶어요','qwer1234', 1);
update board set bo_oriNum = bo_num where bo_oriNum is null; -- null체크할 때는 is null로 해야 정확함

-- abcd1234 회원이 일반게시글 작성
insert board(bo_ca_name, bo_title, bo_content, bo_us_id,bo_secret, bo_oriNum)
	select '일반','안녕하세요1','만나서 반갑습니다','abcd1234',0, ifnull(max(bo_num),0)+1 from board; 
    
-- 관리자가 3번 게시글에 답글을 남김
insert board(bo_ca_name, bo_title, bo_content, bo_us_id, bo_oriNum, bo_depth, bo_secret)
	select '문의사항','문의하신 내용에 답변합니다','비번찾기를 이용하세요','admin123',bo_oriNum,bo_depth+1,1
    from board where bo_num = 3;

-- qwer1234 회원이 5번 게시글에 답글 남김
insert board(bo_ca_name, bo_title, bo_content, bo_us_id, bo_oriNum, bo_depth, bo_secret)
	select '문의사항','그래도 안돼요','비번찾기를 이용해도 안됩니다','qwer1234',bo_oriNum,bo_depth+1,1
    from board where bo_num = 5;

-- abcd1234 회원이 일반게시글 작성 -> 첨부파일 2개 등록
insert board(bo_ca_name, bo_title, bo_content, bo_us_id,bo_secret, bo_oriNum)
	select '일반','제목입니다2','내용입니다','abcd1234',0, ifnull(max(bo_num),0)+1 from board;
-- 첨부파일 추가
insert file(fi_oriName,fi_name,fi_bo_num) values('a.txt', 'uuid_a.txt',7),('b.txt','uuid_b.txt',7);  

-- 1번 게시글에 qwer1234 회원이 만나서 반가워요라고 댓글 작성
-- ifnull은 댓글이나 게시글을 어떻게 삭제하는지에 따라 사용 여부가 판별된다
insert comment(co_content,co_us_id,co_bo_num,co_secret,co_oriNum,co_depth)
	select '만나서 반가워요','qwer1234',1,0,ifnull(max(co_num),0)+1,1 from comment;

-- 1번 댓글의 댓글로 admin123 관리자가 댓글 작성
insert comment(co_content,co_us_id,co_bo_num,co_secret,co_oriNum,co_depth)
	select '잘부탁드립니다', 'admin123', co_bo_num, 0, co_oriNum, co_depth+1 from comment
    where co_num = 1;
    
-- 1번 게시글의 제목 수정
update board 
	set bo_title = '가입인사입니다', 
		bo_update = now()
    where bo_num = 1;
    
-- 카테고리 추가
insert category(ca_name) values('스터디');

-- 게시글 추천 비추천 추가
INSERT INTO `community`.`likes` (`li_us_id`, `li_state`, `li_target`, `li_targetNum`)
	VALUES ('admin123', '1', 'board', '1'), ('abcd1234', '-1', 'board', '1'), ('qwer1234', '-1', 'board', '4');

-- 처음으로 추천/비추천을 했을 때, 해당 게시글에 추천 똔느 비추천 업데이트
-- 기존에 likes에 있는 테이블에 있는 테이블들로 추천/비추천수 업데이트
update board
	set bo_up = (select count(*) from likes 
		where bo_num = li_targetNum and li_target = 'board' and li_state = 1);

update board
	set bo_down = (select count(*) from likes 
		where bo_num = li_targetNum and li_target = 'board' and li_state = -1);

