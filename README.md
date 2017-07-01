# 『Rによるテキストマイニング入門(第2版)』 スクリプトおよびデータ

##
- [出版社サイト](http://www.morikita.co.jp/books/book/3169)
- [Amazon](https://www.amazon.co.jp/dp/4627848420/)

## 正誤表(予定)

https://github.com/IshidaMotohiro/TextMining/wiki/%E6%AD%A3%E8%AA%A4%E8%A1%A8


## Macでのインストール補足

本書の説明通りに RMeCab をインストールしてRが落ちる場合は、再度以下のようにしてインストールしてください

 remove.packages("RMeCab")
 install.packages("RMeCab", repos = "http://rmecab.jp/R", type = "source")
 
## ファイルの説明



- 各章に対応したスクリプトファイル

Chapter01.R
 Chapter02.R
 Chapter03.R
 Chapter04.R
 Chapter05.R
 Chapter06.R
 Chapter07.R
 Chapter08.R
 Chapter09.R
 Chapter10.R
 Chapter11.R

- RMeCab の関数紹介スクリプト

data/RMeCab.R

- データ

  data/H18koe.csv      沖縄観光アンケート
  data/bigram.csv      口コミサイトから生成したバイグラム
  data/hon.txt         短文
  data/merosu.txt      走れメロス
  data/photo.csv       データフレームサンプル
  data/sentences.xlsx  独立性の検定サンプルデータ
  data/classes.csv     クラス成績データ
  data/kumo.txt        芥川龍之介『蜘蛛の糸』
  data/revi.csv        口コミサイトから生成した頻度表
  data/YN.csv          食洗機の購入
  data/classes.xlsx    クラス成績データ
  
- 宮沢賢治『注文の多い料理店』(ルビ等削除済み)

data/NORUBY/chumonno_oi_ryoriten2.txt

- Alice in Wonderland の一部分を三分割したファイル

  data/alice/alice1.txt
  data/alice/alice2.txt
  data/alice/alice3.txt

- 単語文書行列作成用サンプル

  data/doc/doc1.txt
  data/doc/doc2.txt
  data/doc/doc3.txt

- 沖縄観光アンケート性別年齢別仕分け済みファイル

  H18koe.csv からテキスト部分を取り出しがファイル(本書に取り出し方法の説明あり)

  data/okinawa/F20.txt 
  data/okinawa/F30.txt
  data/okinawa/F40.txt
  data/okinawa/F50.txt
  data/okinawa/F60.txt
  data/okinawa/F70.txt
  data/okinawa/M20.txt
  data/okinawa/M30.txt
  data/okinawa/M40.txt
  data/okinawa/M50.txt
  data/okinawa/M60.txt
  data/okinawa/M70.txt

- 文体識別用サンプルファイル(いずれも全文ではなく抜粋) 

  data/writers/ogai_gan.txt               森鴎外『雁』
  data/writers/ogai_niwatori.txt          森鴎外『鶏』
  data/writers/ogai_kanoyoni.txt          森鴎外『かのように』
  data/writers/ogai_vita.txt              森鴎外『ヰタ・セクスアリス』
  data/writers/soseki_eijitsu.txt         夏目漱石『永日小品』
  data/writers/soseki_omoidasu.txt        夏目漱石『思い出す事など』
  data/writers/soseki_garasu.txt          夏目漱石『硝子戸の中』
  data/writers/soseki_yume.txt            夏目漱石『夢十夜』

- 辞書サンプルデータ

  data/motohiro.csv
  data/mecab.bat 

- 説明ファイル

  README.md
  README.txt(README.mdと中身は同じ)
  
- Windows用Shift_Jis(CP932)変換スクリプトおよびデータ

  Windows.zip
