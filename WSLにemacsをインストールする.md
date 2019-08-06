# WSLにemacsをインストールする

## 参考
[WSL で emacs を使うための設定 - NTEmacs @ ウィキ - アットウィキ](https://www49.atwiki.jp/ntemacs/pages/69.html)

## apt-getでインストールできるemacsのバージョンを26にする
```
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs26
```
ここまででterminalで立ち上がるようになった。

## X-Windowで立ち上がるようにする
### X Window serverのインストール
[VcXsrvを使う](https://sourceforge.net/projects/vcxsrv/)

### ~/.bash_profileの編集
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

### ~/.bashrcの編集
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

このあと、WSL再起動し、
```
$ emacs &
```
とすると、X Windowでemacsが立ち上がる。が、日本語入力できない。
以降、諸々設定していく。
