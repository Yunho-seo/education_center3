# 주성분 분석은 10개의 변수 입력 => 10개의 고유치와 10x10 고유벡터행렬이 생성
# 주성분 분석 : 고차원 공간의 데이터들을 저차원 공간으로 변환하는 기법
# 10x10 상관계수행렬이나 공분산행렬이 생성됨
# 고유값 분해
# 10개의 고유치(순서대로 정렬이 되어서 출력됨)와 10x10 고유벡터행렬이 생성된다.

# 공분산
(data1 = 1:5)
(data2 = 2:6)
sum((data1 - mean(data1)) * (data2 - mean(data2))) / (length(data1) - 1)
cov(1:5, 2:6)  # 공분산 : 두 변수간의 변동(cov)
cor(1:5, 2:6)  # 상관계수 : 1 ( 1 : 정상관계가 있다.)
# 주성분 분석은 공분산행렬이나 상관계수행렬을 이용함.

# 상관 계수를 구하는 방법
# pearson, spearman, kendall => 세가지 중 결과가 가장 작은 것을 사용하는 것이 좋다.
(m <- matrix(c(1:10, (1:10)^2), ncol=2))
cor(m, method="pearson")   # 모수적 방법 (t.test) : 데이터가 정규분포
cor(m, method="spearman")  # 비모수적 방법 (kruskal) : 정규분포가 아닐때 -> 순서(rank)에 의해 구해진다.
cor(m, method="kendall")

# 문제
# 다음 두 데이터에 대해 공분산과 상관계수를 구하기
(a <- c(1:10))
(b <- (1:10)^2)
cov(a, b)
  sum((a - mean(a)) * (b - mean(b))) / (length(a) - 1)
cor(a, b)  
  (sum((a - mean(a)) * (b - mean(b))) / (length(a) - 1) / (sd(a) * sd(b)))
  
# 상관분석
# cor.test()
# 귀무가설은 서로 독립이다. (상관이 없다.)
# 대립가설은 서로 상관이 있다.
cor.test(c(1,2,3,4,5), c(1,2,3,4,5), method="pearson")
# p-value < 2.2e-16 : 귀무가설을 기각하고 대립가설을 채택한다. (0.05보다 작음)

cor.test(c(1,2,3,4,5), c(1,2,3,4,5), method="pearson")
cor.test(c(1,2,3,4,5), c(1,2,3,4,5), method="spearman")  # p-value = 0.01667
cor.test(c(1,2,3,4,5), c(1,2,3,4,5), method="kendall")   # p-value = 0.01667

# 문제
# iris 데이터에 대해 전체 변수에 대한 상관계수를 구하기
# 상관분석이나 회귀분석은, 연속형 데이터에서만 가능하다.
library(dplyr)
str(iris)
cor(iris[ , 1:4])
iris %>% select(-(Species)) %>% cor()
symnum(cor(iris[ , 1:4]))

d <- data.frame(x1 = rnorm(10),
                x2 = rnorm(10),
                x3 = rnorm(10))
(M <- cor(d))
# install.packages("corrplot")
library(corrplot)
corrplot(M, method="shade")

# 상관관계 분석
product <- read.csv("product2.csv", encoding="UTF-8", header=T)
head(product)  # 5점 척도
summary(product)
sd(product$"제품_친밀도");  sd(product$"제품_적절성");  sd(product$"제품_만족도");
cor(product$"제품_친밀도", product$"제품_적절성")  # 높은 양의 상관관계
cor(product, method = "pearson")
# install.packages("corrgram")
library(corrgram)
corrgram(product)
corrgram(product, upper.panel=panel.conf)

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(product, histogram=, pch="+")

# 문제
# airquality 데이터에 대해 상관계수 구하기
# 순서 : 1. 분석 대상 변수만 선택 (Month, Day 변수는 제거)
#        2. NA는 제거
#        3. 데이터의 상관 정도를 확인
#        4. 상관계수행렬을 시각화
#        
str(airquality)  # 153x6
(airquality_1 <- airquality[, 1:4])
head(airquality_1)
cor(airquality_1)
(sum(is.na(airquality_1)))
sapply(airquality_1, function(x) sum(is.na(x)))
(airquality_2 <- na.omit(airquality_1))
(airquality_cor <- cor(airquality_2))

par(mfrow=c(1,1))
library(corrplot)
plot(airquality_2)
corrplot(airquality_cor, method="circle")
corrplot(airquality_cor, method="square")  # ellipse, number, shade, pie 등

(col <- colorRampPalette(c("darkblue", "white", "darkorange"))(20))
heatmap(x = airquality_cor, col = col, symm = T)

library(PerformanceAnalytics)
chart.Correlation(airquality_cor, histogram=T, pch=19)

# 상관분석
cor.test(airquality_2$Wind, airquality_2$Temp, method = "spearman", exact=F)
# p-value = 2.426e-08 : 귀무가설을 기각하고 대립가설을 채택 (p-value < 0.05)
# 바람과 온도는, 상호 상관관계가 있다.

library(corrgram)
corrgram(airquality_cor, order=T, lower.panel = panel.shade,
         upper.panel = panel.pie, text.panel = panel.txt,
         main = "공기질 상관계수")

# 상관계수 행렬과 고유값 분해
a <- c(4.0, 4.2, 3.9, 4.3, 4.1)
b <- c(2.0, 2.1, 2.0, 2.1, 2.2)
c <- c(0.60, 0.59, 0.58, 0.62, 0.63)

(mat <- matrix(c(a, b, c), nrow=5, byrow=F))  # 열로 생성함.
(avr <- colMeans(mat))

(acha <- a - avr[1])
(bcha <- b - avr[2])
(ccha <- c - avr[3])

# 등분산
(aa_var <- sum(acha * acha) / (length(a)-1))
(ab_var <- sum(acha * bcha) / (length(a)-1))
(ac_var <- sum(acha * ccha) / (length(a)-1))
cov(mat)

# 상관계수
(aa_cor <- aa_var / (sd(a) * sd(a)))
(ab_cor <- ab_var / (sd(a) * sd(b)))
(ac_cor <- ac_var / (sd(a) * sd(c)))
cor(mat)

# 상관계수 행렬을 이용해서 고유값을 분해
# 변수의 개수 : 3개 => 상관계수 행렬은 3x3 행렬로 출력 (행과 열로 a, b, c가 옴) (정방행렬)
(eigenresult <- eigen(cor(mat)))  # 고유값 분해하기 ( eigen() : 고유값과 고유벡터를 구하는 함수 )
eigenresult$values   # 고유치(고유값) => 정렬되어 있다. (큰값이 주성분이다.)
# 고유값 분해를 하면, 크기와 방향 값으로 분리되어 표현됨.
eigenresult$vectors  # 고유벡터       => 고유벡터는 정직교하는 축이다. (데이터로부터 정직교하는 축)

# 내적이 0이면, 직교이다. 
eigenresult$vectors[, 1] %*% eigenresult$vectors[, 2]  # 벡터와 벡터는, 내적 # -5.551115e-17 => 0으로 본다.
eigenresult$vectors[, 2] %*% eigenresult$vectors[, 3]  # 5.551115e-17 => 0으로 본다.
eigenresult$vectors[, 1] %*% eigenresult$vectors[, 3]  # 0

eigenresult$vectors[1, ] %*% eigenresult$vectors[2, ]  # 6.938894e-18 => 0으로 본다.

eigenresult$values  # 고유값은 정렬되어 있음 (큰 값이 주성분)

# 정직교하는 축에, 데이터를 재표현하면 noise를 제거한 상태이다.
# 주성분을 선택하면, noise가 있는 변수가 제거된다.
# 같이 표현하면, 데이터 압축(차원 축소)을 하는 효과가 있다.
# ex> 이미지 640x640 : 이미지 하나당, 409600개의 변수
#     100개만 주성분으로 취하면, 원래 이미지로 복원할 수 있음.

# 새롭게 생성된 축은, 모든 변수가 참여를 해서 만들어진 축이다. => 시각화.
# 이때, 시각화를 위해 선택되는 축은 3개의 변수를 대표하는 축이다.
# 그래서, 변수만 선택해서 시각화하는 것과는 차이가 있다.

# weather 데이터를 이용해서 상관계수행렬을 구하고 고유값 분해를 실시한 다음
# 그 결과가 단위행렬이 되는지를 확인하기

# 데이터 조회
library(dplyr)
weather <- read.csv("weather.csv", encoding="UTF-8", header=T)
str(weather)
head(weather)
nrow(weather)

# 질적 전처리
sum(is.na(weather))  # NA 개수 조회
sapply(weather, function(x) sum(is.na(x)))  # 변수별 NA 개수 조회
weather <- na.omit(weather)
summary(weather)
weather$key = 1:nrow(weather)
outdata = select_if(weather, is.numeric)
str(outdata)

# 상관 분석
(res_dir <- cor(outdata))  # 정방행렬이면서 대칭행렬인 상관계수행렬
(res_eig <- eigen(res_dir))  # 숫자변수 고유치 : 11, 고유벡터 : 11x11
res_eig$values  # 고유치의 크기에 해당하는 축의 방향으로의 분산 크기 (고유값은 정렬되어 있음)
# 통계분석에서는, 분산이 크면 중요한 변수이다. (주성분 분석)
dim(res_eig$vectors)  # 11x11
length(res_eig$values)  # 변수는 11개 (고유값)
heatmap(res_eig$vectors)
res_eig$vectors %*% t(res_eig$vectors)  # 대각선이 1, 나머지는 0 (t로 전치, 단위행렬) (전치행렬)
# 행렬 %*% 역행렬 = 단위행렬
# 행렬의 항등원은? 단위행렬.
# 정방행렬이면서, 대칭행렬인 행렬은 전치행렬이 역행렬이다.

# 내적
# 고유벡터는 정직교하는 축벡터의 합이다. (내적할때 0이면 직교)
res_eig$vectors[ , 1] %*% res_eig$vectors[ , 2]  # => 0
res_eig$vectors[ , 1] %*% res_eig$vectors[ , 3]  # => 0  // 직교  

# 주성분 분석(PCA) : 고차원 공간의 데이터들을 저차원 공간으로 변환하는 기법
str(USArrests)  # 1973년 미국 50개 주에서 각각 폭행, 살인, 강간으로 주민 10만 명당 체포된 통계
head(USArrests)
pairs(USArrests, panel=panel.smooth, main="USArrets data")  
# 주성분 선정에 있어서 변수의 크기가 주성분을 결정하면 안되기에, scale()
prcomp(USArrests)  # 주성분 분석 함수 = 상관계수행렬 + 고유값 분해  # PC1, PC2, PC3, PC4
# 주성분 분석을 하면, 정직교하는 축이 결정되는데
# 이 축은 각 변수들이 이 축에 미치는 영향을 고려하여 만들어진 축이다.
# 의미를 알 수 없어서, PC1 ~ PC4 라고 이름을 줌.
# 변수들의 참여 정도에 따라 전문가가 의미를 이름으로 재명명 해야 한다.
plot(prcomp(USArrests))
(fit <- prcomp(USArrests, scale=T))  # princomp보다 낫다.
plot(fit, type="lines")
names(fit)
fit$sdev
fit$rotation
fit$center
summary(prcomp(USArrests, scale=T))
# elbow
# 변수가 작으면, bias가 커지는 과소적합문제가 발생 : 변수를 추가.
# 변수가 크면, bias는 작아지지면 variance 거지는 과대적합문제 발생)
# 차원축소를 하는 방법 : PCA(주성분 분석), FA
#
US.prin <- princomp(USArrests, cor=T)
screeplot(US.prin, npcs=4, type="lines")

# install.packages("FactoMineR")
# install.packages("factoextra")
library(FactoMineR)
library(factoextra)
data(iris)
res.pca <- prcomp(iris[, -5], scale = T)
get_eig(res.pca)
fviz_eig(res.pca, addlabels=T, ylim=c(0, 85))

str(mtcars)
head(mtcars, 10)
fit <- princomp(mtcars, cor=T)  # 상관계수로 하는 경우
summary(fit)
loadings(fit)
plot(fit, type="lines")
fit$scores
fit$scores[, 1:3]
fit$scores[, 1:4]
biplot(fit)  # 원점까지의 선을 그어서 거리(크기)를 측정. (x축 : 제1주성분축 / y축 : 제2주성분축)

# 문제
# 다음 데이터를 가지고 주성분 분석을 하여 데이터가 주성분에 미치는 영향을 확인하기
# screeplot으로 주성분 확인하기 (주성분을 몇 개로 할 것인가?)
# loadings를 이용하여 주성분에 기여하는 정도를 확인하기 (새 축으로 만들어진 주성분축에 각 변수가 기여한 점)
# biplot을 이용하여 주성분에 기여하는 정도를 그래프로 확인하기 (주성분의 성분 확인 -> 새 이름으로 결정)
(x <- 1:10)
(y <- x + runif(10, min = -.5, max = .5))
(z <- x + y + runif(10, min = -10, max = 10))

(data <- cbind(x, y, z))
prcomp(data, scale = T)
(fit <- princomp(data, cor=T))
screeplot(fit, type="lines")
loadings(fit)
biplot(fit)

(data <- data.frame(x, y, z))  # 10 x 3
(pr <- prcomp(data, scale=T))  
# prcomp 하는 이유? 
# 1) 분산이 작은 noise같은 역할을 하는 요소들을 제거하기 위해 (주성분을 선택)
# 2) 데이터가 정직교하는 축에 표현되지 않았기에 독립변수 간 상관성을 가질 수 있으니 정직교하는 축에 표현하여 다중공선성을 없애기.
summary(pr)  # PC1, PC2, PC3의 표준편차, 분산, 누적
names(pr)  # 5개의 요소
pr$sdev    # summary에 있는 표준편차와 값이 같다
pr$rotation  # 고유값 분해했을 때의 고유벡터 (3x3) (3x3의 역할 : 축 방향을 회전시킴 / 회전행렬) 
             # 회전 시 noise가 제거 (주성분 선택 시) || princomp : loadings으로 표기 / prcomp : rotation으로 표기
pr$x       # PC1에서는 1:10까지 나와야 하는데, 축 이름이 바뀜(PC1).
           # PC1, PC2, PC3. 즉, 고유벡터의 축으로 표현된 데이터
           # x의 값으로 표현이 됨 -> 원래의 데이터가 변환이 됨 (변환된 기준은, 새로운 축) 
biplot(pr)


# FA (factor analysis, 요인분석) : 차원 축소, 변수 간 숨겨진 공통 요인을 찾는 기법

v1 <- c(1,1,1,1,1,1,1,1,1,1,3,3,3,3,3,4,5,6)
v2 <- c(1,2,1,1,1,1,2,1,2,1,3,4,3,3,3,4,6,5)
v3 <- c(3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,5,4,6)
v4 <- c(3,3,4,3,3,1,1,2,1,1,1,1,2,1,1,5,6,4)
v5 <- c(1,1,1,1,1,3,3,3,3,3,1,1,1,1,1,6,4,5)
v6 <- c(1,1,1,2,1,3,3,3,4,3,1,1,1,2,1,6,5,4)

(med.data <- cbind(v1, v2, v3, v4, v5, v6))
head(med.data)
summary(med.data)
cor(med.data)  # 상관계수 구하기
# install.packages("psych")
# install.packages("GPArotation")
library(psych)
library(GPArotation)
med.factor <- principal(med.data, rotate="none")
names(med.factor)
med.factor$values
op <- par(mfrow = c(1, 1))
plot(med.factor$values, type="b")

# 요인 분석
# 요인분석을 한다면, 축이 다시 결정이 된다. 
# 회전(rotation) => 그 축으로 투영을 해야 한다.
# varimax 알고리즘이 기본. (소스 분석)
?factanal
stats.fact <- factanal(med.data, factors=3, rotation="oblimin", scores="Bartlett")  # factor가 3개(cor(med.data)를 보고 함)
stats.fact

names(stats.fact)
stats.fact$scores  # 재표현된 데이터 (3개의 축)
# 3개의 새로운 축에 대한 명명식( )
stats.fact$loadings  # 설명 (요인에 기여한 변수들의 역할)
stats.fact$factors   # 새로운 축의 개수
stats.fact$criteria  # 최적화의 결과
stats.fact$correlation  # 원 데이터에 대한 상관계수
stats.fact$rotmat    # 변환을 위한 직교축 (회전행렬)
stats.fact$converged # True
stats.fact$dof  # 0
stats.fact$method    # mle : 선형회귀
stats.fact$call   # 호출된 함수의 내용
stats.fact$obs
