SELECT NAME, kor, mat, eng FROM student;
SELECT * FROM student;

# 연습문제
# 미래, 98, 97, 96, 'CH00000001' 데이터를 입력하기
SET @result = 0;
CALL student_insert('미래', 98, 97, 96, 'CH00000001', @result);
SELECT @result;

# 미래의 번호를 확인
# CALL student_select_bunho('미래');
SET @bunho=0;
SELECT bunho INTO @bunho FROM student WHERE NAME = '미래';
SELECT @bunho;

# 미래의 이름을 '미래로'로 수정하고 80, 81, 82점으로 점수 수정
SET @result=0;
CALL student_update(@bunho, '미래로', 80, 81, 82, @result);
SELECT @result;

# 미래의 데이터를 삭제하기
CALL student_delete('미래', @result);
SELECT @result;

# 모든 데이터에 점수를 1점 추가시키고 다시 1점 감소 시키기
SET @num_count = 0;
CALL update_student_cursor(@num_count);
SELECT @num_count;
