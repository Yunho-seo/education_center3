# 부서를 관리하는 테이블
# 데이터베이스 명령어
# DML (Data Manipulation Language)   : select, insert into, update set, delete from
# DDL (Data Definition Language)     : create, drop(테이블 자체를 삭제), alter
# DCL (Data Control Language)        : grant(권한 부여), revoke(권한 회수)
# TCL (Transaction Control Language) : commit, rollback

# Transaction 대상
# -> insert into, update set, delete FROM은 테이블에 영향을 미침
#    여러 명령어를 그룹으로 처리하고자 할 때
# SELECT은 영향을 미치지 않음

CREATE TABLE dept(	# 부서 정보
	DEPTNO TINYINT PRIMARY KEY,	# 1바이트 : 256가지 경우의수, 부서 번호
	DNAME VARCHAR(14),				# 부서 이름
	LOC VARCHAR(13)					# 위치
);

# KEY를 이용하여 두개의 테이블을 연결
# 데이터베이스는 검색이 우선 (중복 데이터가 있으면 안된다)
# 데이터를 유일하게 구분할 수 있는 데이터 : 키(KEY)
# Foreign key는 참조하는 곳에 있는 데이터 범위 내의 것이어야 한다
CREATE TABLE EMP(		# Employee 직원 정보
	ENPNO SMALLINT PRIMARY KEY,	# 2바이트(-32768 ~ 32767)
	ENAME VARCHAR(10),	# 이름
	JOB VARCHAR(9),		# 업무
	MGR SMALLINT,			# 관리자
	HIREDATE DATE,			# 입사일 : 날짜(숫자, 문자, 날짜) - 입출력할때는 문자열, 입력된 문자열은 날짜형으로 변환되어야 한다, 이후 숫자연산이 필요
	SAL FLOAT,				# 봉급
	COMM FLOAT,				# Commission
	DEPTNO TINYINT,		# 부서 번호
	foreign key(DEPTNO) references DEPT(DEPTNO)	# DEPT 테이블의 DEPTNO를 참조한다.
);
SELECT * FROM emp;

CREATE TABLE BONUS(
	ENAME VARCHAR(10),
	JOB VARCHAR(9),
	SAL INT,
	COMM INT
);

CREATE TABLE SALGRADE(
	GRADE TINYINT,
	LOSAL SMALLINT,
	HISAL SMALLINT
);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


# 포맷(Format) 문자열 (ex. %s, %i)
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,STR_TO_DATE('17-12-1980','%d-%m-%Y'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,STR_TO_DATE('20-2-1981','%d-%m-%Y'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,STR_TO_DATE('22-2-1981','%d-%m-%Y'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,STR_TO_DATE('2-4-1981','%d-%m-%Y'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,STR_TO_DATE('28-9-1981','%d-%m-%Y'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,STR_TO_DATE('1-5-1981','%d-%m-%Y'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,STR_TO_DATE('9-6-1981','%d-%m-%Y'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,STR_TO_DATE('1-3-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,STR_TO_DATE('17-11-1981','%d-%m-%Y'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,STR_TO_DATE('8-9-1981','%d-%m-%Y'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,STR_TO_DATE('1-5-1981','%d-%m-%Y'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,STR_TO_DATE('3-12-1981','%d-%m-%Y'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,STR_TO_DATE('3-12-1981','%d-%m-%Y'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,STR_TO_DATE('23-1-1982','%d-%m-%Y'),1300,NULL,10);
INSERT INTO EMP VALUES
(7935,'SUNG','CLERK',7782,STR_TO_DATE('14-11-1981','%d-%m-%Y'),1500,NULL,40);	


# 급여 등급
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);


SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM salgrade;

# select 필드 from 테이블 where 조건
# group by : 그룹으로 묶어서 처리 - excel에 있는 기능
# order by : 정렬
# Limit : 개수 제한

# emp 테이블에서 사원번호, 사원이름, 직업을 출력하기
SELECT ENPNO, ENAME, JOB FROM EMP;

# emp 테이블에서 사원번호, 급여, 부서번호를 출력
# 단 급여가 많은 순서대로 출력할 것
SELECT ENPNO, SAL, DEPTNO FROM EMP ORDER BY SAL DESC;		# descending : 내림차순, 디폴트값이 ASC

# 위의 정렬순서를 급여가 작은 순서대로 출력
SELECT ENPNO, SAL, DEPTNO FROM emp ORDER BY SAL ASC;

# emp 테이블에서 직업, 급여 출력하기
# 단 직업명은 오름차순으로, 급여는 내림차순으로 정렬
SELECT JOB AS '직업', SAL AS '급여' FROM EMP ORDER BY JOB ASC, SAL DESC;

# 산술연산자 (+, -, *, /) 사용 가능
# emp 테이블에서 부서번호가 10번인 사원들의 급여를 출력하되 10% 인상된 급여로 출력
SELECT SAL * 1.1 FROM emp WHERE DEPTNO = 10;

# 관계연산자 (>, >=, =, <, <=)
# emp 테이블에서 급여가 3000 이상인 사원들의 모든 정보를 출력
SELECT * FROM emp WHERE SAL >= 3000;

# 연습문제 1 : 부서번호가 30번이 아닌 사람들의 이름과 부서번호를 출력
SELECT ENAME, DEPTNO FROM emp WHERE DEPTNO != 30;

# 논리 연산자 (AND, OR, NOT)
# emp 테이블에서 부서번호가 10번이고, 급여가 3000 이상인 사원의 이름과 급여를 출력
SELECT ENAME, SAL FROM emp WHERE DEPTNO = 10 AND SAL >= 3000;

# 연습문제 2 : emp 테이블에서 직업이 salesman 이거나 manager인 사원의 사원번호와 부서번호 출력
SELECT ENPNO, DEPTNO FROM emp WHERE JOB = 'salesman' OR JOB = 'manager';

# 연산 (IN, Between, like, is null, is not null)
# IN 연산자
# 부서번호가 10번이거나, 20번인 사원의 사원번호와 이름, 부서번호를 출력
SELECT ENPNO, ENAME, DEPTNO FROM emp WHERE DEPTNO = 10 OR DEPTNO = 20;
SELECT ENPNO, ENAME, DEPTNO FROM emp WHERE DEPTNO IN (10, 20);		# 부서번호가 10번 이거나 20번

# between
# 급여가 1000 ~ 2000 사이인 사원들의 사원번호, 이름, 급여를 출력
SELECT ENPNO, ENAME, SAL FROM emp WHERE SAL >= 1000 AND SAL <= 2000;
SELECT ENPNO, ENAME, SAL FROM emp where SAL BETWEEN 1000 AND 2000; 

# 사원 이름이 'FORD'와 'SCOTT' 사이 사원들의 사원번호와 이름을 출력
SELECT ENPNO, ENAME FROM emp WHERE ENAME BETWEEN 'FORD' AND 'SCOTT';

# like 문자열 비교
# 사원 이름이 'J'로 시작하는 사원 이름과 부서 번호를 출력
SELECT ENAME, DEPTNO FROM emp WHERE ENAME LIKE 'J%';

# 'J'를 포함하는 사원 이름과 부서번호를 출력
SELECT ENAME, DEPTNO FROM emp WHERE ENAME LIKE '%J%';

# 사원 이름의 두번째 글자가 'A'인 사원 이름과 급여, 입사일을 출력
SELECT ENAME, SAL, HIREDATE FROM emp WHERE ENAME LIKE '_A%';		# '_'는 한글자에 대응한다

# 사원의 이름이 'ES'로 끝나는 사원의 이름, 급여, 입사일을 출력
SELECT ENAME, SAL, HIREDATE FROM emp WHERE ENAME LIKE '%ES';

# 입사년도가 81년인 사원들의 입사일과 사원번호 출력
SELECT HIREDATE, ENPNO FROM emp WHERE HIREDATE LIKE '1981%';		# if문은 where로 처리.

# is null, is not null 연산자
# 커미션이 null인 사원의 사원이름과 커미션을 출력
SELECT ENAME, COMM FROM emp WHERE COMM IS NULL;
SELECT ENAME, COMM FROM emp WHERE COMM IS NOT NULL;


# concat 함수
SELECT CONCAT(ENAME, '의 직업은 ', JOB, ' 입니다.') FROM emp;

# SELECT는 for문이 없고 규칙을 모든 데이터에 적용하여 결과를 출력

SELECT CHR(65);
SELECT CHR(97);						 # 아스키 코드
SELECT LOWER('HELLO!');				 # 대문자를 소문자로 변환
SELECT UPPER('hello!');				 # 소문자를 대문자로 변환
SELECT LPAD('HI', 10, '*');		 # left padding(충전재)
SELECT LENGTH('국어');				  # 데이터베이스에서는 문자당 3바이트 문자를 사용
SELECT LEFT('abcde', 3);			 # 왼쪽에서 3개 남기기
SELECT RIGHT('abcde', 3);			 # 오른쪽에서 3개 남기기
SELECT SUBSTRING('abcde', 2, 2);	 # 두번째 글자에서 2개만 남기기
SELECT FORMAT(12345.23456789, 1); # 소수점 한 자리만 출력
SELECT ENAME, NVL(COMM, 0) FROM emp;	# NVL : comm 필드를 출력하는데, 만약 null일 경우 0으로 출력
SELECT ABS(-10);						 # 절대값으로 출력(absolute)
SELECT CEIL(3.1234);					 # 올림
SELECT FLOOR(3.2241);				 # 내림
SELECT ROUND(3.22645, 2);			 # 둘째 자리로 반올림
SELECT MOD(10, 3);					 # 나누기
SELECT TRUNCATE(11111.23456789, 3); 	# 소수점 셋째 자리에서 잘라내어 출력
SELECT CURDATE();						 # 현재 날짜 출력 (current date)
SELECT DATE(CURDATE());
SELECT CURTIME();						 # 현재 시간 출력 (current time)
# 날짜 빼기 연산
SELECT DATE_SUB('2016-02-08', INTERVAL 60 DAY);						# 2016-02-08로부터 60일 빼기(이전)
SELECT DATEDIFF('2016-01-01 23:59:59', '2016-01-03'); 			# 날짜 차이
SELECT DATE_ADD('2016-01-04 23:59:59', INTERVAL 22 SECOND);		# 시간 더하기(22초)
SELECT EXTRACT(YEAR FROM '2016-01-08');								# 년도 출력
SELECT NOW();							 # 현재 날짜와 시간을 출력
SELECT DATE_FORMAT('2016-01-09 20:20:00', '%W %M %Y');			# 날짜 영어표기, Week, Month, Year
# 두 데이터의 주어진 단위 시간차
SELECT TIMESTAMPDIFF(HOUR, '2018-03-01', '2018-03-28');			# 시간(hour) 차이
SELECT COUNT(ENAME) FROM emp;		 	# 행(column) 수를 카운트
SELECT SUM(SAL) FROM emp;			 	# 급여(sal)의 모든 합계를 출력
SELECT AVG(SAL) FROM emp;			 	# 급여의 평균
SELECT AVG(NVL(COMM, 0)) FROM emp;	# NULL을 0으로 두었을 때 급여의 평균
SELECT MAX(SAL) FROM emp;				# 급여의 최대값
SELECT MIN(SAL) FROM emp;				# 급여의 최소값

# group by  부서별 : 집계 대상이 되는 필드나 집계 함수가 사용
SELECT DEPTNO, SUM(SAL) FROM emp GROUP BY DEPTNO;									# 부서별로 급여의 합계를 집계
SELECT DEPTNO, SUM(SAL), MAX(SAL), MIN(SAL) FROM emp GROUP BY DEPTNO;		# 부서별 급여의 합계와 최대급여, 최소급여 출력

# 연습문제 3 : 부서별로 평균 급여 출력 (반올림하여 소수점 첫째 자리까지만 출력)
SELECT DEPTNO, round(AVG(SAL), 1)  FROM emp GROUP BY DEPTNO;

# 연습문제 4 : 직업별로 최대 급여를 출력
SELECT JOB, MAX(SAL) FROM emp GROUP BY JOB;			# job이 중복 - 범주형 데이터

# 연습문제 5 : 급여가 1000 이상인 사원들의 부서별 평균 급여와 반올림값을 부서번호로 내림차순 정렬하여 출력
SELECT DEPTNO, ROUND(AVG(SAL), 1) FROM emp WHERE SAL >= 1000 GROUP BY DEPTNO order by DEPTNO desc;

# 위 문제에서 평균 급여로 오름차순 정렬하여 출력
SELECT DEPTNO, ROUND(AVG(SAL), 1) FROM emp WHERE SAL >= 1000 GROUP BY DEPTNO order by round(avg(SAL), 1) ASC;

# 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무, 인원수를
# 부서번호에 대하여 오름차순 정렬하여 출력
SELECT DEPTNO, JOB, COUNT(*) FROM emp GROUP BY DEPTNO, JOB ORDER BY DEPTNO ASC;

# having 절을 이용한 그룹 제한 - group by를 한 결과에 대한 조건 (having)
# 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력, 단 부서별 평균 급여가 2000 이상인 부서만 출력
SELECT DEPTNO, AVG(SAL) FROM emp WHERE SAL >= 1000 GROUP BY DEPTNO HAVING AVG(sal) >= 2000;

# join
# emp 테이블의 모든 사원 이름, 부서번호, 부서명을 출력
SELECT ENAME, dept.DEPTNO, DNAME FROM emp, dept WHERE emp.deptno = dept.deptno;
# 별칭으로 처리한다면
SELECT e.ENAME, e.DEPTNO, d.DNAME FROM emp e, dept d WHERE e.deptno = d.deptno;
SELECT ENAME, e.DEPTNO, DNAME FROM emp e JOIN dept d ON e.deptno = d.deptno;		# Join 연산은, ON이 조건절


# 급여가 3000에서 5000 사이의 사원 이름과, 부서명을 출력
# SELECT e.ENAME, d.DNAME FROM emp e, dept d WHERE e.SAL BETWEEN 3000 AND 5000;
SELECT ename, dname, FROM emp em, dept d WHERE e.deptno = d.DEPTNO
															  AND (sal >= 3000 AND sal <= 5000);
															  
# 부서명이 'ACCOUNTING'인 사원의 이름, 입사일, 부서번호, 부서명 출력
# SELECT e.ENAME, e.HIREDATE, d.DEPTNO, d.DNAME FROM emp e, dept d WHERE d.DNAME = 'ACCOUNTING';
SELECT ename, hiredate, e.dateno, dname FROM emp e, dapt d WHERE e.deptno = d.deptno AND dname='ACCOUNTING';

# 커미션이 null이 아닌 사원의 이름, 입사일, 부서명 출력
# SELECT e.ENAME, e.HIREDATE, d.DNAME FROM emp e, dept d WHERE e.COMM IS NOT NULL;
SELECT e.ename, e.hiredate, d.dname FROM emp e, dept d WHERE e.DEPTNO = d.DEPTNO AND e.COMM IS NOT NULL;


# mariadb가 동작중임을 확인(service program으로 작성 : 상시대기)
SELECT * FROM emp;

# emp 테이블과 dept 테이블을 조인하여 부서번호, 부서명, 이름, 급여를 출력
# SELECT d.deptno, d.dname, e.ename, e.sal FROM emp e, dept d WHERE e.DEPTNO = d.deptno;
SELECT d.deptno, d.dname, e.ename, e.sal FROM emp e JOIN dept d ON e.deptno = d.deptno;

# 사원의 이름이 'ALLEN'인 사원의 부서명을 출력
# SELECT e.ENAME, d.dname FROM emp e JOIN dept d ON e.deptno = d.deptno WHERE ename = 'ALLEN';
# inner join (두 테이블에 모두 일치하는 데이터가 있어야 함)
SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'ALLEN';

# 모든 사원의 이름, 부서번호, 부서명, 급여를 출력. 단, dept 테이블에 없는 부서도 출력
# 두개의 테이블 조인 시 좌측의 데이터를 기준으로 출력 (left join)
# 두개의 테이블 조인 시 우측의 데이터를 기준으로 출력 (right join)
SELECT e.ename, d.deptno, d.dname, e.sal FROM emp e LEFT JOIN dept d ON e.deptno = d.deptno;

# 사원의 이름과 급여, 급여의 등급을 출력
SELECT * FROM salgrade;
SELECT e.ename, e.sal, s.grade FROM emp e, salgrade s WHERE sal BETWEEN losal AND hisal;

# 사원의 이름과 부서명, 급여의 등급을 출력
# emp, dept, salgrade
#SELECT e.ename, d.dname, s.grade FROM emp e, dept d, salgrade s WHERE e.deptno = d.DEPTNO AND sal BETWEEN losal AND hisal;
SELECT e.ename, d.dname, s.grade FROM emp e, dept d, salgrade s WHERE e.DEPTNO = d.DEPTNO AND e.sal BETWEEN s.losal AND s.hisal;


# 서브쿼리(subquery) : select 안의 select문
# 결과가 하나인 경우(단일형 서브쿼리), 결과가 여러개(복수)인 경우(복수형 서브쿼리)(in, all, any, exist : 다중행 연산자)

# 'SMITH'가 근무하는 부서명을 서브쿼리를 이용하여 출력
SELECT dname FROM dept WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH');

# 'ALLEN'과 같은 부서에 근무하는 사원의 이름과 부서번호를 출력
SELECT ename, deptno FROM emp e WHERE deptno = (SELECT deptno FROM emp WHERE ename = 'ALLEN');

# 연습문제 6 : 'ALLEN'과 같은 직책을 가진 사원의 사원번호와 이름, 직책을 출력
SELECT enpno, ename, job from emp WHERE job = (SELECT job FROM emp WHERE ename = 'ALLEN');

# 'ALLEN'의 급여와 동일하게 받거나 더 많이 받는 사원의 이름과 급여를 출력
SELECT ename, sal FROM emp WHERE sal >= (SELECT sal FROM emp WHERE ename = 'ALLEN');

# 'DALLAS'에서 근무하는 사원의 이름, 부서번호를 출력
SELECT * FROM dept;
SELECT ename, deptno FROM emp WHERE deptno = (SELECT deptno FROM dept WHERE loc = 'DALLAS');

# 자신의 직속상관이 'KING'인 사원의 이름과 급여를 출력
SELECT ename, sal FROM emp WHERE mgr = (SELECT enpno FROM emp WHERE ename = 'KING');		# enpno가 7839인 사원

# 다중행 서브쿼리
# 급여를 3000 이상 받는 사원이 소속된 부서와 같은 부서에서 근무하는 사원들의 이름과 급여, 부서번호를 출력
SELECT ename, sal, deptno FROM emp WHERE deptno IN (SELECT deptno FROM emp WHERE sal >= 3000);

# 직책이 MANAGER인 사원이 속한 부서의 부서번호, 부서명, 부서의 위치를 출력
SELECT deptno, dname, loc FROM dept WHERE deptno in (SELECT deptno FROM emp WHERE job = 'MANAGER');

# 직책이 SALESMAN보다 급여를 많이 받는 사원들의 이름과 급여를 출력 (??)
SELECT ename, sal FROM emp WHERE sal > (SELECT max(sal) FROM emp WHERE job = 'SALESMAN');
SELECT ename, sal FROM emp WHERE sal > in(SELECT sal FROM emp WHERE job = 'SALESMAN');
SELECT ename, sal FROM emp WHERE sal > ANY(SELECT sal FROM emp WHERE job = 'SALESMAN');

# 연습문제 7 : 부서별로 가장 급여를 많이 받는(max(sal)) 사원의 사원번호, 급여, 부서번호 출력
# group by -- 동일한 경우도 있을 수 있다
# SELECT max(sal) FROM emp GROUP BY deptno;
# 숫자만 출력되어 같이 출력되는 문제가 발생
# 다중형 쿼리에서의 문제
# SELECT enpno, sal, deptno FROM emp WHERE sal in (SELECT max(sal) FROM emp GROUP BY deptno);