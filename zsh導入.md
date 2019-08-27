# zsh導入

## zshインストール
```
$ sudo apt install zsh
```
起動するといろいろ設定を促されるので、適当に決めとく

## ログインシェルをzshに変更
```
$ chsh
```
の後、which zshの結果を入力

## zshの設定
デフォだとあまりにそっけないので。

### preztoの導入
[Zsh + Prezto で快適コマンド環境を構築する ｜ DevelopersIO](https://dev.classmethod.jp/tool/zsh-prezto/)
oh-my-zshは何か合わなかった

## XServerの設定をzshにも
これのこと
```
(
    command_path="/mnt/c/Program Files/VcXsrv/vcxsrv.exe"
    command_name=$(basename "$command_path")

    if ! tasklist.exe 2> /dev/null | fgrep -q "$command_name"; then
        "$command_path" :0 -multiwindow -clipboard -noprimary -wgl > /dev/null 2>&1 &
    fi
)

[ -r ~/.bashrc ] && source ~/.bashrc
```

```
if [ "$INSIDE_EMACS" ]; then
    TERM=eterm-color
fi

umask 022
export DISPLAY=localhost:0.0

# export NO_AT_BRIDGE=1
export LIBGL_ALWAYS_INDIRECT=1
# export GIGACAGE_ENABLED=no
```

これをzshの設定ファイルに反映させる。[このあたり](https://qiita.com/muran001/items/7b104d33f5ea3f75353f)も参考に。
.zprofileに以下記述。(Preztoで設定した場合、.zshenvと.zprofileはほぼ同等の位置付け。.zprofileに書けばOK)
```
# Execute vcxsrv.exe when starting zsh
(
  command_path="/mnt/c/Program Files/VcXsrv/vcxsrv.exe"
  command_name=$(basename "$command_path")

  if ! tasklist.exe 2> /dev/null | fgrep -q "$command_name"; then
    "$command_path" :0 -multiwindow -clipboard -noprimary -wgl > /dev/null 2>&1 &
  fi
)
``` 
んでもって.zshrcに以下を書く
```
if [ "$INSIDE_EMACS" ]; then
    TERM=eterm-color
fi

umask 022
export DISPLAY=localhost:0.0

export LIBGL_ALWAYS_INDIRECT=1
```