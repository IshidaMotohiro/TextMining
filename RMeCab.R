## RMeCab マニュアル # ver. 0.1 # 2016 12 15  
######################################################
#　　　石田　基広　著
#     『Rによるテキストマイニング入門』 
#     森北出版,ISBN 978-4-627-84841-2,2017年  3 月

# http://sites.google.com/site/rmecab/
# http://rmecab.jp/index.php?RMeCab


######### シャープ(#)記号から右の記述はコメントです。
######### シャープ(#)記号から右は実行しても無視されます。


##### 作業フォルダを変更する必要があれば
# getwd() ## 現在のフォルダを確認する
##### 作業フォルダを変更する必要があれば
# setwd("C:/data") # Windows

setwd("/Users/ishidamotohiro/data") # Mac OS X
setwd("C:/Users/ishida/data")# Windows

## グラフで日本語を扱う
## R をインストール後、以下をRのコンソールで一度だけ実行してください
source("http://rmecab.jp/R/Rprofile.R")
## ホームフォルダに .Rprofileという設定ファイルが生成されます
### すでに存在している場合は日付をファイル名に追加したバックアップが作られた上で上書きされます
## Rは起動時にこの設定を読み込みます


#####   MeCab のインストール
# https://sites.google.com/site/rmecab/home/install
## を参照してください


##################################################
## RMeCabのインストール

install.packages("RMeCab", repos = "http://rmecab.jp/R")

library(RMeCab)

citation("RMeCab")



##############################################################################
## RMeCabC 関数
##### 文字列を解析

?RMeCabC
### USAGE: RMeCabC(str, mypref, dic = "", mecabrc = "", etc = "")
## str : 文字列
## mypref : 活用語を表層型 にするか (デフォルト)、原型に直すか mypref=1
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す

res <- RMeCabC("すもももももももものうち")
res

res <- RMeCabC("石田基広")
res


## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
 res <- RMeCabC("石田基広", dic = "/home/ishida/Dropbox/R/forCheck_utf8/ishida.dic")
## res




res <- RMeCabC("すもももももももものうち")
res
res <- RMeCabC("Aを1個食べたいな")
res

res <- RMeCabC("ご飯を食べた", 1)
unlist(res)

res <- RMeCabC("ご飯を食べた", 0)
unlist(res)



res <- RMeCabC("すもももももももものうち")
  # Encoding( names(res[[1]]) )

res2 <- unlist(res)
res2


res2[names(res2) == "名詞"]


res3 <- names(res2) == "名詞"

   which(res3)
   any(res3)




##############################################################################
## RMeCabText 関数
###### ファイルから読み込む

?RMeCabText
### USAGE:  RMeCabText(filename , dic = "", mecabrc = "", etc = "")
## file : 解析ファイル名
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す

# setwd("C:/data") # Windows
# setwd("/Users/ishidamotohiro/data") # Mac OS X

res <- RMeCabText("yukiguni.txt")
res

## [[1]]
##  [1] "国境"       "名詞"       "一般"       "*"          "*"         
##  [6] "*"          "*"          "国境"       "コッキョウ" "コッキョー"

## [[2]]
##  [1] "の"     "助詞"   "格助詞" "一般"   "*"      "*"      "*"      "の"    
##  [9] "ノ"     "ノ"    

## [[3]]
##  [1] "長い"             "形容詞"           "自立"             "*"               
##  [5] "*"                "形容詞・アウオ段" "基本形"           "長い"            
##  [9] "ナガイ"           "ナガイ"          
## ... 以下略






## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- RMeCabText("yukiguni.txt", dic = "/home/ishida/ishida.dic")
res



## ベクトルをファイルに偽装する方法

td <- tempfile("tmp")
 write( "私は真面目な学生です。",  file = td)
# library(RMeCab)
test <- RMeCabText(td)
test

dummy <- c ("私は真面目な学生です。", "彼女は数学専攻の学生です。", "すももももももものうち")
dummyList <- list (length (dummy))
td <- tempfile("tmp")

for (i in   seq(dummy) ){                
  write( dummy [i] ,  file = td)# paste(td, "D1", sep="/") )
  dummyList [[i]] <- RMeCabText(td)
}

dummyList 
unlink (td)




##############################################################################
## RMeCabFreq 関数
##### 頻度表の作成

?RMeCabFreq
### USAGE: RMeCabFreq(filename, dic = "", mecabrc = "", etc = "")
## file : 解析ファイル名
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す

res <- RMeCabFreq("yukiguni.txt")
res

##        Term  Info1    Info2 Freq
## 1      ある 助動詞        *    1
## 2        た 助動詞        *    3
## 3        だ 助動詞        *    1
## 4        と   助詞 接続助詞    1
## 5        が   助詞   格助詞    2
## 6        に   助詞   格助詞    1
## 7        の   助詞   格助詞    1
## 8        を   助詞   格助詞    1
## 9        の   助詞   連体化    1
## 10     なる   動詞     自立    1
## 11   抜ける   動詞     自立    1
## 12   止まる   動詞     自立    1
## 13 トンネル   名詞     一般    1
## 14     信号   名詞     一般    1
## 15     国境   名詞     一般    1
## 16       底   名詞     一般    1
## 17     汽車   名詞     一般    1
## 18     雪国   名詞     一般    1
## 19       夜   名詞 副詞可能    1
## 20       所   名詞     接尾    1
## 21     白い 形容詞     自立    1
## 22     長い 形容詞     自立    1
## 23       。   記号     句点    3

# 品詞(Info1)情報でデータをまとめる
res2 <- aggregate(res$Freq, res[1:2], sum)

pt1 <- proc.time()
res <- RMeCabFreq("kumo.txt")
pt2 <- proc.time()
pt2 - pt1

res # 結果を確認



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux


# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
#res <- RMeCabFreq("yukiguni.txt", dic = "/home/ishida/ishida.dic")
# res


RMeCabC("何とも云えない")

## [[1]]
##     副詞 
## "何とも" 

## [[2]]
##   動詞 
## "云え" 

## [[3]]
## 形容詞 
## "ない" 







##############################################################################
## RMeCabDF 関数
#####　データファイルの解析

?RMeCabDF
### USAGE: RMeCabDF(dataf, coln, mypref, dic = "", mecabrc = "", etc = "")
## dataf : 解析対象のデータフレーム名
## coln : データフレームの列名あるいは列番号
## mypref : 表層型(デフォルト)か原型 (myref=1) か
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す

dat <- read.csv("photo.csv")

colnames(dat)
res <- RMeCabDF(dat, 3) #res <- RMeCabDF(dat, "Reply") # に同じ
length(res)

res

## [[1]]
##   名詞   動詞   助詞   動詞   助詞 
## "写真" "とっ"   "て" "くれ"   "よ" 

## [[2]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とっ"       "て" "ください" 

## [[3]]
##   名詞   動詞   助詞   助詞 
## "写真" "とっ"   "て"   "ね" 

## [[4]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とっ"       "て" "ください" 

## [[5]]
##   名詞   動詞   助詞 助動詞 
## "写真" "とっ"   "て" "っす" 

## 活用形は原型にする

res <- RMeCabDF(dat, 3, 1) #res <- RMeCabDF(dat, "Reply", 1) #  に同じ
length(res)

res

## [[1]]
##     名詞     動詞     助詞     動詞     助詞 
##   "写真"   "とる"     "て" "くれる"     "よ" 

## [[2]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とる"       "て" "くださる" 

## [[3]]
##   名詞   動詞   助詞   助詞 
## "写真" "とる"   "て"   "ね" 

## [[4]]
##       名詞       動詞       助詞       動詞 
##     "写真"     "とる"       "て" "くださる" 

## [[5]]
##   名詞   動詞   助詞 助動詞 
## "写真" "とる"   "て" "っす" 



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
# res <- RMeCabDF(dat, 3, 1, dic = "/home/ishida/ishida.dic" ) #res <- RMeCabDF(dat, "Reply", 1) #  に同じ
# length(res)
# res







##############################################################################
## docMatrix 関数
##### ターム・文章行列作成

?docMatrix
### USAGE: docMatrix( mydir, pos = "Default", minFreq = 1, weight ="no", kigo=0, co = 0)
## filename: ファイル集合のあるフォルダ名(パスを含む)
## mydir: (ユーザーは指定できない、内部処理用)
## pos:  抽出単語(デフォルトは名詞と形容詞のみ)
## posN:  (ユーザーは指定できない、内部処理用)
##  minFreq:  最小頻度
##  weight:  重みと正規化
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
##  co:  共起行列を作成するか。デフォルトはしない 0
##  dic: ユーザー辞書の指定
##  mecabrc: MeCab の設定ファイルをデフォルト以外の場所に置く場合に利用
##  etc:     MeCab への特別なオプション指定


  library(RMeCab)
# <2009 May 23> 付属の doc フォルダ内の三つのファイルの内容を変更しました </2009 May 23>
# setwd("C:/data") # Windows
# setwd("/Users/ishidamotohiro/data") # Mac OS X

res <- docMatrix("doc") ## デフォルトの出力は"名詞","形容詞"，pos = c("名詞","形容詞") を指定したと同じ

res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1
 
res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"))
res

## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9
##   は                      1        1        1
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   の                      0        1        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   で                      0        0        1
##   を                      0        0        1
##   難しい                  0        0        1

res <- res[ row.names(res) !=  "[[LESS-THAN-1]]" , ]
res <- res[ row.names(res) !=  "[[TOTAL-TOKENS]]" , ]
res

##         docs
## terms    doc1.txt doc2.txt doc3.txt
##   は            1        1        1
##   学生          1        1        0
##   私            1        0        0
##   真面目        1        0        0
##   の            0        1        0
##   科            0        1        0
##   数学          0        1        1
##   彼女          0        1        1
##   良い          0        1        0
##   で            0        0        1
##   を            0        0        1
##   難しい        0        0        1

res <- res[ rowSums(res) >= 2, ] # 全テキストでの累計が2以上のタームのみ
res

##       docs
## terms  doc1.txt doc2.txt doc3.txt
##   は          1        1        1
##   学生        1        1        0
##   数学        0        1        1
##   彼女        0        1        1



res <- docMatrix("doc", pos = c("名詞","形容詞"), minFreq = 2)
res ## 単独で頻度2以上のタームはないので合計表のみ出力される

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-2]]         3        5        3
##   [[TOTAL-TOKENS]]        6        8        9


## 別のファイル集合

res <- docMatrix("morikita")#  pos = c("名詞","形容詞")
res

## 情報行を削除する
res <- res[row.names(res) != "[[LESS-THAN-1]]" , ]
res <- res[row.names(res) != "[[TOTAL-TOKENS]]" , ]

## 文書全体を通しての頻度が ２ 以上のターム抽出
res <- res[rowSums(res) >= 2, ]
res

#        docs
#terms    morikita1.txt morikita2.txt morikita3.txt
#  家                 1             1             0
#  学                 1             0             2
#  系                 1             0             1
#  研究               1             1             1
#  者                 1             5             2
#  出版               2             0             1
#  小社               1             0             1
#  専門               2             0             1
#  方々               1             1             0
#  理工               1             0             2
#  技術               0             1             1
#  著者               0             2             0
#  編集               0             2             0
#  皆さん             0             0             2
#  書籍               0             0             2

res <- docMatrix("morikita", pos = c("名詞"), minFreq = 2 )
res

#                  docs
#terms              morikita1.txt morikita2.txt morikita3.txt
#  [[LESS-THAN-2]]             18            18            21
#  [[TOTAL-TOKENS]]            42            60            77
#  出版                         2             0             0
#  専門                         2             0             0
#  者                           0             5             2
#  著者                         0             2             0
#  編集                         0             2             0
#  皆さん                       0             0             2
#  学                           0             0             2
#  書籍                         0             0             2
#  理工                         0             0             2

## 記号を含める

 ##### <2009 04 21 RMeCab_0.81 にて改訂>
  # sym 引数は廃止し kigo 引数としました
 ##### </ 以上 2009 04 21 RMeCab_0.81 にて改訂>

res <- docMatrix("doc",kigo = 1) # TOTAL に記号の数を含めている
res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        7        9       10 # ここが違う
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1


## 記号を含めない

res <- docMatrix("doc", kigo = 0)
res

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        6        8        9 #  ここが違う
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1



res <- docMatrix("doc", pos = c("名詞","形容詞","記号")) # 「ターム」として記号を含める
res  # kigo = 1 は自動的にセットされる

##                   docs
## terms              doc1.txt doc2.txt doc3.txt
##   [[LESS-THAN-1]]         0        0        0
##   [[TOTAL-TOKENS]]        7        9       10
##   。                      1        1        1
##   学生                    1        1        0
##   私                      1        0        0
##   真面目                  1        0        0
##   科                      0        1        0
##   数学                    0        1        1
##   彼女                    0        1        1
##   良い                    0        1        0
##   難しい                  0        0        1


## 重みを加える

res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), weight = "tf*idf")
res

##         docs
## terms    doc1.txt doc2.txt doc3.txt
##   は     1.000000 1.000000 1.000000
##   学生   1.584963 1.584963 0.000000
##   私     2.584963 0.000000 0.000000
##   真面目 2.584963 0.000000 0.000000
##   の     0.000000 2.584963 0.000000
##   科     0.000000 2.584963 0.000000
##   数学   0.000000 1.584963 1.584963
##   彼女   0.000000 1.584963 1.584963
##   良い   0.000000 2.584963 0.000000
##   で     0.000000 0.000000 2.584963
##   を     0.000000 0.000000 2.584963
##   難しい 0.000000 0.000000 2.584963


## 重みを加えて標準化

res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), weight = "tf*idf*norm")
res

##         docs
## terms     doc1.txt  doc2.txt  doc3.txt
##   は     0.2434238 0.1870469 0.1958515
##   学生   0.3858176 0.2964624 0.0000000
##   私     0.6292414 0.0000000 0.0000000
##   真面目 0.6292414 0.0000000 0.0000000
##   の     0.0000000 0.4835093 0.0000000
##   科     0.0000000 0.4835093 0.0000000
##   数学   0.0000000 0.2964624 0.3104173
##   彼女   0.0000000 0.2964624 0.3104173
##   良い   0.0000000 0.4835093 0.0000000
##   で     0.0000000 0.0000000 0.5062688
##   を     0.0000000 0.0000000 0.5062688
##   難しい 0.0000000 0.0000000 0.5062688

colSums(res^2)  #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意



## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## 以下に例があります


## 行名のタームと列名のタームが共起した回数
## 対称行列


res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), co = 1)
nrow(res); ncol(res)
res

##         terms
## terms    は 学生 私 真面目 の 科 数学 彼女 良い で を 難しい
##   は      3    2  1      1  1  1    2    2    1  1  1      1
##   学生    2    2  1      1  1  1    1    1    1  0  0      0
##   私      1    1  1      1  0  0    0    0    0  0  0      0
##   真面目  1    1  1      1  0  0    0    0    0  0  0      0
##   の      1    1  0      0  1  1    1    1    1  0  0      0
##   科      1    1  0      0  1  1    1    1    1  0  0      0
##   数学    2    1  0      0  1  1    2    2    1  1  1      1
##   彼女    2    1  0      0  1  1    2    2    1  1  1      1
##   良い    1    1  0      0  1  1    1    1    1  0  0      0
##   で      1    0  0      0  0  0    1    1    0  1  1      1
##   を      1    0  0      0  0  0    1    1    0  1  1      1
##   難しい  1    0  0      0  0  0    1    1    0  1  1      1
## 上記のコードと同じことをより効率的，高速に行うには

 library(Matrix)# Matrix パッケージを利用した sparse 行列への変換

 res0 <- docMatrix("doc", pos = c("名詞","形容詞","助詞"))
 res0 <- res0[ row.names(res0) !=  "[[LESS-THAN-1]]" , ]
 res0 <- res0[ row.names(res0) !=  "[[TOTAL-TOKENS]]" , ]
 res0 <- Matrix((res0 > 0) * 1) # 
    # res1 <- crossprod( ( t(res0) > 0) *1  )
 res1 <- tcrossprod( res0 )
 nrow(res1); ncol(res1)

all(res == res1)  #  一致を確認



### 行名のタームと列名のタームが共起したか (1) 否 (0) か
## 対称行列

res <- docMatrix("morikita", pos = c("名詞","形容詞","助詞"), co = 2)
# head(res0)

res # コンソールが埋まってしまうので注意！


## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
# res <- docMatrix("doc", dic = "/home/ishida/ishida.dic") ## 
# trace(docMatrix, edit =T)

  ##  ##### <2009 04 21 RMeCab_0.81 にて改訂> 廃止しました
  ## # 行名のタームに対して，列名のタームが出現した回数
  ## ## 対称行列とは限らない
  ## ## 計算量が多くなるので注意してください
  ## res <- docMatrix("doc", pos = c("名詞","形容詞","助詞"), co = 3)
  ## res
  ##  </ 以上 2009 04 21 RMeCab_0.81 にて改訂>







##############################################################################
## docMatrix2()関数
##### docMatrix()関数の拡張版

?docMatrix2()
### USAGE:  docMatrix2(directory, pos= "Default",  minFreq = 1, weight = "no", kigo = 0, co = 0 , dic = "", mecabrc = "", etc = "" )

## 第 1 引数で指定されたファイル (フォルダが指定された場合は，その中の全ファイル)
## を読み込んで，ターム・文書行列を作成する．
## なお[[LESS-THAN-1]] と [[TOTAL-TOKENS]] の情報行は追加されない 
## 
##   指定可能な引数は
##      directory, pos, minFreq, weight, kigo, co, dic   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##            例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##            のタームは，これ以外の各文書に一度しか出現していなくとも，
##            出力のターム・文書行列に含まれる． 
##            docMatrix() 関数では，文書のごとの最低頻度であった．
##            したがって，doc1という文書で二度以上出現しているタームが，
##            他の文書で一度しか出現していない場合，このタームは出力の
##            ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており，
##            記号はカウントされないが，
##            kigo = 1 とすると，記号を含めてカウントした結果が出力される
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## co 引数はタームの共起行列を作成する．下記の例を参照．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
## [[LESS-THAN-1]]" と [[TOTAL-TOKENS]] の二つの行を含まない

   ## <2009 04 21 RMeCab_0.81 にて改訂>
    #    sym 引数は廃止しました 
   ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>
  
  library(RMeCab)

res <- docMatrix2("doc")

     # res <- docMatrix2("doc", pos = c("名詞","形容詞"), minFreq = 1, kigo = 0, weight = "no") に同じ

res

##        doc1.txt doc2.txt doc3.txt
## 学生          1        1        0
## 彼女          0        1        1
## 数学          0        1        1
## 真面目        1        0        0
## 私            1        0        0
## 科            0        1        0
## 良い          0        1        0
## 難しい        0        0        1


res <- docMatrix2("doc",pos = c("名詞","形容詞","記号") )
res

##        doc1.txt doc2.txt doc3.txt
## 。            1        1        1
## 学生          1        1        0
## 彼女          0        1        1
## 数学          0        1        1
## 真面目        1        0        0
## 私            1        0        0
## 科            0        1        0
## 良い          0        1        0
## 難しい        0        0        1

res <- docMatrix2("kumo.txt", minFreq = 5) 
res

##        kumo.txt
## ない         12
## の           18
## よう         13
## 一            8
## 上            9
## 下            5
## 中            8
## 事           15
## 何            6
## 地獄         13
## 底            8
## 極楽         10
## 様            7
## 糸           14
## 罪人          6
## 自分          6
## 蜘蛛         14
## 血の池        7
## 釈迦          7
## 針            5
## 陀多         17


gc();gc() # メモリを掃除


# 以下時間がかかる処理です
pt1 <- proc.time()
res <- docMatrix2("writers",pos = c("名詞","形容詞","助詞") )
pt2 <- proc.time()

pt2 - pt1


head(res)  # 全体を表示させると画面が埋まってしまいます


## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## 以下に例があります．

## 行名のタームと列名のタームが共起した回数
## 対称行列

 res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 1)
 nrow(res); ncol(res)
colSums(res); rowSums(res)

 ## 上記のコードと同じことをより効率的，高速に行うには

 library(Matrix)# Matrix パッケージを利用した sparse 行列への変換

 res0 <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"))
 res0 <- Matrix( (res0 > 0) * 1) #
str(res0)
   #  res1 <- crossprod( (t(res0) > 0) *1  )
 res1 <- tcrossprod( res0 )
 # head(res0)  # コンソールが埋まってしまうので注意！
   nrow(res1); ncol(res1)
   colSums(res1); rowSums(res1)

 all(res == res1)  #  一致を確認


### 行名のタームと列名のタームが共起したか否か
## 対称行列

res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 2)
res



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- docMatrix2("morikita", pos = c("名詞","形容詞","助詞"), co = 2, dic = "/home/ishida/ishida.dic" )
res



   ## ## <2009 04 21 RMeCab_0.81 にて改訂> 廃止しました
   ## # 行名のタームに対して，列名のタームが出現した回数
   ## ## 対称行列とは限らない
   ## res <- docMatrix2("writers", pos = c("名詞","形容詞","助詞"), co = 3)
   ## res
   ## ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>



##############################################################################
## Ngram 関数
##### N-gram の作成

?Ngram
### USAGE: Ngram(filename, type = 0, N = 2, pos = "Default",  dic = "", mecabrc = "", etc = "" )
## filename : 解析対象のファイル名
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## N : デフォルトは 2
## pos : 品詞、デフォルトは名詞と形容詞
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す


res <- Ngram("yukiguni.txt")
res

#    Ngram Freq
#1  [。-信]    1
#2  [。-夜]    1
#3  [あ-っ]    1
#4  [い-ト]    1
#5  [が-止]    1
#  ... 以下略

res <- Ngram("merosu.txt")
head (res)
# この結果から，読点との組み合わせを取る
# res [grep ("、", res $ Ngram), ]
res2 <- res [grep ("-、]", res $ Ngram), ]
res2

###### res [grep (res $ Ngram %in% c("、]")),] 

res <- Ngram("yukiguni.txt", type = 1) 
res                                    

##             Ngram Freq
## 1 [トンネル-雪国]    1
## 2       [信号-所]    1
## 3 [国境-トンネル]    1
## 4         [夜-底]    1
## 5       [底-信号]    1
## 6       [所-汽車]    1
## 7       [雪国-夜]    1
## ## >   # 以下は以前の出力
## ## #            Ngram Freq
## ## #1 [トンネル-雪国]    1
## ## #2     [国境-長い]    1
## ## #3       [所-汽車]    1
## ## #4       [信号-所]    1
## ## #5       [雪国-夜]    1
## ## #6 [長い-トンネル]    1
## ## #7       [底-白い]    1
## ## #8     [白い-信号]    1
## ## #9         [夜-底]    1

res <- Ngram("yukiguni.txt", type = 2)
res

#             Ngram Freq
#1      [記号-名詞]    2
#2    [形容詞-動詞]    1
#3    [形容詞-名詞]    1
#4    [助詞-形容詞]    2
#5      [助詞-動詞]    2
#6      [助詞-名詞]    3
#7    [助動詞-記号]    3
#8  [助動詞-助動詞]    2
#9      [動詞-助詞]    1
#10   [動詞-助動詞]    2
#11     [名詞-助詞]    6
#12   [名詞-助動詞]    1
#13     [名詞-名詞]    1



# トライグラム

res <- Ngram("yukiguni.txt", type = 2, N = 3)
res

#                    Ngram Freq
#1        [記号-名詞-助詞]    1
#2        [記号-名詞-名詞]    1
#3    [形容詞-動詞-助動詞]    1
#4      [形容詞-名詞-助詞]    1
#5      [助詞-形容詞-動詞]    1
#6      [助詞-形容詞-名詞]    1
#7        [助詞-動詞-助詞]    1
#8      [助詞-動詞-助動詞]    1
#9        [助詞-名詞-助詞]    2
#10     [助詞-名詞-助動詞]    1
#11     [助動詞-記号-名詞]    2
#12   [助動詞-助動詞-記号]    1
#13 [助動詞-助動詞-助動詞]    1
#14       [動詞-助詞-名詞]    1
#15     [動詞-助動詞-記号]    2
#16     [名詞-助詞-形容詞]    2
#17       [名詞-助詞-動詞]    2
#18       [名詞-助詞-名詞]    2
#19   [名詞-助動詞-助動詞]    1
#20       [名詞-名詞-助詞]    1


res <- Ngram("yukiguni.txt", type = 1, pos = "名詞")
res

#             Ngram Freq
# 1 [トンネル-雪国]    1
# 2 [国境-トンネル]    1
# 3       [所-汽車]    1
# 4       [信号-所]    1
# 5       [雪国-夜]    1
# 6       [底-信号]    1
# 7         [夜-底]    1





## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないことをおすすめします
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
## res <- Ngram("yukiguni.txt", type = 1, pos = "名詞"  , dic = "/home/ishida/ishida.dic")
## res
#




##############################################################################
## NgramDF 関数
##### N-gram の作成

?NgramDF
### USAGE: NgramDF(filename, type = 0, N = 2, pos  = "Default", dic = "", mecabrc = "", etc = "" )
## filename : 解析対象のファイル名
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## N : デフォルトは 2
## pos : 品詞、デフォルトは名詞と形容詞
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す



# 同じ処理結果をデータフレームとして返す

res <- NgramDF("yukiguni.txt", type = 1, N = 2)
res

##     Ngram1   Ngram2 Freq
## 1 トンネル     雪国    1
## 2     信号       所    1
## 3     国境     長い    1
## 4       夜       底    1
## 5       底     白い    1
## 6       所     汽車    1
## 7     白い     信号    1
## 8     長い トンネル    1
## 9     雪国       夜    1


library(dplyr)

removeWords1 <- c("白い" , "長い" )
removeWords2 <- c("所" , "底" )

res %>% filter (! Ngram1 %in% removeWords1, ! Ngram2 %in% removeWords2)   

res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = "名詞")
nrow(res)  ## 書籍とはターム数が異なっている場合があります．
res

#    Ngram1   Ngram2 Freq
#1 トンネル     雪国    1
#2     国境 トンネル    1
#3       所     汽車    1
#4     信号       所    1
#5     雪国       夜    1
#6       底     信号    1
#7       夜       底    1


res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = c("名詞","形容詞","助詞"))
nrow(res)  ## 書籍とはターム数が異なっている場合があります．
res

##      Ngram1   Ngram2 Freq
## 1        が     白い    1
## 2        と     雪国    1
## 3        に     汽車    1
## 4        の       底    1
## 5        の     長い    1
## 6        を       と    1
## 7  トンネル       を    1
## 8      信号       所    1
## 9      国境       の    1
## 10       夜       の    1
## 11       底       が    1
## 12       所       に    1
## 13     汽車       が    1
## 14     白い     信号    1
## 15     長い トンネル    1
## 16     雪国       夜    1


res <- NgramDF("yukiguni.txt", type = 2, N = 2)
res

##   Ngram1 Ngram2 Freq
## 1  助動詞 助動詞    2
## 2  助動詞   記号    3
## 3    助詞   動詞    2
## 4    助詞   名詞    3
## 5    助詞 形容詞    2
## 6    動詞 助動詞    2
## 7    動詞   助詞    1
## 8    名詞 助動詞    1
## 9    名詞   助詞    6
## 10   名詞   名詞    1
## 11 形容詞   動詞    1
## 12 形容詞   名詞    1
## 13   記号   名詞    2

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
# res <- NgramDF("yukiguni.txt", type = 1, N = 2, pos = c("名詞","形容詞","助詞") , dic = "/home/ishida/ishida.dic")
# res
#




##############################################################################
## NgramDF2 関数
##### NgramDF()関数の拡張版

?NgramDF2
### USAGE: NgramDF2(directory, type = 0, pos = "Default", minFreq = 1, N = 2, kigo = 0, dic = "", mecabrc = "", etc = "")
## filename : 解析対象のファイル集合があるフォルダ
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## N : デフォルトは 2
##  minFreq:  最小頻度
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
## pos : 品詞、デフォルトは名詞と形容詞
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す



## 
##   指定可能な引数は
##      directory, type, pos, minFreq, N, kigo   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## type 引数は　type=0　が文字、type=1　が形態素、type=2　が記号である
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
##       type引数指定が文字 0 あるいは記号 1 の場合は無視される
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##            例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##            のタームは，これ以外の各文書に一度しか出現していなくとも，
##            出力のターム・文書行列に含まれる． 
##            docMatrix() 関数では，文書のごとの最低頻度であった．
##            したがって，doc1という文書で二度以上出現しているタームが，
##            他の文書で一度しか出現していない場合，このタームは出力の
##            ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## N 引数は N-gram　を指定する。上限は設定されていないが、
##         あまり大きな数値を指定すると
##         R の処理能力の限界を超えるので注意されたい
##  kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており，
##            記号はカウントされないが，
##            kigo = 1 とすると，記号を含めてカウントした結果が出力される
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する

  ## <009 04 21 RMeCab_0.81 にて改訂>
   # sym 引数は廃止しました  
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>


res <- NgramDF2("yukiguni.txt")
res

##    Ngram1 Ngram2 yukiguni.txt
## 1      。     信            1
## 2      。     夜            1
## 3      あ     っ            1
## 4      い     ト            1
## 5      が     止            1
## 6      が     白            1
## 7      く     な            1
## 8      け     る            1
## 9      た     。            3
## 10     っ     た            3
## ... 以下略

res <- NgramDF2("yukiguni.txt", type = 1)
res

##     Ngram1   Ngram2 yukiguni.txt
## 1 トンネル     雪国            1
## 2     信号       所            1
## 3     国境     長い            1
## 4       夜       底            1
## 5       底     白い            1
## 6       所     汽車            1
## 7     白い     信号            1
## 8     長い トンネル            1
## 9     雪国       夜            1

res <- NgramDF2("yukiguni.txt", type = 1, N = 2, pos = "名詞")
nrow(res)## 書籍とはターム数が異なっている場合があります．
res

##     Ngram1   Ngram2 yukiguni.txt
## 1 トンネル     雪国            1
## 2     国境 トンネル            1
## 3       所     汽車            1
## 4     信号       所            1
## 5     雪国       夜            1
## 6       底     信号            1
## 7       夜       底            1



res <- NgramDF2("yukiguni.txt", type = 1, N = 2, pos = c("名詞","記号"))   
nrow(res)## 書籍とはターム数が異なっている場合があります．
res   

##      Ngram1   Ngram2 yukiguni.txt
## 1        。     信号            1
## 2        。       夜            1
## 3  トンネル     雪国            1
## 4      汽車       。            1
## 5      国境 トンネル            1
## 6        所     汽車            1
## 7      信号       所            1
## 8      雪国       。            1
## 9        底       。            1
## 10       夜       底            1


res <- NgramDF2("doc")
res

##    Ngram1 Ngram2 doc1.txt doc2.txt doc3.txt
## 1      い     ま        0        0        1
## 2      す     ．        1        1        1
## 3      で     い        0        0        1
## 4      で     す        1        1        0
## 5      の     学        0        1        0
## 6      は     学        1        0        0
## 7      は     数        0        1        1
## 8      ま     す        0        0        1
## 9      を     学        0        0        1
## 10     ん     で        0        0        1
## ... 以下略


res <- NgramDF2("doc", type = 2, minFreq = 2)
res

##   Ngram1 Ngram2 doc1.txt doc2.txt doc3.txt
## 1 助動詞   記号        1        1        1
## 2   助詞   動詞        0        0        1
## 3   助詞   名詞        1        1        0
## 4   助詞 形容詞        0        1        1
## 5   名詞 助動詞        1        1        0
## 6   名詞   助詞        1        1        1
## 7 形容詞   名詞        0        1        1





## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- NgramDF2("doc", dic = "/home/ishida/ishida.dic")
res
# 





##############################################################################
## docNgram関数
##### N-gram による文書行列

?docNgram
### USAGE:  docNgram(mydir, type = 1, N = 2, pos = "Default"  , dic = "", mecabrc = "", etc = "")
## mydir : 解析対象のファイル集合があるフォルダ
## type : 文字(0) か、形態素 (デフォルト、1) か、品詞(2)か
## N : デフォルトは 2
##  minFreq:  最小頻度
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
## pos : 品詞、デフォルトは名詞と形容詞
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す



res <-  docNgram("doc", type = 0)
res

##          Text
## Ngram     doc1.txt doc2.txt doc3.txt
##   [い-ま]        0        0        1
##   [す-．]        1        1        1
##   [で-い]        0        0        1
##   [で-す]        1        1        0
##   [の-学]        0        1        0
##   [は-学]        1        0        0
##   [は-数]        0        1        1
##   [ま-す]        0        0        1
##   [を-学]        0        0        1
##   [ん-で]        0        0        1
##   [学-の]        0        1        0
## ... 以下略


res <- docNgram("doc", type = 1)
res

##   [科-良い]            0        1        0
##   [私-真面目]          1        0        0
##   [真面目-学生]        1        0        0
##   [数学-科]            0        1        0
##   [難しい-数学]        0        0        1
##   [彼女-数学]          0        1        0
##   [彼女-難しい]        0        0        1
##   [良い-学生]          0        1        0





##############################################################################
## docNgram2関数
##### N-gram による文書行列

?docNgram2
### USAGE: docNgram2(directory, type = 0, pos = "Default", minFreq = 1,N = 2, kigo = 0, weight = "no" , dic = "", mecabrc = "", etc = "")

## directory : 解析対象のファイル集合があるフォルダ
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## N : デフォルトは 2
##  minFreq:  最小頻度
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
## pos : 品詞、デフォルトは名詞と形容詞
##  weight:  重みと正規化
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
##  co:  共起行列を作成するか。デフォルトはしない 0
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す



#################### docNgram()関数の拡張版
##  http://rmecab.jp/wiki/index.php?RMeCabFunctions
##   指定可能な引数は
##      directory, type, pos, minFreq, N, kigo   である．
## directory 引数はファイル名ないしフォルダ名であり
##              (どちらが指定されたかは自動判定される)
## type 引数は　type=0　が文字、type=1　が形態素、type=2　が記号である
## pos 引数は pos = c(``名詞'', ``形容詞'') のように指定する
##       type引数指定が文字 0 あるいは記号 1 の場合は無視される
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##          例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##          のタームは，これ以外の各文書に一度しか出現していなくとも，
##          出力のターム・文書行列に含まれる． 
##          docMatrix() 関数では，文書のごとの最低頻度であった．
##          したがって，doc1という文書で二度以上出現しているタームが，
##          他の文書で一度しか出現していない場合，このタームは出力の
##          ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
## N 引数は N-gram　を指定する。上限は設定されていないが、あまり大きな数値を指定すると
##      R の処理能力の限界を超えるので注意されたい
## kigo 引数は，抽出タームに句読点なので記号を含めるかを指定する．
##            デフォルトでは kigo = 0 とセットされており
##            pos 引数に"記号"が含まれている場合自動的に kigo=1 となる．
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する

  ## <2009 04 21 RMeCab_0.81 にて改訂>
   #  sym 引数は廃止しました
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>


res <- docNgram2("doc")
res

##         doc1.txt doc2.txt doc3.txt
## [い-ま]        0        0        1
## [す-．]        1        1        1
## [で-い]        0        0        1
## [で-す]        1        1        0
## [の-学]        0        1        0
## [は-学]        1        0        0
## [は-数]        0        1        1
## [ま-す]        0        0        1
## [を-学]        0        0        1
## [ん-で]        0        0        1
## [学-の]        0        1        0
## ... 以下略


res <- docNgram2("doc", pos = c("名詞","形容詞"), type = 1)
res

##               doc1.txt doc2.txt doc3.txt
## [彼女-数学]          0        1        0
## [彼女-難しい]        0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-良い]            0        1        0
## [良い-学生]          0        1        0
## [難しい-数学]        0        0        1



res <- docNgram2("doc", type = 1, pos = c("名詞","形容詞","記号"))
res

##               doc1.txt doc2.txt doc3.txt
## [学生-。]            1        1        0
## [彼女-数学]          0        1        0
## [彼女-難しい]        0        0        1
## [数学-。]            0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-良い]            0        1        0
## [良い-学生]          0        1        0
## [難しい-数学]        0        0        1


res <- docNgram2("doc", type = 2)
res

##               doc1.txt doc2.txt doc3.txt
## [助動詞-名詞]        1        0        0
## [助動詞-記号]        1        1        1
## [助詞-動詞]          0        0        1
## [助詞-名詞]          1        1        0
## [助詞-形容詞]        0        1        1
## [動詞-助動詞]        0        0        1
## [動詞-助詞]          0        0        1
## [名詞-助動詞]        1        1        0
## [名詞-助詞]          1        1        1
## [名詞-名詞]          0        1        0
## [形容詞-名詞]        0        1        1



res <- docNgram2("doc", pos = c("名詞","記号"), kigo = 1, type = 1) # doc はフォルダ名

  ## <2009 04 21 RMeCab_0.81 にて改訂>
   # sym 引数は廃止しました
  ## </ 以上 2009 04 21 RMeCab_0.81 にて改訂>

nrow(res)## 書籍とはターム数が異なっている場合があります．
res

##               doc1.txt doc2.txt doc3.txt
## [学生-。]            1        1        0
## [彼女-数学]          0        1        1
## [数学-。]            0        0        1
## [数学-科]            0        1        0
## [真面目-学生]        1        0        0
## [私-真面目]          1        0        0
## [科-学生]            0        1        0


res <- docNgram2("doc", pos = c("名詞","記号"), type = 1, weight = "tf*idf*norm") # doc はフォルダ名
nrow(res)
res

##                doc1.txt doc2.txt  doc3.txt
## [学生-。]     0.5773503      0.5 0.0000000
## [彼女-数学]   0.0000000      0.5 0.7071068
## [数学-。]     0.0000000      0.0 0.7071068
## [数学-科]     0.0000000      0.5 0.0000000
## [真面目-学生] 0.5773503      0.0 0.0000000
## [私-真面目]   0.5773503      0.0 0.0000000
## [科-学生]     0.0000000      0.5 0.0000000

colSums(res^2) #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意




## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
# res <- docNgram2("doc", pos = c("名詞","記号"), type = 1, weight = "tf*idf*norm"  , dic = "/home/ishida/ishida.dic") # doc はフォルダ名
# res


##############################################################################
##  docMatrixDF() 関数
##### データフレームから文書・ターム行列を作成する
### USAGE: docMatrixDF( charVec = c("MeCab","CaBoCha"), pos= "Default", minFreq = 1, weight = "no", co = 0 , dic = "", mecabrc = "", etc = "")
##  charVec : 解析対象のデータフレームの列
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## N : デフォルトは 2
##  minFreq:  最小頻度
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
## pos : 品詞、デフォルトは名詞と形容詞
## dic : 辞書の指定

## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す




  library(RMeCab)

targetText <- "photo.csv" #<2009 05 23>  ファイルの中身を一部変えました</2009 05 23>

dat <- read.csv(targetText, head = T)

# 男性の被験者だけを見る
dat[dat$Sex == "M",]

res <- docMatrixDF(dat[,"Reply"]) # デフォルトでは名詞と形容詞のみ
res

##        OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## 写真       1     1     1     1     1
# 大きい     0     0     1     0     0



res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"))
res

##          OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## くださる     0     1     0     1     0
## くれる       1     0     0     0     0
## とる         1     1     1     1     1
## 写真         1     1     1     1     1



### テキスト（被験者）全体を通じて，総頻度が ２ 以上のタームを抽出
## ここで総頻度とは、各タームごとに、各文書での出現した頻度を合計した頻度をいう

res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"), minFreq = 2)
res

##          OBS.1 OBS.2 OBS.3 OBS.4 OBS.5
## くださる     0     1     0     1     0
## とる         1     1     1     1     1
## 写真         1     1     1     1     1


res <- docMatrixDF(dat[,"Reply"], pos = c("名詞","動詞"), minFreq = 2, weight = "tf*idf*norm")
res

##              OBS.1     OBS.2     OBS.3     OBS.4     OBS.5
## くださる 0.0000000 0.8540570 0.0000000 0.8540570 0.0000000
## とる     0.7071068 0.3678223 0.7071068 0.3678223 0.7071068
## 写真     0.7071068 0.3678223 0.7071068 0.3678223 0.7071068

## 文書に NA がある場合や，minFreq を 2以上に指定した場合，
## 頻度に 0 のセルがありうるので，出力に NA が含まれることがあります 


## co 引数はタームの共起行列を作成する．下記の例を参照．2009 年 ３月実装
## テキストに記載はありません．
## ############### 共起行列を返す
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．

## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用した sparse 行列への変換をおすすめします
## docMatrix() 関数や docDF() 関数に実行例があります


## 行名のタームと列名のタームが共起した回数
## 対称行列

res <- docMatrixDF(dat[,"Reply"],  pos = c("名詞","動詞"),co = 1)
res

##          くださる くれる とる 写真
## くださる        2      0    2    2
## くれる          0      1    1    1
## とる            2      1    5    5
## 写真            2      1    5    5

### 行名のタームと列名のタームが共起したか否か
## 対称行列

res <- docMatrixDF(dat[,"Reply"],   pos = c("名詞","動詞"),co = 2)
res

##          くださる くれる とる 写真
## くださる        1      0    1    1
## くれる          0      1    1    1
## とる            1      1    1    1
## 写真            1      1    1    1



## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- docMatrixDF(dat[,"Reply"],   pos = c("名詞","動詞"),co = 2 , dic = "/home/ishida/ishida.dic")
res
# 


   ## <廃止しました>
   ## # 行名のタームに対して，列名のタームが出現した回数
   ## ## 対称行列とは限らない
   ## res <- docMatrixDF(dat[,"Reply"], co = 3)
   ## res
   ## </廃止しました>





##############################################################################
##  docNgramDF() 関数  
##### データフレームの指定列から文字あるいはタームのNgram頻度行列を作成する

?docNgramDF
### USAGE: docNgramDF(mojiVec = "MeCab", type = 0, pos = "Default", baseform =0, minFreq = 1, N = 1, kigo = 0, weight = "no", co = 0 , dic = "", mecabrc = "", etc = "" )

## directory : 解析対象のデータフレーム列
## type : 文字(0, デフォルト) か、形態素 (1) か、品詞(2)か
## baseform : 未使用
## N : デフォルトは 2
##  minFreq:  最小頻度
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
## pos : 品詞、デフォルトは名詞と形容詞
##  weight:  重みと正規化
##  kigo:  総語数に記号を含めるか。含めるなら kigo = 1 デフォルトは  0
##  co:  共起行列を作成するか。デフォルトはしない 0
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す
     


 library(RMeCab)


## 出力が他の関数と異なり，行に文書（被験者回答）列にタームとなっている．
## type = 1 の場合，デフォルトでは "名詞","形容詞" を抽出

targetText <- "H18koe.csv"

dat <- read.csv(targetText, head = T)

# 最初の２行
dat[1:2,]

res <- docNgramDF(dat[,"opinion"])
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [障] [集] [雑] [離] [難] [雨]
## Row1     0    0    0    0    0    0
## Row2     0    0    0    0    1    0
## Row3     0    0    0    0    0    0
## Row4     0    0    0    0    0    0
## Row5     0    0    0    0    0    0
## Row6     0    0    0    0    0    0
## Row7     0    0    0    0    0    1
## Row8     0    0    0    0    0    0
## Row9     0    0    0    0    0    0
## Row10    0    0    0    0    0    0

res <- docNgramDF(dat[, "opinion"], N = 2)
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [が-楽] [が-標] [が-殆] [が-残] [が-気] [が-永]
## Row1        0       0       0       0       0       0
## Row2        0       0       0       0       0       0
## Row3        0       0       0       0       0       0
## Row4        0       0       0       0       0       0
## Row5        0       0       0       0       0       0
## Row6        0       0       0       0       0       0
## Row7        0       0       0       0       0       0
## Row8        0       0       0       0       0       0
## Row9        0       0       0       0       0       0
## Row10       0       0       0       0       0       0
## 

res <- docNgramDF(dat[,"opinion"], type = 1)
nrow(res);ncol(res)
res[1:10, 1000:1005]

##       [浴衣] [海] [海中] [海外] [海岸] [海底]
## Row1       0    0      0      0      1      0
## Row2       0    0      0      0      0      0
## Row3       0    0      0      0      0      0
## Row4       0    0      0      0      0      0
## Row5       0    0      0      0      0      0
## Row6       0    0      0      0      0      0
## Row7       0    1      0      0      0      0
## Row8       0    0      0      0      0      0
## Row9       0    0      0      0      0      0
## Row10      0    0      0      0      0      0




res <- docNgramDF(dat[,"opinion"], type = 1, N = 2)
nrow(res);ncol(res)
res[1:3, 1000:1003]

##     [バイキング-どれ] [バイキング-以外] [バイキング-朝] [バイク-多い]
## Row1                 0                 0               0             0
## Row2                 0                 0               0             0
## Row3                 0                 0               0             0

res <- docNgramDF(dat[,"opinion"], pos = "名詞", type = 1, N = 3, weight = "tf*idf*norm")
nrow(res);ncol(res)
res[1:3, 100:102]

##      [いつ-開発-自然] [いつ-風景-生活] [いつか-ツケ-沖縄]
## Row1                0                0                  0
## Row2                0                0                  0
## Row3                0                0                  0

rowSums(res^2 , na.rm = T) # 行（文書・被験者回答）の合計は １

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意



## dic 引数にユーザーが独自に作成した辞書を指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux

# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- docNgramDF(dat[,"opinion"], type = 1, N = 2 , dic = "/home/ishida/ishida.dic")
nrow(res);ncol(res)
res[1:3, 1000:1003]
#



##############################################################################
## collocate関数 ## 共起
##### node 引数で指定された語(ただし形態素原形)の前後に出てくる単語頻度を計算する

?collocate
### USAGE:  collocate(filename, node, span , dic = "", mecabrc = "", etc = "")

## filename : 解析対象のファイル
## node : ノード
## span : スパン
## dic : 辞書の指定
## mecabrc : MeCab 設定ファイルの指定
## etc : MeCab へ特別なオプションを渡す


# 記号を除いてすべてのタームを抽出します
# なおスパンは引数 span で指定する

res <- collocate("kumo.txt", node = "極楽", span =3)
nrow(res)

##            Term Before After Span Total
## 1            、      2     0    2   136
## 2            。      4     0    4    61
## 3            う      1     0    1     9
## 4            が      0     1    1    34
## 5          この      1     0    1    11
## 6        しかし      2     0    2     2
## 7            た      1     0    1    51
## 8          ただ      1     0    1     4
## 9            と      2     1    3    43
## 10           に      2     0    2    73
## 11           の      0    12   12   117
## 12           は      3     1    4    46
## 13       はいる      0     1    1     1
## 14           へ      0     1    1    19
## 15         ます      2     0    2    69
## 16           も      0     1    1    21
## 17         もう      0     1    1     5
## 18         丁度      0     1    1     3
## 19           上      1     0    1     9
## 20           事      0     1    1    15
## 21           午      0     1    1     1
## 22         地獄      1     0    1    13
## 23         居る      2     0    2     7
## 24           朝      0     1    1     1
## 25         極楽     10     0   10    10
## 26           様      2     0    2     7
## 27         蓮池      0     4    4     4
## 28         蜘蛛      0     2    2    14
## 29         行く      1     0    1     4
## 30         釈迦      2     0    2     7
## 31           間      0     1    1     3
## 32 [[MORPHEMS]]     18    13   31   413
## 33   [[TOKENS]]     40    30   70  1808

sum(res$Before[1:31] > 0) 
# [1] 18  出現した形態素 [[MORPHEMS]] type の数
 sum(res$Before[1:31])
#[1] 40  出現した語数 [[TOKENS]]   token の数
sum(res$After[1:31])
# [1] 30

#  Total は対象テキスト全体に表われた回数，すなわち総頻度
#  Total  [[MORPHEMS]] はテキスト全体の形態素数
#  Total  [[TOKENS]]  はテキスト全体の総語数






## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.

## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux


# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
res <- collocate("kumo.txt", node = "極楽", span =3, dic = "/home/ishida/ishida.dic")
res
# 





##############################################################################
## collScores関数
##### T 値，MI 値

?collScores
### USAGE: collScores(kekka, node, span = 0)

## kekka : collocateの出力
## node :  ノード
## span : スパン(デフォルトは 0)


# collocate() 関数の出力であるオブジェクト を第 1 引数として，
# collocate() 関数で指定した中心語を node 引数に，同じく span に前後の語数を指定する．

res2 <- collScores(res, node  = "極楽", span =3)
nrow(res2)
res2[25:nrow(res),]

##            Term Span Total         T       MI
## 25         極楽   10    10        NA       NA
## 26           様    2     7 1.2499520 3.105933
## 27         蓮池    4     4 1.9336283 4.913288
## 28         蜘蛛    2    14 1.0856905 2.105933
## 29         行く    1     4 0.8672566 2.913288
## 30         釈迦    2     7 1.2499520 3.105933
## 31           間    1     3 0.9004425 3.328326
## 32 [[MORPHEMS]]   31   413        NA       NA
## 33   [[TOKENS]]   70  1808        NA       NA


log2( 4 / ((4/1808) * 10 * 3 * 2))



  res <- collocate("kumo.txt", node = "極楽", span =5)
  res

  ## ...
  ## 44         蓮池    4     4
  ## 45         蜘蛛    2    14
  ## 46         行く    1     4
  ## 47         近く    1     1
  ## 48         釈迦    2     7
  ## 49           間    1     3
  ## 50 [[MORPHEMS]]   49   413
  ## 51   [[TOKENS]]  110  1808

  res2 <- collScores(res, node  = "極楽", span =5)
  res2


  res <- collocate("cred.txt", node = "クレジットカード", span =3)
  res
  res2 <- collScores(res, node  = "クレジットカード", span =3)
  res2





##############################################################################
## docDF()関数
##### 汎用関数 
# http://rmecab.jp/wiki/index.php?RMeCabFunctions

?docDF
### USAGE:   docDF(target, column = 0, type = 0, pos = NULL, minFreq = 1, N = 1,Genkei = 0, weight ="", nDF = 0, co = 0 , dic = "", mecabrc = "", etc = "")

# 第 1 引数で指定されたファイル (フォルダが指定された場合は，その中の全ファイル)，あるいは第1引数でデータフレームを，また第 2 引数で列（番号あるいは名前）を指定して，Ngram行列，あるいはターム・文書行列を作成する．
## なお[[LESS-THAN-1]] と [[TOTAL-TOKENS]] の情報行は追加されない 
## 
##   指定可能な引数は target column type pos minFre N Genkei weight nDF co dic
##      
## target 引数はファイル名ないしフォルダ名,あるいはデータフレーム
## type 引数は　type=0　が文字、type=1　が形態素である
## column はデータフレームを指定し場合，列（番号あるいは名前）を指定する
## pos 引数は pos = c(``名詞'', ``形容詞'', ``記号'') のように指定する．
##                        デフォルトは記号を含め，すべての品詞
## minFreq 引数には頻度の閾値を指定するが，docMatrix() 関数の場合とは異なり，
##     全テキストを通じての総頻度を判定対象とする．
##           例えば minFreq=2 と指定した場合，どれか一つの文書で頻度が二つ以上
##           のタームは，これ以外の各文書に一度しか出現していなくとも，
##           出力のターム・文書行列に含まれる． 
##           docMatrix() 関数では，文書のごとの最低頻度であった．
##           したがって，doc1という文書で二度以上出現しているタームが，
##           他の文書で一度しか出現していない場合，このタームは出力の
##           ターム．文書行列に含まれるが，doc1以外の文書の頻度は一律 0 にされる
##  weight 重みを付ける 標準的には "tf*idf*norm"を指定 
##  Genkei = 0 活用語を原型 (0) にするか，表層形(1) にするか
##  nDF : N個のタームそれぞれを独立した列に取る．デフォルトは 0： nDF = 1 とするとNgramDF() 関数, NgramDF2() 関数に似た出力になります．
## co 共起行列の作成．docMatrix2 の事例を参照のこと
## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する


  library(RMeCab)

(res <- docDF("doc"))

## file_name =  doc/doc1.txt opened
## file_name =  doc/doc2.txt opened
## file_name =  doc/doc3.txt opened
## number of extracted terms = 23
## now making a data frame. wait a while!

##    Ngram doc1.txt doc2.txt doc3.txt
## 1     。        1        1        1
## 2     い        0        1        2
## 3     し        0        0        1
## 4     す        1        1        1
## 5     で        1        1        1
## 6     な        1        0        0
## 7     の        0        1        0
## 8     は        1        1        1
## 9     ま        0        0        1
## 10    を        0        0        1
## ... 以下省略 

res <- docDF("doc", type=1, N=1, co=1 )
res

##      TERM   POS1         POS2 。 いる だ で です の は ます を 学ぶ 学生 彼女
## 1      。   記号         句点  3    1  1  1    2  1  3    1  1    1    2    2
## 2    いる   動詞       非自立  1    1  0  1    0  0  1    1  1    1    0    1
## 3      だ 助動詞            *  1    0  1  0    1  0  1    0  0    0    1    0
## 4      で   助詞     接続助詞  1    1  0  1    0  0  1    1  1    1    0    1
## 5    です 助動詞            *  2    0  1  0    2  1  2    0  0    0    2    1
## 6      の   助詞       格助詞  1    0  0  0    1  1  1    0  0    0    1    1
## 7      は   助詞       係助詞  3    1  1  1    2  1  3    1  1    1    2    2
## 8    ます 助動詞            *  1    1  0  1    0  0  1    1  1    1    0    1
## 9      を   助詞       格助詞  1    1  0  1    0  0  1    1  1    1    0    1
## 10   学ぶ   動詞         自立  1    1  0  1    0  0  1    1  1    1    0
## ... 以下省略


(res <- docDF("doc", pos = c("名詞","形容詞","助詞"),N=1, type = 1))


##      TERM   POS1         POS2 doc1.txt doc2.txt doc3.txt
## 1      で   助詞     接続助詞        0        0        1
## 2      の   助詞       格助詞        0        1        0
## 3      は   助詞       係助詞        1        1        1
## 4      を   助詞       格助詞        0        0        1
## 5    学生   名詞         一般        1        1        0
## 6    彼女   名詞       代名詞        0        1        1
## 7    数学   名詞         一般        0        1        1
## 8  真面目   名詞 形容動詞語幹        1        0        0
## 9      私   名詞       代名詞        1        0        0
## 10     科   名詞         接尾        0        1        0
## 11   良い 形容詞         自立        0        1        0
## 12 難しい 形容詞         自立        0        0        1
## > 


   (res <- docMatrix("doc", pos = c("名詞","形容詞"), weight = "tf*idf"))# 参考



(res <- docDF("doc", N=1, type=1, weight = "tf*idf"))
## file_name =  doc/doc1.txt opened
## file_name =  doc/doc2.txt opened
## file_name =  doc/doc3.txt opened
## number of extracted terms = 18
## now making a data frame. wait a while!
## * * 
##      TERM   POS1         POS2 doc1.txt doc2.txt doc3.txt
## 1      。   記号         句点 1.000000 1.000000 1.000000
## 2    いる   動詞       非自立 0.000000 0.000000 2.584963
## 3      だ 助動詞            * 2.584963 0.000000 0.000000
## 4      で   助詞     接続助詞 0.000000 0.000000 2.584963
## 5    です 助動詞            * 1.584963 1.584963 0.000000
## 6      の   助詞       格助詞 0.000000 2.584963 0.000000
## 7      は   助詞       係助詞 1.000000 1.000000 1.000000
## 8    ます 助動詞            * 0.000000 0.000000 2.584963
## 9      を   助詞       格助詞 0.000000 0.000000 2.584963
## 10   学ぶ   動詞         自立 0.000000 0.000000 2.584963
## 11   学生   名詞         一般 1.584963 1.584963 0.000000
## 12   彼女   名詞       代名詞 0.000000 1.584963 1.584963
## 13   数学   名詞         一般 0.000000 1.584963 1.584963
## 14 真面目   名詞 形容動詞語幹 2.584963 0.000000 0.000000
## 15     私   名詞       代名詞 2.584963 0.000000 0.000000
## 16     科   名詞         接尾 0.000000 2.584963 0.000000
## 17   良い 形容詞         自立 0.000000 2.584963 0.000000
## 18 難しい 形容詞         自立 0.000000 0.000000 2.584963

   (res <- docMatrix("doc", pos = c("名詞","形容詞"), weight = "tf*idf*norm"))
   colSums(res^2)# 参考

(res <- docDF("doc", type = 1, weight = "tf*idf*norm"))

##      TERM   POS1         POS2  doc1.txt  doc2.txt  doc3.txt
## 1      。   記号         句点 0.1922000 0.1765162 0.1456847
## 2    いる   動詞       非自立 0.0000000 0.0000000 0.3765895
## 3      だ 助動詞            * 0.4968298 0.0000000 0.0000000
## 4      で   助詞     接続助詞 0.0000000 0.0000000 0.3765895
## 5    です 助動詞            * 0.3046298 0.2797716 0.0000000
## 6      の   助詞       格助詞 0.0000000 0.4562878 0.0000000
## 7      は   助詞       係助詞 0.1922000 0.1765162 0.1456847
## 8    ます 助動詞            * 0.0000000 0.0000000 0.3765895
## 9      を   助詞       格助詞 0.0000000 0.0000000 0.3765895
## 10   学ぶ   動詞         自立 0.0000000 0.0000000 0.3765895
## 11   学生   名詞         一般 0.3046298 0.2797716 0.0000000
## 12   彼女   名詞       代名詞 0.0000000 0.2797716 0.2309048
## 13   数学   名詞         一般 0.0000000 0.2797716 0.2309048
## 14 真面目   名詞 形容動詞語幹 0.4968298 0.0000000 0.0000000
## 15     私   名詞       代名詞 0.4968298 0.0000000 0.0000000
## 16     科   名詞         接尾 0.0000000 0.4562878 0.0000000
## 17   良い 形容詞         自立 0.0000000 0.4562878 0.0000000
## 18 難しい 形容詞         自立 0.0000000 0.0000000 0.3765895

colSums(res[,4:6]^2) #各列とも二乗の合計は１

##  データに NA が含まれる場合や，minFreq 引数に 2 以上を指定した場合は出力には NA が含まれるので注意





(res <- docDF("doc", N=1))

(res <- docDF("doc", type = 1, N=1))

(res <- docDF("doc", type = 1, N=2))

(res <- docDF("doc", type = 1, pos = c("名詞","動詞"), N=1))

(res <- docDF("doc", type = 1, pos = c("名詞","動詞", "記号"),N=1))

(res <- docDF("doc", type = 1))

(res <- docDF("yukiguni.txt", type = 1))

(res <- docDF("yukiguni.txt", N= 1, type = 1))

# 時間がかかります．
res <- docDF("morikita", pos = c("名詞","形容詞"), type = 1, N=3)
nrow(res); ncol(res)


(target <- read.csv("photo.csv"))

(res <- docDF(targetText, col = 3))

(res <- docDF(targetText, col = 3, type = 1, N = 1,pos = c("名詞","動詞")))

(res <- docDF(targetText, col = 3, type=1, pos = c("名詞","動詞","助詞")))


(res <- docDF("doc", type=1, N=2,pos = c("名詞","動詞"),
          Genkei = 1, nDF = 1))
##       N1     N2      POS1                POS2 doc1.txt doc2.txt doc3.txt
## 1   学ん     い 動詞-動詞         自立-非自立        0        0        1
## 2   彼女   数学 名詞-名詞         代名詞-一般        0        1        1
## 3   数学   学ん 名詞-動詞           一般-自立        0        0        1
## 4   数学     科 名詞-名詞           一般-接尾        0        1        0
## 5 真面目   学生 名詞-名詞   形容動詞語幹-一般        1        0        0
## 6     私 真面目 名詞-名詞 代名詞-形容動詞語幹        1        0        0
## 7     科   学生 名詞-名詞           接尾-一般        0        1        0

(res <- docDF("doc", N=3, nDF = 0))

## もしも dic 引数を指定する場合は，ユーザーが mecab を使って独自に作成した辞書ファイルを指定する
# かならず mecab で正しくコンパイルした辞書ファイルを指定してください.
## dic 引数にユーザーが独自に作成した辞書を指定する
# 「Rによるテキストマイニング入門」p.58 for Windows ユーザー
# http://mecab.sourceforge.net/dic.html for Mac/Linux
# ただし，Mac や Linux の場合，
# RMeCab側では辞書指定しないこともできます
# 代わりに自分のホームディレクトリに
# /usr/local/etc/mecabrc をコピーした .mecabrc を用意し
#dicdir =  /usr/local/lib/mecab/dic/ipadic
#userdic = /home/ishida/ishida.dic
# などとした2行を加えておきます
## (res <- docDF(target, col = 3, type=1, pos = c("名詞","動詞","助詞") , dic = "/home/ishida/ishida.dic" ))
# 

## 共起行列の作成
### 共起行列の作成は，非常にメモリを喰います．
### 例えば本書付属の wrinters フォルダから行列を作成する際，
### 同時に co 引数で共起行列への変換を指定すると
### １GB 程度のメモリのマシンではフリーズすることもあります．


## テキストの分量が大きく，行列が大きくなる場合は
## Matrix パッケージを利用したsparse 行列への変換をおすすめします
## 以下に例があります

(res <- docDF("doc", pos = c("名詞","形容詞"), co = 1))

(res <- docDF("doc", co = 2))

## (res <- docDF("doc", co = 3))

  # 時間がかかります
   rm(list = ls())
   gc(); gc()

  res <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"))
  nrow(res); ncol(res)



##### 特に共起行列の作成は注意が必要です
  rm(list = ls())
  gc(); gc()

# 以下の処理は負荷が非常に高くなります
 pt1 <- proc.time()
 res <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"), co =1)
 pt2 <- proc.time()
 pt2 - pt1
 ##    user  system elapsed 
 ##   4.744   0.984   5.932
 ## core2duo memory 4GB Ubuntu 8.10  R-2.8.1 


 nrow(res);ncol(res)
## [1] 5643
## [1] 5646 ## ターム名の列が三つある

  ##  library(Matrix)# Matrix パッケージを利用したsparse 行列への変換
 
  ## #  rm(list = ls())
  ##  gc(); gc(); ls()
  ##  pt1 <- proc.time()
  ##  res0 <- docDF("writers", type = 1,pos = c("名詞","形容詞","助詞"))
 

  ##  res1 <- Matrix( (as.matrix( res[,  -c(1,2,3)] ) >0) * 1)
  ##  res2 <- crossprod(t(res1))
  ##  pt2 <- proc.time()
  ##  pt2 - pt1
  ##  ##    user  system elapsed 
  ##  ##   1.240   0.564   2.200
  ##  ## core2duo memory 4GB Ubuntu 8.10  R-2.8.1 
  ## all(res == res2)




##############################################################################
## ユーザー辞書の作成方法
## Mac および Linux では http://mecab.sourceforge.net/dic.html の説明に従ってください．一部を以下の引用いたします．

##     * 適当なディレクトリに移動 (例: /home/foo/bar)
##     * foo.csv という辞書ファイルを作成（例はテキスト58ページのishida.csv）
##     * 辞書のコンパイル

##       % /usr/local/libexec/mecab/mecab-dict-index -d/usr/local/lib/mecab/dic/ipadic  -u ishida.dic -f utf8 -t utf8 ishida.csv

##           o -d DIR: システム辞書があるディレクトリ
##           o -u FILE: FILE というユーザファイルを作成
##           o -f charset: CSVの文字コード
##           o -t charset: バイナリ辞書の文字コード 
##     * /home/foo/bar/foo.dic ができていることを確認
##     * /usr/local/lib/mecab/dic/ipadic/dicrc 
##       userdic = /home/foo/bar/foo.dic 
