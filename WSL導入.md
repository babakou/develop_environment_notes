# WSL導入
## 動機
Cygwinから乗り換えたい

## 利用シーン
- WSLを起動する
- WSLからemacsを起動してファイル編集する
  - svnからチェックアウトしたファイル
  - 適当に作ったファイル
  - agでファイル検索
  - gtagsでタグジャンプ
  - ドラッグ&ドロップで開く
  - C-x C-fで適当なファイルをWindows上に作る
- WSLからVSCodeを起動してファイル編集する
- WSLからWindows上のフォルダでシェルスクリプトを実行する
- WSLからリモートサーバにSSH接続する

## 導入手順
### 参考
[WSL で emacs を使うための設定 - NTEmacs @ ウィキ - アットウィキ](https://www49.atwiki.jp/ntemacs/pages/69.html)

### インストールまで
1. コントロールパネル→Windowsの機能の有効化または無効化→Windows Subsystem for Linuxにチェックを入れる
2. Microsoft Store→WSLを検索→Ubuntu→入手→起動
3. Installing, this may take a few minutes ... しばらく待つ
4. Please create a default UNIX user account... WSL用ユーザを作る。
ユーザ名とパスを指定する
To run a command as administrator (user "root"), use "sudo <command>". らしい

### インストール可能なパッケージ一覧の更新
```
$ sudo apt-get update
```
インストール可能なパッケージの一覧が更新される。
実際のパッケージのインストール、アップグレードはされない。

### インストールされているパッケージの更新
```
sudo apt-get upgrade
```
途中でrestart云々と訊かれるので、Yesと答えておく。
upgradeが終わったらWSL再起動する。

### localeを日本向けに変更
```
$ sudo -E apt install language-pack-ja language-pack-gnome-ja
$ sudo update-locale LANG=ja_JP.UTF-8
```

### タイムゾーンをJSTに変更
```
$ sudo dpkg-reconfigure tzdata
Asia → Tokyoを選択
```