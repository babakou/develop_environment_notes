# WSLにインストールしたemacsを設定する

けっこう道のりが長い...めげずにやるぞ

## 参考
[emacs-mozc を動かすための設定（WSL 設定編） - NTEmacs @ ウィキ - アットウィキ](https://www49.atwiki.jp/ntemacs/pages/61.html)

## 日本語入力できるようにする
### Google日本語入力をインストール
[Google 日本語入力 – Google](https://www.google.co.jp/ime/)

### emacs-mozcの設定
MozcはGoogleが提供するIME。emacs-mozcはMozcをemacs上から動かすためのパッケージ

#### mozc_emacs_helperのインストール
ここからダウンロードし、Windowsファイルシステム上に置く
[GitHub - smzht/mozc_emacs_helper: mozc_emacs_helper for Windows](https://github.com/smzht/mozc_emacs_helper)

#### mozc_emacs_helper.shの作成
mozc_emacs_helper.shを作る
```
#!/bin/bash

cd /mnt/c/Users/babakou/local/wsl_emacs/mozc_emacs_helper
./mozc_emacs_helper.exe "$@" | cat
```

作ったらPATHが通っているフォルダに移して、実行権限を付与
```
$ sudo mv mozc_emacs_helper.sh /usr/local/bin
$ sudo chmod 755 /usr/local/bin/mozc_emacs_helper.sh
```

mozc, mozc-im, mozc-popupをインストールする
MELPAの設定がどーやってもうまくいかなかったので、直接*.elをインストール(load-pathが通った)
mozc.elは[ここ](https://github.com/google/mozc/blob/master/src/unix/emacs/mozc.el)
mozc-im.elは[ここ](https://github.com/d5884/mozc-im/blob/master/mozc-im.el)
mozc-popup.elは[ここ](https://github.com/d5884/mozc-popup/blob/master/mozc-popup.el)
mozc-cursor-color.elは[ここ](https://github.com/iRi-E/mozc-el-extensions/blob/master/mozc-cursor-color.el)
mozc-popup.elに必要なpopup.elは[ここ](https://github.com/auto-complete/popup-el/blob/master/popup.el)

あと適当にmozcの設定をコピペして動かしてみたら動いた
IMEのトグルを<zenkaku-hankaku>にすると、なぜかIMEの切り替えが止まらなくなるので、
泣く泣くC-oのまま...

### やはりC-\で日本語入力に切り替えたい
IMEが切り替わりまくる現象に手を打つ。
[ここ](https://vogel.at.webry.info/201903/article_1.html)参考
```
sudo apt install x11-xserver-utils <-- xsetを使うために必要
```
.bashrcに以下追加
```
xset -r 49
```
その後切り替えを半角/全角にしたら普通に動いた。神

## フォントの設定
### 参考
ここのフォントの設定あたりを参考に
[WSL上のUbuntu18.04でのEmacs](http://www.aise.ics.saitama-u.ac.jp/~gotoh/EmacsUbuntu1804onWSL.html)

```
$ sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/windows
$ sudo fc-cache -fv
```