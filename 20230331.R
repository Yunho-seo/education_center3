# dicision tree ( 의사 결정 트리 )
# binary tree
# rule base로 작동한다.
# 외삽데이터(사례가 없는 데이터)는 예측 불가 / 회귀분석(기울기, 절편 : 회귀선)
# 과적합(Overfitting)의 문제 (root -> terminal node까지 가장 깊은 곳까지 depth)
# 데이터 변수의 입력순서를 변경하면, 결과가 바뀌는 현상이 발생.
# 단점을 극복하기 위해, RandomForest 의 출현. (데이터는 랜덤하게 선택하고 모델의 숲을 만들어 다수결의 원리로 해결)

# 100개 중 50개는 동전의 앞면, 50개는 동전의 뒷면
# p(x) = -(50/100) * log2(50/100) = 0.5
library(rpart)
(result <- sample(1:nrow(iris), nrow(iris) * 0.7))  # 105개(150*0.7)를 임의적으로 선택(sampling)
(train <- iris[result, ])
(test <- iris[-result, ])  # 45개 데이터를 추출
dim(train); dim(test)
unique(iris$Species)  # iris의 Species 종류 출력 (setosa, versicolor, virginica)
head(iris)
# 데이터를 이용한 분류문제.
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
model <- rpart(formula = formula, data=train)  # rpart 모델 / 불순도를 이용하여 정보이득이 있으면 분할
model
pred <- predict(model, test)  # 범주별로 확률 -> 라벨링(labeling)
pred  # 합계 100%를 분할하여 확률이 출력됨.
cpred <- ifelse(pred[, 1] >= 0.5, "setosa",
                ifelse(pred[, 2] >= 0.5, "versicolor", "virginica"))
cpred

(tb = table(cpred, test$Species))  # 예측(cpred)이 virginica 때, 실제 virginica 12개 => 예측이 성공. (테이블에서는 대각선이 성공된 예측)
                                   # 예측이 versicolor일 때, 실제 verginica도 2개 포함 => 오분리 발생
# 정분류율 / 오분류율
# 정분류율 구하기
sum(diag(tb)) / nrow(test)  # 43 / 45 => 0.955556 => 95% 예측 성공.
plot(model)
text(model, use.n=T, cex=0.6)
post(model, use.n=T, file="")
# install.packages("rpart.plot")
# install.packages("rattle")
library(rpart.plot)
library('rattle')
prp(model)
rpart.plot(model)
fancyRpartPlot(model)
# 통계학에서는 분산이 큰 변수가 중요한 변수이다.
# C 트리 (C tree) : 범주형 데이터를 제외하고 선형분석을 실행, 입력변수의 level이 31개로 제한
# 스스로 가지치기를 하기에, 따로 가지치기가 불필요.
# C5.0 : 불순도 척도가 엔트로피(Entropy), 범주형 데이터에 대해 범주의 수 만큼 분리가 발생.
# rpart : 지니 인덱스를 사용
# install.packages("party")
library(party)
result <- sample(1:nrow(iris), nrow(iris) * 0.7)

table(result)
train <- iris[result, ]
test <- iris[-result, ]
head(train)
formula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
(iris_ctree <- ctree(formula, data=train))  # 4개의 터미널
plot(iris_ctree, type="simple")
plot(iris_ctree)
names(train)
result <- subset(train, Petal.Length > 1.9 & Petal.Width > 1.7)
dim(result)  # 32 x 5 (32개)
table(result$Species)
(pred <- predict(iris_ctree, test))
(tr <- table(pred, test$Species))  # 45개 중 정분류가 44개, 오분류가 1개
paste(round(sum(diag(tr)) / nrow(test) * 100), '%')  # 0.9777778 => 예측 성공확률이 98%

getwd()
setwd("C:/Users/401-25/Documents")
# 유방암 진단결과 데이터셋
#
wdbc <- read.csv("wdbc_data.csv", stringsAsFactors = F)
str(wdbc)  # 569 x 32
head(wdbc)
# diagnosis 진단 :
unique(wdbc$diagnosis)  # 'B' : 양성, 'M' : 악성 (30개 필드의 조합)
# DT를 이용하여 모델을 구현하기 (rpart) (DT : Dicision Tree)
# 데이터 : train:7, test:3 => 애매한 것.
wdbc <- wdbc[-1]
wdbc$diagnosis <- factor(wdbc$diagnosis, levels = c("B", "M"))
# DT : 데이터에 대해서 강건하다 (범주형 / 연속형 데이터에 대해 잘 작동함.)  # 분산이 크면 중요한 변수, 영향력을 동일하게 해주어야 함
# 정규화
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
wdbc_x <- as.data.frame(lapply(wdbc[2:31], normalize))
summary(wdbc_x)

# 7(train, 학습) : 3(test, 평가)
wdbc_df <- data.frame(wdbc$diagnosis, wdbc_x)  # 569 x 31, 종속변수는 범주형, 독립변수는 정규화
dim(wdbc_df)
idx = sample(nrow(wdbc_df), nrow(wdbc_df) * 0.7)
(wdbc_train = wdbc_df[idx, ])
(wdbc_test = wdbc_df[-idx, ])
dim(wdbc_train)  # 398개
dim(wdbc_test)   # 171개
names(wdbc_train)
(model2 <- rpart(wdbc.diagnosis ~ ., data = wdbc_train))  # .은, 나머지 모든 것을 의미
(pred2 <- predict(model2, wdbc_test, type='class'))
prp(model2)
rpart.plot(model2)
fancyRpartPlot(model2)

# 평가 (혼동행렬)
(tr <- table(pred2, wdbc_test$wdbc.diagnosis))
# paste("정분류율", round(sum(diag(tr)) / nrow(wdbc_test)) * 100, '%')
paste("정분류율", sum(diag(tr)) / nrow(wdbc_test) * 100, '%')  # 정분류율 : 약 93.56 %
paste("오분류율", round(sum(tr[1,2], tr[2,1]) / nrow(wdbc_test) * 1000) / 10, '%')  # 오분류율 : 약 6.4 %
paste("정밀도",  round(tr[1, 1] / sum(tr[1, ]) * 100))  # 정밀도 : 95
paste("민감도",  round(tr[1, 1] / sum(tr[, 1]) * 100))  # 민감도 : 95
paste("특이도",  round(tr[2, 2] / sum(tr[, 2]) * 100))  # 특이도 : 90

# 자동화 패키지인 caret 패키지를 적용 (modern 모델 학습)
install.packages("dplyr")
install.packages("caret")
install.packages("recipes", type = 'binary') 


library(caret)
set.seed(300)
m <- train(wdbc.diagnosis ~ ., data = wdbc_train, method = "C5.0")  # entropy를 이용한 트리(tree) 분석
p <- predict(m, wdbc_test)
tr <- table(p, wdbc_test$wdbc.diagnosis)
paste("정분류율", sum(diag(tr)) / nrow(wdbc_test) * 100, '%')
paste("오분류율", round(sum(tr[1,2], tr[2,1]) / nrow(wdbc_test) * 1000) / 10, '%')
paste("정밀도",  round(tr[1, 1] / sum(tr[1, ]) * 100))
paste("민감도",  round(tr[1, 1] / sum(tr[, 1]) * 100))
paste("특이도",  round(tr[2, 2] / sum(tr[, 2]) * 100))
head(predict(m, wdbc, type="raw"))
head(predict(m, wdbc, type="prob"))
# cross validation (교차 검증)
ctrl <- trainControl(method = "cv", number = 10, selectionFunction = "oneSE")
# parameter 조합
expand.grid(height = seq(60, 80, 5), weight = seq(100, 300, 50),  # 경우의 수를 생성
            sex = c("Male", "Female"))

grid <- expand.grid(.model = "tree",
                    .trials = c(1, 5, 10, 15, 20, 25, 30, 35),
                    .winnow = "FALSE")
m <- train(wdbc.diagnosis ~ ., data = wdbc_train, method="C5.0",
           metric = "Kappa",
           trControl = ctrl,
           tuneGrid = grid)
m
p <- predict(m, wdbc_test)
table(p, wdbc_test$wdbc.diagnosis)

m$bestTune
