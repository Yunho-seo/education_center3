Sys.getenv("JAVA_HOME")
Sys.getlocale()
ls()

# 대입(<-), equal(=)
x <- 5
x

typeof(x)   # double
mode(x)     # 데이터타입
class(x)    # 자료구조

# 정수형으로 변환하기
x = as.integer(x)   # R에서는, '.'이 이름으로 사용(클래스X) (함수가 곧 클래스)
typeof(x)

y <- x;
typeof(y)

x <- 10   # 값에 의한 전달
y
x

z = "대한민국"
print(z)
z

x + y
x - y
x * y
y / x
y %/% x  # 몫연산자
y %% x   # 나머지 연산자
y ^ x    # y의 x승
x + z    # java라면 암묵적 캐스팅으로, 문자로 출력 (R은 연산이 우선, 타입이 다르면 error)

# 비교(관계) 연산자 ( TRUE / FALSE ) -> true, false, True, False (R은 모두 대문자로 출력)
x <- 5
y <- 16
x < y
x > y
x <= 5
y >= 20
y == 16
x != 5  # 같지 않음

x <- c(TRUE, FALSE, 0, 6)   # 벡터를 만들 때에는 combine (vector) (T=1, F=0)
x
(x <- c(TRUE, FALSE, 0, 6)) # 입력하면서 출력 (바깥쪽에에 괄호)
(y <- c(FALSE, TRUE, FALSE, TRUE))  # boolean

typeof(x)
mode(x)
class(x)

x+1  # 모든 대상에 대해 연산 (for문 사용 x) (vector화 연산)
!x   # 0이 TRUE, 1 이상은 FALSE (데이터를 TRUE/FALSE로 자동 변환하고 부정)

x    # 1 0 0 1
y    # 0 1 0 1

x & y  # 0 0 0 1 (AND 연산) (개별 연산)
x && y # 통합 연산 (전체 중 하나) (모두가 TRUE면 TRUE, 하나라도 FALSE면 FALSE)

# 숫자를 벡터화할때
# 범위 연산자
v <- 2:8   # 2~8
print(v)
v1 <- 8
v2 <- 12

t <- 1:10  # 2~10
v1 %in% t  # 매칭(Matching) 연산 (t에 v1이 있느냐?)
print(v1 %in% t)
print(v2 %in% t)


# 행렬 (vector로 부터 생성)
# 2x3 행렬
(M = matrix( c(2,6,5,1,10,4), nrow = 2, ncol = 3, byrow = TRUE)) # byrow = 행방향으로 (행 우선)
t(M) # transpose (전치행렬) = 행과 열의 순서를 변경 (사용 이유 : 행렬곱 때문에)
# 행렬곱 : %*% (규칙 : 앞 행렬의 열수와 뒤 행렬의 행수가 일치해야 함)
# 결과 : 앞 행렬의 행수 * 뒤 행렬의 열수
# 앞에 있는 행렬( 2x3 )
# 뒤에 있는 행렬( 3x2 )
t = M %*% t(M)  # 행렬곱의 결과로 (2x2)
print(t)

# 행렬의 거듭제곱을 하려면, 행렬의 전치행렬을 구해서 행렬곱을 해야 함
# M %*% M   # 2x3 2x3 => 앞 행렬의 열수와 뒤 행렬의 행수가 다르므로 곱할 수 없음

num <- 6
num ^ 2
num
num <- num ^ 2 * 5 + 10 /3
num

# scalar 량
c(1,3,5,7,9) * 2          # 각 요소에 2 곱하기
c(1,3,5,7,9) * c(2,4)     # recycling (배수가 되어야함)
c(1,3,5,7,9,10) * c(2,4)
c(2,4) * c(1,3,5,7,9,10)  # recycling을 통하여 개수를 맞춤

factorial(1:5)  # 5! (1, 2, 3, 4, 5), 함수의 매개변수는 기본이 벡터(Vector)

exp(2)  # 밑을 자연대수로 하는 지수
exp(2:10)  # 2, 3, 4, 5, 6, 7, 8, 9, 10 (9개)
sqrt(c(1, 4, 9, 16))  
cos(c(0, pi/4))  # 여러개의 매개변수 선언 가능

?exp  # 명령어가 이해되지 않을때 Tip -> (?명령어)
1 / 0 # Inf (무한대)
0 / 0 # NaN (수가 정해지지 않음), NA는 결측치
sum(c(1,2,NA,3))  # 연산에서 결측치가 하나라도 있으면, 결과는 NA
# 반드시 결측치 처리를 해야함

# 기본 수치는 double
vec <- c(0, Inf, NaN, NA)
typeof(vec)
mode(vec)
class(vec)

is.finite(vec)  # 확인 함수(is. 으로 시작)
is.nan(vec)     # 벡터에서 nan이 있는지 확인
is.na(vec)
is.infinite(vec)
sum(vec)

# 연산자 함수 작성 | (divisible 함수) (사용자 정의)
'%divisible%' <- function(x, y)
{
  if (x%%y == 0) return (TRUE)
  else           return (FALSE)
}
10 %divisible% 3
10 %divisible% 2
'%divisible%' (10,5)
}

# 
x <- c(5,6,7)  # vector
y <- c(1,2,3)
x%%y  # 나머지 연산자
x%*%y # 행렬곱 ,, 벡터곱을 내적 이라고 함.
# 내적의 의미 : 크기값을 고려한 사이각
# 같은 위치의 요소를 곱한 다음, 다 더해주면 내적
x*y
sum(x*y)  # 결과값 38이 사이각 (내적) (사이각이 0이면, 직교)

# R은 대소문자를 구분
LETTERS
letters  # 대문자는 A~Z까지, 소문자는 a~z까지
month.abb # 월별, abb : 축약어
month.name
pi
ls()  # 메모리에 있는 변수 확인
int <- 50  # 데이터 타입을 자료형으로 사용 가능

# 통계함수
score <- c(85, 95, 75, 65)  # 대표값
score
mean(score)  # 벡터의 평균
sum(score)   # 모든 데이터의 합계
(avg <- sum(score)/4)   # 평균값을 avg 라는 변수로 대입

var(score)   # 분산 (분산이 큰 변수가 중요한 변수, 주성분) (분산이 큰 데이터가 집단의 성격을 좌우)
# 데이터는 4개이므로, avg를 4개로 늘림 (recycling)
# (score - avg) ^ 2   # 평균값의 차의 제곱이 분산 (분산은 평균 기준 최대, 최소의 분포도) (부호를 떼기 위해)
var_value = sum((score - avg) ^ 2) / 3  # 표본인 경우 자유도를 사용 (데이터는 4개이지만 3으로 나눔, n-1)
sqrt(var_value)  # 12.90994 : 표준편차 -> 표준오차 -> 신뢰구간
sd(score)    # 표준편차


score <- c(85, 95, NA, 75, 65)
score
sum(score)  # NA가 하나라도 존재한다면 결과도 NA
mean(score, na.rm = TRUE)  # NA를 없앤(TRUE) 다음 계산 
sum(score, na.rm = T)      # NA를 없앤(T) 다음 계산 (2)

x <- c(10, 20, 30, '40')
mode(x)   # '40'이 포함되어 있기에, character
typeof(x)

(xx <- as.numeric(x))  # 문자형을 숫자로 형 변환
mode(xx)  # numeric

# R에서 사용하는 데이터는 '정성적 데이터(질적)' / '정량적 데이터(양적)' : 이산적, 연속적 데이터
# factor형 데이터(문자 / 숫자 사용 가능), 범주형 데이터
gender <- c('M', 'F', 'M', 'F', 'M')  # Male, Female
gender         # 데이터 출력
mode(gender)   # character
class(gender)  # character
plot(gender)

fgender <- as.factor(gender)  # 범주형 데이터로 변환 시 as.factor() 사용
fgender   # Levels : F, M
fgender[2] # 2개의 레벨 중 두번째 있는 요소는 F

# 범주형 데이터는 그래프로 출력이 가능하다.
mode(fgender)
class(fgender)
levels(fgender)
plot(fgender)  # 범주형은 숫자로 매핑(Mapping)이 된다.

# 날짜
Sys.Date()
Sys.time()
today <- '2017-03-11 10:15:24'  # 입출력은 문자열, 계산은 특별 숫자계산 (KST)
(today2 <- as.Date(today))
ctoday <- strptime(today, '%Y-%m-%d %H:%M:%S')  # 문자열을 날짜로 분해 (형태 지정)
ctoday

?sum
args(sum)  # 매개변수 출력
example(sum)  # sum의 사용법 출력
data()  # 현재 메모리에 올라와있는 데이터 출력 (학습용)
Nile    # 강수량 집계 (100개의 데이터, [1]부터 시작) / 시계열 데이터
length(Nile)  # 길이
plot(Nile)    # 강수량 그래프 (x축=년도) / 시계열 데이터



# Vector : 배열 개념으로 저장 (Arraylist)
# 왜 벡터(Vector)인가? : 데이터를 선형대수로 처리
# vector : 동질적 데이터를 담는다.
# vector의 기본연산 : (+, -, *, / : 요소별로 연산)
# 중요연산 : 내적과 외적 : 분석에서는 외적을 사용하지 않음
# (게임에서 : 면에 직교하는 두 벡터가 이루는 면에 수직 벡터를 이용하여 음영을 줄 때 사용)
# 내적은 요소끼리 곱한 다음, 다 더하면 크기가 고려된 사이각으로 표현
# A,B = [A] [B] cos theta
# norm = : 벡터의 크기
# normalize : 정규화. 방향값으로 표현되고 사이즈는 1이다.
# 두개의 벡터인 경우
  # 방향 : 내적
  # 크기 : 피타고라스 정리

# 벡터 : 크기와 방향을 표현
# 가격벡터, 수량벡터의 내적 : 매출
# 유사도(추천)와 거리(군집분석)
# 사이각이라면, 각도는 사이즈가 1이다. (곱셈의 항등원은 1) (덧셈의 항등원은 0)
# 방향을 표시할 때는 사이즈가 1인 것으로 표현

x <- c(1, 5, 4, 9, 0)  # 벡터는 위아래로 저장
class(x)   # numeric 타입
typeof(x)  # double
length(x)  # 5 (5개 요소)
NROW(x)    # 5 행
NCOL(x)    # 1 열
# vector -> matrix(2차원) -> array(n차원) : 동질적인 데이터
# vector -> 이질적인 요소(데이터)로 구성된 dataframe
# dataframe은 열(col)로 표현됨, 열 내 동질적, 열 간 이질적
# matrix, array, dataframe은 사각형으로, 이빨이 빠지면 안됨
# list은 이빨이 빠져도 가능

(x=vector("list", 10))
(y=vector("numeric", 10))
rm(x)
(y <- 2:-2)

seq(1, 3.2, by=0.2)     # by : 간격을 지정 (1~3.2를 0.2씩)
seq(1, 5, length.out=4) # length.out : 개수를 지정
seq(1, 6, length.out=4) 

(b<-rep(1:4, 2))         # 1부터 4씩, 2번 출력
(d<-rep(1:3, each=3))    # 1부터 3까지, 각각 3번씩
(d<-rep(1:3, 2, each=3)) # 1부터 3까지 각각 3번씩 2번 출력 (each가 먼저 작동)

(x <- c(1:9))
x[3]
x[c(2,4)]  # 벡터를 이용하여 인덱싱 (벡터 안에 벡터)
x[-1]  # 1 제외하고 출력

x[c(2, -4)]  # 복합할 수 없다.
x[c(2.4, 3.54)]  # 소수점은 절사
x[c(TRUE, FALSE, FALSE, TRUE)]  # Boolean indexing, 리사이클링하여 2, 3, 6, 7이 제외
# 조건절 사용 가능
x[x < 3] # x에서 3보다 작은 요소 출력
x[x > 3] # x에서 3보다 큰 요소 출력 (관계 연산자를 이용한 인덱싱)


# 열의 이름, 행의 이름을 부여하는 것이 가능능
(x <- c("first"=3, "second"=0, "third"=9))
x
x["second"]  # 키 데이터 접근방법
x[c("first", "third")]

# 비교
c(1, 2, 3) == c(1, 2, 100)

x <- 1:5
all(x > 2)  # 모두 조건을 만족하는가 
any(x > 2)  # 하나라도 조건을 만족하는가

# 정렬 : 원본에 영향을 미치지 않음
# 데이터를 정렬
x <- c(3, 2, 6, 4, 5, 8, 1)
x
sort(x)
sort(x, decreasing=TRUE)  # 내림차순

# 인덱스 정렬 ( order : 하나의 열을 기준으로 다른 데이터를 정렬하고 싶은 경우 )
# 두 개의 열에 대하여 하나는 기준 하나는 정렬된 참조
# ex. 국어 점수를 기준으로 이름을 참조할 때 order 사용
order(x)
order(x, decreasing = TRUE)
x[order(x)]

# NA 결측치
sum(2, 7, 5)
x = c(2, NA, 3, 1, 4)
sum(x)
sum(x, na.rm=TRUE)
mean(x, na.rm=TRUE)
median(x, na.rm=TRUE)  # 중위수 - 통계학 (이상치를 고려하기 때문.)
prod(x, na.rm=TRUE)

# 벡터에 이름 정하기
vectorA <- c(1, 2, 3, 4)
names(vectorA) <- c("국어", "수학", "영어", "과학")
vectorA
vectorA["국어"]
vectorA[2]
vectorA[-1]
vectorA[c(1, 3)]  # 벡터 인덱싱 (subset)
vectorA[vectorA > 5]
vectorA[c(FALSE, FALSE, TRUE)]
append(vectorA, c(3, 4, 5))   # (3, 4, 5) 추가
vectorA  # append 되었던 요소가 출력 안됨 -> 원래 데이터에 영향을 미치지 않음 (값에 의한 전달)
(vectorB = append(vectorA, c(3, 4, 5)))

# 집합 연산 (set : 중복이 없음)
union(vectorA, vectorB)      # 합집합
intersect(vectorA, vectorB)  # 교집합
setdiff(vectorA, vectorB)    # 차집합 - 순서가 있음 (차집합은 순서를 바꾸면 결과도 달라짐)
setdiff(vectorB, vectorA)
setequal(vectorA, vectorB)   # 체크 함수

# 인덱스를 리턴하는 것들은 하나를 기준으로 다른 데이터 참조할 때.
(x <- c(3, 2, 6, 4, 5, 8, 1))
subset(x, x > 3)   # x에 대해, x가 3보다 큰 요소들을 출력 (6, 4, 5, 8)
which(x*x > 8)   # 인덱스를 찾을 경우 which
x[which(x*x > 8)]

# 확률 (표본을 뽑는 행위)
# ex. 우리나라 사람 키의 평균
# 전국민을 대상으로 키를 측정 -> 비용과 시간이 많이 듦
   # 전국민 에너지
   # 인구 센서스
# 표본을 추출 : 각 도의 중요한 동을 기준으로 선정 (확률)
# 복원추출
# 1~3중 3개를 뽑는데 1은 0.1의 확률, 2는 0.2의 확률, 3은 0.3의 확률
(x <- c(sort(sample(1:3, 3, replace=T, prob=c(0.1, 0.3, 0.2)))))


nums <- c(5, 8, 10, NA, 3, 11)
nums
which.min(nums)  # 결과가 인덱스로 출력, 5
which.max(nums)  # 결과가 인덱스로 출력, 6
nums[which.min(nums)]
nums[which.max(nums)]


# 연습문제 (for문을 사용해서 프로그래밍 => 인덱스) : if문 => [ ]. for문은 자동
# 1) vector1 벡터 변수를 만들고, "R" 문자가 5회 반복되도록 하기
vector1 <- rep('R', 5)
vector1

# 2) vector2 벡터 변수에 1~20까지 3 간격으로 연속된 정수 만들기
vector2 <- seq(1, 20, by=3)
vector2

# 3) vector3에 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만들기 (seq)
vector3 <- rep(seq(1, 10, by=3), 3)
vector3

# 4) vector4에는 vector2~vector3이 모두 포함되는 벡터 만들기
vector2
vector3
# vector4 <- union(vector2, vector3)
vector4 <- append(vector2, vector3)
vector4

# 5) 25~-15까지 5간격으로 벡터 생성 - seq() 함수 사용
seq(-15, 25, 5)
seq(25, -15, -5)

# 6) vector4에서 홀수번째 값들만 선택하여 vector5에 할당(첨자 이용)
vector4 <- seq(1, 10)
vector5 <- vector4[(seq(1, length(vector4), by=2))]
vector5

# 7) vector5에서 짝수번재 값들만 선택하여 vector6에 할당(첨자 이용)
vector5 <- seq(1, 10)
vector6 <- vector5[(seq(2, length(vector5), by=2))]
vector6

# 8) vector5의 데이터를 문자로 변경하여 vector7에 저장 (as.character())
vector5
vector7 <- as.character(vector5)
vector7

# 9) vector5와 vector6을 벡터 연산하여 더하기
vector5
vector6
vector5 + vector6

# 10) vector5와 vector7을 벡터 연산하여 더하기 (as.numeric())
vector5
vector7
vector5 + as.numeric(vector7)


# packages :
# base packages( RStudio가 로딩할 때 자동으로 로딩되는 패키지 ),
# recommended packages (설치는 되어있는데 로딩이 안된 패키지 ),
# others (설치도 안되어있고 로딩도 안된 패키지)
install.packages("NISTunits")  # 설치
library(NISTunits)    # 로딩
NISTdegTOradian(180)  # 각도 -> 라디안
# 각도에서 sin(x), cos(x)의 값의 범위: -1 ~ 1 사이의 값을 가진다.
# 반지름이 1인 원에서의 계산
NISTradianTOdeg(pi)

# 문제
# 45도를 라디안으로 변경
angle <- 45
angle
rad1 = NISTdegTOradian(angle)
NISTradianTOdeg(rad1)

# 밑변의 길이와 높이를 구하기 (반지름이 1) : 곱할 때의 항등원
cosbi <- cos(rad1)  # 길이, 0.7071069 : 대각선과 밑변의 비
sin(rad1)  # 높이, 0.7071067 

# 대각선과 밑변의 비를 각도로 변경하기
cosradian <- acos(cosbi) # 라디안으로 변경, 0.785398 
NISTradianTOdeg(cosradian)
# 삼각함수, 지수함수, 로그함수 -> 초월함수(+, -, *, /으로 값을 구할 수 없음: 즉 대수적으로 정확한 값이 없음)
# 극한
# 회전, 주기적으로 값이 변화하는 경우

# 독립변수의 영향을 균등하게 하기 위해서 정규화를 진행한다.
# 벡터 -> 정규화(Normalize)
# 1. min-max 정규화, 2. normalize, 3. z-점수 정규화
# 모든 값을 0~1 사이의 값으로 변환
# 벡터의 크기값을 구해서 벡터의 요소값을 나누어주면, 사이즈가 1인 벡터
# -1, 1 값을 가짐
# z-점수 정규화는, -oo ~ oo (무한대)