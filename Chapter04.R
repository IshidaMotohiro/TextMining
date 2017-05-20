# 『改訂版Rによるテキストマイニング入門』
## 第4章 文字処理と正規表現


### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 4.1 文字データの検索・置換
uni <- c("北海道大学獣医学部", "東北大学工学部", "東京大学教養学部", 
          "名古屋大学情報文化学部", "京都大学医学部", "広島大学総合科学部", 
          "九州大学農学部")
# 内容を確認
uni

grep("医学", uni)

uni[c(1,5)]

grep("医学", uni, value = TRUE)

sub("医学", "薬学", uni)

### 4.2 stringr パッケージによる処理
install.packages("stringr")

library(dplyr)
library(stringr)
uni %>% str_subset("医学")


### 4.2.1 置換
uni %>% str_replace("京都", "東京")

### 4.2.2 部分抽出
uni %>% str_extract("医学")

tel <- c("電話番号 00-123-5678", "市外局番 03", "電話は 09-876-5432 です")

tel %>% str_extract("\\d{2}-\\d{3}-\\d{4}")



### 4.3 正規表現で使われる記法 
tel %>% str_extract("1|2|3|4|5|6|7|8|9|0")


### 4.3.1 メタ文字
tel %>% str_extract("\\d")

tel %>% str_extract("\\d+")

tel %>% str_extract_all("\\d+")

### 4.3.2 量指定子 
tel %>% str_extract("\\d{2}-\\d{3}-\\d{4}")

### 正規表現の制御
weather <- c("今日は雪です", "昨日は雨でした", "明後日は晴れです")
weather %>% str_replace("[雪雨]", "晴れ")

pm <- c("安倍 晋三","野田 佳彦", "菅 直人", "鳩山 由紀夫", "麻生 太郎")
pm %>% str_replace("(\\w+) (\\w+)", "\\1")

pm %>% str_replace("(\\w+) (\\w+)", "\\2")

library(stringr)
x <- "ひらがな hiragana カタカナ katakana 日本語 12345"
x %>% str_replace_all("\\p{ASCII}", "") 
x %>% str_replace_all("\\p{Hiragana}", "") 
x %>% str_replace_all("\\p{Katakana}", "") 
x %>% str_replace_all("\\p{Han}", "")

gsub("\\p{ASCII}", "", x)

install.packages("tm")

### 4.4 tm パッケージ
library(tm)
library(dplyr)

getwd()# 現在のワークスペースを確認
alice <- VCorpus(DirSource(dir = "data/alice/"), 
                 readerControl = list(language = "english"))

getReaders() %>% head()

alice
alice  %>% inspect

alice[[1]] %>% as.character()

### 4.4.1 空白文字などの削除
alice1 <- alice %>% tm_map(stripWhitespace)

alice1[[1]] %>% as.character()

library(magrittr)
alice1 %<>% tm_map(removePunctuation)

alice1[[1]] %>% as.character()

### 4.4.2 大文字小文字の統一
alice1 %<>% tm_map(content_transformer(tolower))

alice1[[1]] %>% as.character()

### 4.4.3 ストップワードの削除 
alice1 %<>% tm_map(removeWords, stopwords("english"))

alice1[[1]] %>% as.character()

### 4.4.4 ステミング
install.packages("SnowballC")

library(SnowballC)

alice1 %<>% tm_map(stemDocument)

alice1[[1]] %>%  as.character()

### 4.5 単語文書行列の生成
dtm <- TermDocumentMatrix(alice1)

dtm %>% inspect()

dtm %>% findFreqTerms(3)

dtm %>% findAssocs("alic", .8)

vignette(package = "tm")
vignette("tm")
