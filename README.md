# 『Rによるテキストマイニング入門(第2版)』 スクリプトおよびデータ


- [出版社サイト](http://www.morikita.co.jp/books/book/3169)
- [Amazon](https://www.amazon.co.jp/dp/4627848420/)

関連ファイルは右上の[Code] ボタンを押して[Download ZIP]をクリックしてください。

## 正誤表(予定)

https://github.com/IshidaMotohiro/TextMining/wiki/%E6%AD%A3%E8%AA%A4%E8%A1%A8


Windows 版 R バージョン 4.2 から、デフォルトの文字コードが UTF-8 となり、またインストールされるのが 64 Bit のみとなりました。
本書の次回増刷で対応予定ですが、基本、以下が必要となります。


## Windows版MeCab のインストールについて

Windows版Rをご利用の場合、Rのバージョンによって、それぞれ異なるインストーラーをダウンロードしてインストールしてください。

### Windows版R-4.1 まで

工藤拓氏の公式サイト <https://taku910.github.io/mecab/> からインストーラーをダウンロードして、文字コードは標準のShift-JISのままインストールしてください。

また、このGithubレポジトリ <https://github.com/IshidaMotohiro/TextMining> に登録されているファイルはすべて文字コードが UTF-8 になっています。このため Windows 版 RStudio で開くと、日本語部分が文字化けします。これを修正するには、RStudio のメニューから、File -> Reopen with Encoding -> UTF-8 として開き直します。画面上で文字化けが修正されたことが確認できたら、再び RStudio のメニューから Save with Encoding を指定し CP932 で保存し直してください。


### Windows版R-4.2 以降

ikegami氏の Github サイト <https://github.com/ikegami-yukino/mecab/releases> から私家版MeCabインストーラーをダウンロードし、文字コードはUTF-8を指定してインストールしてください。もしも公式のMeCabを既にインストールしている場合は、必ず、アンインストールしてから、ikegami氏のバイナリからインストールし直してください。

このサイト <https://github.com/IshidaMotohiro/textMining> に登録されているファイルはすべて文字コードが UTF-8 になっていますが、このファイルをそのまま使ってください。Shift-JISに変換する必要はありません。


## macOS での MeCab インストールについて

左上のAppleアイコンをクリックし、「このMacについて」を選びます。ここで、自身が使っている MacOS マシンが Intel 版なのか M1 版なのか、確認しておいてください。
なおMeCabをインストールするには、Apple 社が無償で公開している Xcode コマンドラインツールが必要です（Xcode本体は必要ありません）。コマンドラインツールのインストールは、アプリケーションフォルダのユーティリティーフォルダにあるターミナルを起動し、以下の命令を入力してEnterキーを押します。

```
xcode-select --install
```

ポップアップメッセージに従ってインストールを完了してください。

### Intel 版 macOS

工藤拓氏のサイトから MeCab 本体のソース mecab-0.996.tar.gz と、辞書 mecab-ipadic-2.7.0-20070801.tar.gz をダウンロードしてビルドしてください。


### M1 (Sillicon) 版 macOS

ターミナルのプロパティを確認します。「ファイル」＞「情報を見る」と選択するか、ターミナルのアイコン上でCommand＋Iキーを押します。サブメニューが表示されるので、「情報をみる」を選びます。

ここで「Rosettaを使用して開く」にチェックが入っていないかどうかを確認してください。もしも導入された Python が M1 用であれば、MeCab も M1 用にビルドします。ビルドというのは、ソースファイルからアプリケーションを作成することです。 この際、ターミナルを使いますが Rosetta を使う設定がなされていると、M1 用ではなく Intel 用の MeCab が作成されてしまいます。

ところが、ややっこしいのですが、M1 MacOS に Intel 用の MeCab をビルドすることができます（ユーザーが意識しないところで Rosetta というソフトウェアが M1 アーキテクチャと Intel アーキテクチャの橋渡しを行います）。ユーザーが気が付かないうちにターミナルが Rosetta を利用している場合があります。これを確認するため、ターミナルの「情報をみる」で「Rossetaを使用して開く」を確認するわけです。チェックが入っている場合はチェックを外し、ターミナルをいったん閉じて、起動し直します。

なお M1 版 macOS で MeCab をビルドする手順を YouTube で公開しています。動画では Python から MeCab を利用する前提で説明していますが、MeCab のビルドとインストール手順については、Python も R も全く同じです。

https://youtu.be/0ePI8a9kNUI

[![MeCab_Install](http://img.youtube.com/vi/0ePI8a9kNUI/0.jpg)](https://www.youtube.com/watch?v=0ePI8a9kNUI)


## RMeCab インストールについて

パソコンに開発環境があれば GitHub からもインストールもできます。本書の説明通りに RMeCab をインストールしてRが落ちる場合には、この方法を試してください。開発環境としては Windowsの場合 R-4.2 以降をお使いの場合は Rtools42 https://cran.ism.ac.jp/bin/windows/Rtools/ を、 Mac であればコマンドラインツール https://support.apple.com/ja-jp/guide/deployment-reference-macos/apdf028a757b/web をインストールした上で試してください。MeCab については上記の手順であらかじめインストールしておいてください。

```
# Windows Mac Linux の場合
install.packages("remotes")
remotes::install_github("IshidaMotohiro/RMeCab")
# Mac Linux の場合は以下でも良い
# install.packages("RMeCab", repos = "http://rmecab.jp/R", type = "source")
```

## ファイルの説明



- 各章に対応したスクリプトファイル

-- Chapter01.R
-- Chapter02.R
-- Chapter03.R
-- Chapter04.R
-- Chapter05.R
-- Chapter06.R
-- Chapter07.R
-- Chapter08.R
-- Chapter09.R
-- Chapter10.R
-- Chapter11.R

- RMeCab の関数紹介スクリプト

data/RMeCab.R

- データ

--  data/H18koe.csv      沖縄観光アンケート
-- data/bigram.csv      口コミサイトから生成したバイグラム
--  data/hon.txt         短文
--  data/merosu.txt      走れメロス
--  data/photo.csv       データフレームサンプル
--  data/sentences.xlsx  独立性の検定サンプルデータ
--  data/classes.csv     クラス成績データ
--  data/kumo.txt        芥川龍之介『蜘蛛の糸』
--  data/revi.csv        口コミサイトから生成した頻度表
--  data/YN.csv          食洗機の購入
--  data/classes.xlsx    クラス成績データ
  
- 宮沢賢治『注文の多い料理店』(ルビ等削除済み)

-- data/NORUBY/chumonno_oi_ryoriten2.txt

- Alice in Wonderland の一部分を三分割したファイル

--  data/alice/alice1.txt
--  data/alice/alice2.txt
--  data/alice/alice3.txt

- 単語文書行列作成用サンプル

--  data/doc/doc1.txt
--  data/doc/doc2.txt
--  data/doc/doc3.txt

- 沖縄観光アンケート性別年齢別仕分け済みファイル

  H18koe.csv からテキスト部分を取り出しがファイル(本書に取り出し方法の説明あり)

--  data/okinawa/F20.txt 
--  data/okinawa/F30.txt
--  data/okinawa/F40.txt
--  data/okinawa/F50.txt
--  data/okinawa/F60.txt
--  data/okinawa/F70.txt
--  data/okinawa/M20.txt
--  data/okinawa/M30.txt
--  data/okinawa/M40.txt
--  data/okinawa/M50.txt
--  data/okinawa/M60.txt
--  data/okinawa/M70.txt

- 文体識別用サンプルファイル(いずれも全文ではなく抜粋) 

--  data/writers/ogai_gan.txt               森鴎外『雁』
--  data/writers/ogai_niwatori.txt          森鴎外『鶏』
--  data/writers/ogai_kanoyoni.txt          森鴎外『かのように』
--  data/writers/ogai_vita.txt              森鴎外『ヰタ・セクスアリス』
--  data/writers/soseki_eijitsu.txt         夏目漱石『永日小品』
--  data/writers/soseki_omoidasu.txt        夏目漱石『思い出す事など』
--  data/writers/soseki_garasu.txt          夏目漱石『硝子戸の中』
--  data/writers/soseki_yume.txt            夏目漱石『夢十夜』

- 辞書サンプルデータ

--  data/motohiro.csv
--  data/mecab.bat 

- 説明ファイル

--  README.md
  

## 本書のデータ分析を Python で実施する方法

『Pythonで学ぶテキストマイニング』
    出版社  :  シーアンドアール研究所 (2022/8/13)
    発売日  :  2022/8/13
    ISBN-13  :  978-4863543935 https://www.amazon.co.jp/dp/486354393X/
