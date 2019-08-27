# VSCode on WSLでPlantUMLを使う
今まで使えてたけど、Cannot find Javaとか言われてPreviewできなくなった...
使えるようにする。

## Remote DevelopmentのVSCodeでPlantUML Extensionをインストール
入れるだけ。

## Javaのランタイム環境のインストール
WSL以外でも使うので、一般的な方法で試してみる
[ここ](https://www.java.com/ja/download/manual.jsp)からWindows オフライン(64ビット)をインストール

インストールフォルダはそのまま。

## PATHを通し直す
どこだこれ...
```
~ ❯❯❯ which java.exe
/mnt/c/Program Files (x86)/Common Files/Oracle/Java/javapath/java.exe
```
この時点でVSCodeのPreviewをやろうとしても駄目。
java自体はインストールされていて、plantuml.jarも動けているようだ。
```
java.exe -jar plantuml.jar -version
PlantUML version 1.2018.10 (Sun Aug 26 02:02:59 JST 2018)
(APACHE source distribution)
Java Runtime: Java(TM) SE Runtime Environment
JVM: Java HotSpot(TM) 64-Bit Server VM
Java Version: 1.8.0_221-b11
...
```
やっぱパスかあ...？もしかしてjavaじゃなくてjava.exeじゃないと動かないのが駄目なのか？
シンボリックリンクを作る。
```
sudo ln -s /mnt/c/Program\ Files\ \(x86\)/Common\ Files/Oracle/Java/javapath/java.exe /usr/local/bin/java
```
それでも駄目。sudoしないと動かないから...？

## 非WSLのVS Codeから実行してみる
やっぱ駄目。PATH通ってるし実行権限もあるのに...謎

## 直接plantumlを叩いてみる
plantuml.jarを置いてこんなかんじ
```
sudo java -jar plantuml.jar -charset UTF-8 Othello_component_overview.wsd
```
pngが生成された。環境自体は整ってるっぽいけど...

## settings.jsonからplantuml.javaを消したら
非WSL環境では動いた。
その状態でWSL環境だとやっぱり動かない。

## もしかして
PlantUML拡張は、plantuml.javaが設定にあったら、その設定値をそのままjava executableとして扱うっぽい。
てことは、plantuml.javaにjava.exeを指定してやれば...？

だめだったけどエラーが変わった！java executableはPlantUML拡張から見つかるようになったらしい。

## Unable to access jarfileを解決する
試しに
```
$ java.exe -jar /home/babakou/.vscode-server/extensions/jebbs.plantuml-2.11.2/plantuml.jar -version
Error: Unable to access jarfile /home/babakou/.vscode-server/extensions/jebbs.plantuml-2.11.2/plantuml.jar
```
だめ。
VolFs上の適当な場所にplantuml.jarを置いて、そこを指定するようsettings.jsonを編集する
```
"plantuml.jar": "C:/Users/babakou/local/bin/plantuml.jar"
```
だめ。見つからない...

## 結論
**あきらめた。**
Markdownとか書くならWSL無くても良いし...？