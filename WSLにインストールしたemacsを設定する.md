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

作ったらPATHが通っているフォルダに移す
```
$ sudo mv mozc_emacs_helper.sh /usr/local/bin
```

mozc, mozc-im, mozc-popupをインストールする
MELPAの設定がどーやってもうまくいかなかったので、直接*.elをインストール(load-pathが通った)
mozc.elは[ここ](https://github.com/google/mozc/blob/master/src/unix/emacs/mozc.el)
mozc-im.elは[ここ](https://github.com/d5884/mozc-im/blob/master/mozc-im.el)
mozc-popup.elは[ここ](https://github.com/d5884/mozc-popup/blob/master/mozc-popup.el)
mozc-cursor-color.elは[ここ](https://github.com/iRi-E/mozc-el-extensions/blob/master/mozc-cursor-color.el)
mozc-popup.elに必要なpopup.elは[ここ](https://github.com/auto-complete/popup-el/blob/master/popup.el)

あと適当にmozcの設定をコピペして動かしてみたら、
IMEのトグルはできてるっぽいものの、Communication error with the helper process と出て日本語入力できない。
[ここ](http://listserv.linux.or.jp/pipermail/vine-users/2013-December/002284.html)を参考にmozc_emacs_helperを/usr/binに置いた
```
sudo ln -s /path/to/mozc_emacs_helper /usr/bin/mozc_emacs_helper
```
そしたら動いた！
IMEのトグルを<zenkaku-hankaku>にすると、なぜかIMEの切り替えが止まらなくなるので、
泣く泣くC-oのまま...

## フォントの設定
### 参考
ここのフォントの設定あたりを参考に
[WSL上のUbuntu18.04でのEmacs](http://www.aise.ics.saitama-u.ac.jp/~gotoh/EmacsUbuntu1804onWSL.html)

```
$ sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/windows
$ sudo fc-cache -fv
```