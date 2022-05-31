-- 학교 데이터베이스 생성하는 쿼리문 작성
drop database if exists 학교;
create database if not exists 학교;
use 학교;

create table if not exists 학생(
	학생번호 	int 	not null	auto_increment,
    이름 	char(6)	not null,
    primary key(학생번호)
);

-- <insert에서 속성이 없는 경우>
-- 속성 순서에 맞게 값 입력
-- 정수가 들어가야 하는 곳에 ''로 해도 ''안에 정수만 있으면 가능
insert into 학생 values('2', '임꺽정');
-- 속성 순서가 맞지 않아서 오류 발생
-- insert into 학생 values('이순신', 3);

-- <insert에서 속성이 있는경우>
insert 학생(학생번호, 이름) values(3, '이순신');
-- 속성을 입력해줬기 때문에 순서가 바뀌어도 데이터가 삽입됨
insert 학생(이름, 학생번호) values('유관순', 4);
-- 학생 번호가 없지만 auto_increment를 통해 다음 숫자가 자동으로 입력
insert 학생(이름) values('고길동');
-- default 값이 없어서 null이 들어가는데 이름이 not null이라서 오류 발생
-- insert 학생(학생번호) values(6);

SELECT * FROM 학교.학생;