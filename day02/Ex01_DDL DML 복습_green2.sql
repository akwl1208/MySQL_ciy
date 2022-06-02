-- <DDL>
drop database if exists green2; -- 데이터베이스 삭제
create database if not exists green2; -- 데이터베이스 생성
use green2; -- green2 선택

drop table if exists 학생; -- 학생 테이블 삭제
create table if not exists 학생( -- 테이블 생성
	학생번호 	int 	auto_increment,
	이름 		char(6),
	primary key(학생번호)
);

alter table 학생 add 학과 char(6); -- 학생 테이블에 학과 속성 추가
alter table 학생 drop 학과; -- 학생 테이블에 학과 속성 삭제
alter table 학생 add 학과 char(6); 
alter table 학생 change 학과 학부 char(6); -- 학생 테이블에 학과 속성을 학부로 바꿈
alter table 학생 change 학생번호 학생번호 int; -- 학생번호에서 auto-increment 삭제
alter table 학생 drop primary key; -- 오류 발생 -> auto_increment를 삭제 안하면
alter table 학생 add primary key(학생번호); -- 기본키 추가
-- desc 학생; -- 테이블 속성 정보 확인

drop table if exists 학부; -- 학부 테이블 삭제
CREATE TABLE if not exists `학부` ( -- 학부 테이블 생성
  `학부명` char(6) NOT NULL,
  `학부위치` char(45) DEFAULT NULL,
  PRIMARY KEY (`학부명`)
);

alter table 학생 add foreign key(학부) references 학부(학부명); -- 외래키 설정

-- <DML>
-- 학부 테이블에 컴퓨터 공학부 추가
-- 속성명 생략 -> 테이블 생성 시 추가한 속성들의 순서 중요
insert into 학부 values('컴퓨터공학부', '그린대학교 1관 401호');
-- 학부 테이블에 기계 공학부 추가
-- 속성명 입력 -> 테이블 생성 시 추가한 속성들의 순서는 중요하지 않고, 입력한 순서가 중요
insert into 학부(학부위치, 학부명) values('그린대학교 1관 201호', '기계공학부');
-- 학부 테이블에 전자 공학부 추가
-- 생략한 속성이 있는 경우, 생략한 속성에는 기본값으로 저장
-- 기본값을 설정하지 않은 경우 null이 들어감
-- not null을 설정한 속성은 생략하면 안됨 -> 가능한 경우는 기본키에 auto_increment를 설정한 경우
insert into 학부(학부명) values('전자공학부');
-- 학생 테이블에 컴퓨터공학부 홍길동 학생 정부 추가
insert 학생 values(1, '홍길동','컴퓨터공학부');

-- 컴퓨터공학부 학부위치가 그린대학교 2관 101호 이동
-- update에서 set에 있는 =은 값 수정 역할, where에 있는 =은 값 비교 역할
update 학부 set 학부위치 = '그린대학교 2관 101호' where 학부명 = '컴퓨터공학부';
-- 홍길동 학생의 이름을 고길동으로 개명함
-- where에 기본키가 아닌 속성이 오면 추가 작업이 필요함
update 학생 set 이름 = '고길동' where 이름 = '홍길동';

-- 1번 학생의 데이터 삭제
delete from 학생 where 학생번호 = 1;
