# 『改訂版Rによるテキストマイニング入門』
## 第1章 テキストマイニングとは何か

### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など

### 1.2.1 対応分析

## 以下のコードは第3章R/RStudio速習を読了後に実行されることを勧める
dat <- matrix(c(4,2,2,3,1, 2,8,9,3,7, 6,1,2,6,2, 2,4,4,3,2), nrow = 5)
colnames(dat) <- c("主婦Yes", "主婦No", "独身Yes", "独身No")
rownames(dat) <- c("機能",  "スペース", "場所", "便利", "割高")
dat

install.packages("FactoMineR")
library(FactoMineR)
dat_ca <- CA(dat, graph = FALSE)

install.packages("factoextra")
library(factoextra)

fviz_ca_biplot(dat_ca)

# 上記の実行結果の画像で文字化けが生じている場合、以下のようにPDF画像として作成して確認してみてください
# 3行続けて実行することで画像ファイルが作成されます
# RStudio 右のFilesタブで画像ファイルをクリックすることで、適切なビューワー が立ちあがります
cairo_pdf(file = "chapter1") 
fviz_ca_biplot(dat_ca)
dev.off()


