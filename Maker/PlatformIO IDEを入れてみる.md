# PlatformIO IDEを入れてみる

## 拡張機能のインストール
手順はいつもの。

拡張機能を入れた後、一発目の起動でPlatformIO IDEのインストールが走る。終わるまで待つこと。
終わって再起動するとPIO Homeが立ち上がる。

New Project
- Name: integrate_with_raspi
- Board: M5Stack Core ESP32
- Frameworrk: Arduino
- Location: Use default locationのチェックを外して、予め作っておいたフォルダを指定

※ Nameを入力できない場合はPIO Homeタブを閉じて再度開く。[ここ](https://github.com/platformio/platformio-vscode-ide/issues/892)も参照。

## getting started
### プロジェクトのビルド
[M5Stack公式のgetting started](https://docs.m5stack.com/#/en/quick_start/m5core/m5stack_core_get_started_Arduino_Windows?id=_5-example)をPlatformIO IDE上でビルド、転送してみる。
プロジェクト作った直後で「PlatformIO: Build」-> M5Stack.hが無いと言われて失敗。なんでやねん

PIO HomeからM5Stack用のライブラリをインストールしないといけないらしい。
参考：[M5Stackの開発環境を整える - PlatformIO IDE編 - Qiita](https://qiita.com/lutecia16v/items/1c560bdd7eac7ebeaff7)

PIO HomeのLibraries -> Search libraries...にm5stackを入れて検索 -> M5Stackを選んでInstall
Congrats!と出たら成功。

もう一度ビルドすると今度はコンパイルが進む。
ビルドメッセージを一部抜粋...
```
...
Compiling .pio\build\m5stack-core-esp32\src\main.cpp.o
Compiling .pio\build\m5stack-core-esp32\lib0f9\FS\FS.cpp.o
Compiling .pio\build\m5stack-core-esp32\lib0f9\FS\vfs_api.cpp.o
...
```
どうやら、プロジェクトルートの下にあるbuildフォルダにバイナリが生成されるようだ。
元のソースファイルはどこにあるんだろう...？

#### ソースファイルの在り処
${Home}/.platformio以下に色々あった。
PIO Homeでプロジェクトを作ると、Project Rootに自動的に.vscode/c_cpp_properties.jsonが生成され、
そこに上記フォルダ以下がinclude pathとして指定されるらしい。なるほど

M5Stack.hは以下にあった。
${Home}/.platformio/lib/M5Stack_ID1851/src/M5Stack.h



### プロジェクトの転送
ビルド直後に「PlatformIO: Upload」したら転送できた。
ポートの設定とかは要らないのかもしれない。

## その他設定
- Activate Only On Platform IOProject: true
VSCodeを起動するたびにPlatformIO IDEが主張してくるのがうざいので..
と思ったけど、これすると新規にPlatform IO projectを作れなくなるので、
しゃーなしにfalseのままに...

- project root/platformio.iniのlib_deps
公式が推奨してるので。**プロジェクト毎に** 依存ライブラリを定義すべし、らしい。

## コツ
### PlatformIO projectを作る場所
**何もフォルダを開いていない状態で** New projectすると、Intellisenseとかが上手く機能した。
既にフォルダを開いてる状態で、そのフォルダ以下にNew projectすると、上手く動いてくれなかった。
恐らく元々開いてたフォルダの.vscode/c_cpp_properties.jsonと、PIOが自動生成した
c_cpp_properties.jsonが競合したためと思われる。正直よくわからんけど...