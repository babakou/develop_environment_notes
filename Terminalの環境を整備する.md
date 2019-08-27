# Terminalの環境を整備する
## tmux導入
### インストール
```
$ sudo apt install tmux
```

### tmux起動時のシェルをzshにする
参考：[tmuxのデフォルトシェルをzshにしたいのに起動時にbashなる問題 - Qiita](https://qiita.com/puriso/items/9cec04eaba47a9d563ea)
~/.tmux.confに以下記述
```
set-option -g default-shell /usr/bin/zsh
set -g default-command /usr/bin/zsh
```
再起動

### そのほか
参考：[達人に学ぶ.tmux.confの基本設定 - Qiita](https://qiita.com/succi0303/items/cb396704493476373edf)

