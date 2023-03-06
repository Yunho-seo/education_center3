# 데이터베이스는 파일 베이스로 동작한다.
# HeidiSQL : 클라이언트 툴 (DB작업을 위한 툴) - 서버관리자가 작업하는 툴
# mariadb가 데이터베이스에 자동으로 전송이 되어, 실행

INSERT INTO MEMBER(num, NAME, addr) VALUES (1, '대한', '서울');
# 민국을 2번에, 주소는 대전으로 해서 입력
INSERT INTO MEMBER(num, NAME, addr) VALUES (2, '민국', '대전');

INSERT INTO MEMBER(num, NAME) VALUES(3, '민국');


# 별칭을 부여 (as)
SELECT num AS 번호, NAME AS 이름 FROM MEMBER;

SELECT num, NAME FROM member;

SELECT * FROM MEMBER;

# 삭제 (조건 : num이 2인 필드)
DELETE FROM MEMBER WHERE num = 2;

# 수정 (name이 '민국'인 필드를 찾아, '민국아'로 수정)
UPDATE MEMBER SET NAME = '민국아' WHERE NAME = '민국';  # '==' 같다는 의미가 '='