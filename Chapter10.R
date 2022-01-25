# 『改訂版Rによるテキストマイニング入門』
## 第10章 書き手の判別 漱石と鴎外の文体比較


### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Download/TextMining")# など


library(RMeCab)

### 10.2 N グラムを利用したクラスター分析
res <- docNgram("data/writers", type = 0)

ncol(res) ; nrow(res)

colnames(res) <- c("鴎外：雁", "鴎外：かのように", "鴎外：鶏", "鴎外：ヰタ", 
                   "漱石：永日", "漱石：硝子", "漱石：思い出す", "漱石：夢")

res %>% tail()

library(dplyr)
res2 <- res %>% t() %>% dist() %>% hclust("ward.D2")

library(ggdendro)
res2 %>% ggdendrogram()

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "res2.pdf", family = "JP1")# Mac の場合は family = "HiraKakuProN-W3" と変えてください
ggdendrogram(res2)
dev.off()



### 10.3 書き手の癖
res2 <- res[rownames(res) %in% c("[と-、]", "[て-、]", "[は-、]", "[が-、]", 
                                  "[で-、]", "[に-、]", "[ら-、]", "[も-、]"), ]
dim(res2)

iris %>% head()


### 10。4 主成分分析
iris_pc <- princomp(iris[ , -5])
iris %>% head()

## アヤメの種類を数値で表わす
iris.name <- as.numeric(iris[, 5])
## プロットの土台だけ描く
plot(iris_pc$scores[, 1:2], type = "n")
## 土台に文字を重ねる
text(iris_pc$scores[, 1:2], lab = iris.name, 
     col = as.numeric(iris.name))



### 10.5 主成分分析による作家の判別
res2_pc <- princomp(t(res2))
res2_pc <- res2 %>% t()%>% princomp()

options(digits = 3)

summary(res2_pc)

# install.packages("ggfortify")
library(ggfortify)

library(stringr)
rownames(res2_pc$scores) 

# 変数名を日本語にした場合は以下（１）はスキップして、（２）を実行
# （１）変数名がアルファベット表記の場合
rownames(res2_pc$scores) <- res2_pc$scores %>% 
                              rownames() %>% 
                                str_extract("[a-z]+") %>% 
                                  paste0(1:8)

# （２） バイプロットの作成
autoplot(res2_pc, label =TRUE, label.size = 8, loadings = TRUE, 
          loadings.label = TRUE,  loadings.label.size  = 6, 
          loadings.label.family = "JP1")

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "res2pc.pdf", family = "JP1")# Mac の場合は family = "HiraKakuProN-W3" と変えてください
autoplot(res2_pc, label =TRUE, label.size = 8, loadings = TRUE, 
         loadings.label = TRUE,  loadings.label.size  = 12, 
         loadings.label.family = "JP1")# Mac の場合は family = "HiraKakuProN-W3" と変えてください
dev.off()

