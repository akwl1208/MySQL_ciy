-- <self join>
use green;

CREATE TABLE `green`.`직원` (
  `사번` INT NOT NULL AUTO_INCREMENT,
  `이름` VARCHAR(45) NULL,
  `직급` VARCHAR(45) NULL,
  `직속상사` INT NULL,
  PRIMARY KEY (`사번`));
  
ALTER TABLE `green`.`직원` 
ADD INDEX `직속상사_idx` (`직속상사` ASC) VISIBLE;

ALTER TABLE `green`.`직원` 
ADD CONSTRAINT `직속상사`
  FOREIGN KEY (`직속상사`)
  REFERENCES `green`.`직원` (`사번`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
INSERT INTO `green`.`직원` (`이름`, `직급`) VALUES ('홍길동', '대표이사');
INSERT INTO `green`.`직원` (`이름`, `직급`) VALUES ('임꺽정', '이사');
INSERT INTO `green`.`직원` (`이름`, `직급`) VALUES ('유관순', '과장');
INSERT INTO `green`.`직원` (`이름`, `직급`) VALUES ('이순신', '대리');
INSERT INTO `green`.`직원` (`이름`, `직급`) VALUES ('고길동', '사원');

UPDATE `green`.`직원` SET `직속상사` = '1' WHERE (`사번` = '2');
UPDATE `green`.`직원` SET `직속상사` = '2' WHERE (`사번` = '3');
UPDATE `green`.`직원` SET `직속상사` = '3' WHERE (`사번` = '4');
UPDATE `green`.`직원` SET `직속상사` = '4' WHERE (`사번` = '5');

SELECT 직원.이름, 직원.직급, 직속상사.이름 as 직속상사 FROM 직원
	left join 직원 as 직속상사 on 직속상사.사번 = 직원.직속상사;
    




