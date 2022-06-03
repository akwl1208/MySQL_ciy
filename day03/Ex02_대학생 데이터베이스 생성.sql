drop schema if exists 대학생;
CREATE SCHEMA if not exists `대학생` ;
use 대학생;

drop table if exists 교수;
CREATE TABLE if not exists 교수 (
  교번 char(10) NOT NULL,
  이름 VARCHAR(10),
  PRIMARY KEY (교번));
  
drop table if exists 학생;
CREATE TABLE if not exists 학생 (
  학번 char(10) NOT NULL,
  이름 VARCHAR(10),
  교번 char(10),
  PRIMARY KEY (학번),
  foreign key(교번) references 교수(교번));
  
drop table if exists 강좌;
CREATE TABLE if not exists 강좌 (
  강좌코드 char(6) NOT NULL,
  강좌명 VARCHAR(15),
  교번 char(10),
  PRIMARY KEY (강좌코드),
  foreign key(교번) references 교수(교번));

drop table if exists 수강;
CREATE TABLE if not exists 수강 (
  수강번호 INT NOT NULL AUTO_INCREMENT,
  학번 char(10) not NULL,
  강좌코드 char(6) not NULL,
  중간 INT not null default 0,
  기말 INT not null default 0,
  과제 INT not null default 0,
  출석 INT not null default 0,
  총점 INT not null default 0,
  PRIMARY KEY (수강번호),
  FOREIGN KEY (학번) REFERENCES 학생 (학번),
  FOREIGN KEY (강좌코드) REFERENCES 강좌 (강좌코드),
  check(총점 <= 100));
  
-- 학생 테이블에 학생 추가(160: 컴공, 135: 전자, 123: 기계)
insert 학생(학번, 이름) values
	('2022160001', '고길동'), ('2022160002', '홍길동'),
	('2022135001', '유관순'), ('2022135002', '이순신'),
    ('2022123001', '논개'), ('2022123002', '세종대왕');
-- 교수 테이블에 교수 추가    
insert 교수 values
	('2022160001', '유재석'), ('2022135001', '강호동'), ('2022123001', '나영석');
-- 학생들은 학과 교수님들에게 지도 받음
update 학생 set 교번 = '2022160001' where 학번 like '____160___';
update 학생 set 교번 = '2022135001' where 학번 like '____135___';
update 학생 set 교번 = '2022123001' where 학번 like '____123___';
-- 강좌 테이블에 강좌 추가
insert 강좌 values ('MSC002', '대학영어', '2022123001'),('ITC001', '컴퓨터개론', '2022160001'), 
	('ITE001', '기초전기', '2022135001'),('ITT001', '기초기계', '2022123001');
-- 이런 식으로 select를 사용할 수 있음
insert 강좌 select 'MSC001', '대학수학기초', 교번 from 교수 where 이름 = '유재석';
-- 수강테이블에 수강 추가
insert 수강(학번, 강좌코드) select '2022160001', 강좌코드 from 강좌 where 강좌명 = '대학수학기초';
insert 수강(학번, 강좌코드) select '2022160001', 강좌코드 from 강좌 where 강좌명 = '대학영어';
insert 수강(학번, 강좌코드) select '2022160001', 강좌코드 from 강좌 where 강좌명 = '컴퓨터개론';

insert 수강(학번, 강좌코드) select '2022160002', 강좌코드 from 강좌 where 강좌명 = '대학수학기초';
insert 수강(학번, 강좌코드) select '2022160002', 강좌코드 from 강좌 where 강좌명 = '컴퓨터개론';

insert 수강(학번, 강좌코드) select '2022135001', 강좌코드 from 강좌 where 강좌명 = '대학영어';
insert 수강(학번, 강좌코드) select '2022135001', 강좌코드 from 강좌 where 강좌명 = '기초전기';

insert 수강(학번, 강좌코드) select '2022135002', 강좌코드 from 강좌 where 강좌명 = '대학수학기초';
insert 수강(학번, 강좌코드) select '2022135002', 강좌코드 from 강좌 where 강좌명 = '대학영어';

insert 수강(학번, 강좌코드) select '2022123001', 강좌코드 from 강좌 where 강좌명 = '기초기계';

insert 수강(학번, 강좌코드) select '2022123002', 강좌코드 from 강좌 where 강좌명 = '대학수학기초';
insert 수강(학번, 강좌코드) select '2022123002', 강좌코드 from 강좌 where 강좌명 = '대학영어';
insert 수강(학번, 강좌코드) select '2022123002', 강좌코드 from 강좌 where 강좌명 = '기초기계';