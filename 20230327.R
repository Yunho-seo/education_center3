data(iris)
head(iris)
str(iris)
summary(iris)
dim(iris)
levels(iris$Species)
unique(iris$Species)
score4 <- c(3,3,6,7,7,10,10,10,11,13,30)
(n <- length(x))
# 대표값
min(score4)
max(score4)
range(score4)
diff(range(score4))
mean(score4)
median(score4)
sum(score4)
sort(score4)
order(score4)
summary(score4)
var(score4)  # 분산  54.2    # 문제 : var를 수식으로 구하기
# 자유도 : 표본에서는 전체개수-1 => (n-1)
(total<-sum((score4-mean(score4))^2))  # 542
(total<-sum((score4-mean(score4))^2) / (length(score4)-1))  # 54.2

sd(score4)   # 표준편차  # 문제 : sd를 수식으로 구하기
sqrt(total)  # 7,362065

range(score4)
quantile(score4)
quantile(score4, probs=c(1:100)/100)  # 백분위 수를 전체 출력
(Iqr <- quantile(score4)[4] - quantile(score4)[2])  # IQR
IQR(score4)

# 정규분포인 경우
# 1차 원점에 대한 적률 (평균을 빼거나, 빼지 않는가에 따라) : 누적했다는 말
# 2차 중심적률 : 분산 (중심 : 평균)
# 3차 중심적률 : 왜도 - 기준점이 0 : 좌우 대칭
# 4차 중심적률 : 첨도 - 기준점이 3 : 뾰족함의 정도

# install.packages("moments")
library(moments)
set.seed(1234)
n.sample <- rnorm(n=10000, mean=55, sd=4.5)
skewness(n.sample)  # 왜도 : 정규분포이면, 0
kurtosis(n.sample)  # 첨도 : 정규분포이면, 3

# 만약 정규분포가 아니라면, 정규분포화 해야한다. 분석 => 변환
# install.packages("UsingR")
library(UsingR)
data(cfb)
head(cfb)
summary(cfb$INCOME)
hist(cfb$INCOME, breaks=500, freq=TRUE)
# log, sqrt, exp, 제곱 => 변환
cfb <- transform(cfb, INCOME_log = log(INCOME + 1))  # 로그를 취하면, 0일 때 무한대
hist(cfb$INCOME_log, breaks=500, freq=T)

cfb <- transform(cfb, INCOME_sqrt = sqrt(INCOME + 1))  # sqrt 변환 
hist(cfb$INCOME_sqrt, breaks=500, freq=T)
par(mfrow=c(1,3))
qqnorm(cfb$INCOME, main="INCOME")
qqline(cfb$INCOME)

qqnorm(cfb$INCOME_log, main="INCOM_log")
qqline(cfb$INCOME_log)

qqnorm(cfb$INCOME_sqrt, main="QINCOME_sqrt")
qqline(cfb$INCOME_sqrt)
par(mfrow=c(1,1))

skewness(cfb$INCOME)
kurtosis(cfb$INCOME)
skewness(cfb$INCOME_log)
kurtosis(cfb$INCOME_log)
skewness(cfb$INCOME_sqrt)
kurtosis(cfb$INCOME_sqrt)
# 키의 집단, 체중집단 : 사이즈가 다른 집단을 비교해야 하는 경우, 표준화를 해야 함
# 대표치 : 평균, 분산, 표준편차, 표준오차(표본개수를 고려) : 구간추정, 변동계수(평균사이즈를 고려) : 비교
data(trees)
dim(trees)
head(trees)
summary(trees)
sd(trees$Height);  # 6
sd(trees$Girth);   # 3
sd(trees$Volume);  # 16  =>  변동이 심함.
# 변동 여부를 확인 시, 변동계수를 만들어서 이질적인 집단에 대한 비교
sd(trees$Volume) / mean(trees$Volume)  # 0.54
sd(trees$Girth) / mean(trees$Girth)    # 0.23
sd(trees$Height) / mean(trees$Height)  # 0.08  => 변동이 심하지 않음 (변동이 제일 작다)

# 분포 : 정규분포, 카이제곱분포(범주형 데이터), T분포(평균 비교를 할 때), F분포 (세 집단 이상인 경우)
# 신뢰구간
# 표준오차(Standard error) : 신뢰구간 값을 구하기 위해 표준오차 값을 구한다.
x = c(0,1,2,3,4,5,6,7,8,9,10,11)
(sem <- sd(x) / sqrt(length(x)))
c(mean(x) - 2*sem, mean(x) + 2*sem)  # 95%  : 1.96 => 모집단의 정규분포
                                     # 표본 : 1.97 => T 분포
c(mean(x) - 3*sem, mean(x) + 3*sem)

# 모든 데이터에 대하여 평균을 빼고 제곱 : 표준편차 / sqrt(length(x)) => 표준오차의 공식
sem <- sqrt(sum((x-mean(x))^2) / (length(x)-1)) / sqrt(length(x))
c(mean(x) - 2*sem, mean(x) + 2*sem)  # 표준편차의 2배수( 95% 신뢰구간 )
c(mean(x) - 3*sem, mean(x) + 3*sem)  # 99% 신뢰구간 (국방, 의료 분야에서 사용) / 1% 유의 수준

# 문제
# iris 데이터의 Sepal.Length에 대하여 표준오차를 구하고 95% 신뢰구간 값을 구하기
# 표준오차를 위해 구해야할 값 : 표준편차, 데이터개수-1 == 자유도, 평균값, 표준오차
(mean_value <- mean(iris$Sepal.Length))
(n <- length(iris$Sepal.Length))
(std <- sd(iris$Sepal.Length))
(st_error <- std / sqrt(n))  # 표준오차
degrees_of_freedom = n-1

# 분위수 (0.05유의 수준) : 95%
 alpha = 0.05
# 정규분포 (rnorm(랜덤), dnorm(특정값에서의 확률), qnorm(특정 확률값에 해당하는 분위수), pnorm(값의 누적확률값))
# t 분포 : 표본에 대해서는 t 분포를 사용한다.
# 확률에 대해서 분위수 (확률을 입력하면 -> 입력한 확률에 대한 분위수)
# 자유도에 따라서 분포도가 달라짐(정규분포는 표준정규분포 하나만 있음)
 (t_score = qt(p=alpha/2, df=degrees_of_freedom, lower.tail=F))  # 1.976 , 정규분포, 1.96
 margin_error <- t_score * st_error
 lower_bound <- mean_value - margin_error
 upper_bound <- mean_value + margin_error
# 신뢰구간
 print(c(lower_bound, mean_value, upper_bound))

# 모집단의 분포 -> 검정이 가능함. (표본이 어느 지점에서 뽑혔는지) : 유의수준에 따라. ( 5% (사회적 문제), 1% (국방, 의료 문제) )
# 모수 분포(정규분포인 경우), 비모수분포(정규분포가 아닌경우) -> 머신러닝
# 선형회귀 => tree 분석 => Machine Learning

rnorm(5, 64.5, 2.5)  # random. 평균이 64.5, 표준편차가 2.5 인 요소 5개를 뽑아내기(난수)
                     # 정규분포에서 확률이 가장 높은 분위수(x축, y축은 확률)는 평균
# z-점수 = x-xbar / sd(x)
(x <- rnorm(1000, 0, 1))
(x <- sort(x))
(d <- dnorm(x, 0, 1))

plot(x, d, main="표준정규분포")
curve(dnorm(x), -3, 3)
plot(density(rnorm(10000, 0, 1)))  # interploation(보간법을 사용)
# 확률은 0 ~ 1 사이의 값
pnorm(0)  # 값의 누적 확률 값
pnorm(1) - (1-pnorm(1))
# 2사분위수의 누적 확률
pnorm(2) - (1-pnorm(2))
pnorm(1.96) - (1-pnorm(1.96))
# 3배수
pnorm(3) - (1-pnorm(3))
pnorm(1) - (pnorm(-1))
dnorm(0, 0, 1)  # 분위수 => 확률 (평균일때 확률은?) (표준정규분포에서 값이 0일 때의 확률 밀도 값) 0.3989423
dnorm(1, 0, 1)  # 24%

# 문제 (샘플 개수가 필요한 경우는 표준 오차를 구할때이다.)
# 문제1) 평균이 100이고 표준편차가 10인 정규분포에서 50이 나올 확률은?
z = (50-100)/10  # z-점수로 바꿨다는 것은? => 표준정규분포로 바꾸었다는 것(평균이 0, 표준편차가 1인 경우)
dnorm(z, 0, 1)   # 1.48672e-06 (희박한 확률)

# 일반 모든 정규분포는 표준정규분포로 매핑 (z-점수)

# 문제2) 평균이 90이고 표준편차가 12인 정규분포에서 98이 나올 확률은?
# 한 지점에서 평균이 90이고 표준편차가 12일때의 누적 확률, 이것을 표준화(Z점수)했을 때 
# 누적확률은 같은데 한 지점에서의 출현확률은 다르다.
# 매핑
# 상태가 같은 상태 : 한 지점에서의 확률값 => 표준정규분포 확률값
# 범위값에 해당하는 함수
# Z 점수 : 표준정규분포 매핑

dnorm(98, 90, 12)

qnorm(0.319448)  # 0.319448의 분위수
# x축 : 표준편차 분위수, 표준편차의 몇 배수인가 / z = (x - mu) / sd
plot(seq(-3.2, 3.2, length=50), dnorm(seq(-3, 3, length=50), 0, 1), type="l", xlab="", ylab="",
     ylim=c(0,0.5))
segments(x0 = c(-3,3), y0 = c(-1, -1), x1 = c(-3, 3), y1 = c(1, 1))
text(x=0, y=0.45, labels=expression("99.7%가 표준편차 3배수 안에 3" ~ sigma))
arrows(x0 = c(-2, 2), y0 = c(0.45, 0.45), x1 = c(-3, 3), y1 = c(0.45, 0.45))
segments(x0 = c(-2, 2), y0 = c(-1, -1), x1 = c(-2, 2), y1 = c(0.4, 0.4))
text(x=0, y=0.3, labels=expression("95%가 표준편차 2배수 안에 2" ~ sigma))
arrows(x0 = c(-1.5, 1.5), y0 = c(0.3, 0.3), x1 = c(-2, 2), y1 = c(0.3, 0.3))
segments(x0 = c(-1, 1), y0 = c(-1, -1), x1 = c(-1, 1), y1 = c(0.25, 0.25))
text(x=0, y=0.15, labels=expression("68%가 표준편차 1배수 안에 1" ~ sigma), cex=0.9)

# 확률의 범위를 표현
curve(dnorm(x, 0, 1), -4, 4, xlab="z", ylab="f(z)")  # -4 ~ 4까지.
z=seq(0, 4, 0.02)
lines(z, dnorm(z), type="h", col="grey")

# 문제
# 비행기의 평균 비행시간은 120시간이다. 비행시간이 정규분포이고
# 표준편차가 30시간이라고 가정하고 9대를 표본으로 추출할 때와 36대를 표본으로 추출할 때,
# 표본평균과 분산을 비교

# 표본이 많아지면 => 모집단이 됨.
# 표본이 많아지면 분산이 커지고, 표준오차는 줄어든다.
(t9 = rnorm(9, 120, 30))
(t36 = rnorm(36, 120, 30))
mean(t9)   # 112.6335
var(t9)    # 375.0752
mean(t36)  # 125.0417
var(t36)   # 751.6718

# 표준오차 ( 표준편차 / 데이터 길이 )
stderr <- function(x) sd(x, na.rm = T) / sqrt(length(na.omit(x)))  # na.omit(x)는 x 데이터프레임 중 결측치 제거
stderr(t9)
stderr(t36)

# 문제
# X-(300, 50^2)인 정규분포(평균이 300, 분산이 2500)에서 P(X >= 370)일 확률을 구하기 (z-점수 사용)
(1-pnorm(370, 300, 50))  # 분포를 입력
(1-pnorm((370-300)/50))  # z-점수

(x <- rnorm(1000, 0, 1))
curve(dnorm(x, 0, 1), -4, 4, xlab="z", ylab="f(z)")
z = seq(((370-300) / 50), 4, 0.01)
lines(z, dnorm(z), type="h", col="gray")
points(((370-300)/50), dnorm(((370-300)/50)))

# 문제 3
# 백열전구의 수명이 1500시간의 평균값과 75시간의 표준편차로 정규분포되어 있다.
# 1) 백열 전구가 1410시간보다 덜 오래갈 확률은?

(Z = (1410-1500) / 75)
pnorm(Z)  # 값의 누적확률값
pnorm(1410, 1500, 75)  # 0.1150697 = 11%
curve(dnorm(x, 0, 1), -4, 4, xlab="z", ylab="f(z)")
z = seq(-4, (1410-1500)/75, 0.01)
lines(z, dnorm(z), type="h", col="gray")

# 2) 백열 전구가 1563 ~ 1648시간 사이의 오래 갈 확률?
Z1 <- (1563 - 1500) / 75
Z2 <- (1648 - 1500) / 75
pnorm(Z2) - pnorm(Z1)  # 1563시간에서 1648시간 사이의 확률, 0.1762254 = 17%
curve(dnorm(x, 0, 1), -4, 4, xlab="z", ylab="f(z)")
z = seq((1563-1500)/75, (1648-1500)/75, 0.01)
# z=seq(0.4, 0.02)
lines(z, dnorm(z), type="h", col="gray")


# 문제 4
# 우리나라에서 사육하는 생후 18개월 이상 된 황소의 무게는 평균이 500kg이고
# 표준편차가 50kg인 정규분포라 한다. 이제 우량 한우를 집중 관리하기 위해,
# 무게가 무거운 순서대로 5%에 해당하는 황소를 선별하고자 한다.
# 그렇다면 무게가 몇 kg 이상인 황소를 선발해야 하는가?

qnorm(1-0.05, 500, 50)  # 582.2427kg 이상인 황소를 선정해야 한다.

# Z점수를 구하는 함수 : scale()
(x <- matrix(1:10, ncol=2))
scale(x)  # 평균, 표준편차(열중심으로 계산) : z-점수 정규화 
(centered.x <- scale(x, scale=F))  # 평균

# 평균 비교 (정규화하여 비교) : 두 집단에서 평균과 표준편차가 다르면 직접 비교할 수 없다
# 이런 경우에는 Z-점수 표준화 이후 비교한다.
set.seed(100)
(h_korean <- rnorm(n=1000, mean=170, sd=10))
(h_bushman <- rnorm(n=1000, mean=140, sd=8))
height <- data.frame(h_korean, h_bushman)  # R은 복사에 의해 전달된다.
# rm(h_korean, h_bushman)  # h_korean와 h_bushman의 데이터 값들은 삭제된다.

par(mfrow = c(1, 2))
hist(h_korean, freq = T, main="한국인 키 빈도 히스토그램")
hist(h_korean, freq = F, main="한국인 키 빈도 확률밀도함수 그래프")

hist(h_bushman, freq = T, main="부시맨 키 빈도 히스토그램")
hist(h_bushman, freq = F, main="부시맨 키 빈도 확률밀도함수 그래프")

(height <- transform(height, z2.h_korean = (h_korean - mean(h_korean)) / sd(h_korean),
                     z2.h_bushman = (h_bushman - mean(h_bushman)) / sd(h_bushman)))
(height <- transform(height, z.h_korean = scale(h_korean), z.h_bushman = scale(h_bushman)))

hist(height$z.h_korean, freq=T, main="한국인 표준")  # freq=T 하면 y축이 Frequency(빈도)로, F하면 Density(밀도)로 표기됨
hist(height$z.h_bushman, freq=T, main="부시맨 표준")

# 문제
# 160cm의 키가 한국인과 부시맨에서 어떤 위치인지 비교
# z-점수로 비교 / dnorm 발생확률로 비교
# z점수
(160 - mean(h_korean)) / sd(h_korean)    # -1.022838 / 역 1배수
(160 - mean(h_bushman)) / sd(h_bushman)  # 2.509045  / 정 2.5배수 
# dnorm
dnorm(160, mean(h_korean), sd(h_korean))   # 0.0242431
dnorm(160, mean(h_bushman), sd(h_bushman)) # 0.00219079


