# graphic
data(cars)
str(cars)  # 50x2 행렬 : data.frame
head(cars)
plot(cars$speed, type="l")  # 2차원 (x, y축) 데카르트 좌표 : 90도로 직교 
plot(cars$dist, type="l")
plot(cars, type="l")  # line
plot(cars, type="p")  # point
plot(cars, type="b")  # both
# point shapes is pch
plot(cars, type="b", pch=20)  # ploting character
plot(cars, type="b", pch=22)
plot(cars, type="b", pch="+")
plot(cars, type="b", pch=2, cex=2)  # cex : 점의 크기
plot(cars, type="l", pch="+", cex=2, col="red", lty="dotdash")  # 0-6번까지.
plot(cars, main="그래픽", sub="옵션확인을 위해서", col="red", xlab="speed", ylab="distance", ylim=c(0,40),
     xlim=c(1,10), type="l", asp=1) # aspect

# 문제 : 라인타입(lty)의 종류 확인
# blank(빈칸), solid(실선), dashed(대시선), dotted(점선), dotdash(점-대시-점), longdash(긴 대시선), twodash(두줄 대시)
# plotting character : 0~25까지, 26개
# cex : character expansion

plot(cars, cex=0.5)
identify(cars$speed, cars$dist)  # 좌표 표현
plot(cars, cex=0.5)
text(cars$speed, cars$dist, pos=1)  # 포인트에 대한 값을 출력

# 앞면하고 뒷면이 있는 코인에 대하여 5회 던졌을 때, 앞면이 나온 횟수
coin <- c(2, 2, 0, 1, 1, 1, 2, 3, 1, 2, 2, 3, 3, 4, 1, 3, 2, 3, 3, 1, 2, 2, 1, 2, 2)
(frequency <- table(coin))  # 도수 분포표
(relative <- frequency/length(coin))  # 상대 도수 분포표
(cumulative <- cumsum(relative))  # 누적(cumsum) 상대도수 분포표

# par : margins, fonts, colors 등을 지정(수정)할 수 있다.
opar <- par(mfrow=c(1, 4)) # 1행 4열, 이전의 상태값 리턴
plot(frequency, xlab="값", ylab="도수", type="b", col="red", main="도수",
     sub="순수도수", frame.plot = F, panel.first=T)
plot(1:5, frequency, xlab="값", ylab="도수", type="b", col="red", frame.plot = F)
plot(round(relative, 2), type="b", pch=23, col="red")
plot(round(cumulative, 2), type="b", col="red", axes = F)  # axes = F : 축을 그리지 않음
par(opar)  # 상태를 복원
opar <- par(mfrow=c(1,1))
plot(round(cumulative, 2), type="b", col="red", axes = F)

plot(c(1:10), xlab=expression(xLab ~ x^2 ~ m^-2), #  ~ mu ~ sqrt(2) ~ pi),
     ylab = expression(yLab ~ y^2 ~ m^2),
     main = "Plot 1")

max.temp <- c(22, 27, 26, 24, 23, 26, 28)
names(max.temp) <- c("Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat")
par(mfrow=c(1, 2))
barplot(max.temp, main="Barplot")
pie(max.temp, main="Piechart", radius=1)
par(mfrow=c(1,1))

?faithful
str(faithful) # 분출 - 분출 간 대기시간
with(faithful, {  # bw : bandwidth (주변에 영향을 미치는 구간) (주변값)
  plot(density(eruptions, bw = 0.15))  # 밀도 -> 보간법을 이용하여 연속적으로 표현
  rug(eruptions)
  # jitter : 잡음을 지정 
  rug(jitter(eruptions, amount=0.01), side=3, col="light blue")
})

library(MASS)
Boston$tax
plot(density(Boston$tax, bw=5)) # 보간법 사용
rug(Boston$tax + rnorm(length(Boston$tax), sd=5), col=2, lwd=3.5)  # 표준편차(sd)가 5인 만큼 규격화

# sin 그래프
(x=(0:100) * pi / 10)
plot(x, sin(x), # + exp(x/10) : 주기적으로 성장하는 형태
     main="sin 출력",
     ylab="",
     type="l",
     col="blue")
# cos 그래프
(x=(0:100) * pi / 10)
plot(x, cos(x),
     main="cos 출력",
     ylab="",
     type="l",
     col="violet")

# 시계열 데이터. 시계열 데이터는 주기성을 띄고 있음
amp.1 <- 2  # 진폭을 결정
amp.2 <- 2
amp.3 <- 5
amp.4 <- 5

wav.1 <- 1  # 주기를 결정
wav.2 <- 2
wav.3 <- 3
wav.4 <- 7

signal.1 <- amp.1 * sin(wav.1 * x)  # (라디오파) 장파, 저주파
signal.2 <- amp.2 * sin(wav.2 * x)  # 회전 각도가 빨라짐 (내부 변화)
signal.3 <- amp.3 * sin(wav.3 * x)
signal.4 <- amp.4 * sin(wav.4 * x)  # 단파, 고주파

par(mfrow=c(1, 4))
plot(x, signal.1, type="l", ylim=c(-5, 5)); abline(h=0, v=0, lty=3)
plot(x, signal.2, type="l", ylim=c(-5, 5)); abline(h=0, lty=3)
plot(x, signal.3, type="l", ylim=c(-5, 5)); abline(h=0, lty=3)
plot(x, signal.4, type="l", ylim=c(-5, 5)); abline(h=0, lty=3)
par(mfrow=c(1,1))

par(mfrow=c(1, 2))
str(cars)  # 스피드에 따른 제동거리 (제동 거리 중복)
           # 고주파 -> 저주파로 변환 (규칙, 패턴 발견이 용이함)
plot(cars$dist, type="o", cex=0.5, xlab="speed", ylab="dist")
tapply(cars$dist, cars$speed, mean)
plot(tapply(cars$dist, cars$speed, mean), type="o", cex=0.5, xlab="speed", ylab="dist")
par(mfrow=c(1,1))

# 통계학 :
#     추상과 검증

# ex. 우리나라 전 국민의 키의 평균 -> 비용, 시간의 문제
#  -> 표본을 구하여(각 도의 랜덤으로 3개 동을 구하기)
#     키의 평균 -> 모집단(전 국민) 키의 평균으로 추정
#     추정 : 점 추정보다는 구간 추정이 유리 (틀릴 확률 감소)

# 구간을 정하는 문제 : 표준 오차로 구함
# 표준오차 : 표준편차를 sqrt(루트) (표본의 개수)
# 표본이 많다면 분산도 커짐
# 1.96 : 표준편차의 2배수 -> 95% 신뢰구간
# 평균 - 표준오차 * 2 ~ 평균 + 2 * 표준오차  ==>  신뢰구간

# 선형회귀(linear regression) -> 점 추정과 구간 추정 -> 신뢰구간
# 데이터를 기울기와 절편을 구해서 추정
# lm : linear model

(m <- lm(dist ~ speed, data=cars))  # lm : 선형회귀, 기울기와 절편이 리턴되어야 함
plot(cars)  
dim(cars)  # 50x2
abline(m)  # 축을 그릴때 사용하는 라인 (직선을 적도)
(p <- predict(m, interval = "confidence"))  # 신뢰구간을 가지고 예측
head(p)
x <- c(cars$speed, tail(cars$speed, 1), rev(cars$speed), cars$speed[1])  # 50개 중 맨 뒤의 하나를 추출 (tail)
y <- c(p[, "lwr"], tail(p[, "upr"], 1), rev(p[, "upr"]), p[, "lwr"][1])
# 폐다각형
polygon(x, y, col=rgb(.7,.7,.7,.5))  # rgba alpha 투명도


# 비선형회귀
opar <- par(mfrow=c(1,1))
plot(cars)
lines(lowess(cars))  # 딥러닝은 비선형

# 문제 : women 데이터에 대해 선형회귀 후, 회귀선을 출력
str(women)  # 키와 체중 간 관계, 15x2 행렬
head(women)
summary(women)
(res = lm(height ~ weight, data=women))  # 키에 따른 체중 변화
# 순서를 변경하기 위해
plot(women$weight, women$height)  # 독립변수(weight)가 x축으로 와야 함, 종속변수가 y축
abline(res)

###### 관측값뿐만 아니라 다양한 파생변수와 관계를 고려
# trees 데이터
str(trees)
Height2 <- trees$Height^2  # 파생변수도 종속 변수에 영향을 미칠 수 있다.
trees2 <- cbind(trees, Height2)
attach(trees2)
(test2 <- lm(Girth ~ Height + Height2))
plot(Girth ~ Height)
fitted(test2)
lines(sort(Height), fitted(test2)[order(Height)], col="red", type="l")
detach(trees2)

###
par(mfrow=c(1,1))
honeymoon <- c(12, 14, 8, 9)
names(honeymoon) <- c("하와이", "동남아", "유럽", "기타")
pie(honeymoon, col=rainbow(4))

(per <- round(100 * honeymoon / sum(honeymoon), 1))  # 소수점 첫째 자리까지 출력. 비율
lab <- paste(names(honeymoon), "\n", per, "%")  # paste() : 하나의 문자열로 만들기(java에서의 cat())
pie(honeymoon, labels=lab, col=rainbow(4))  # rainbow() : color palette

# pie의 원점은 가운데 지점
text(-0.5, 0.2, "35%", col="red")
text(0.3, 0.3, "30%", col="black")
text(-0.1, -0.5, "20%", col="black")
text(0.5, -0.3, "15%", col="black")

# 정규분포와 데이터를 비교한 결과를 출력
x <- rnorm(1000, mean=100, sd=1)  # 정규분포. 평균이 100이고 표준편차가 1인 1000개의 데이터 랜덤 생성
qqnorm(x)
qqline(x, lty=2)

x <- runif(1000) # 균등분포 -> 정규분포가 아니다
qqnorm(x)
qqline(x, lty=2)

# lattice 패키지
library(lattice)
str(airquality)  # 153x6
head(airquality)  # Ozone, Wind, 5~9월(Month)
xyplot(Ozone ~ Wind, data=airquality)
xyplot(Ozone ~ Wind | Month, data=airquality) # Month 별로 분할 (범주형이 아니라 int형이라, int형에 그룹별로 묶음)

xyplot(Ozone ~ Wind | Month, data=airquality, layout=c(3, 2))
convert <- transform(airquality, Month=factor(Month))  # Month에 월 수를 부여 (int형에서 범주형으로 바꿔주어야 함)
xyplot(Ozone ~ Wind | Month, data=convert, layout=c(5, 1))

# qplot(quick plot), ggplot
library(ggplot2)
str(mpg)  # 234 x 11
qplot(displ, hwy, data=mpg)  # (displ : x축, hwy : y축)
qplot(displ, hwy, data=mpg, color=drv)  # 범례를 자동으로 출력. drv마다 color값을 넣기
qplot(hwy, data=mpg, fill=drv, binwidth=2)  # drv로 채우기(fill)
# 범주형 출력
qplot(hwy, data=mpg, fill=drv, facets=.~ drv, binwidth=2)
# 중량별 연비 -> carb 종류별로.
qplot(wt, mpg, data=mtcars, color=factor(carb), shape=factor(cyl))
# 비선형회귀
qplot(wt, mpg, data=mtcars, color=factor(cyl), geom=c("point", "smooth"))
qplot(wt, mpg, data=mtcars, color=factor(cyl), geom="point") + geom_line()  # 포인터로 찍고 라인으로 연결

# ggplot : 레이어(layer)
# Data, Function (요약)
# Coodinates (축을 지정 : aes)
# Mapping (color, size, shape, transparency, fill)
# Geometries (geom_point : 출력 모양) 
# Scales (데이터 스케일링, 정규화(전처리 작업)) 
# Facets (범주별로 출력)
# Themes (전체적인 배경이나 글꼴)
(p <- ggplot(mtcars, aes(wt, mpg)))  # 기본 형태를 지정
p + geom_point()
p + geom_point(aes(colour = factor(cyl))) # 색깔 지정
p + geom_point(aes(shape = factor(cyl)))  # 모양 지정
p + geom_point(aes(size = qsec))          # 포인트의 사이즈
ggplot(mtcars, aes(wt, mpg)) + geom_point(colour = "red", size =3)
# y축이 지정되지 않았음 : 자동으로 count 라는 통계처리.
ggplot(data=mtcars) + geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position="dodge")

ggplot(mpg, aes(x=hwy, fill=drv)) + geom_dotplot(binwidth = 2)
ggplot(mpg, aes(x=hwy)) + geom_histogram(binwidth=2)  # 연속된 수치에 대해 구간별로 카운트
ggplot(mpg, aes(x=hwy)) + geom_density()  # 보간법에는 다양한 커널(kernel)이 있다. (선형, 비선형) (y축이 density)
ggplot(mpg, aes(x=hwy)) + geom_density() + coord_flip()

# 문제 : iris 데이터에 대하여 x=Sepal.Length, y=Sepal.Width로, geom_point 기하 형태로 출력
# 조건 : point size는 3으로 설정
# 위의 그래프에서 Species를 구분하도록, 모양(shape)을 다르게 하여 출력하기
# 조건2 : Species를 범주형으로 3개의 그래프로 출력하기
str(iris)

ggplot(iris, aes(Sepal.Length, Sepal.Width, shape=Species)) + geom_point(size=3) + facet_wrap( ~ Species, ncol=3)

res <- ggplot(iris, aes(Sepal.Length, Sepal.Width, shape=Species))
res <- res + geom_point(size=3)
res + facet_wrap ( ~ Species, ncol =3 )


# 문제
# 도수분포표, 상대 도수 분포표, 누적 도수 분포표를 만든 다음 dataframe에 하나의 데이터로 묶고
# ggplot을 이용해서 시각화 (하나의 화면에 모두 출력되는 것을 권장 : geom_point, geom_line)

coin <- c(2,2,0,1,1,1,2,3,1,2,2,3,3,4,1,3,2,3,3,1,2,2,1,2,2) 
(frequency <- table(coin)) # 도수 분포표
(relative <- frequency / length(coin)) # 상대 도수 분포표
(cumulative <- cumsum(relative)) # 누적 도수 분포표

class(frequency)

(po <- data.frame(
  frequency = frequency, 
  relative = relative, 
  cumulative = cumulative)
)

str(po)  # 5x5

ggplot(po, aes(po$relative.coin, po$frequency.Freq, group=1)) + geom_point(size=3) + geom_line()
ggplot(po, aes(po$relative.coin, po$relative.Freq, group=1)) + geom_point(size=3) + geom_line()
ggplot(po, aes(po$relative.coin, po$cumulative, group = 1)) + geom_point(size=3) + geom_line()

ggplot(po, aes(po$relative.coin, po$frequency.Freq, group=1)) +
  geom_line(color = "red") +
  geom_line(aes(y=po$relative.Freq), color = "blue") +
  geom_line(aes(y=po$cumulative), color = "green") +
  labs(x = "코인", y = "분포 및 확률") +
  scale_y_continuous(breaks = seq(0,10,1))

# ----------------------------------------------------- #

coin <- c(2,2,0,1,1,1,2,3,1,2,2,3,3,4,1,3,2,3,3,1,2,2,1,2,2) 

# 열 0, 1, 2, 3, 4 / 열 val / 열 type
# 5개 (15x3)
(coin.freq <- table(coin))
class(coin.freq)
(coin.rel = round(coin.freq/length(coin), 2))
(coin.cum = cumsum(coin.rel))
(coin.num = sort(unique(coin)))  # 경우의 수를 만들기
# data.frame의 열은 vector로 생성됨
# 똑같은 열 이름으로 생성
(coin.freq <- data.frame(coin.num = coin.num, coin.freq=as.vector(coin.freq)))
names(coin.freq)[2] <- paste("val")
coin.freq$type = rep("freq", length(coin.num))
coin.freq

(coin.rel <- data.frame(coin.num, coin.rel=as.vector(coin.rel)))
names(coin.rel)[2] <- paste("val")
(coin.rel$type = rep("rel", length(coin.num)))
coin.rel

(coin.cum <- data.frame(coin.num, coin.cum=as.vector(coin.cum)))
names(coin.cum)[2] <- paste("val")
(coin.cum$type = rep("cum", length(coin.num)))
class(coin.cum)
coin.cum

# long형으로 묶음
(coin.graph <- rbind(coin.freq, coin.rel, coin.cum))

ggplot(coin.graph, aes(coin.num, val, group=type, col=type)) +
  geom_point() + geom_line()

# R의 ggplot2에서 y축의 양쪽 scale을 달리 주는 방법?
ggplot(mtcars, aes(x = wt)) +
  geom_point(aes(y = mpg, color = "mpg")) +
  geom_point(aes(y = qsec, color = "qsec")) +
  geom_line(aes(y = qsec * 10, color = "qsec")) +
  scale_y_continuous(
    name = "mpg",
    sec.axis = sec_axis(~ . / 10, name = "qsec * 10"),
    breaks = seq(10, 40, 5),
    limits = c(10, 40)
  ) +
  labs(x = "wt", color = "Variable")

# 다음 코드를 역코딩하시오 (주로 범주형 데이터의 값의 변환이고 요약변수를 생성하는 것)
# resident2 : '1.서울특별시', '2.인천광역시', '3.대전광역시', '4.대구광역시', '5.서구군'
# job2 : '1.공무원', '2.회사원',' 3.개인사업'
# age2 : 청년층, 중년층, 장년층
# position2 : 1급, 2급, 3급, 4급, 5급
# gender2 : 성별 1:남자, 2:여자
# age3 : 청년층, 중년층, 장년층의 level 번호로 저장

getwd()
data <- read.csv("dataset.csv", header=TRUE)
str(dataset)

data <- read.csv("C:/Users/401-25/Documents/dataset.csv", fileEncoding = "CP949", header=T,)
data

resident2 <- c('1.서울특별시', '2.인천광역시', '3.대전광역시', '4.대구광역시', '5.서구군')
job2 <- c('1.공무원', '2.회사원', '3.개인사업')
age2 <- c('청년층', '중년층', '장년층')
position2 <- c('1급', '2급', '3급', '4급', '5급')
gender2 <- c('1:남자', '2:여자')
age3 <- factor(c('청년층', '중년층', '장년층'), levels=c('청년층', '중년층', '장년층'))


# 문제1) 데이터 구조 확인
str(data)
dim(data)
nrow(data)
ncol(data)
length(data)
summary(data)
names(data)
attributes(data)


# 문제2) 다양한 방법으로 데이터 조회
print(data)
View(data)
head(data)
tail(data)
data$age
data[1, 5]
data[2]
data[c('age', 'gender')]


# 문제3) 결측치를 확인하고
# 3-1) 결측치 개수를 확인하고 제거
colSums(is.na(data))
sum(is.na(data))
sapply(data, function(x) sum(is.na(x)))
nrow(data)

na.omit(data)
## data <- na.omit(data)


# 3-2) 결측치의 값을 0, 또는 평균값으로 대체
x <- data$price
sum(is.na(x))
price2 <- na.omit(data$price)

(data$price2 <- ifelse(!is.na(x), x, 0))  # 전체 데이터를 처리하는 방식
(data$price2 <- ifelse(is.na(x), 0, x))

# 평균
(data$price3 <- ifelse(!is.na(x), x, round(mean(x, na.rm=T), 2)))


# 문제4) 이상치를 확인하고
# 4-1) 변수별 이상치 확인
# boxplot은 정량적 데이터에만 적용 가능하다.
# data.frame : 범주형인지, 정량적 데이터인지 판단할 수 있어야 함
quantile(data$resident, na.rm=T)
quantile(data$gender, na.rm=T)
quantile(data$age, na.rm=T)  
quantile(data$position, na.rm=T)
quantile(data$price, na.rm=T)
quantile(data$survey, na.rm=T)

boxplot(data$age)

quantile(data$resident, 0.75) + 1.5 * IQR(data$resident, na.rm=T)

# 4-2) 이상치 제거


# 문제 5) gender 변수를 정제 (as.factor) (범주형 데이터 -> 숫자를 매칭 (DB))
# 범주형일 때에는 table로 확인
pie(table(data$gender))
data <- subset(data, gender==1 | gender==2)
table(data$gender)

# 확인
data %>%
  select(gender) %>%
  filter(gender==1 | gender==2) %>%
  table()

# 처리
data<- data %>%
  filter(gender==1 | gender==2)

# 정량적 데이터
boxplot(data)
boxplot(data$price)  # 3사분위수 + IQR * 1.5
data2 <- subset(data, price >= -100 & price <= 100)  # 일정한 값으로 제한
data2


# 문제6) price 변수를 확인하고 범위값으로 제한(2~10)
(data2 <- subset(data, price >= 2 & price <= 10))


# 문제7) age 변수를 20~69 사이의 값으로 제한하고 시각화
(data2 <- subset(data, age >= 20 & age <= 69))


# 문제8) resident2 변수를 resident변수의 값에 따라 입력
#        '1.서울특별시', '2.인천광역시', '3.대전광역시', '4.대구광역시', '5.서구군'
data2$resident2[data2$resident == 1] <- '1.서울특별시'
data2$resident2[data2$resident == 2] <- '2.인천광역시'
data2$resident2[data2$resident == 3] <- '3.대전광역시'
data2$resident2[data2$resident == 4] <- '4.대구광역시'
data2$resident2[data2$resident == 5] <- '5.서구군'
data2[c("resident", "resident2")]
# if문을 이용해서 반복적으로 작성하는 코드로 처리


# 문제9) job2 변수에 job에 따른 값 입력하기
#        '1.공무원', '2.회사원',' 3.개인사업'
data2$job2[data2$job == 1] <- '공무원'
data2$job2[data2$job == 2] <- '회사사원'
data2$job2[data2$job == 3] <- '개인사업'
head(data2)


# 문제10) 연속형 변수인 age를 age2에 범주화
#         age<=30 : 청년층, age<=55 : 중년층, age>55 : 장년층
data2$age2[data2$age <= 30] <- "청년층"
data2$age2[data2$age > 30 & data2$age <= 55] <- "중년층"
data2$age2[data2$age > 55] <- "장년층"
head(data2)


# 문제11) 긍정점수(survey) 5점 척도를 역순으로 재입력
#         1. 매우만족 ... 5. 매우 불만족
# 1-5 / 6-1=5 / 6-5=1
unique(data$survey)
csurvey <- 6-data$survey
unique(csurvey)
data$survey <- csurvey


# 문제12) 거주지역별(resident2), 성별 분포를 시각화
resident_gender <- table(data2$resident2, data2$gender)
barplot(resident_gender, beside=T, horiz=T,
        col = rainbow(5),
        legend = row.names(resident_gender),  # legend : 범례 지정
        main = "성별에 따른 거주지역 분포 현황")


# 문제13) 성별에 따른 거주지역 분포현황을 시각화
gender_resident <- table(data2$gender, data2$resident2)
barplot(gender_resident, beside=T, 
        col = rep(c(2, 4),5), horiz=T,  # 2, 4에 맞는 색깔로 5번 반복
        legend = c("남자", "여자"),  # legend : 범례 지정
        main = "거주지역별에 따른 성별 분포 현황")


# 문제14) 직업 유형에 따른 나이 분포현황을 시각화
densityplot( ~ age, data=data2, groups = job2,
              plot.point=T, auto.key=T)

# 문제15) 성별에 따른 직급별 구매비용을 시각화  ( 좀 이상함 )
densityplot( ~ price | factor(position), data=data2,
            groups = gender, plot.points=T, auto.key=T)

