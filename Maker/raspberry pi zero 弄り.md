# raspberry pi zero 弄り
自分用メモ。
まずSSH経由で接続できるようになるところまで

## 参考
以下。
[Raspberry Pi Zero(W, WH)のセットアップ - Qiita](https://qiita.com/hishi/items/8bdfd9d72fa8fe2e7573)

## 起動SDを作る
OSイメージを取ってきてmicroSDに焼く。
OSイメージはここから取った。Lite版。
[Download Raspbian for Raspberry Pi](https://www.raspberrypi.org/downloads/raspbian/)

microSDに焼くのは[Etcher](https://www.balena.io/etcher/?ref=etcher_update)を使った。
OSイメージはzipのままでOK。
ダウンロードしたOSイメージを選んでFlash!するだけ。

SD焼いた後に差し直すとbootというデバイスが見える。
無線LAN経由でssh接続できるようにするため、bootデバイス上に
wpa_supplicantとsshの設定ファイルを置く。

作成は[wpa_supplicant.conf作成](https://mascii.github.io/wpa-supplicant-conf-tool/)より。
wpa_supplicant.txtとssh.txtをbootデバイスに放り込む。

ここまでできたらmicroSDをraspi zeroに差して電源投入。しばらく待つ。

raspi zeroのIPアドレスを特定するため、LAN内のセグメントを適当に爆撃する。
[ここ](https://qiita.com/kmatae/items/1dd81f2b2091c6ce776b)を参考にした。

母艦PCでifconfigして自分が接続しているLANのセグメントを特定したら、(自環境では192.168.179.xxxだった)
サブネット内の数字をひたすら変えてpingを打つ。そのあとarp -aでb8-27で始まるMACアドレスを見つけて、
IPアドレスを特定する。

## SSHで接続する
WSLから接続しようとしたら弾かれた..
```
~ ❯❯❯ ssh 192.168.179.6                                                                                                                                                               ✘ 255
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:iPFdIpg1MVdK2K5AoFbIggujV9QdML0xiXQCjOkLNzE.
Please contact your system administrator.
Add correct host key in /home/babakou/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/babakou/.ssh/known_hosts:4
  remove with:
  ssh-keygen -f "/home/babakou/.ssh/known_hosts" -R "192.168.179.6"
ECDSA host key for 192.168.179.6 has changed and you have requested strict checking.
Host key verification failed.
```
仕方ないのでteratermからアクセスする。TCP/IPポートは22。
ユーザ名はpi、パスワードはraspberry
これで入れた。

## raspi zeroのアップデート
いつもの。
```
sudo apt-get update
sudo apt-get upgrade
```

公開鍵で入れるようにする。
[ラズパイにSSH接続（鍵認証） - Qiita](https://qiita.com/kuro___inu/items/93da8aa9b56847c3a2bf)を参考にした。

母艦PCでキーペア生成
```
ssh-keygen
```
公開鍵をraspiに転送。
とりあえず/etc/ssh/sshd_configの以下だけ直す
```
PubkeyAuthentication yes  <-- コメント外す
AuthorizedKeysFile      .ssh/authorized_keys .ssh/authorized_keys2  <-- コメント外す
```
.sshと.ssh/authorized_keysのパーミッションを設定
```
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
```
設定したらsshdを再起動
```
/etc/init.d/ssh restart
```
母艦PCの.ssh/configに以下を記載しておく
```
Host raspi
     HostName 192.168.179.6
     User pi
     IdentityFile ~/.ssh/id_rsa_raspi
```
こうしとけば ssh raspi で入れる。

## camera module起動
参考：[Camera Module - Raspberry Pi Documentation](https://www.raspberrypi.org/documentation/usage/camera/README.md)
5 Interfacing Options -> P1 Camera -> Yes

## pythonからカメラを使う
### パッケージ導入
python-picameraが必要。
```
sudo apt-get install python-picamera
```

## webサーバとして動かす
### nginxのインストール
```
sudo apt-get install nginx
```
#### nginxの主要なファイルたち
- /lib/systemd/system/nginx.service
- /etc/nginx/nginx.conf
- /etc/logrotate.d/nginx
- /etc/init.d/nginx
- /usr/sbin/nginx
- /run/nginx.pid

特に大事なのはnginx.conf。

#### 動作確認
ブラウザからhttp://(raspiのIP)/ にアクセスしてWelcome to nginx!と表示されたら成功。

#### nginx.conf
[Beginner’s Guide](http://nginx.org/en/docs/beginners_guide.html)見てちょっと勉強した


----
**以下古い情報**

ssh接続可能にするためにはbootデバイス上にファイルを作る必要がある。
そのためにWSL上からSDカードにアクセスしたいがデフォルトではSDカードにマウントされていない。
なのでマウント(※)する。

※ /をルートとするUnix Filetreeに、あるデバイスのFiletreeを"ぶら下げる"行為。

エクスプローラ上Dドライブなので、
```
sudo mkdir /mnt/d  (マウントポイントが無い場合のみ)
sudo mount -t drvfs D: /mnt/d
```
でマウントする。

マウントしたら、bootデバイス上にsshという空ファイルを作る。
```
cd /mnt/d
touch ssh
```