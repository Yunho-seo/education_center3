# 카이제곱분포와 자유도
(x <- seq(1, 10, .1))
par(mfrow=c(2,3))
plot(x, dchisq(x, 6), type="l")  # probability density (확률 밀도 함수)
plot(x, dchisq(x, 5), type="l")
plot(x, dchisq(x, 4), type="l")
plot(x, dchisq(x, 3), type="l")
plot(x, dchisq(x, 2), type="l")
plot(x, dchisq(x, 1), type="l")

# factor(요소)를 기준으로 한 도수분포표
# 카이제곱 분석에서는 인접행렬을 필요로 한다.
x=c(1, 2, 3, 4, 5, 6)
y=c(7, 8, 9, 10, 11, 12)
z=10:15
(ta = table(x))
(tb = table(x, y))   # 인접 행렬 (Contingency table) : 그래프로 표현하는 방법
(tc = table(x, y, z))
class(tc)  # table

# xtabs (분할표)
(d <- data.frame(x=c("1", "2", "2", "1"), y=c("A", "B", "A", "B"), num=c(3,5,8,7)))
class(d)  # data.frame
str(d)
(xt = xtabs(num ~ x+y, data=d))  # xtabs(~도수 가로 + 세로)
class(xt)
margin.table(xt, 1)  # 행의 합계(1 : 행방향)
margin.table(xt, 2)  # 열의 합계(2 : 열방향)
margin.table(xt)     # 전체 합계
# 상대도수 (비율)
prop.table(xt, 1)  # 비율로 표현.
prop.table(xt, 2)
prop.table(xt)

Titanic
# Class, Sex, Age, Survived
class(Titanic)  # table
margin.table(Titanic, 1)  # 합계 : 선실별(Class) 전체 인원수
margin.table(Titanic, 2)  # Male, Female
margin.table(Titanic, 3)  # Child, Adult
margin.table(Titanic, 4)  # No, Yes (Survived)
margin.table(Titanic)

barplot(margin.table(Titanic, 1))
barplot(margin.table(Titanic, 2))
barplot(margin.table(Titanic, 3))
barplot(margin.table(Titanic, 4))
(titanic.data = xtabs( Freq ~ Survived + Sex, data=Titanic))  # Frep : 도수를 카운트하기

# Ftable
# 계층적 인덱스를 이용해서 표현
ftable(Titanic, row.vars = 1:3)
ftable(Titanic, row.vars = 2:1) 
ftable(Titanic, row.vars = 1:2, col.vars = "Survived")  # 열의 계층을 "Survived"로 선택

# 문제
# 성별별로 생존여부를 확인
ftable(Titanic, row.vars = "Sex", col.vars = "Survived")
(titanic.data = xtabs( Freq ~ Sex + Survived, data=Titanic))

# 객실과 나이별로 데이터를 확인
ftable(Titanic, row.vars = "Age", col.vars = "Class")
(titanic.data = xtabs( Freq ~ Age + Class, data=Titanic))

# Cross 테이블
# table + chisq(카이제곱 분석)
# install.packages("gmodels")
library(gmodels)
CrossTable(mtcars$vs, mtcars$am)  # vs : 엔진, am : 변속기(자/수동) 
#  |-------------------------|
#  |                       N |  관측빈도 (관측수)
#  | Chi-square contribution |  sigma (관측빈도 - 기대빈도)^2 / 기대빈도 
#  |           N / Row Total |  관측수 / 행 합계 = 행 기준 비율값
#  |           N / Col Total |  관측수 / 열 합계 = 열 기준 비율값
#  |         N / Table Total |  관측수 / 테이블 합계 = 전체 기준 비율값
#  |-------------------------|


1 일반횟수
2 카이로제곱
3 행을 기준으로 비율 값  ( 가로로 해석할 때 )
4 컬럼을 기준으로 비율 값 ( 세로로 해석할 때 )
5 전체를 기준으로 비율 값

19/32  # 0.594
13/32  # 0.406
14/32  # 0.438
18/32  # 0.562
19/32 * 18 # 10.6875
13/32 * 18 #  7.3125
# 검정 통계량 -> chisq 분포도에서 확률값을 구하기 위해.
(12 - 10.6875)^2 / 10.6875  # 0.1611842 => 0.161
(6 - 7.3125)^2 / 7.3125     # 0.2355769 => 0.236

CrossTable(mtcars$vs, mtcars$am, expected=T)
0.161 + 0.236 + 0.207 + 0.303 = 0.907  # Chi^2  < 자유도에 따라 분포도가 다르다 >

library(gmodels)
library(MASS)
CrossTable(infert$education, infert$induced, expected=T)
fisher.test(infert$education, infert$induced, alternative = "two.sided")

getwd()
###
data <- read.csv("cleanDescriptive_1.csv", fileEncoding = "UTF-8", encoding="CP949", header=T,)
str(data)
class(data)
# 부모 학력수준(level2)과 자녀 대학진학여부(pass)에 관련이 있는지 검정
# 가설 설정
# 귀무가설 : 상호 관련성이 없다.
# 대립가설 : 상호 관련성이 있다.
x <- data$level2
y <- data$pass
result <- data.frame(Level=x, Pass=y)
sapply(result, function(x) sum(is.na(x)))
# result <- na.omit(result)  # na값 삭제
# sapply(result, function(x) sum(is.na(x)))
CrossTable(x = result$Level, y = result$Pass, expected=T)
chisq.test(x = result$Level, y = result$Pass)  # 카이제곱 검정 : 2.767, 확률값 : 0.2507
# p-value = 0.2507, 유의수준 : 0.05
# p-value > 0.05 이므로, 귀무가설을 기각할 수 없다.
# 따라서, 부모학력수준(level2)과 자녀 대학진학여부(pass)는 상호 관련성이 없다.
# 카이제곱분석 : 적합성, 독립성, 동질성 검정

# 사이다 종류별로 선호도 차이가 있는가?
data <- textConnection(
  "사이다종류 관측도수
  1  14
  2  32
  3  17
  4  9
  5  18")
(x <- read.table(data, header=T))
# 귀무가설 : 선호도 차이가 없다.
# 대립가설 : 선호도 차이가 있다.
# 유의수준 : 0.05
# 기대도수 : 18
(14 + 32 + 17 + 9 + 18) / 5 = 18  # 기대도수 구하기(18)
res <- (14-18)^2 + (32-18)^2 + (17-18)^2 + (9-18)^2 + (18-18)^2
(res <- res/18)  # 16.33333
1 - pchisq(16.333, 4)  # 0.002603381
chisq.test(x$관측도수)
# X-squared = 16.333, df = 4, p-value = 0.002603
# p-value < 0.05 : 귀무가설을 기각할 수 있다.
# 사이다 제품별로 선호도 차이가 있다.
data(survey)
# 문제
# 성별과 운동량은 상호 관련성이 있는가? (독립성 검정) (독립성 검정 : 종속변수 없이 두개의 독립변수 간 분석)
# 귀무가설 : 관련성이 없다.
# 대립가설 : 관련성이 있다.
# 유의수준 : 0.05
library(MASS)
str(survey)

sum(is.na(survey))
sapply(survey, function(x) sum(is.na(x)))
survey <- na.omit(survey)
(xt = xtabs (~ Sex + Exer, data = survey)) # formula
(xt = ftable(survey$Sex, survey$Exer))     # 기본
CrossTable(survey$Sex, survey$Exer, expected = T) # 데이터를 요약할때
chisq.test(xt)
# chi^2 = 4.158519    d.f. = 2     p = 0.1250228
# 검정통계량 : chi^2 = 4.158519
# p-value = 0.1250228
# p-value > 0.05, 귀무가설을 기각할 수 없다.
# 따라서 성별과 운동량은 관련성이 없다.

# 문제
# 박수치는 손과 글씨쓰는 손의 독립성 검정을 하시오
# 귀무가설 : 상호 독립적이다.
# 대립가설(연구가설) : 상호 상관성이 있다.
# 유의 수준 : 0.05
chisq.test(xtabs(~ W.Hnd + Clap, data=survey))
fisher.test(xtabs(~ W.Hnd + Clap, data=survey))
# p-value = 0.007371
# 귀무가설을 기각하고 대립가설을 채택한다
# 글을 쓰는 손과 박수치는 손은 상호 상관성이 있다.


# 동질성 검정
# 왼손잡이와 오른손잡이의 비율이 0.3:0.7이다. 이때 표본이 어떤 경향을 보이는지?
chisq.test(table(survey$W.Hnd), p=c(.3, .7))
# 귀무가설은 비율이 동일하다.
# 대립가설은 비율이 동일하지 않다.
# 검정통계량 : X-squared = 41.796, df = 1,
# p-value = 1.013e-10
# p-value < 0.05 : 귀무가설을 기각하고 대립가설을 채택한다.
# 비율이 0.3:0.7이 아니다.

# 다음 데이터에 대해 카이제곱식으로 계산하여 p-value 값을 구하고
# 브랜드별 선호도 조사를 검정
data <- textConnection(
  "브랜드종류 관측도수
  BrandA  18
  BrandB  23
  BrandC  19")
(x <- read.table(data, header=T))
# 가설 설정
# 계산식으로.
freq.mean = sum(x$관측도수) / length(x$관측도수)
# freq.mean(18 + 19 + 23) / 3
res <- (18-freq.mean)^2 / freq.mean + (23-freq.mean)^2 / freq.mean + (19-freq.mean)^2 / freq.mean
p.value <- 1 - pchisq(res, length(x$관측도수)-1)
# p.value > 0.05
p.value < 0.05  # p.value = 0.7046881
# 귀무가설을 기각할 수 없다.
# 브랜드별 선호도는 차이가 없다

data <- read.csv("homogenity.csv", header=T)
str(data)
# method : 방법1, 방법2, 방법3
# survey 만족도 : 1:매우만족, 2:만족, 3:보통, 4:불만족, 5:매우불만족
# 문제
# 데이터를 변환하고 교차표를 생성한 다음 교육방법별 동질성 검정 후 해석하기

# 독립성검정하고 같은 방법. 기대값으로 계산한 검정통계랑의 p-value가
# 유의 수준보다 적지 않으면, 같다고 본다.
data <- subset(data, !is.na(survey), c(method, survey))
nrow(data)

meth_ch <- function(x) {
  if(x == 1) {
    x <- as.character("방법1")
  } else if(x == 2) {
    x <- as.character("방법2")
  } else if(x == 3) {
    x <- as.character("방법3")
  }
}
data$method2 <- sapply(data$method, meth_ch)
data$method2[data$method==1] <- "방법1"
data$method2[data$method==2] <- "방법2"
data$method2[data$method==3] <- "방법3"
data$survey2 = sapply(data$survey, switch, "1"="매우만족", "2"="만족", "3"="보통",
                       "4"="불만족", "5"="매우불만족")
data$method2 = sapply(data$method, switch, "1"="방법1", "2"="방법2", "3"="방법3")

# 교차표
table(data$method2, data$survey2)
xtabs( ~ method2 + survey2, data=data)
ftable(data, row.vars = "method2", col.vars="survey")

# 동질성 검정 
# sigma(관측도수 - 기대도수)^2
chisq.test(data$method2, data$survey2)
CrossTable(data$method2, data$survey2, expected = T)
# p-value > 0.05
# 귀무가설을 기각하지 못한다.
# 교육방법에 따른 만족도에는 차이가 없다.

# 평균분석 : ( t.test ) : 두 집단을 분석
# t 분포 : 정규분포보다 완만한 분포 
# 정규분포테스트 : ( shapiro.test )
# 모수분석 (t.test()),  비모수분석(wilcox.test())  (정규분포면 모수분석, 정규분포 아니면 비모수분석)
# dependent / independent (연구자의 동일표본 사용 여부로 dependent/independent로 나뉨) pairs
# 등분산 테스트 (var.test()) : var.equal = T, F

# ANOVA test
# 분산분석 ( F = 군집 간 분석 / 군집 내 분산 ) 검정통계량
# 자유도에 의해서 영향을 받는다.
# 정규분포 테스트
# 모수분석(aov()) / 비모수분석(kruskal.test())
# 등분산 테스트 (모수적 : bartlett.test  비모수적 : fliger.test)
# 선형회귀처럼 사후분석 : TurkeyHSD()

# 단일표본 평균분석
# 모집단의 평균
x = c(65, 78, 88, 55, 48, 95, 66, 57, 79, 81)
t.test (x, mu=75)
# 귀무가설 : 두 집단의 평균이 같다.
# 대립가설 : 두 집단의 평균이 같지 않다.
# p-value > 0.05
# 귀무가설을 기각할 수 없다.

# 폐암 발생률 평균이 20이라는 가설을 검증
(lung <- runif(20, min=19, max=20))
t.test(lung, mu=20, conf.level=.99)
# p-value = 5.963e-09
# 기무가설을 기각하고 대립가설 선택

str(sleep)
?(sleep)

# 두 집단에 대한 평균검정
attach(sleep)
par(mfrow=c(1,1))
plot(extra ~ group, data=sleep)
var.test(extra[group == 1], extra[group == 2], data = sleep)
# 등분산 테스트 (var.test())
# 귀무가설 : 두 집단의 분산치가 없다.  # 0.7427 -> 등분산이다.
# 대립가설 : 두 집단의 분산치가 있다.
with(sleep, t.test(extra[group == 1], extra[group == 2], var.equal = T))
detach(sleep)
# t = -1.8608, df = 18, p-value = 0.07919
# p-value = 0.07919 > 0.05
# 귀무가설을 기각할 수 없고 두 집단의 수면차이가 없다.

?ToothGrowth
str(ToothGrowth)
my_data <- ToothGrowth
res.ftest <- var.test(len ~ supp, data=my_data)
res.ftest
res.ftest$estimate
res.ftest$p.value < 0.05
# 0.2331433 < 0.05
# 등분산이다. (귀무가설을 기각할 수 없음)

shapiro.test(rnorm(1000))     # p-value = 0.5606, 귀무가설을 채택 (정규분포이다)

set.seed(450)
x <- runif(50, min=2, max=4)  # p-value = 0.003259, 대립가설을 채택 (정규분포가 아니다)
shapiro.test(x)
# 귀무가설 : 정규분포이다.
# 대립가설 : 정규분포가 아니다.

# 양측검정과 단측검정
x <- rnorm(1000, 5.0, 0.5)  # 평균분석(두 집단을 분석)
t.test(x, mu=5.2, alter="two.side", conf.level = 0.95)  # conf.level (신뢰수준)
(result <- t.test(x, mu=5.2, alter="greater", conf.level = 0.95))
(result <- t.test(x, mu=5.2, alter="less", conf.level = 0.95))

# 문제
# iris의 Sepal.Width와 Sepal.Length의 등분산성테스트 진행하기 (bartlett : 등분산 테스트 / 모수분석(정규분포일 때))
# 귀무가설 : 두 집단의 분산은 같다
# 대립가설 : 두 집단의 분산은 다르다
x <- rnorm(1000, 5.0, 0.5)
var.test(x, x)
with(iris, var.test(Sepal.Width, Sepal.Length))
# p-value = 3.595e-14, 등분산이 아니다 (대립가설을 채택)

# 문제
# 새로운 당뇨병 치료제를 개발한 제약사의 예)
# 치료에 지대한 영향을 주는 외부요인을 통제하기 위해 10명의 당뇨병 환자를 선별하여 1달 동안
# '위약(placebo)'을 투여한 기간의 혈당 (X1)과 '신약(new medicine)'을 투여한 1달 기간 동안의
#  혈당 수치(x2)를 측정하여 짝을 이루어 혈당 차이를 유의수준 5%에서 비교
# 표본이 동일집단
# 유의미한 차이가 있는가? 차이가 있다면 약효가 있다.
x1 <- c(51.4, 58.0, 45.5, 55.5, 52.3, 50.9, 52.7, 50.3, 53.8, 53.1)
x2 <- c(50.1, 51.5, 45.9, 53.1, 51.8, 50.3, 52.0, 49.9, 52.5, 53.0)

# 정규성 테스트
shapiro.test(x1)  # 정규성
shapiro.test(x2)  # 비정규성 (p-value < 0.05)

# 등분산 테스트
var.test(x1, x2)  # p-value = 0.2073, 등분산(p-value > 0.05)이다.

# 평균분석
t.test(x1, x2, alternative = c("greater"),
       paired = T,
       var.equal = T,
       conf.level = 0.95)
# 검정 통계량 : t = 2.153, df = 9, 
# p-value = 0.02987
# 평균 분석의 귀무가설 : 평균이 동일하다. (범위 내)
# 귀무가설을 기각하지 못한다면 : 약효는 효과가 없음
# 평균 분석의 대립가설 : 평균이 다르다.

# 비정규성이라면 wilcox.test()로 바꿔주어야 한다
?wilcox.test
# 순위 테스트 -> 전제조건 : 중위수(median)가 같다.
wilcox.test(x1, x2,
            alternative = c("greater"),
            paired = T,
            conf.int = F,
            exact = F,  # TIE가 있어 정확한 P값을 계산할 수 있다.
            conf.level = 0.95)
# 검정통계량 : v = 52.5
# p-value = 0.006201
# 평균분석의 귀무가설을 기각, 대립가설을 채택한다.
# 당뇨병치료제는 약효가 있다.

wilcox.test(x1, x2,
            paired = T,
            var.equal = T,
            exact = F,
            conf.level = 0.95)
# var.equal = T를 추가한 경우.
# V = 52.5
# p-value = 0.0124  =>  값이 달라짐.
# 평균분석의 귀무가설을 기각하고 대립가설을 채택한다.

# ANOVA test
?InsectSprays  # 모기약
data(InsectSprays)
attach(InsectSprays)
str(InsectSprays)
InsectSprays
xtabs(InsectSprays) # A, B, C, D, E, F. 6개의 제품
aov.out = aov(count ~ spray, data=InsectSprays)
summary(aov.out) # 회귀분석한 결과와 비슷하다 
TukeyHSD(aov.out)
