# 『改訂版Rによるテキストマイニング入門』
## 第9章 テキストの分類 クラスター分析、トピックモデルマイニングとは何か


### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### l9.1 解析の準備
library(RMeCab)
## Windowsの場合は以下の "data/prime/utf" を "data/prime/sjis" にするなど
## 自身の作業環境にあわせて適宜変更
prime <- docMatrix2("data/prime/utf8", pos = c("名詞","形容詞","動詞"), 
                   weight = "tf*idf*norm")

ncol(prime) ; nrow(prime)


library(stringr)
library(dplyr)
library(magrittr)
## 列名を短縮化する
colnames(prime)  %<>% str_replace("_general-policy-speech.txt", "")
colnames(prime)  %<>% str_replace("(\\d{4})\\d{4}_(\\d{3})", "\\1_\\2")


### 9.3 所信表明演説のクラスター分析
hc <- prime %>% t %>% dist %>% hclust("ward.D2")

# 
install.packages("ggdendro")

library(ggdendro)
ggdendrogram(hc, rotate= TRUE)

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "hc.pdf", family = "JP1")
ggdendrogram(hc, rotate= TRUE)
dev.off()


### 9.5 特異値分解

TD <- matrix (c(1,0,0,0,1,0,
                0,1,0,1,0,1, 
                0,1,0,0,0,0,
                0,1,0,0,0,0,
                0,0,1,0,0,1,
                1,1,1,1,0,0,
                0,0,1,2,1,0,
                1,1,0,0,0,0), nrow = 8, byrow = TRUE)
## 作成した行列に列名と行名を設定
colnames(TD) <- paste0("doc", 1:6)
rownames(TD) <- paste0("w", 1:8)

# 特異値分解
TD_svd <- svd(TD)

options(digits = 3)
TD_svd$u

TD_svd$d

TD_svd$v

t(TD_svd$u[, 1:3]) %*% TD

### 9.6 潜在的意味インデキシングによる分類
install.packages("rgl")

prime.svd <- svd(prime)
prime2 <- t(prime.svd$u[, 1:3]) %*% prime
dim(prime2)

colnames(prime2) <- prime2 %>% colnames() %>%
                        str_extract("\\d{4}_\\d{2,3}")
cols <- prime2 %>% colnames() %>% str_extract("\\d{3}")

# パッケージ読み込み
library(rgl)
# 別ウィンドウを開き
rgl.open()
# 座標を色分けする
rgl.lines(c(-1,1), 0,0, color = "gold")
rgl.lines(0, c(-1,1), 0, color = "gray")
rgl.lines(0,0,c(-1,1), color = "black")
# 3次元空間のカラーを指定し
rgl.bbox(color = "blue", emission = "green")
# 文書名を付置する
rgl.texts(prime2[1,], prime2[2,], prime2[3,],
          colnames(prime2), color = cols)

rgl.snapshot(file = "prime.png")

rgl.close()

library(rgl)
plot3d(t(prime2), type = "n")
text3d(t(prime2), text = colnames(prime2), col = cols, cex = 1.4)

vignette(package = "rgl")
vignette("rgl")


### 9.7 トピックモデル
install.packages(c("topicmodels","lda"))

library(RMeCab)


prime <- docDF("data/prime/utf8", type = 1, 
               pos = c("名詞","形容詞"), minFreq = 3)

dim(prime)

prime2 <- prime %>% filter(POS2 %in% c("一般","自立"))
dim(prime2)

prime2$TERM %>% duplicated() %>% which()

library(stringr)
library(magrittr)
## 数値列だけを殘したオブジェクトを作成
prime3 <-  prime2 %>% select(-c(TERM:POS2))
## 行名に形態素解析の結果を設定 
rownames(prime3) <- prime2$TERM
## 列名は短縮化
colnames(prime3)  %<>% str_replace("_general-policy-speech.txt", "")
colnames(prime3)  %<>% str_replace("(\\d{4})\\d{4}_(\\d{3})", "\\1_\\2")

library(tm)
prime3a <- prime3 %>% t() %>%  as.DocumentTermMatrix(weighting = weightTf)

### 9.7.1 トピックモデルによるモデル推定
library(topicmodels)
## トピックの数を指定
K <- 5
res1 <- prime3a %>% LDA(K)

terms(res1)

str(res1)
posterior(res1)[[1]] [1:5,1:5]
posterior(res1)[[2]]


### 9.7.2 ldaパッケージによる分析と可視化

library(topicmodels)
prime4  <- dtm2ldaformat(prime3a)

library(lda)
set.seed(123)
K <- 5
result <- lda.collapsed.gibbs.sampler(prime4$documents, K = K, 
            prime4$vocab, 25, 0.1, 0.1, compute.log.likelihood=TRUE)

top.topic.words(result$topics, 10, by.score=TRUE)

prime5 <- rownames(prime3a) %>% str_subset("koizumi|hatoyama|noda|abe")
prime5

prime6 <- rownames(prime3a) %>% 
        str_detect("koizumi|hatoyama|noda|abe") %>% which
prime6

cbind(prime6, prime5)

## 文書全体のトピック割合
options(digits = 3)

topic.proportions <- t(result$document_sums) / colSums(result$document_sums)
## 対象とする所信表明演説を抽出
ministers  <- topic.proportions [c(64, 74, 77, 80), ]
ministers

ministers %>% rowSums()

ministers

## 行列をデータフレームに変換し列名を設定
ministersDF <- as.data.frame(ministers) %>% 
                 set_names(paste0("topic", 1:5)) %>% 
                   ## num という列を追加
                   mutate(num = paste0("No", c(64, 74, 77, 80)))
ministersDF

# install.packages("tidyr")

library(tidyr)

ministersDF <- ministersDF %>% 
                   gather(key = topic, value = props, -num)

library(ggplot2)

ministersDF %>% ggplot(aes(x = topic, y = props, fill = num)) +       geom_bar(stat = "identity") + facet_wrap(~num)

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "ministersDF.pdf", family = "JP1")
x
dev.off()

