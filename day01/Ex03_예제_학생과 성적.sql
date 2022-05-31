-- <DDL> create, alter, drop
drop database if exists score;
create database if not exists score;
use score;

drop table if exists 학생;
create table if not exists 학생 (
	-- AUTO_INCREAMENT는 기본키에만 설정할 수 있음 -> 대리키에서 주로 사용
	학생번호 	int, 
    학년		int 	not	null 	default 1,
	반 		int 	not null 	default 1,
    번호 	int 	not null 	default 1,
    이름 	char(6),
    primary key(학생번호)
);

drop table if exists 성적;
create table if not exists 성적(
	성적번호 	int,
    학년 	int 	not null 	default 1,
    학기 	int 	not null 	default 1,
    과목명 	char(6),
    primary key(성적번호)
);

drop table if exists 보유;
create table if not exists 보유 (
	보유번호 	int,
    중간 	int 	not null 	default 0,
    기말 	int 	not null 	default 0,
    수행 	int 	not null 	default 0,
    학생번호 	int 	not null,
    성적번호 	int 	not null,
    primary key(보유번호),
    -- foreign key(학생번호) references 학생(학생번호), -- 외래키 설정
	-- foreign key(성적번호) references 성적(성적번호),
	
    check(중간 >= 0 && 중간 <= 100), -- 값의 범위 제한
    check(기말 >= 0 && 기말 <= 100),
    check(수행 >= 0 && 수행 <= 100)
);
/* auto_increment는 기본키로 지정된 속성에 설정하는 키워드이기 때문에,
	테이블을 생성 후 alter를 이용하여 변경 */
alter table 학생
	change 학생번호 학생번호 int auto_increment;
alter table 성적
	change 성적번호 성적번호 int auto_increment;
alter table 보유
	change 보유번호 보유번호 int auto_increment;
    
/* 외래키로 지정된 기본키의 옵션을 수정할 수 없기 때문에
	각 기본키를 auto_increment로 설정 후 외래키 지정 */
alter table 보유
	add foreign key(학생번호) references 학생(학생번호);
alter table 보유
	add foreign key(성적번호) references 성적(성적번호);

-- <DML> insert, update, delete
-- 학생정보 추가
insert 학생(학년,반,번호,이름) values(1, 1, 1, '홍길동'), (1, 1, 2, '임꺽정');

-- 성적 추가(1학년 1반 1번 학생)
insert 성적(학년, 학기, 과목명) values(1, 1, '국어');
insert 보유(중간, 기말, 수행, 학생번호, 성적번호) values(100, 90, 80, 1, 1); 

-- 성적 추가(1학년 1반 2번 학생)
insert 보유(학생번호, 성적번호, 중간, 기말, 수행) values(2, 1, 80, 85, 89);

-- 성적 추가(1학년 1반 3번 학생)
insert 학생(학년, 반, 번호, 이름) values(1, 1, 3, '이순신');
insert 성적(학년, 학기, 과목명) values(1, 1, '수학');
insert 보유(학생번호, 성적번호, 중간, 기말, 수행) values(3, 2, 70, 90, 100);

-- 1학년 1반 1번 학생의 이름을 고길동으로 수정하는 쿼리
update 학생
	set 
		이름 = '고길동'
	where 학년 = 1 and 반 = 1 and 번호 = 1;

-- 보유 테이블에 총점 속성 추가하는 쿼리
alter table 보유
	add 총점 int not null default 0;
    
-- 중간 40 기말 50 수행 10를 반영한 점수를 총점에 수정하는 쿼리
update 보유
	set
		총점 = 중간*0.4 + 기말*0.5 + 수행*0.1;
        
-- 1학년 1반 1번 학생의 1학년 1학기 국어 성적 삭제
delete from 보유 where 학생번호 = 1 and 성적번호 = 1;