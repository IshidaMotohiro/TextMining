# 『改訂版Rによるテキストマイニング入門』
## 第6章 口コミのテキストマイニング

### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 6.2 ウェブスクレイピングの準備
# install.packages("rvest")

# library(rvest)

### 2017年4月にサイト構造が大きく変ったため、以下のコードではテキストを抽出できません
### サイトからテキストを抽出し、テキストマイニングのデータとする手順として参考にしてください
### 抽出し、形態素解析を実行した結果のファイルを revicsv, bigram.csv として用意しています

# jobs <- read_html("http://bookmeter.com/b/4062180731")

library(dplyr)
# reviews <- jobs %>% html_nodes("div[id^='review_text_']") %>% html_text()

library(magrittr)
# reviews %>% extract(1)

library(RMeCab)
# reviews %>% extract2(1) %>% RMeCabC() %>% unlist()

## writeLines(reviews, "data/reviews.txt")

# revi <- docDF("data/reviews.txt", type = 1, pos = c("名詞","形容詞", "動詞"))
# revi %>% NROW()


revi <- read.csv("data/revi.csv", stringsAsFactors = FALSE)

revi %>% head ()

revi %>% filter(POS1 == "名詞") %>% head(10)

revi %>% filter(POS1 == "名詞",  POS2 %in% c("一般","固有")) %>% head(10)

revi %>% filter(POS1 == "動詞") %>% head(10)

revi %>% filter(POS1 == "形容詞") %>% head(10)

revi2 <- revi %>% filter(POS2 %in% c("一般", "固有", "自立"))
revi2 %>% NROW()

revi2 %>% arrange(reviews.txt) %>% tail(30)

# 
#bigram <- docDF("data/reviews.txt", type = 1, nDF = 1, N = 2, 
#                 pos = c("名詞","形容詞","動詞"))
#
#write.csv(bigram, file = "data/bigram.csv", row.names = FALSE, quote = FALSE, fileEncoding = "UTF-8")

bigram  <- read.csv("data/bigram.csv", stringsAsFactors = FALSE)


bigram %>% arrange(reviews.txt) %>% tail(10)

bigram2 <- bigram %>% select (N1, N2, reviews.txt) %>% 
             filter(reviews.txt > 1)
bigram2 %>% class()
bigram2 %>% head(10)

## install.packages("igraph")
library(igraph)

bigramN <- graph.data.frame(bigram2)
bigramN <- graph_from_data_frame(bigram2)

tkplot(bigramN, vertex.color = "SkyBlue", vertex.size = 22)

plot(bigramN, vertex.color = "SkyBlue", vertex.size = 22)
