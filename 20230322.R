(x <- 1:10)
(x = rnorm(100))  # random normal : 정규분포로부터 랜덤하게 선택 (데이터타입 : 벡터)
# vector -> matrix, dataframe, array, list
var(x)   # 기본이 벡터
sd(x)    # 표준편차
range(x) # 상한선, 하한선
diff(range(x))  # 상한선 - 하한선
quantile(x, 0.75) - quantile(x, 0.25)  # 사분위(IQR)를 구하는 함수 (3사분위 - 1사분위) (75%)

IQR(x)
IQR(rnorm(10000))
summary(x) # Min, 1st Qu, Median, Mean, 3rd Qu, Max 정보 출력
boxplot(x)
summary(x)

vec <- 1:10
vec <- sample(vec)  # 랜덤 선택
summary(vec)
table(vec)  # 도수 분포표 출력

directory <- getwd()  # 현재 디렉터리 출력(getwd() : 현재 작업 경로의 위치를 출력하는 함수)
setwd(directory)
getwd()

x <- c(1.5, 2.5, -1.3, 2.5)
x
round(mean(x))   # 평균 반올림
ceiling(mean(x)) # 평균 올림
floor(mean(x))   # 평균 내림

#
#install.packages("mlbench")
library(mlbench)
data ("BostonHousing", package="mlbench")  # BostonHousing : 보스턴주 주택가격 dataset.
original <- BostonHousing
# 예측 데이터 (선형회귀)
?BostonHousing  # 차수 : 506 x 14 (종속변수 : medv, 13개는 독립변수)
head(BostonHousing)
set.seed(100)   # 컴퓨터의 난수는 의사난수 -> 똑같은 결과가 나오기 위해
# 3(평가) : 7(학습)
# 컴퓨터의 모델은 난수에 의해 작동되는 경우가 많음
# 선형회귀는 전부 수치데이터여야 한다. 범주형 데이터는 2개 이상 사용하지 못한다.
str(BostonHousing)

sum(is.na(BostonHousing))  # NA가 있는지 여부, 0
na.omit(BostonHousing) # 처리
# 값에 의한 전달을 하기에 이전 값들이 없어짐
BostonHousing <- na.omit(BostonHousing)
# 506개에서 40개를 선택하여 처리
BostonHousing[sample(1:nrow(BostonHousing), 40), "rad"] <- NA  # rad: 방사형 도로 접근지수
BostonHousing$rad
BostonHousing[sample(1:nrow(BostonHousing), 40), "ptratio"] <- NA  # ptratio : 도시의 학생-교사 비율

sum(is.na(BostonHousing))  # 단순히 sum() 으로 사용하면, 어떤 변수에 na가 있는지 모름

# apply : 데이터에 함수를 적용
# apply, lapply(리스트), sapply(벡터나 행렬), tapply(그룹핑 후 함수 적용)
# 함수적 프로그래밍(반복문 X, 자동으로 모든 데이터에 대해 적용) 
# 열(col)별로 적용
# 데이터프레임은 열이 우선( )
# 열을 중심 (열별로 함수를 적용)
sapply(BostonHousing, function(x) sum(is.na(x))) # x는 열벡터로 입력, x에 값이 들어오면 sum()으로.
# 종속변수 ~ 독립변수(ptratio와 rad를 사용해서 medv를 정의하라는 의미)
# 506 - 80 = # 426
lm(medv ~ ptratio + rad, data=BostonHousing, na.action=na.omit)
# install.packages("Hmisc")
library(Hmisc)
impute(BostonHousing$ptratio, mean)   # ptratio 데이터에 대해서, NA가 있으면 평균으로 채우기 (대체)
impute(BostonHousing$ptratio, median) # ptratio 데이터에 대해서, NA가 있으면 중위수로 채우기
impute(BostonHousing$ptratio, 20)     # 특정한 값으로 대체, '20'
# if문
BostonHousing$ptratio[is.na(BostonHousing$ptratio)] <- mean(BostonHousing$ptratio, na.rm = T)
sum(is.na(BostonHousing$ptratio))

# 2차원 데이터 apply
# byrow의 디폴트 값은 FALSE (열)
(m1 <- matrix(C <- (1:10), nrow=5, ncol=6))  # 5x6 행렬 -> 요소는 10개 삽입 -> 나머지는 리사이클링
a_m1 <- apply(m1, 1, sum)  # 1 : 행 방향으로 sum (apply는 행렬 방향을 지정할 수 있다.)
# a_m1 <- apply(m1, 2, sum)  2 : 열 방향으로 sum
a_m1

# 1차원 데이터 apply
vec <- c(1:10)
vec
apply(vec, 2, sum) # 실행이 되지 않음, 전제조건 : dim이 2차원
sapply(vec, sum)   # sapply는 행렬을 무시, 열별로 적용

# 함수 1급 객체
avg <- function(x) {
  (min(x) + max(x)) / 2
}
cars
head(cars)  # 속도(speed)에 따른 제동 거리(dist)
dt <- cars
sapply(dt, avg)  # 열별로 적용

data(iris)
iris
head(iris)  # 5개 변수
dim(iris)   # 150x5 (데이터포인트가 150개, 변수가 5개) -> Species가 종속변수(setosa, versicolor, virginica)
# 종속변수 : 독립변수에 영향을 받아서 변화하는 변수 (독립변수는 4개(Sepal.*, Petal.*))
tapply(iris$Sepal.Width, iris$Species, median) # Sepal.width에 대해 Species를 그룹으로 하여 median(중위수) 구하기
tapply(iris$Sepal.Width, iris$Species, sum)
tapply(iris$Sepal.Width, iris$Species, mean) # 그룹 변수가 3개(종속변수) 변수를 가지고 있음

?mtcars # 32x11 데이터 (변수가 11개, 데이터포인트는 32개), 연비테스트 : 예측 데이터
head(mtcars)
tail(mtcars)
summary(mtcars)
str(mtcars)

(exdata <- mtcars[1:10, 1:3])
class(exdata)

apply(exdata, 2, mean)  # 열 방향, 변수마다 평균을 내기
(x = apply(exdata, 1, mean)) # 행 방향으로 변수마다 평균 내기
boxplot(mtcars)  # 열별 

list.o.nums <- list(runif(100), rnorm(100), rpois(100, lambda=1))
lapply(list.o.nums, sd)  # 결과 : list
sapply(list.o.nums, sd)  # 결과 : 벡터
apply(list.o.nums, 2, sd)  # 출력이 되지 않음, 이빨빠진 2차원은, 2차원으로 인식하지 않는다.

# 1부터 10의 데이터에 대해 2승 값을 구하여 출력 (apply 적용)
a <- c(1:10)
lapply(a, function(a) {a^2})
sapply(a, function(a) {a^2})

# 문제 : iris의 4개의 독립변수에 대해(열별) 평균을 계산하기 (종속변수는 문자열)
data(iris)
iris
sapply(iris[ ,1:4], mean) # [행, 열] -> 행은 전체라서 비워놓고 열은 1:4 처리

# 정규분포에서 랜덤하게 데이터를 20개 선택한 다음 5x4를 만들고 
# 행 합계와 열 합계를 구하기
(x = rnorm(20))
(x1 <- matrix(x, nrow=5, ncol=4))
sum(x1)  # 전체 합계
apply(x1, 2, sum) 
apply(x1, 1, sum)
colSums(x1)
rowSums(x1)

# 1사분위수와 2사분위수, 3사분위수를 구하기
quantile(x1, probs=0.25)  # 1사분위수
quantile(x1, probs=0.5)   # 2사분위수
quantile(x1, probs=0.75)  # 3사분위수
apply(x1, 2, quantile, probs=c(0.25, 0.5, 0.75))

#
?gl
(data <- c(1:10, rnorm(10, 2), runif(10)))  # 30개
groups <- gl(3,10)  # 10개씩 세 그룹으로 묶기
tapply(data, groups, mean)

# factor
# 구간범주화
library(ggplot2)  # 시각화 패키지
library(MASS)
str(Cars93)
hist(Cars93$MPG.highway)
disc_1 <- Cars93[ , c("Model", "MPG.highway")]  # Cars93의 "Model", "MPG.highway"의 모든 값만을 disc_1에 대입 후 출력
                                                # 고속도로 연비(수치형이고, 범주형 데이터가 아니다) : 6가지 구간화
head(disc_1)
range(disc_1["MPG.highway"])  # MPG.highway의 범위


dim(Cars93)  # 93x27
sum(disc_1$MPG.highway >= 45 & disc_1$MPG.highway < 50)



disc_1 <- within (disc_1, {  # 연비를 구간화함  (within() 사용하여 disc_1$MPG.highway 처럼 사용하지 않음 -> 단순화)
  MPG.highway_cd = character(0)  # 변수를 추가(MPG.highway_cd)하고 문자 타입으로 초기화시킴킴
  MPG.highway_cd[ MPG.highway >= 20 & MPG.highway < 25 ] = "20~25"  # 구간 이름 = 그룹 이름, 14개
  MPG.highway_cd[ MPG.highway >= 25 & MPG.highway < 30 ] = "25~30"  # 41개
  MPG.highway_cd[ MPG.highway >= 30 & MPG.highway < 35 ] = "30~35"  # 27개
  MPG.highway_cd[ MPG.highway >= 35 & MPG.highway < 40 ] = "35~40"  # 7개
  MPG.highway_cd[ MPG.highway >= 40 & MPG.highway < 45 ] = "40~45"  # 2개
  MPG.highway_cd[ MPG.highway >= 45 & MPG.highway <= 50 ] = "45~50" # 1개
  MPG.highway_cd = factor(MPG.highway_cd,
            level = c("20~25", "25~30", "30~35", "35~40", "40~45", "45~50"))
})
attributes(disc_1$MPG.highway_cd)
# 문제 : 범주화된 구간값에 따라 MPG.highway의 합계, 평균, 표준편차 구하기
tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd, sum)  # 합계
tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd, mean) # 평균
tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd, sd)   # 표준편차
# tapply(disc_1$MPG.highway, disc_1$MPG.highway_cd, c(sd, sum, mean)) # 실행 안됨
# data.frame에 적용
# ggplot은 layer로 적용한다.
ggplot(disc_1, aes(x = MPG.highway_cd, fill = MPG.highway_cd)) + geom_dotplot(binwidth=0.3)
ggplot(disc_1, aes(x = MPG.highway_cd, fill = MPG.highway_cd)) + geom_bar()

# 사분위수 구간 범주화
quantile(disc_1$MPG.highway, 0.25)
quantile(disc_1$MPG.highway, 0.5)
quantile(disc_1$MPG.highway, 0.75)

# dummy 변수화
# 원래 변수는 2개 => 6개의 변수로 늘어남
# 더미변수화 => 선형회귀에서는 범주형 변수를 반드시 더미변수화 해야 함.
cust_id <- c("c01", "c02", "c03", "c04", "c05", "c06", "c07")
age <- c(25, 45, 31, 30, 49, 53, 27)
cust_profile <- data.frame(cust_id, age, stringsAsFactors = F)
cust_profile

# 범주 수만큼 변수가 증가하고 데이터는 0과 1로만 표현함
cust_profile <- transform(cust_profile,
                      age_20 = ifelse(age >= 20 & age < 30, 1, 0), # 참이면 1, 거짓이면 0으로로
                      age_30 = ifelse(age >= 30 & age < 40, 1, 0),
                      age_40 = ifelse(age >= 40 & age < 50, 1, 0),
                      age_50 = ifelse(age > 50 & age < 60, 1, 0))
cust_profile

# 정규화 (min-max)
head(iris)
min_max_norm <- function(x) {
  (x-min(x)) / (max(x) - min(x))  
} 
lapply(iris[1:4], min_max_norm) # 1열부터 4열까지 lapply 적용, 결과가 리스트로 나오기에 다시 data.frame으로 묶기기
iris_norm <- as.data.frame(lapply(iris[1:4], min_max_norm))  # lapply는 열별 적용
head(iris_norm)
iris_norm$Species <- iris$Species
head(iris_norm)
# 정규화를 하는 이유? 독립변수를 정규화하여 종속변수에 동일한 영향을 미치기 위해서 

# z-점수 정규화
z_normal <- function(x) {
  (x - mean(x)) / sd(x)  # 표준편차 : sqrt(var) # 분산은 평균과의 차의 제곱의 합
}
iris_z_norm <- as.data.frame(lapply(iris[1:4], z_normal))
iris_z_norm

# iris의 데이터타입은 데이터 프레임
class(iris)
iris_standardize <- as.data.frame(scale(iris[1:4]))  # 열별로.

head(iris)
re = boxplot(iris)
re  # re의 데이터타입은 리스트(list)

fivenum(iris[ , 1], na.rm=TRUE)
# minimum, lower, median, upper, maximum
# install.packages("dplyr")
library(dplyr)
outdata <- iris[1:4]
out <- outdata  # out으로 초기화
for(i in 1:(ncol(outdata)-1)){  # 사분위수 : 열의 수
  uppercut = quantile(outdata[ , 0.75]) + 1.5 * IQR(outdata[ , i])  # 원래 데이터
  lowercut = quantile(outdata[ , 0.25]) - 1.5 * IQR(outdata[ , i])
  # ,로 분리된 조건
  out <- filter(out, out[ , i] <= uppercut, out[ , i] >= lowercut)
}
str(out)

########################
# 위치 데이터
state_table <-
  data.frame( key = c("SE", "DJ", "DG", "SH", "QD"),
              name = c("서울", "대전", "대구", "상해", "칭따오"),
              country = c("한국", "한국", "한국", "중국", "중국"))
state_table

# 년도
month_table <-
  data.frame( key = 1:12,
              desc = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"),
              quarter = c("Q1", "Q1", "Q1", "Q2", "Q2", "Q2", "Q3", "Q3", "Q3", "Q4", "Q4", "Q4"))
month_table

# 상품 테이블
prod_table <-
  data.frame( key = c("Printer", "Tablet", "Laptop"),
              price = c(225, 570, 1120))

(prod_table1 <- data.frame(Printer=225, Tablet=570, Laptop=1120))
(prod_table1 <- t(prod_table1))  # 행 이름으로 바꾸기 위해 전치

prod_table
names(prod_table)
row.names(prod_table)

gen_sales <- function(no_of_recs) {  # 가짜 데이터 생성
  loc <- sample(state_table$key, no_of_recs, replace=T, prob=c(2,2,1,1,1))  # 복원 추출
  time_month <- sample(month_table$key, no_of_recs, replace=T)
  time_year <- sample(c(2012, 2013), no_of_recs, replace=T)
  prod <- sample(prod_table$key, no_of_recs, replace=T, prob=c(1,3,2))  # 복원 추출, (1, 3, 2)의 확률값
  unit <- sample(c(1,2), no_of_recs, replace=T, prob=c(10, 3))
  
  amount <- unit * prod_table1[prod, ]
  sales <- data.frame(month = time_month,
                      year = time_year,
                      loc = loc,
                      prod = prod,
                      unit = unit,
                      amount = amount)
  
  sales <- sales[order(sales$year, sales$month), ]
  row.names(sales) <- NULL
  return(sales)
}
sales_fact <- gen_sales(500)
sales_fact
dim(sales_fact)
str(sales_fact)

# 상품(prod)별로 월, 년으로 location별로 합계를 낼 때
# 범주형 3개, 월은 범주형, 3 x 12 x 2 x 5 (상품 x 월 x 년도 x 지역)\

# Data ware house
(revenue_cube <-
    tapply(sales_fact$amount,
           sales_fact[ , c("prod", "month", "year", "loc")],  # 데이터를 4차원으로 확인
           FUN = function(x){return(sum(x))}))

# 문제 1 : 제품별 판매액을 계산
tapply(sales_fact$amount,
           sales_fact[ , c("prod")],
           FUN = function(x){return(sum(x))})

# 문제 2 : 지역별, 제품별로 판매액을 계산
tapply(sales_fact$amount,
       sales_fact[ , c("loc", "prod")],
       FUN = function(x){return(sum(x))})

# 문제 3 : 2012년 1월 태블릿에 대한 판매현황을 출력
revenue_cube["Tablet", "1", "2012", ]  # 지역별 2012년 1월 태블릿 판매현황 출력
apply(revenue_cube, c("year", "prod"), FUN=function(x) {return(sum(x, na.rm=TRUE))})  # 년도별 상품 판매현황 출력

dim(revenue_cube)  # revenue_cube은 몇 차원인가? (변수가 각각 몇 개인가?)

# 보는 관점, 즉 범주별로 지정하면 나머지 축의 값들은 모두 합계가 되어 나타남.

# 연습문제 : 제품별로 년도별, 월별, 매출액을 확인
apply(revenue_cube, c("prod", "month", "year"), FUN=function(x) {return(sum(x, na.rm=TRUE))})  # 차원 축소 
      
# 년도별, 월별로 매출액 확인
apply(revenue_cube, c("year", "month"), FUN=function(x) {return(sum(x, na.rm=TRUE))}) # 차원 축소 (year, month은 남고 나머지 변수는 합계로 쓰임)

# 매장별, 제품별로 월별 매출액 확인하기
apply(revenue_cube, c("loc", "prod", "month"), FUN=function(x) {return(sum(x, na.rm=TRUE))})
# 3 x 12 x 2 x 5  # 경우의 수가 360가지를 입체적으로 표현 (차원 확대(그룹의 개수), 차원 축소(그룹 개수 줄임))

# 로딩된 패키지 확인(출력)
search()
mean(iris$Sepal.Length)
# with / within (대입 가능)
with(iris, {
  mean(Sepal.Length)
})

head(iris)
iris[1, 1] = NA
head(iris)
# split : 그룹으로 Length을 나누는 것 => 테이블이 나누어 질 것.
# 종(Species)별로 중위수를 구함 (Species 별로 Length 들을 split 하는 것)
median.per.species <- sapply(split(iris$Sepal.Length, iris$Species), median, na.rm=T) # sapply는 벡터나 행렬(Matrix)에 적용
median.per.species
iris <- within(iris, {  # within()를 통해 iris$를 사용하지 않아도 됨
  # 중위수로 대체하거나, 자기 자신의 값
  Sepal.Length <- ifelse(is.na(Sepal.Length), median.per.species[Species], Sepal.Length)  # NA를 중위수(median)로 대체
})
head(iris)

?mtcars # 연비 테스트
mtcars
# 실린더(cyl)가 4개 또는 6개인 자동차 중 연비(mpg), 실린더 수(cyl), 변속기 종류(am)를 출력
str(mtcars)
# 행 / 열로 인덱싱
mtcars[which(mtcars$cyl == c(4, 6)), c("mpg", "cyl", "am")]  # which로 실린더의 개수 조건을 선언 / 행은 조건으로 옴
# 연비가 20보다 큰 데이터중 연비, 실린더수, 변속기 종류 출력하기
mtcars[which(mtcars$mpg >= 20), c("mpg", "cyl", "am")]
# 평균 마력(hp) 이상인 자동차 중 연비, 실린더, 변속기를 출력
mean(mtcars$hp)
mtcars[mtcars$hp > mean(mtcars$hp), c("mpg", "cyl", "am")]
# mtcars의 연비(mpg) 대해 min/max 정규화하기
(mtcars$mpg - min(mtcars$mpg) ) / (max(mtcars$mpg) - min(mtcars$mpg))
# 이를 with 문을 이용하여 수정
with (mtcars, (mpg - min(mpg)) / (max(mpg) - min(mpg)))

# merge (합병) # rbind, cbind 역시 합병 (데이터 프레임 합병)
# 차이점? : 양 쪽에 키가 있어야 함.
x <- data.frame(name = c("a", "b", "c"), math = c(1,2,3))
y <- data.frame(name = c("a", "b", "d"), english = c(4,5,6))
merge(x, y)  # 키가 일치하는 경우에 합병, 출력
merge(x, y, all=TRUE)  # 모든 경우 합병, 없으면 NA 출력

merge(x, y, all.x=TRUE)  # x 프레임만 대하여 합병 (= left join)
merge(x, y, all.y=TRUE)  # y 프레임만 대하여 합병 (= right join)
merge(x, y, all=TRUE)    # full join

# search
search()
attach(airquality)
search()  # 데이터를 패키지처럼 로딩
# transform(airquality$Ozone, airquality$logOzone = airquality$log(Ozone))
transform(Ozone, logOzone = log(Ozone))
detach(airquality)
search()
ls()

# subset (부분집합)
subset(iris, subset=(Species == "setosa"))  # 조건을 추가
subset(iris, subset=(Species == "setosa" & Sepal.Length>5.0))
subset(iris, select=c(Sepal.Length, Species))   # 열을 선택하여 출력
subset(iris, select=-c(Sepal.Length, Species))  # 조건의 열을 제외하고 출력
subset(iris, subset=(Species == "setosa"), select=c(Sepal.Length, Species))  # setosa에 대해, Sepal.Length와 Species 출력

# 문제 : 실린더가 4~6개인 자동차 중 연비, 실린더수, 변속기 종류 출력
subset(mtcars, select=c(mpg, cyl, am), subset = cyl>=4 & cyl<=6)
subset(mtcars, select=c(mpg, cyl, am), subset = (cyl %in% c(4,5,6)))

# 문제 : 실린더가 4 또는 6개인 자동차 중 연비(mpg), 실린더(cyl), 변속기(am), 마력(hp) 종류를 출력
subset(mtcars, select=c(mpg, cyl, am, hp), subset = (cyl==4 | cyl==6))
subset(mtcars, select=c(mpg, cyl, am), subset = (cyl %in% c(4,6)))

# 연습문제
# 1. 연비(mpg)가 20보다 큰 자동차 중 연비, 실린더수, 변속기 종류를 출력
subset(mtcars, select=c(mpg, cyl, am), subset=(mpg>20))
# 2. 변속기가 자동이고 실린더가 4개, 6개인 자동차들의 연비 평균은?
subset(mtcars, subset= (am == 0 & (cyl==4 | cyl==6)), select = c(mpg) )
colMeans(subset(mtcars, subset= (am == 0 & (cyl==4 | cyl==6)), select = c(mpg)))

       
# 과제 (20230322) :
(revenue_cube <-
    tapply(sales_fact$amount,
           sales_fact[ , c("prod", "month", "year", "loc")],  # 데이터를 4차원으로 확인
           FUN = function(x){return(sum(x))}))
       
아래 소스를 (4차원 행렬) 그림으로 표현 (그리기)
