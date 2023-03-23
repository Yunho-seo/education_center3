# 과제
# 엑셀에서 성적 데이터를 입력(국어 영어 수학 과목과, 3인분의 데이터) (합계, 평균 제외)
#  - csv로 저장
# R에서 데이터를 로딩하여 합계 평균 및 학점을 구하기
# 계산된 결과 data.frame을 sungjukResult 데이터베이스의 student 테이블로 저장합니다. (Rmysql 사용)
# 저장된 데이터를 dbplyr을 이용하여 데이터베이스로부터 로딩합니다.

data <- read.csv("C:/Users/401-25/Documents/sungjukResult.csv", fileEncoding = "UTF-8", header=F,)
colnames(data)[c(1:4)] <- c("이름", "국어", "영어", "수학")
data


data$"합계" <- data$"국어" + data$"영어" + data$"수학"
data$"평균" <- data$"합계" / 3

data$"학점" <- ifelse(data$"평균" >= 90, "A", 
                    ifelse(data$"평균" >= 80, "B", 
                           ifelse(data$"평균" >= 70, "C", 
                                  ifelse(data$"평균" >= 60, "D", "F"))))
# 결과 출력
data


# 데이터베이스 접속
library(dplyr)
library(dbplyr)
library(DBI)
library(rstudioapi)
# install.packages("RMySQL")
library(RMySQL)
conn = dbConnect(MySQL(), user='root', password='acorn1234', dbname='sungjukResult',
                 host = '192.168.41.184')
dbListTables(conn)

data
dbWriteTable(conn, "student", data, row.names = F) # student 테이블에 data 정보를 삽입
dbListTables(conn)
dbListFields(conn, "student")  # 열 이름이 출력됨
db_data <- dbReadTable(conn, "student")
dim(db_data)

# 쿼리문 작성
student <- dbSendQuery(conn, "select * from student")
student
student_query <- dbFetch(student)
dim(student_query)
student_query

# 국어 영어를 선택하고, 국어 점수가 80점 이상인 데이터만 필터링
# (student_db <- tbl(conn, "student"))
# 
# db_test <- student_db %>% 
#   select("국어", "영어") %>%
#   filter("국어" > 80)
# 
# student <- dbSendQuery(conn, "select '국어', '영어' from student where '국어' > 80")
# student
# student_query <- dbFetch(student)
# dim(student_query)
# student_query
# db_test %>% show_query()

student <- dbSendQuery(conn, "select 국어,영어 from student")
student
student_query <- dbFetch(student)
student_query
class(student_query)

student2 <- dbSendQuery(conn, "select * from student where 국어>=80")
student2
student_query2 <- dbFetch(student2)
student_query2

student_db %>% select("국어", "영어")

aaa <- student_query %>%
  select(국어, 영어) %>%
  filter(국어 >= 80) 

class(aaa)

# 처리 결과를 sungjukResult 데이터베이스의 calcsungjuk 테이블에 저장
dbListTables(conn)
dbWriteTable(conn, "calcsungjuk", aaa)