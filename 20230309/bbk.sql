-- --------------------------------------------------------
-- 호스트:                          192.168.41.5
-- 서버 버전:                        10.3.28-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- bbk 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `bbk` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `bbk`;

-- 테이블 bbk.buytbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `buytbl` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `userID` char(8) DEFAULT NULL,
  `prodName` varchar(20) DEFAULT NULL,
  `groupName` varchar(20) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `userID` (`userID`),
  CONSTRAINT `FK__usertbl` FOREIGN KEY (`userID`) REFERENCES `usertbl` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 bbk.buytbl:~12 rows (대략적) 내보내기
INSERT INTO `buytbl` (`num`, `userID`, `prodName`, `groupName`, `price`, `amount`) VALUES
	(1, 'KBS', '운동화', '의류', 30, 2),
	(2, 'KBS', '노트북', '전자', 1000, 1),
	(3, 'JYP', '모니터', '전자', 200, 1),
	(4, 'BBK', '모니터', '전자', 200, 5),
	(5, 'KBS', '청바지', '의류', 50, 3),
	(6, 'BBK', '메모리', '전자', 80, 10),
	(7, 'SSK', '책', '서적', 15, 5),
	(8, 'EJW', '책', '서적', 15, 2),
	(9, 'EJW', '청바지', '의류', 50, 1),
	(10, 'BBK', '운동화', '의류', 30, 2),
	(11, 'EJW', '책', '서적', 15, 1),
	(12, 'BBK', '운동화', '의류', 30, 2);

-- 테이블 bbk.usertbl 구조 내보내기
CREATE TABLE IF NOT EXISTS `usertbl` (
  `userID` char(8) NOT NULL,
  `name` varchar(50) NOT NULL,
  `birthYear` int(11) NOT NULL,
  `addr` varchar(50) NOT NULL,
  `mobile1` char(3) DEFAULT NULL,
  `mobile2` char(8) DEFAULT NULL,
  `height` smallint(6) DEFAULT NULL,
  `mDate` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 테이블 데이터 bbk.usertbl:~10 rows (대략적) 내보내기
INSERT INTO `usertbl` (`userID`, `name`, `birthYear`, `addr`, `mobile1`, `mobile2`, `height`, `mDate`) VALUES
	('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-05-05'),
	('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-03-03'),
	('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10'),
	('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-04-04'),
	('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-04-04'),
	('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-07-07'),
	('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-09-09'),
	('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-08-08'),
	('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12'),
	('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-05-05');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
