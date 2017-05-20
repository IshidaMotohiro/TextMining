
# 『改訂版Rによるテキストマイニング入門』
## 第3章 R/RStudio 速習

### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 3.2 起動から終了まで
x <- 1:10
x

### 3.2.1  ワークスペース
getwd()

setwd("C:/Users/ishida/Downloads/TextMining")

### 3.4 ベクトル
y <- c(1, 20, 100)
y
z <- c("あ", "いう", "えおか")
z

onetwothree <- c(1, "1", 2, "二", 3)
onetwothree

options(width = 50)
LETTERS

LETTERS[c(1, 12, 23)]

### 3.5 関数
sum(1:10)

?sum

### 3.6 データフレーム
df1 <- data.frame(クラス = c("B", "A", "A", "B", "C", "A"), 
                   名前 = c("逢坂", "荻窪", "茅原", "金元", "原田", "佐倉"),  
                   英語 = c(77, 90, 79,  76, 67, 72), 
                   現文 = c(67, 86, 81, 75, 66, 84),
                   数学 = c(61, 89, 75, 61, 57, 79))

### 3.7 CSV ファイルの読み込み
dat <- read.csv("data/classes.csv")
##  一般に Mac ないし Linux でWindowsで作成された csv ファイルを読み込むには以下を実行する(ただし本書サポートサイトの classes.csv は UTF-8 に変換されているので不要)
## dat <- read.csv("data/classes.csv", fileEncoding= "CP932")
                
head(dat)


### 3.8 データフレームの操作(添字)
dat[1:3, c(2, 5)]

dat[1:3, ]

colMeans(dat)

colMeans(dat[ , -c(1, 2)])


### 3.8.1 因子
dat$クラス

str(dat$クラス)

dat <- read.csv("data/classes.csv", 
                 fileEncoding= "CP932", 
                 stringsAsFactors = FALSE)
str(dat)

### 3.8.3 xlsxファイルの読み込み
install.packages("readxl")

library(readxl)
getwd()# 現在のワークスペースを確認
dat <- read_excel("data/classes.xlsx")

head(dat)

### 3.9 リスト
dat <- data.frame(A = c("A", "B", "C"), a = c("a","b"))

dat <- list(A = c("A", "B", "C"), a = c("a","b"))
dat

dat[[2]]

dat$A

library(RMeCab)
getwd()# 現在のワークスペースを確認
RMeCabText("data/hon.txt")

### 3.10 リストの繰り返し処理
myList <- list(A = 1:10, B = 12:18, C = 23:27)
myList

lapply(myList, mean)

sapply(myList, mean)

### 3.11 行列
mat <- matrix(1:9, nrow = 3)
mat

mat[2:3, 1:2]


### 3.12 効率的なデータ操作
install.packages("dplyr")

library(dplyr)

head(ToothGrowth)

?ToothGrowth



### 3.12.1 従来の方法
options(digits = 3)

head(ToothGrowth[ToothGrowth$supp == "OJ", ])

head(subset(ToothGrowth, supp == "OJ"))


### 3.12.2 パイプ演算子
ToothGrowth %>% filter(supp == "OJ") %>% head()


### 3.13 データフレームを操作する主な関数
ToothGrowth %>% select(length = len, supp_type = supp) %>% head()


### 3.13.2 行の指定
ToothGrowth %>% filter(len > 25, dose  == 2.0)


### 3.13.3 値の操作
ToothGrowth  %>% mutate(len2 = len * 0.039) %>% head()

library(magrittr)
ToothGrowth %<>% mutate(len = len * 0.039)

vignette("introduction", package = "dplyr")



### 3.14.1 ループ
x <- 1:10
tmp <- 0
for (i in x) {
    tmp <- tmp + i
}
tmp

x <- 1:10
sum(x)

x <- 8
if(x %% 2 == 0) {
    print("偶数")
} else {
    print("奇数")
}


### 3.15 関数の作成
## 関数を定義
mySum <- function(vec) {
    tmp <- 0
    for (i in vec){
        tmp <- tmp + i
    }
    tmp
}
## 実行してみる
x <- 1:10
mySum(x)



### 3.16 その他、便利な関数
aggregate(len ~ supp, data = ToothGrowth, FUN = mean)


### 3.16.2 検索用の演算子
aiu <- c("あ", "い", "う", "え", "お")
aiu %in% c("え", "い")

aiu[aiu %in% c("え", "い")]


### 3.16.3 文字列の結合
paste("被験者", 1:30)



### 3.16.4 ベクトルの要素の名前
animals <- c(犬 = 1,  猫 = 2, 猿 = 3)
animals

names(animals)

animals + 1

### 3.17 グラフィックス
install.packages("ggplot2")

library (ggplot2)
library(dplyr)

p1 <- iris %>% ggplot (aes (x = Sepal.Length, y = Sepal.Width, color = Species))
p1 + geom_point()


source("http://rmecab.jp/R/Rprofile.R")

