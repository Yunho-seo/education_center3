# 부서번호가 10번인 사원에 대한 정보를 출력
select * from emp where deptno = 10;

# 급여가 2000 이상인 사람 출력
select * from emp where sal >= 2000;

# hiredate가 '1982/01/01' 보다 큰 사원의 ename, hiredate를 출력
select ename, hiredate from emp where hiredate > '1982/01/01';

# 사원 이름이 SCOTT인 사원의 사원번호, 사원이름, 급여를 출력
select empno, ename, sal from emp where ename='SCOTT';

# Job이 'CLERK'이고 부서번호가 10인 직원을 출력
select * from emp where job='CLERK' and deptno=10;

# 입사일이 '1982/01/01'일 이후 이거나 job이 'MANAGER'인 직원을 출력
select * from emp where hiredate>'1982/01/01' or job='MANAGER';

# 부서번호가 10이 아닌 직원을 출력
select * from emp where deptno <> 10;

# 급여가 2000에서 3000 사이 급여를 받는 사원 출력
select ename from emp where sal between 2000 and 3000;
select * from emp where sal between 2000 and 3000;

# 커미션이 300이거나 500이거나 1400인 사원 출력
select * from emp where comm=300 or comm=500 or comm=1400;
select * from emp where comm in(300, 500, 1400);

# 7521이거나 7654이거나 7844인 사원들의 사원번호와 급여를 검색하는 쿼리문 작성 (비교연산자와 OR 연산자 작성)
select empno, sal from emp where empno=7521 or empno=7654 or empno=7844;

# 1987년에 입사한 사원을 BETWEEN AND 연산자를 이용하여 출력
select ename from emp where between '1987/1/1' and '1987/12/31';

# 커미션이 300이 아니거나 500이 아니거나 1400이 아닌 사원 출력
select * from emp where comm!=300 and comm!=500 and comm!=1400;
select * from emp where comm not in(300, 500, 1400);

# 사원테이블의 사원들 중 커미션을 받는 사원수를 출력
select count(comm) from emp;

# 직업의 종류 개수, 즉 중복되지 않는 직업의 개수를 카운트하여 출력
select count(distinct job) from emp;        -- 범주형 데이터 -> 종류

select * from dept;
select * from emp;

# 부서별 평균 급여를 출력
select deptno, avg(sal) from emp group by deptno;

# 소속 부서별 최대급여와 최소급여를 출력
select deptno, max(sal), min(sal) from emp group by deptno;

# 업무별로 그룹화하여 업무, 인원수, 평균급여, 최고 급여액, 최저 급여액 및 합계를 출력
select job, count(job), avg(sal), max(sal), min(sal), sum(sal) from emp group by job;
select job, count(*) as 인원수, avg(sal), max(sal), min(sal), sum(sal) from emp group by job;

# 문제 : 1000 이상의 급여를 가지고있는 사람들에 대해서만 부서별로 평균을 구한 후 구해진
#       부서별 평균급여가 2000 이상인 부서번호와 부서별 평균 급여를 출력
select deptno, avg(sal) from emp where sal>1000 group by deptno having avg(sal) >= 2000;

# 부서별 급여의 최대값과 최소값을 구하되 최대급여가 2900 이상인 부서만 출력
select deptno, max(sal), min(sal) from emp group by deptno having max(sal) >= 2900;

# 전체 월급이 5000을 초과하는 각 업무에 대해서 업무와 월급여 합계를 출력
# (단 판매원은 제외하고 월 급여 합계로 내림차순 정렬)
-- 집합연산
select job, sum(sal) from emp where job not in('SALESMAN') group by job having sum(sal) > 5000 order by sum(sal) desc;


# 부서별로 가장 급여를 많이받는 사원의 사원번호, 이름, 급여, 부서번호를 출력
# 4개
select empno, ename, sal, deptno from emp where concat(sal, deptno) in(select concat(max(sal), deptno) from emp group by deptno);      # (deptno 20이 두명 나옴)

# SCOTT와 동일한 직급을 가진 사원을 출력
# "" : 테이블이나 객체를 표현, 문자열을 표현할 때에는 ''
select * from emp where job = (select job from emp where ename = 'SCOTT');

# SCOTT의 급여와 동일하거나 더 많이받는 사원이름과 급여를 출력
SELECT ename, sal FROM emp WHERE sal >= (SELECT sal FROM emp WHERE ename = 'SCOTT');

# 급여가 20부서의 평균 급여보다 크고, 사원을 관리하는 사원으로서 20부서에 속하지 않는 사원 정보를 출력
select * from emp where sal > (select avg(sal) from emp where deptno = 20) and deptno != 20;
select * from emp where sal > (select avg(sal) from emp group by deptno having deptno=20) and empno in (select distinct mgr from emp) and deptno != 20;

# 10번 부서에 근무하는 사원의 이름과 10번 부서의 부서명을 출력
select e.ename, d.dname from emp e, (select deptno, dname from dept where deptno=10) d where e.deptno = d.deptno;

# 사원수가 5명 이상 부서의 부서명과 사원 수를 출력
select d.deptno, count(empno) from emp e join dept d on group by d.deptno=e.deptno having count(empno) >= 5;
select d.dname, count(e.empno) from emp e, dept d where e.deptno=d.deptno
 group by d.dname having count(e.empno) >= 5;

select dname, count(e.empno) from emp e join dept d on e.deptno=d.deptno group by d.dname having count(e.empno)>=5;

# SCOTT인 사람의 부서명을 출력
SELECT e.ename, d.dname FROM emp e, dept d WHERE e.deptno = d.deptno AND e.ename = 'SCOTT';
select dname from emp e, dept d where e.deptno=d.deptno and e.ename='SCOTT';
select dname from emp e join dept d on e.deptno=d.deptno where e.ename='SCOTT';

select round(42.195, 2);    # mariaDB에서는 출력 됨
select round(42.195, 2) from dual;  # 소수점 아래 둘째자리 반올림
select round(42.195, -1) from dual;

# 문제 : emp의 sal을 100으로 나머지 연산
select mod(sal, 100) from emp;

select -10, abs(-10) from dual;         # abs : 절대값
select ename, length(ename) from emp;   # 사원명(ename)의 길이
select lpad('1234', 20, '*') from dual;
select sysdate from dual;               # 오늘 날짜
select sysdate, hiredate, months_between(sysdate, hiredate) from emp;
select hiredate, add_months(hiredate, 6) from emp;
select last_day(hiredate) from emp;     # 입사일의 마지막

# 변환함수 ( mariadb에서는 casting을 사용 )
select ename, to_char(sal, '$999,999') from emp;

# 삼항 연산자 (if(조건, 참, 거짓);
select ename, deptno, decode(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 
                     'SALES', 40, 'OPERATIONS') from emp;
select ename, deptno,
    case when deptno=10 then 'ACCOUNTING'
         when deptno=20 then 'RESEARCH'
         when deptno=30 then 'SALES'
         when deptno=40 then 'OPERATIONS'
     end case
from emp;

# 연습문제 : JOB별로 Bonus를 급여의 1.5, 1.6, 1.7, 1.8배 등으로 주려고 한다.
# JOB의 종류를 확인하고 JOB을 오름차순으로 정렬하여 1.5배를 기준으로 0.1씩 증가하면서 계산된 보너스를 출력
select distinct job from emp order by job;
select ename, deptno, 
    case when job= 'ANALYST'   then sal*1.5
         when job= 'CLERK'     then sal*1.6
         when job= 'MANAGER'   then sal*1.7
         when job= 'PRESIDENT' then sal*1.8
         when job= 'SALESMAN'  then sal*1.9
    end as 보너스급여
from emp order by job;


# 테이블 생성
# 테이블과 제약조건 : constraint를 붙이는 경우 반드시 이름이 있어야 함
create table dept2(
    deptno number constraint dept_pk_deptno primary key, -- 자동 부여
    dname varchar2(40),
    loc varchar2(50)
);
select * from dept2;
drop table dept2;

insert into dept2 values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept2 values(20, 'RESERCH', 'DALLAS');
insert into dept2 values(30, 'SALES', 'CHICAGO');
insert into dept2 values(40, 'OPERATIONS', 'BOSTON');

create table emp10(
    empno number(4)     constraint emp10_empno_pk primary key,
    ename varchar2(10)  constraint emp10_ename_nn not null,
    sal number(7,2)     constraint emp10_sal_ck check(sal between 500 and 5000),
    gender varchar2(1)  constraint emp10_gender_ck check (gender in('M', 'F'))
);
select * from emp10;
drop table emp10;

insert into emp10(empno, ename, sal, gender) values (123, '프로남', 1000, 'M');
insert into emp10(empno, ename, sal, gender) values (124, '여주연', 6000, 'F');
insert into emp10(empno, ename, sal, gender) values (125, '성공남', 1000, 'M');

alter table emp10 drop constraint emp10_sal_ck;

# 제약조건 수정
alter table emp10 add constraint emp10_sal_ck check (sal>=500 and sal<=7000);

select count(*) from emp10;
insert into emp10 values(null, null, 'SALESMAN', 101);      # ename이 NOT NULL이라 삽입 불가
insert into emp10 values(null, '성공남', 'SALESMAN', 101);   # primary key는 중복 X, NULL 허용 X
                                                            # Unique key는 중복 X, NULL 허용

# 문제 : mariadb에서 했던 school과 sungjuk 테이블을 생성하기
# primary / foreign key로 연결
create table school(
    no number(4) constraint school_no_nn NOT NULL,
    schoolname varchar2(50),
    address varchar2(50),
    schoolcode char(10) constraint school_schoolcode_pk primary key,
    studentcount number(4)
);
select * from school;
drop table school;


create table sungjuk(
    no number(3) constraint sungjuk_no_pk primary key,
    name varchar2(20) not null,
    kor number(3) constraint sungjuk_kor_ck check(kor between 0 and 100),
    mat number(3) constraint sungjuk_mat_ck check(mat between 0 and 100),
    eng number(3) constraint sungjuk_eng_ck check(eng between 0 and 100),
    total number(4),
    average number(5, 2),
    grade char(1),
    schoolcode char(10) constraint sungjuk_schoolcode_fk references school(schoolcode)
);
select * from sungjuk;
drop table sungjuk;

create sequence school_no_seq increment by 1 start with 1;
create sequence student_no_seq increment by 1 start with 1;
-- query에서 번호를 증가시켜가면서 입력을 해야 한다.

INSERT INTO school(no, schoolname, address, schoolcode, studentcount) 
    VALUES(school_no_seq.NEXTVAL, '충주여자고등학교', '충주시', 'CH00000001', 360);
INSERT INTO school(no, schoolname, address, schoolcode, studentcount)
    VALUES(school_no_seq.NEXTVAL, '서울여자고등학교', '서울시', 'SE00000001', 1200);
INSERT INTO school(no, schoolname, address, schoolcode, studentcount) 
    VALUES(school_no_seq.NEXTVAL, '대전고등학교', '대전시', 'IC00000001', 560);

INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '김만덕', 100, 99, 99, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '고려인', 100, 99, 99, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '전공인', 81, 81, 81, 'SE00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '전공이', 81, 81, 81, 'SE00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '전공삼', 91, 100, 100, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '전공사', 100, 100, 100, 'CH00000001');
INSERT INTO sungjuk(no, NAME, kor, mat, eng, schoolcode) 
    VALUES(student_no_seq.nextval, '종로구', 100, 81, 71, 'IC00000001');



# 이름이 전공인인 학생의 학교, 번, 학생이름, 총점, 평균 출력
select s.schoolname, sj.no, sj.name, sj.kor+sj.mat+sj.eng as 총점, round((sj.kor+sj.mat+sj.eng)/3, 2) as 평균
 from school s join sungjuk sj on s.schoolcode=sj.schoolcode where sj.name='전공인';

# 성적이 최우수인 학생의 정보 출력
select * from school s join sungjuk sj on s.schoolcode=sj.schoolcode 
    where sj.kor+sj.mat+sj.eng = (select max(kor+mat+eng) from sungjuk);

# 학교별 학생수와 평균점수를 출력
select s.schoolname, count(sj.no) as 학생수, round(avg(sj.kor+sj.mat+sj.eng), 2) as 평균점수
    from school s join sungjuk sj on s.schoolcode = sj.schoolcode group by s.schoolname;

# 학교별 우수한 학생을 한명씩 선정하여 이름, 총점, 학교 이름 출력
select sj.name, sj.kor+sj.mat+sj.eng as 총점, s.schoolname 
    from school s, sungjuk sj 
    where s.schoolcode=sj.schoolcode and (sj.kor+sj.mat+sj.eng) in (select max(kor+mat+eng) from sungjuk group by schoolcode);
