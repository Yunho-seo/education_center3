INSERT INTO usertbl VALUES ('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES ('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES ('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES ('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES ('SSK', '성시경', 1979, '서울',  NULL,  NULL,     186, '2013-12-12');
INSERT INTO usertbl VALUES ('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES ('YJS', '윤종신', 1969, '경남',  NULL,  NULL,     170, '2005-5-5');
INSERT INTO usertbl VALUES ('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES ('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES ('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
SELECT * FROM usertbl;

INSERT INTO buytbl(userID, prodName, groupName, price, amount) VALUES
    ('KBS', '운동화', '의류', 30,   2),
    ('KBS', '노트북', '전자', 1000, 1),
    ('JYP', '모니터', '전자', 200,  1),
    ('BBK', '모니터', '전자', 200,  5),
    ('KBS', '청바지', '의류', 50,   3),
    ('BBK', '메모리', '전자', 80,  10),
    ('SSK', '책'    , '서적', 15,   5),
    ('EJW', '책'    , '서적', 15,   2),
    ('EJW', '청바지', '의류', 50,   1),
    ('BBK', '운동화', '의류', 30,   2),
    ('EJW', '책'    , '서적', 15,   1),
    ('BBK', '운동화', '의류', 30,   2);
SELECT * FROM buytbl;

SELECT * FROM usertbl;
SELECT * FROM buytbl;
# 문제 )
- 1) BBK가 구매한 데이터를 출력
SELECT * FROM buytbl WHERE userID='BBK';

- 2) 김씨인 사람 중 이름과 키를 기준으로, 이름, 키, 주소를 내림차순으로 출력
	  ( 이름 뒤에 '님'을 붙여서 출력)
SELECT concat(NAME, '님') AS NAME, height, addr FROM usertbl where name LIKE '김%' ORDER BY NAME, height, addr desc;

- 3) USER  출생년도별 오름차순으로 이름, 주소, 키, 출생년도를 출력 (이름은 성 빼고 출력)
SELECT substr(name, 2, 2) as NAME, addr, height, birthYear FROM usertbl ORDER by birthYear;

- 4) 모바일 번호가 011로 시작하는 사람이 몇명인지 출력
SELECT COUNT(*) FROM usertbl WHERE mobile1 = '011';

- 5) 출생년도가 1960년도에서 1979년까지 태어난 사람들이 구매한 품목을 출력
SELECT bu.prodName FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID WHERE birthYear BETWEEN 1960 AND 1979;

- 6) userID별로 구매한 price와 amount의 합계를 출력 (이때 userID는 NAME 으로 출력)
SELECT us.NAME AS "이름", SUM(bu.price) AS "가격합계", SUM(bu.amount) AS "수량합계" FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID GROUP BY us.userID;

- 7) 주소가 서울인 사람이 구매한 총액을 구하기
SELECT SUM(price*amount) AS "판매금액" FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID WHERE addr='서울';

- 8) 품목별 판매 총액을 출력
SELECT prodName AS "품목", SUM(price*amount) AS "판매총액" FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID GROUP BY prodName;

- 9) 출생년도가 1970년도 이상인 사람들을 대상으로 구매한 개수가 2개 이상인 것의 판매 총합계 구하기
SELECT SUM(price*amount) FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID WHERE us.birthYear >= 1970 AND bu.amount >= 2;

- 10) 모든 유저 출력 (이름 중 김씨와 조씨는 모두 컬씨로 바꾸어 출력)
SELECT if(LEFT(NAME,1)='김' OR LEFT(NAME,1)='조', concat(REPLACE(LEFT(NAME,1)='김' OR LEFT(NAME,1)='조', 1, '컬'),MID(NAME,2)), NAME) FROM usertbl;

- 11) 책을 구매한 사람의 이름의 출생년도와 주소를 출력
SELECT distinct NAME, birthYear, addr FROM usertbl us JOIN buytbl bu ON us.userID=bu.userID WHERE bu.prodName='책';
