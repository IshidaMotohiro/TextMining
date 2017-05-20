
# 『改訂版Rによるテキストマイニング入門』
## 第2章 テキストマイニングの準備

### ダウンロードしたスクリプトおよびデータが保存されたフォルダをワークスペースとして設定
### Windows
setwd("C:/Users/ishida/TextMining")# など
### Mac
setwd("/Users/ishida/Download/TextMining")# など
### Linux
setwd("/home/ishida/Dropbox/R/Morikita/Version2/")# など


### 2.4.5 ソースからのインストール
# 以下はR/RStudioではなく、別のソフトウェアである「ターミナル」を起動して入力、実行します
tar xf mecab-0.996.tar.gz
cd mecab-0.996
./configure --with-charset=utf8
make
sudo make install
sudo ldconfig ## Linux ではこれが必要

# 辞書
cd ~/Downloads
tar xf mecab-ipadic-2.7.0-20070801.tar.gz
cd mecab-ipadic-2.7.0-20070801
./configure --with-charset=utf-8
make
sudo make install
sudo ldconfig ## Linux ではこれが必要

### 2.5 MeCab の実行 c ドライブの work フォルダに test.txt ファイル(この近くに郵便局ありますか)が存在するとして 
# 以下はR/RStudioではなく、ターミナルで実行
C:\Program Files (x86)\MeCab\bin\mecab.exe c:\work\test.txt > c:\work\res.txt
### 32 ビット版Windowsでは以下のように実行
C:\Program Files\MeCab\bin\mecab.exe c:\work\test.txt > c:\work\res.txt

# Mac ではターミナルを起動して以下のように実行
mecab /Users/ishida/test.txt > /Users/ishida/res.txt

### 2.6 RMeCab の導入
install.packages("RMeCab", repos = "http://rmecab.jp/R")

# Mac あるいは Linux であれば、以下のようにしてGitHubからソースを取得してインストールすることも可能
# install.packages("devtools")
# devtools::install_github("IshidaMotohiro/RMeCab")


### 2.7 MeCab の辞書整備
#### 以下はR/RStudioではなく、ターミナルで実行
C:\Program Files (x86)\MeCab\bin>mecab-dict-index.exe -d "c:\Program Files (x86)\MeCab\dic\ipadic" -u c:\data\motohiro.dic -f shift-jis -t shift-jis c:\data\motohiro.csv
### 32ビットWindowsの場合
C:\Program Files\MeCab\bin>mecab-dict-index.exe -d "c:\Program Files\MeCab\dic\ipadic" -u c:\data\motohiro.dic -f shift-jis -t shift-jis c:\data\motohiro.csv

### Mac/Linux ではターミナルを起動して実行
### ソースコードからインストールした場合
/usr/local/libexec/mecab/mecab-dict-index -d /usr/local/lib/mecab/dic/ipadic -u motohiro.dic -f utf-8 -t utf-8 motohiro.csv 
### Homebrew を使ってインストールした場合
/usr/local/Cellar/mecab/0.996/libexec/mecab/mecab-dict-index  -d /usr/local/Cellar/mecab/0.996/lib/mecab/dic/ipadic -u motohiro.dic -f utf-8 -t utf-8 motohiro.csv 

# 以下で dic=引数の指定は読者の環境にあわせて変更してください
library(RMeCab)
(docDF(data.frame(X = "石田基広"), "X", type = 1,  dic = "C:/Users/ishida/ishida.dic"))
(docDF(data.frame(X = "石田基広"), "X", type = 1,  dic = "/home/ishida/Dropbox/R/forCheck_utf8/ishida.dic"))


