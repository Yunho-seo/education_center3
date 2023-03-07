INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("충주여자고등학교", "충주시", "CH00000001", 360);
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("서울여자고등학교", "서울시", "SE00000001", 1200);
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("대전고등학교", "대전시", "IC00000001", 560);

INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('김만덕', 100, 99, 99, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('고려인', 100, 99, 99, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('천공인', 81, 81, 81, 'SE00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('천공이', 81, 81, 81, 'SE00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('천공삼', 91, 100, 100, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('천공사', 100, 100, 100, 'CH00000001');
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('종로구', 100, 81, 71, 'IC00000001');
		
SELECT * FROM school;
SELECT * FROM student;

# 김만덕을 검색해서 이름 국어 영어 수학 학교코드를 별칭으로 출력
SELECT NAME AS '이름', kor AS '국어', mat '수학', eng '영어', schoolcode '학교코드' FROM student WHERE NAME='김만덕';

# 이름에 천이 들어있는 사람을 모두 출력
SELECT * FROM student WHERE NAME LIKE '천%';
SELECT * FROM student WHERE NAME LIKE '%천%';

# 이름이 3자이면서 가운데 공이 들어간 사람을 출력
SELECT * FROM student WHERE NAME LIKE '_공_';

# 국어, 영어, 수학 점수가 모두 90점 이상인 사람의 이름, 국어, 수학, 영어 점수 출력
SELECT NAME, kor, mat, eng FROM student WHERE kor>=90 AND mat>=90 AND eng>=90;

# 국어, 영어, 수학 점수 중 하나라도 90점 이상인 사람의 이름, 국어, 수학, 영어 점수 출력
SELECT NAME, kor, mat, eng FROM student WHERE kor>=90 OR mat>=90 OR eng>=90;

# 국어 점수가 60점에서 80점 사이인 사람 중 2사람을 출력
SELECT kor FROM student WHERE kor BETWEEN 60 AND 80 LIMIT 2;

# 학생들의 이름 중 중복되는 것을 제외하고 이름만 출력
SELECT distict NAME FROM student;
SELECT COUNT(*) AS '학생수' FROM student;

# 학생들의 이름 뒤 '님'자를 붙여서 출력
SELECT CONCAT(NAME, '님') FROM student;

# 학생들의 이름 뒤 '님'자를 붙이고 각 점수는 10자리의 공간을 확보하고 숫자가 없는 부분은 *을 붙여 출력
SELECT CONCAT(NAME, '님'), LPAD(kor, 10, '*'), LPAD(mat, 10, '*'), LPAD(eng, 10, '*')  FROM student;

# 학생들의 이름 중 성을 빼고 출력
SELECT substring(NAME, 2, 2) FROM student;

# 학생들을 이름(오름차순)과 국어 점수(내림차순)로 정렬하여 출력
SELECT * FROM student ORDER BY NAME ASC, kor DESC;

# 학생의 이름, 평균, 학교 이름을 출력
SELECT NAME, (kor+mat+eng)/3, schoolname FROM student st, school sc WHERE st.schoolcode = sc.schoolcode;

# 학교별로 총점의 합계 구하기
SELECT schoolcode, SUM(kor+mat+eng) AS '학교별총점' FROM student GROUP BY schoolcode;


# 변수를 사용하는 방법
# DB에서 변수는 @을 붙인다, @@가 붙은 변수는 시스템에서 만든 변수
SET @abc = 0;
# 스쿨코드가 @abc로 들어감
SELECT schoolcode INTO @abc FROM school WHERE schoolname="충주여자고등학교";
SELECT NAME, kor, mat, eng FROM student WHERE schoolcode=@abc;
SELECT @abc;

# 데이터 백업
CREATE TABLE if NOT EXISTS student_backup AS SELECT * FROM student;
SELECT * FROM student_backup;

# 서울여자고등학교 학생들만 se_backup 테이블로 백업하기
CREATE TABLE if NOT EXISTS se_backup AS SELECT * FROM studentschool WHERE schoolcode = (SELECT schoolcade FROM school WHERE shcoolname = "서울여자고등학교");
SELECT * FROM se_backup;

--
SELECT * FROM student;
# 삼항 연산자가 연속으로 사용됨
# if(kor>=90, 'A', 'B');
SELECT NAME, (if(kor>=90, 'A', if(kor>=80, 'B', if(kor>=70, 'C', if(kor>=60, 'D', 'F'))))) FROM student;

# 김만덕의 점수 합계와 평균을 구해서 입력하시오 (update set 문)
UPDATE student SET total = kor+mat+eng, average = round(total/3, 2) WHERE NAME='김만덕';
SELECT * FROM student WHERE NAME='김만덕';

# 김만덕의 grade를 결정하여 입력하기
UPDATE student SET grade = if(average>=90, 'A', if(average>=80, 'B', if(average>=70, 'C', if(average>=60, 'D', 'F')))) WHERE NAME='김만덕';

# 김만덕의 grade를 결정하여 입력하기 (case end문 사용)
UPDATE student SET
	grade = 
	(case when average >= '90' then 'A'
			when (average >= '80' AND average < '90') then 'B'
			when (average >= '70' AND average < '80') then 'C'
			when (average >= '60' AND average < '70') then 'D'
			ELSE 'F'
	 END)
	 WHERE NAME = '고려인';

# 나머지 계산이 안된 학생들의 총점, 평균, 학점을 계산하여 테이블에 입력
UPDATE student SET total = kor+mat+eng, average = round(total/3, 2), grade = if(average>=90, 'A', if(average>=80, 'B', 
												if(average>=70, 'C', if(average>=60, 'D', 'F'))));
# 혹은
UPDATE student SET total = kor+mat+eng, average = round(total/3, 2);
UPDATE student SET
	grade = 
	(case when average >= '90' then 'A'
			when (average >= '80' AND average < '90') then 'B'
			when (average >= '70' AND average < '80') then 'C'
			when (average >= '60' AND average < '70') then 'D'
			ELSE 'F'
	 END) ;
	 
SELECT * FROM student;

# 연습문제 1 : 김만덕의 국어:80, 영어:60 점으로 수정
UPDATE student SET kor = 80, eng = 60 WHERE NAME = '김만덕';
UPDATE student SET total = kor+mat+eng, average = round(total/3, 2), grade = if(average>=90, 'A', if(average>=80, 'B', 
												if(average>=70, 'C', if(average>=60, 'D', 'F')))) WHERE NAME = '김만덕';
												
# 천공인의 점수 바꾸기 (트리거 정의한 이후)
UPDATE student SET kor=100, eng=100 WHERE NAME='천공인';

# 연습문제 2 : 학생 '만세야'의 국어:99, 수학:99, 영어:99으로 입력, 학교코드는 CH00000001
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES('만세야', 80,80,80, 'CH00000001');
# DELETE FROM student WHERE NAME = '만세야';

# 저장 프로시져 호출
SET @result = 0;
CALL school_insert("대전여상", "대전시", "DE00000001", 2000, @result);
SELECT @result;	# 데이터 입력이 잘 됨
SELECT * FROM school WHERE schoolname = "대전여상";

# 사용자 정의 함수 호출
SELECT calc_add(10, 20);
SELECT calc_function(200);


SELECT * FROM student;
SELECT * FROM school;
# 연습문제 3 : 다음은 stored procedure를 이용하여 해결합니다. 그리고 결과를 확인할 것.
# 학교이름 '대전여상'을 '대전여자상업고등학교'로 수정
# UPDATE student SET schoolname = "대전여자상업고등학교" WHERE schoolname = "대전여상";
SET @result=0;
CALL school_update("대전여상", "대전여자상업고등학교", @result);
SELECT @result;

# 학교코드가 CH00000001번인 학교 정보를 출력
# SELECT * FROM schoolcode = 'CH00000001';
CALL school_select2("CH00000001");

# 'CH00000001' schoolcode를 삭제
SET @result = 0;
CALL school_delete('CH00000001', @result);	# 참조 때문에 삭제되지 않음
SELECT @result;


# 뷰(View)는 자주 사용되는 select문을 테이블로 정의해서 사용하는 것 
# Ch00000001에 해당되는 학교의 학생들만 별도의 테이블로 생성하시오.
# 이름 국어 영어 수학 합계 평균 학교이름 학교주소
SELECT NAME, st.kor, st.mat, st.eng, st.total, st.average, sc.schoolname, sc.address FROM student st,
	school sc WHERE st.schoolcode = sc.schoolcode AND sc.schoolcode = 'CH00000001';

SELECT * FROM student_view;
