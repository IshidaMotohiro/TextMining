# 『改訂版Rによるテキストマイニング入門』
## 第5章 RMeCabによるテキスト解析

### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 5.2 短かいテキストの解析
library(RMeCab)
RMeCabC("本を読んだ")

library(dplyr)
RMeCabC("今日は本を読んだ。") %>% unlist ()

hon <- RMeCabC("今日は本を読んだ。") %>% unlist() 
hon [names(hon) %in% c("名詞", "動詞")]

RMeCabC("今日は本を読んだ。", 1) %>% unlist()

?RMeCabC

### 5.3 MeCabの解析出力をすべて取り込む方法
getwd()# 現在のワークスペースを確認
file.exists("data/hon.txt")

RMeCabText("data/hon.txt")

tmp <- tempfile()
writeLines("本を買った", con = tmp)
# 一時ファイルの保存場所を表示
tmp 
x <-RMeCabText(tmp)
# 一時ファイルを削除
unlink(tmp) 
# 解析結果を確認
x

install.packages("purrr")
library(purrr)
x %>% map_chr(extract(9))

### 5.4 頻度表の作成と利用
tmp <- data.frame(BUN = "本を買った", stringAsFactor = FALSE)
x <- docDF(tmp, "BUN", type = 1)

x


### 5.4.1 品詞を限定して抽出する
merosu <- docDF("data/merosu.txt", 
                type = 1, pos = c("名詞", "形容詞", "動詞"))

merosu %>% head()

library(magrittr)
merosu %<>% rename(FREQ = merosu.txt) %>% arrange(FREQ)

merosu %>% tail()

### 5.4.2 形態素の検索 
merosu %>% filter(TERM == "メロス")

merosu2 <- merosu %>% select(TERM, POS1, FREQ) %>% 
             group_by(TERM, POS1) %>%
               summarize(FREQ = sum(FREQ)) 
merosu2 %>% NROW()

merosu2 %>% head()

merosu2 %>% filter(TERM == "メロス")

merosu2 %>% group_by(POS1) %>% summarize(SUM = sum(FREQ))

merosu2 %>% group_by(POS1) %>% summarize(SUM = sum(FREQ)) %>%
               mutate(PROP = SUM / sum(SUM) )


### 5.4.3 分析結果から品詞情報を指定して検索
merosu %>%  filter(POS1 %in% c("動詞", "形容詞"), POS2 == "自立") %>% NROW()


### 5.4.4 共起語
res <- collocate("data/kumo.txt", node = "極楽", span = 3)

library(dplyr)
res %>% tail(15)

log2(4 / ((4/1808) * 3 * 2 * 10))

res2 <- collScores(res, node = "極楽", span = 3)
res2 %>% tail(15)

### 5.5 単語文書行列の生成
mat <- docMatrix("data/doc")

mat

mat <- mat[ rownames(mat) != "[[LESS-THAN-1]]" , ]
mat <- mat[ rownames(mat) != "[[TOTAL-TOKENS]]" , ]

mat

mat <- docMatrix("data/doc", pos = c("名詞","形容詞","動詞","助詞"))

mat

### 5.5.1 重み(TF-IDF) 掲載
matW <- docMatrix("data/doc", weight = "tf*idf*norm")

options(digits = 3)

matW %>% head()

matW %>% apply(2, function(x) sum(x^2))

?docMatrix


### 5.5.2 その他の関数
photo <- read.csv("data/photo.csv", stringsAsFactor = FALSE)
photo

res <- docMatrixDF(photo[ ,"Reply"])

res

res <- docDF(photo, column = "Reply", type = 1, pos = c("名詞","形容詞"), N = 2)
res

### 5.6 Nグラムのデータフレームを生成
library(RMeCab)
S <- data.frame(BUN = "メロスは激怒した", stringsAsFactors = FALSE)
(docDF(S, column = 1, type = 1, N = 2))

### 5.6.1 文字のNグラムの
merosu <- Ngram("data/merosu.txt", type = 0, N = 2)

merosu %>% head()

### 5.6.2  形態素のNグラム
merosu <- Ngram("data/merosu.txt", type = 1, N = 2)

merosu %>% head()

### 5.6.3 品詞でのNグラムの
merosu <- Ngram("data/merosu.txt", type = 2, N = 2)

merosu %>% head()


### 5.6.4 汎用的なdocDF() 
merosu <- docDF("data/merosu.txt", type = 1, pos = c("名詞","形容詞"), N = 2, nDF = 1)
merosu %>% head()

S <- data.frame(S= "メロスは激怒した", stringsAsFactors = FALSE)
(docDF(S, column = 1, type = 1, N = 2, nDF = 1))


### 5.6.5 Nグラムを行列として出力
merosu <- docNgram("data/doc")

merosu %>% head()

merosu %>% rownames()


### 5.6.6 Nグラムを生成する他の関数
merosu <- NgramDF("data/merosu.txt", type = 1, N = 2)

merosu %>% head()

res <- docNgram("data/doc", type = 0) # デフォルトは 1 (形態素のバイグラム)
res

res <- docNgram2("data/doc") # デフォルトは文字のバイグラム
res <- docNgram2("data/doc", type = 1,       # 形態素のバイグラム
                  pos = c("名詞", "形容詞")) # 品詞を指定
res <- docNgram2("data/doc", type = 1, 
                  pos = c("名詞", "形容詞", "記号")) # 記号を含めた出力
res %>% head()

?docDF
