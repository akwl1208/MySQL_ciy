drop database if exists green3;
create database if not exists green3;
use green3;

drop table if exists test1;
CREATE TABLE if not exists `test1` (
  `num` int NOT NULL AUTO_INCREMENT,
  `name` char(45) DEFAULT NULL,
  PRIMARY KEY (`num`)
);
drop table if exists test2;
CREATE TABLE if not exists `test2` (
  `num` int NOT NULL AUTO_INCREMENT,
  `name` char(45) DEFAULT NULL,
  PRIMARY KEY (`num`)
);

insert into test1(name) values('홍길동'),('임꺽정'),('유관순');
insert into test2(name) values('홍길동'),('임꺽정'),('유관순');

truncate table test1;
delete from test2;

-- truncate를 이용하여 테이블을 초기화하면 새로 데이터를 추가할 때 auto_increment 값이 1부터 시작
-- delete를 이용하여 테이블을 전체 삭제하고, 새로 데이터를 추가할 때 이전 auto_increment 값을 이어서 시작
insert into test1(name) values('홍길동'),('임꺽정'),('유관순');
insert into test2(name) values('홍길동'),('임꺽정'),('유관순');