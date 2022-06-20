## 動的サイトをスクレイピングする方法として
## selenium を利用した例を紹介します
## java が動作する環境整備と、selenium のインストールが必要です
## https://www.selenium.dev/ja/

## java (jre) をダウンロードします
##  https://www.java.com/ko/download/manual.jsp

## Selenium Standalone Server をダウンロードします
##  https://www.selenium.dev/downloads/

## ブラウザ用のドライバをダウンロードします
## https://www.selenium.dev/ja/documentation/webdriver/getting_started/install_drivers/

## RSelenium をインストールします
install.packages("RSelenium")

# use installed selenium-server
## 以下は筆者の環境でseleniumサーバを起動する例です
# cd .local/share/binman_seleniumserver/generic/4.0.0-alpha-2/
# java -jar selenium-server-standalone-4.0.0-alpha-2.jar 

## 起動後Rで以下を操作
library(RSelenium)
# Start Selenium Session
## 以下を実行すると、バックグランドで自動的に関連ドライバがインストールされる？
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444L,
  browserName = "firefox"
)
remDr$open()

remDr$navigate(url = "https://bookmeter.com/books/5550353")

# reviews <- remDr$findElements(using = "css", "html body.layouts.application section.books.show div.bm-wrapper div.bm-wrapper__main section.layouts.components.content-with-header div.content-with-header__content section")
reviews <- remDr$findElements(using = "class", "frame__content__text")

texts <-  unlist(lapply(reviews, function(x){x$getElementText()}))

texts

remDr$close()

writeLines(texts, "data/reviews.txt")

library(RMeCab)
revi <- docDF("data/reviews.txt", type = 1, pos = c("名詞","形容詞", "動詞"))
revi
# revi %>% NROW()
