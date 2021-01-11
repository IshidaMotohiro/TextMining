# 『改訂版Rによるテキストマイニング入門』
## 第7章 アンケート自由記述文の分析 対応分析


### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など
  setwd("/myData/Books/morikita/")
  
### 7.1 沖縄観光への意見データ
okinawa <- read.csv("data/H18koe.csv", stringsAsFactors = TRUE)
## 行数を確認
NROW(okinawa)
## 列名を確認
colnames(okinawa)

library(dplyr)
library(magrittr)

okinawa %>% select(Region:Satis) %>% summary()

## データフレームから地域列を削除して上書き
okinawa %<>% select(-Region)
## 欠損値を削除
okinawa %<>% na.omit()

okinawa %>% select(Sex:Satis) %>% summary()

okinawa %>% xtabs(~ Sex + Satis , data = .)

### 7.2 アンケート自由記述文のデータ整形

AgeL <- okinawa %>% use_series(Age) %>% levels() 
AgeL

library(purrr)
AgeL %>% map(
 ~ filter(okinawa, Age == .x) %>% NROW()
)
AgeL %>% map_chr(
  ~ filter(okinawa, Age == .x) %>% NROW()
)

AgeL <- AgeL[-1]

### Windows
setwd("C:/Users/ishida/okinawa")
### Mac
setwd("/Users/ishida/okinawa")

library(magrittr)
AgeL %>% map(
  ~ filter(okinawa, Age  == .x, Sex == "女性") %>% {
   tmp <-  use_series(data = ., Opinion) %>% as.character() 
   writeLines(text = tmp, con = paste0("F", (2:7)[AgeL == .x], "0.txt"))
  }
)

library(magrittr)
AgeL %>% map(
  ~ filter(okinawa, Age  == .x, Sex == "男性") %>% {
   tmp <-  use_series(data = ., Opinion) %>% as.character() 
   writeLines(text = tmp, con = paste0("M", (2:7)[AgeL == .x], "0.txt"))
  }
)


library(RMeCab)

### Windows
setwd("C:/Users/ishida")
### Mac
setwd("/Users/ishida")

FM <- docDF("okinawa", type = 1, 
             pos = c("名詞","動詞","形容詞"))

FM2 <- FM %>% filter(POS2 %in% c("一般", "固有", "自立"))
FM2 <- FM2 %>% filter(! TERM%in% c("ある","いう","いる", "する", 
                                   "できる", "なる","思う"))

FM2 %>% NROW()

FM2$SUMS <- rowSums(FM2[, -(1:3)])
summary(FM2$SUMS)

FM3 <- FM2 %>% filter(SUMS >= 7)
FM3 %>% NROW
colnames((FM3))

FM3$TERM

library(stringr)
## 正規表現で数値列だけを取り出す
FM4 <- FM3 %>% select(matches("[FM]\\d\\d"))
## 列名を設定
colnames(FM4) <- str_extract(colnames(FM4), "[FM]\\d\\d")
## 行列の名前を設定
rownames(FM4) <- FM3$TERM
## 次元(行数と列数)を確認
dim(FM4)
## 列名と行名を確認
colnames(FM4) 
rownames(FM4)

### 7.3 意見データの対応分析
#install.packages(c("FactoMineR", "factoextra"))
library(FactoMineR)
FM4ca <- CA(FM4, graph = FALSE)
## ggplot2 ベースのバイプロットを描く
library(factoextra)
fviz_ca_biplot(FM4ca)

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf("FM4ca.pdf", family = "JP1")# Mac の場合は family = "HiraKakuProN-W3" と変えてください
fviz_ca_biplot(FM4ca)
dev.off()


### 独立性の検定(カイ自乗検定)
# Excel ファイルの読み込み
library(readxl)

setwd("C:/Users/ishida/Documents/TextMining")

dat <- read_excel("data/sentences.xlsx")

## クロス表を生成
dat_tb <- xtabs(~ Sex + Sent, data = dat)
dat_tb

options("digits" = 7)

chisq.test(dat_tb)

### 7.5 対応分析

dat <- matrix(c(1,2,0,0,  0,2,6,0, 0,1,2,2,  0,0,0,2),
              ncol = 4, byrow = TRUE)
colnames(dat) <- c("中卒F", "高校中退F", "高卒F", "大卒F")
rownames(dat) <- c("中卒M", "高校中退M", "高卒M", "大卒M")
dat

library(FactoMineR)
library(factoextra)
datCA <- CA(dat, graph = FALSE)
fviz_ca_biplot(datCA)

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "datCA.pdf", family = "JP1") # Mac の場合は family = "HiraKakuProN-W3" と変えてください
fviz_ca_biplot(datCA)
dev.off()


dat_cp <- MASS::corresp(dat, nf = 2)
biplot(dat_cp)


