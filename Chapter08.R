# 『改訂版Rによるテキストマイニング入門』
## 第8章 青空文庫データの解析  ワードクラウドとネットワークグラフ


### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 8.1 ダウンロードしたファイルの整形と解析
source("http://rmecab.jp/R/Aozora.R")
Aozora

x <- Aozora("http://www.aozora.gr.jp/cards/000081/files/43754_ruby_17594.zip")

library(RMeCab)
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")

## miyaz <- docDF("data/NORUBY/chumonno_oi_ryoriten2.txt", type = 1)
miyaz <- docDF(x, type = 1)
library(dplyr)
miyaz %>% head()

miyaz %>% filter(POS2 == "固有名詞")
miyaz2 <- miyaz %>% select(everything(), FREQ = chumonno_oi_ryoriten2.txt) %>% 
                    filter(POS1 %in% c("名詞","形容詞"), 
                           POS2 %in% c("一般", "固有名詞", "自立"))

miyaz2 %>% arrange(FREQ) %>% tail(50)

## ワードクラウドを作成する準備
install.packages("wordcloud")
library(wordcloud)
## プロット作成
wordcloud(miyaz2$TERM, miyaz2$FREQ, min.freq = 3, 
          scale = c(6,1),family = "JP1", colors = brewer.pal(8, "Dark2"))


### 8.2 ネットワークグラフ 
bigram <- NgramDF("data/NORUBY/chumonno_oi_ryoriten2.txt", type = 1, 
                    pos = c("名詞","形容詞", "動詞"))

bigram <- NgramDF(x, type = 1, pos = c("名詞","形容詞", "動詞"))

bigram %>% head()

bigram2 <- docDF("data/NORUBY/chumonno_oi_ryoriten2.txt", type = 1, N = 2, 
              pos = c("名詞","形容詞", "動詞"), nDF = 1)

bigram2 %>% head()

library(magrittr)

bigram2 %>% use_series(POS2) %>% unique()

bigram2 %>% filter(POS2 == "数-数")

bigram2 %>% filter(POS2 == "代名詞-接尾")

bigram3 <- bigram2 %>% select(everything(), 
                         FREQ = chumonno_oi_ryoriten2.txt) %>%
                      filter(!grepl("数|接尾|非自立", POS2) | FREQ > 5)
bigram3 %>% NROW()
bigram3 %>% head()

bigram4 <- bigram3 %>% select (N1, N2, FREQ) %>% 
                       filter(FREQ >= 2)
bigram4 %>% NROW()

bigram4 %>% filter(FREQ == max(FREQ))

bigram5 <- bigram4 %>% filter(FREQ < 25)

library(igraph)

bigram6 <- graph_from_data_frame(bigram5)

tkplot(bigram6, vertex.color = "SkyBlue", vertex.size = 22)


E(bigram6)$weight <- bigram5$FREQ *2

bigram7 <- edge.betweenness.community(bigram6, 
                                      weights = E(bigram6)$weight, 
                                      directed = F)


## マージンを調整する
par(mar= c(1,0,1,0), oma = c(0,0,0,0), omi = c(0,0,0,0))
plot(bigram6, vertex.color = "SkyBlue", vertex.size = 6,
     vertex.label.cex  = 1.5, ## 形態素のサイズ
     vertex.label.dist = .5,  ## ラベルを円から離す 
     edge.width = E(bigram6)$weight, ## 辺のサイズを調整
     vertex.label.family = "JP1") ## フォントの指定

bigram7 <- edge.betweenness.community(bigram6, 
                                      weights = E(bigram6)$weight, 
                                      directed = F)

plot(bigram7, bigram6, vertex.label.family = "JP1")# Mac の場合は family = "HiraKakuProN-W3" と変えてください

