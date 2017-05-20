# 『改訂版Rによるテキストマイニング入門』
## 第11章 Twitter タイムラインの分析 APIの利用


### 11.2 R での準備

install.packages(c("twitteR", "bit64", "rjson", "DBI", "httr", 
                   "base64enc"), dependencies = TRUE)

library("twitteR")
### 以下の ################################################## を自身が取得したキーに置き換える
# Consumer Key
consumerKey <- "##################################################"
# Consumer Secret
consumerSecret <- "##################################################"
# Access Token
accessToken <- "########################################"
# Access Token Secret
accessSecret <- "########################################"


### 11.3 認証
options(httr_oauth_cache = TRUE)
setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessSecret)


### 11.4 twitteR の利用
## Windowsの場合文字コードを変換して投稿する
tweet(iconv("2017 1 14 R から呟いてみる", 
            from = "UTF-8", to = "CP932"))
## Mac ないし Linux の場合
## tweet("2017 1 14 R から呟いてみる")

### 特定のアカウントのツィートを取得
tweets <- userTimeline("mextjapan", 200)

str(tweets[[1]])

texts <- sapply(tweets, statusText)

library(dplyr)
texts %>% head()

library(stringr)
library(magrittr)

texts %<>% str_replace_all("\\p{ASCII}", "")
# 欠損値となった要素があれば省く
texts <- texts[!is.na(texts)]


# Windowsの場合文字コードを変更する
# texts <- iconv(texts , from = "UTF-8", to = "CP932")
   # Macの場合、上の１行は実行してもしなくとも問題ない


# 取得したツィーツをファイルに保存
text2 <- paste(texts, collapse ="")
xfile <- tempfile()
write(text2, xfile)


library(RMeCab)
mext <- docDF(xfile, type = 1, pos = "名詞")

# 名詞のみ抽出
mext <- docDF(xfile, type = 1, pos = "名詞")
#library(magrittr) # %<>% 演算子と ! を利用する
mext %<>% filter(!POS2 %in% c("非自立", "数","サ変接続"))

head(mext)

library(dplyr)

# 列名を変更
mext %<>% select(everything(), FREQ = starts_with("file"))
unlink(xfile)
mext %>% arrange(FREQ) %>% tail(40)



library (wordcloud)
#  pal <- brewer.pal(8,"Dark2")
# wordcloud (m2[,1], m2[,4], min.freq = 7, colors = pal)
wordcloud (mext$TERM, mext$FREQ, min.freq = 6, family = "JP1")


### 11.6 トレンドの取得
woeid <- availableTrendLocations()
woeid %>% filter(country == "Japan")

trends <- getTrends(1118370)
trends$name


center <- searchTwitter(searchString = "センター試験", n = 1000, since = "2017-01-13")

cntDF <- twListToDF(center)
cntDF %>% head()


texts <- cntDF$text
# 記号などを削除

texts %<>% str_replace_all("\\p{ASCII}", "")
# Windowsの場合はここで文字列を変換する
# texts <- iconv(texts , from = "UTF-8", to = "CP932")
  # Mac や Linux で実行してはいけない

# 取得したテキストをファイルに保存
text2 <- paste(texts, collapse = "")
xfile <- tempfile()
write(text2, xfile)

cnttxt <- NgramDF(xfile, type = 1, pos = c("名詞","形容詞"))
cnttxt  %>%  arrange(Freq) %>% tail(50)

cnttxt2 <- cnttxt %>% filter(Freq >= 31)

library(igraph)
cntgraph  <- graph.data.frame(cnttxt2)
RC

tkplot(cntgraph, vertex.size = 23, vertex.color = "SkyBlue")




