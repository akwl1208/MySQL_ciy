-- green이라는 데이터베이스 생성
-- 여러 번 실행하면 두 번째부터 에러 발생(이미 만들었기 때문에)
create database green;
-- green이라는 데이터베이스가 없으면 데이터베이스를 생성
-- 여러 번 실행해도 에러가 발생하지 않음
create database if not exists green;

-- green 데이터베이스를 제거
-- 여러 번 실행하면 두 번째부터 에러 발생(이미 삭제했기 때문에)
drop database green;
-- green 데이터베이스가 있으면 제거
-- 여러 번 실행해도 에러가 발생하지 않음
drop database if exists green; 
