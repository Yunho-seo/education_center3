# matrix
# 동질적인 vector가 열로 여러개 모여있는 행렬
# 데이터 변환, 데이터 처리를 함
# 공간 매핑 (MRS)
# 데이터 처리 : 차원감소(시각화(3차원(컬러값, 선타입)) 하기위해 사용), 특징 추출
# 시각화 없이 데이터를 이해할 수 없음 (ex. 100개 변수를 2차원 / 3차원으로 변환)
# 특징이 많으면 복잡 -> 특징을 추출

# 클래스를 함수로 만든 함수 베이스 프로그래밍
(a = matrix(1:9, nrow=3, ncol=3, byrow=TRUE))  # 행 우선
# (a = matrix(1:10, nrow=4, ncol=3, byrow=TRUE))
matrix(1:9, nrow=3)  # ncol은 자동으로 계산
class(a)
(b = matrix(1:9, nrow=3, ncol=3, byrow=FALSE))
attributes(a)  # 차수 (dimmension)
x <- (matrix(1:9, nrow=3))
colnames(x)
colnames(x) <- c("c1", "c2", "c3")
rownames(x) <- c("R1", "R2", "R3")
x
# x["C1"]
# x["R1"]

# dimnames를 list로 전달하는 이유?
# list 사용 시, 열별, 행별 개수가 달라도 됨 (대부분 매개변수를 list로 전달)
(x <- matrix(1:9, nrow=3, dimnames=list(c("X", "Y", "Z"), c("A", "B", "C"))))

# 선형대수는 동질적 데이터에만 가능 - 이질적 데이터는 불가
# dataframe에는 행렬 연산이 적용되지 않음
# 빈 매트릭스를 만들고 값을 지정정
y <- matrix(nrow=2, ncol=2)
y[1,2]
y[1,1]<-1
y[2,1]<-2
y[1,2]<-3
y[2,2]<-4
y
mode(y)
class(y)

# 두개의 매트릭스를 결합할 때
cbind(c(1,2,3), c(4,5,6))  # column bind
rbind(c(1,2,3), c(4,5,6))  # row bind

# 매트릭스의 attribute는 dim 이 없다.
(x <- c(1,2,3,4,5,6))  # x는 벡터
dim(x)   # dim 정보가 없음

(dim(x) <- c(2,3)) 
x

(x <- matrix(1:9, nrow=3, byrow=TRUE))
(y <- matrix(11:19, nrow=3, byrow=TRUE))
(c <- rbind(x, y))
(d <- cbind(x, y))

# 매트릭스를 인덱싱
(x = matrix(1:9, nrow=3, byrow=TRUE))
x[c(1,2), c(2,3)]  # 행이 1과 2, 열이 2와 3인 요소 출력
x[c(2,3),]  # 있으면 모두 출력
x[,]
x[-1,]      # 1행 제외
a=x[1,]
class(a)
typeof(a)
x[c(TRUE, FALSE, TRUE), c(TRUE, TRUE, FALSE)]
x[c(TRUE, FALSE), c(2,3)]

x[c(TRUE, FALSE)]  # 하나의 벡터를 보고 데이터를 추출.

x[x < 5]
x[x %% 2 == 0]  # 데이터를 1차원으로 보고 추출

(mdat <- matrix(seq(20, 4, -2), nrow=3, ncol=3, byrow=TRUE,
                dimnames=list(c("a", "b", "c"), c("x","y", "Z"))))
t(mdat)
nrow(mdat)
ncol(mdat)
dim(mdat)       # 차수
rowMeans(mdat)  # 행방향으로
rowSums(mdat)   # 열 개수만큼 (행이 없어지는 것)
colMeans(mdat)  # 행 개수만큼
colSums(mdat)

# 행렬의 대각선에 있는 값의 의미 : 크기를 결정
?diag
diag(mdat)
diag(20, 12, 4)  # diag(넣을 값, 행, 열) 대각선으로.

# 벡터는 크기와 방향값을 표현
eigen(mdat)  # eigen은 고유값 분해 (크기와 방향을 분해)
# 고유치 + 고유벡터
# 고유치는 축 방향 위에 크기
# 고유벡터는 축의 방향을 의미
# 정방행렬이면서 대칭행렬(상관계수행렬, 거리값 행렬)에 대해 고유값을 분해하면 고유치와 고유벡터 출력
# 고유벡터는 othogonal 하다 ( 정직교한다. ) -> 고유값 분해라고 함
# 고유값 분해를 하여 생성되는 고유벡터에 데이터를 재표현하면 noise가 사라진다.
# 주성분 분석 : Principal Component Analysis

svd(mdat)  # singular value decomposition (특이행렬분해: 희소행렬에서 특징을 추출할 때 사용)
# 비정방행렬에 사용
# 비정방행렬에는 정방행렬도 포함된다.
# 희소행렬 : (sparce matrix : 요소가 0이 많은 경우)
# ex. 마트에서 시장을 본 이후 저장된 벡터
# 텍스트 분석에서 사용하는 단어 벡터


# y = ax
# y = 10x일때 y가 20이라면, x의 값은?
solve(10, 20)

# 2x + 3y = 5
# 3x + 5y = 6
(mdat <- matrix(c(2,3,8,5), nrow=2, ncol=2, byrow=TRUE))
(c=c(5,6))
solve(mdat, c)
# x = 7, y = -3
2 * 7 + 3 * -3
3 * 7 + 5 * -3

# 문제
# matrix의 등장은 방정식의 해를 푸는 도구
# 연립방정식의 해를 구하고 과정에서 발생하는 매트릭스의 행의 합, 행의 평균, 열의 합, 열의 평균 구하기
# 1) x + 3y + 5z = 10
# 2) 2x - 5y + z = 8
# 3) 2x + 3y + 8z = 3
# c(1,3,5,2,5,1,2,3,8) [x, y, z] = [10, 8, 3]
# [x, y, z] = [10, 8, 3] / c(1,3,5,2,5,1,2,3,8)
# [x, y, z] = [10, 8, 3] %*% inverse matrix

# 행렬은 나눗셈이 없음 -> 역행을 이용해 곱하면 된다.
x = c(1,3,5,2,5,1,2,3,8)
b = c(10, 8, 3)
(mat <- matrix(x, nrow=3, byrow=T))
solve(mat, b)  # -9.28, 5.16, 0.76 / 첫 매개변수는 역행렬로 구하고 다음 매개변수와 행렬곱
1 * -9.28 + 3 * 5.16 + 5 * 0.76
(inv_m <- solve(mat))  # 역행렬 값, inverse matrix 구하기
inv_m %*% b
(identity_m <- inv_m %*% mat)  # 단위행렬, 1과 마찬가지
identity_m %*% inv_m  # 행렬의 항등원은 단위행렬
# +의 항등원은 0, 곱셈의 항등원은 1, 행렬의 항등원은 단위행렬

rowMeans(mat)
rowSums(mat)
colMeans(mat)
colSums(mat)


# Matrix Operations 문제
# 1. 다음 두 매트릭스를 rbind, cbind를 이용하여 묶기
# 2. 다음 두 매트릭스의 사칙연산 구하기
# 3. 다음 두 매트릭스의 행렬내적(곱 : %*%) 구하기
# 1   2  3  4  5
# 6   7  8  9 10
# 11 12 13 14 15

# 16,17,18,19,20
# 21,22,23,24,25
# 26,27,28,29,30

# 1. 
(mat1 <- matrix(1:15, nrow=3, byrow=T))
(mat2 <- matrix(16:30, nrow=3, byrow=T))
mat1
mat2
(c <- rbind(mat1, mat2))  # 6x5
(d <- cbind(mat1, mat2))  # 3x10

# 2. 행렬 사칙연산 (요소끼리)
mat1 + mat2
mat1 - mat2
mat1 * mat2
mat1 / mat2
# 앞에 있는 행렬의 열수와 뒤에 있는 행렬의 행수는 일치
# 내적을 내는 의미는 투영의 의미가 있음.
 (mat1 %*% t(mat2)) # 앞에 있는 행렬의 행벡터에 대해 뒤에 있는 행렬의 열개수만큼 별도의 특징 추출을 해서 데이터 변환
#(대상 %*% 기준값) -> (앞행렬이 캐릭터, 뒤 행렬이 회전값)
# 2000 x 3 => 캐릭터
#    3 x 3 => 결과 : 2000 x 3
#   cos theta   0     sin theta  # 새로운 축에 투영된 값을 다시 구하기
#      0        0        0
#  -sin theta   0     cos theta


# Array : 기준은 행렬
vector1 <- c(5, 9, 3)
vector2 <- c(10, 11, 12, 13, 14)
# combine
# 24개의 데이터가 필요 -> recycling
result <- array(c(vector1,vector2), dim=c(4,3,2))  # 면행렬 -> 행렬면으로 표현 dim=c(행, 열, 행렬개수(면))
print(result)

# 3차원 데이터
column.names <- c("COL1", "COL2", "COL3")
row.names <- c("ROW1", "ROW2", "ROW3")
matrix.names <- c("Matrix1", "Matrix2", "Matrix3", "Matrix4", "Matrix5")

result <- array(c(11:19, 21:29, 31:39, 41:49, 51:59), dim=c(3,3,5),
                dimnames=list(row.names, column.names, matrix.names))
print(result)
print(result[3,,2])
print(result["ROW3","COL2", "Matrix2"])


# 문제
# 2면에 있는 데이터를 모두 출력하기
print(result[,,2])
# 2번 매트릭스의 3행 2열에 있는 데이터를 추상하고 확인
print(result[3,2,2])
# 1번 매트릭스의 2행 3열에 있는 데이터를 추상하고 확인
print(result[2,3,1])
# 2번 매트릭스의 1행 3열에 있는 데이터를 추상하고 확인
print(result[1,3,2])
# 3번 매트릭스의 2행 2열에 있는 데이터를 추상하고 확인
print(result[2,2,3])
# 3번 매트릭스의 2행 3열에 있는 데이터를 추상하고 확인
print(result[2,3,3])
# 4번 매트릭스의 3행 2열에 있는 데이터를 추상하고 확인
print(result[3,2,4])
# 5번 매트릭스의 3행 1열에 있는 데이터를 추상하고 확인
print(result[3,1,5])


# data.frame
# 사각형을 유지해야 하고 열내 동질적이고 열간 이질적인 데이터
# R은 데이터를 표현할 때 열 중심으로 데이터를 저장하고 통계처리에 유리함 (10배 정도)
# 데이터를 실시간으로 추가할 수 있음 (Javascript)
x <- c(10, 20, 30, 40)
y <- c(6, 7, 8, 9)
# 데이터 프레임에서 변수의 개수는 특성의 개수를 의미한다.
(data <- data.frame(width=x, height=y))  # 처음부터 열 이름을 붙여서 사용
str(data)
data$width  # $ 뒤에는 열 이름 (width 열에 있는 데이터를 조회)
data[,1]    # matrix 방식으로 접근 가능 (1번 열의 데이터 조회) (숫자 인덱스, 열이름 인덱스 가능)
head(data)  # 데이터 저장 형태를 조회 (default는 6개)
data$delinetr = c(30, 40, 50, 60)  # 실시간으로 데이터 추가가
data

data <- edit(data)  # 데이터 편집기기
data

L3 = LETTERS[1:3]
d <- data.frame(cbind(x=1, y=1:10), fac=sample(L3, 10, replace=T))
d
d$fac  # fac 열에 있는 데이터 조회, 범주형 변수수
(d$yhat <- d$fac)  # 파생변수
str(d)
head(d)
# 범주형 변수
d$fac = factor(d$fac)
rownames(d) = c("일", "이", "삼", "사", "오", "육", "칠", "팔", "구", "십")
d

# factor형으로 자동 변환되는 현상이 버전업 되면서 해결됨
x <- data.frame("SN"=1:2, "Age"=c(21,15), "Name"=c("에어컨", "삼성SDS"))
str(x)
x$Name    # 문자열로 참조
x["Name"] # 데이터 프레임(data.frame)으로 참조(조회)
x$Name = as.character(x$Name)
ncol(x)
nrow(x)
length(x)  # 2차원에서는 열의 개수를 의미
x

# 데이터 수정
x["Age", 1] <- 20;  # age 행이 새로 생성
x[1, "Age"] <- 25;
x$SN <- NULL
x

data()
str(trees)
head(trees)
tail(trees)  # 6개 데이터에 대해서 뒤에서부터 조회
trees[2:3,]
trees[trees$Height > 82, ]  # 조건식으로, boolean indexing
trees[10:12, 2]   # numeric
trees[10:12, 2, drop=F]     # data,frame / drop=FALSE : 형태를 잃지 말라는 의미
summary(trees)  # 데이터를 열로 조회
# Min : 최소값, 1st Qu : 1사분위수, Median : 중위수, Mean : 산술평균, 3rd Qu : 3사분위수 max : 최대값
boxplot(trees)
# 3사분위수 - 1사분위수 : IQR(inter Quantile range)
# 3사분위수 + IQR * 1.5
# 1사분위수 - IQR * 1.5

# Data Cleaning (데이터 전처리)
# - 결측치 처리 (NA) : 제거, 평균으로 대치, 비슷한 데이터로 대치
# - 이상치 처리 (boxplot(trees)) : 신뢰구간을 구한 다음 2사분위수를 넘어가는 것을 제외외
# - 정규화  min-max, normalize(-1 ~ 1), z-점수 정규화(-oo ~ oo) (평균을 0으로 만들고 표준편차로 나눔)
# - 사이즈를 1로 설정, z-점수 정규화가 성능이 좋음 (평균을 0으로, +- 값이 존재할 때 모델학습이 잘 됨)
# - 범주화 : 정성적 데이터는 범주화 해주어야 함.
##############################

pairs(trees)  # 변수간의 상관도를 출력 : 대칭행렬
# 상관계수 행렬은 대칭행렬

data <- read.csv("C:/Users/401-25/Documents/input.csv", fileEncoding = "CP949", header=TRUE,)
data

colnames(data)[1] <- "id"
print(data)
print(is.data.frame(data))
ncol(data)
nrow(data)
sal <- max(data$salary)  # 데이터 파일 중 급여 필드에서 가장 높은 급여
print(sal)
(retval <- subset(data, salary == max(salary)))  # 가장 급여가 높은 사람의 정보 출력 (subse(조건)에 맞는 필드 조회)

install.packages("stringr")
library(stringr)
(retval <- subset(data, str_trim(dept) == "전산"))  # dept가 전산인 사람 정보 출력
(info <- subset(data, salary>600 & str_trim(dept) == "전산"))
(retval <- subset(data, as.Date(start_date) > as.Date("2014-01-01")))
write.csv(retval, "output.csv")
(newdata <- read.csv("output.csv"))

# 문제
# 다음을 데이터 프레임에 입력할 것
#      영어 등급
# 퀴즈  67  "C"
# 중간  92  "A"
# 기말  89  "B"
x <- c(67, 92, 89)
y <- c("C", "A", "B")
name <- c("퀴즈", "중간", "기말")
(data <- data.frame("영어"=x, "등급"=y, row.names=name))
data

# 문제 2
# 수학점수를 50, 100, 80점으로 입력 (열로 추가)
data$"수학" <- c(50, 100, 80)
# '보충'이라는 이름으로 dataframe을 만들어 rbind 시키기 (행으로 추가)
da <- data.frame("영어"=c(90), "등급"=c('A'), "수학"=c(100), row.names="보충")
# 영어점수 90, 등급 "A", 수학점수 100
data2 <- rbind(data, da)
data2
# 열별합계를 내서 데이터에 추가하기 ( colSums() )
hab <- colSums(as.matrix(cbind(data2$"영어", data2$"수학")))
hab
da <- data.frame("영어"=hab[1], "등급"=0, "수학"=hab[2], row.names=("합계"))
data2 <- rbind(data2, da)
data2

# 국어 점수를 추가 (90, 80, 100, 77)
kor <- c(90, 80, 100, 77)
(kor <- c(kor, sum(kor)))
data2$"국어" <- kor
data2
write.table(data2, file="sungjuk.csv", sep=",", col.names=NA)
(data3 <- read.table("sungjuk.csv", header=TRUE, sep=","))

# 정규분포 : 평균이 0이고, 전체 확률이 1인 분포표
(x <- rnorm(400, mean=70, sd=10))  # 평균이 50, 표준편차가 10, r은 random
# 표준정규분포표 ( 확률을 확인하는 것이 가능 ) - 확률표를 단일 작성
# z-점수 = (데이터 - 평균) / 표준편차
hist(x)

(x <- runif(400, min=0, max=100))  # uniform 균등 분포
hist(x)
x <- floor(runif(400, min=0, max=100))
plot(x)

# b : both (line + dot)
plot(c(data3$"수학"[1:4]), main="그래픽", col="red", ylab="국어점", ylim=c(0,100), type="b")

# 문제 : 수학의 평균, 중위수, 분산, 표준편차 구하기
mean(data3$"수학"[1:4])
median(data3$"수학"[1:4])
var(data3$"수학"[1:4])
sd(data3$"수학"[1:4])

# 문제
# name <- c("대한이", "민국이", "만세이", "희망이", "다함께")
# age <- c(55, 45, 45, 53, 15)
# gender <- c(1,1,1,2,1)  # 1:남자, 2:여자
# job <- c("연예인", "주부", "군인", "직장인", "학생")
# sat <- c(3,4,2,5,5)  # 만족도
# grade <- c("C", "C", "A", "D", "A")
# total <- c(44.4, 28.5, 43.5, NA, 27.1)
name <- c("대한이", "민국이", "만세이", "희망이", "다함께")
age <- c(55, 45, 45, 53, 15)
gender <- c(1,1,1,2,1)  # 1:남자, 2:여자
job <- c("연예인", "주부", "군인", "직장인", "학생")
sat <- c(3,4,2,5,5)  # 만족도
grade <- c("C", "C", "A", "D", "A")
total <- c(44.4, 28.5, 43.5, NA, 27.1)
# 문제 1: 다음과 같은 벡터를 열로 가지는 데이터프레임 생성
# 문제 2: 성별(gender) 변수를 이용하여 히스토그램 그리기 (hish())
# 문제 3: 만족도 변수를 이용하여 산점도 그리기 (plot())
# 문제 4: 총 구매금액에 대해 평균과 분산, 표준편차 구하기

user <- data.frame(
  name=name,
  age=age,
  gender=gender,
  job=job,
  sat=sat,
  grade=grade,
  total=total
)
user
str(user)
user$gender <- as.factor(user$gender)
str(user)

# histogram : 연속된 수치에 대한 카운트(Count)
hist(as.integer(user$gender), main="성별분포", xlab="성별(남자, 여자)", xlim=c(1, 2),
     ylab="인원", col="lightblue")
plot(user$sat, main="만족도, 산점도", col="red", ylab="만족도", ylim=c(0,5), type="b")
mean(user$total, na.rm=T)  # 평균
var(user$total, na.rm=T)   # 분산
sd(user$total, na.rm=T)    # 표준편차

# 문제 : 다음 데이터를 data.frame으로 만들기
name <- c("유관순", "홍길동", "이순신", "신사임당")
gender <- c("F", "M", "M", "F")
price <- c(50, 65, 45, 75)
client <- data.frame(name, gender, price)
# 조건 1 : price가 65만원 이상인 고객은 "Best", 미만이면 "Normal" 문자열을
# result 변수에 넣고 client에 파생변수로 추가
# 삼항 연산자 : ifelse(조건, 참, 거짓)
client$result = ifelse(client$price >= 65, "Best", "Normal")
client
# 조건 2 : result의 빈도수 구하기
# 도수분포표 (table)
table(client$result)

# 조건 3: gender가 'M'이면 Male, 'F'이면 'Female' 형식으로 client의 파생변수로 추가
client$gender_origin <- ifelse(client$gender == 'M', "Male", "Female")
client


# list
# 이질적인 데이터를 가질 수 있고 사각형을 유지하지 않아도 됨.
x <- c(82,95, 78)
y <- c(84, 92)
z <- c(96, 86, 82, 77)
(core <- list("수학"=x, "영어"=y, "국어"=z))  # $로 접근하는 것은 동일함
core
typeof(core)
length(core)
str(core)

# data.frame과 형식이 비슷함 : 사이즈가 다르다.
# 리턴 데이터로 참조해야 하는 경우가 많다.
(x <- list("name" = "에어컨", "age"= 19, "speaks" = c("한국어", "영어")))
x$name
x[c(1:2)]
x[-2]
x[c(T,F,F)]  # "name" 요소만 True라서 출력력
x[c("age", "speaks")]
x["age"]
typeof(x["age"])   # List로 결과 출력됨
x[("age")]         # 요소로 결과 출력됨 (괄호가 2개)
typeof(x[["age"]]) # double 형

a <- list(c(1:5))
b <- list(6:10)
lapply(c(a,b), max)  # 함수 호출은 max(데이터) : 함수의 매개변수로 함수를 전달할 때 ()를 붙이지 않음

# factor형 (범주형 데이터 : 무순서, 순서 범주 데이터) : 정성적 데이터 -> 범주형.
gender <- c('M', 'F', 'M', 'F', 'M')
gender
plot(gender)  # 문자로는 그래프를 만들 수 없다다
fgender <- as.factor(gender)
fgender
fgender[2]
mode(fgender); class(fgender)
plot(fgender)

(x <- factor(c("single", "married", "married", "single"),
             levels = c("single", "married", "divorced")))
str(x)
levels(x)
x[3]
x[c(2, 4)]
x[-1]
x[2] <- "divorced"
x[3] <- "widowed"  # level에 없기 때문에 입력 불가
x

# 연속형 숫자의 범주화
(x = c(1:100))
cut(x, breaks=4)  # 구간범주화 : 분석은 범주형 : 구간 계수로 범주화
# 함수 충돌을 방지하기 위해 stats::rnorm() 으로 사용
Z <- stats::rnorm(10000)  # rnorm을 패키지마다 다르게 정의 / 중복 방지를 위해 패키지명(stats)을 참조
Z
table(cut(Z, breaks = -6:6))
graphics::hist(Z, breaks = -6:6)

#############################
# 내일(3.22) 할 것
# 전처리 (결측치, 이상치, 범주화, 정규화)
# 데이터 변환(data transform(select, filter, arange, aggregate, sumarize, groupby))
# 60%
#############################

IQR(x)

# Z 점수를 구하는 방법 : 평균을 빼주고 표준편차로 나누기
# 표준정규분포표에 접근할 수 있음 1sigma : 0.675, 2sigma : 95%, 3sigma : 99.7%
# 1.5배 하는 이유?
# 표준 정규분포에서 3sigma : 99.7 % -> 일반적으로 정상 데이터라고 본다.
# IQR 1배수로 하면 너무 작은 데이터를 정상적으로 보기 때문에 이상치가 많고
# IQR 2배수로 하면 너무 큰 번위를 정상으로 보기 때문에 이상치가 많고
# 그래서 1.5배를 사용한다.