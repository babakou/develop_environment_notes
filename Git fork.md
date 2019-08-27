# Git fork
いいかんじのGit GUI client

## WinMergeとの連携
File -> Preferences -> Integration から、以下を設定
- Merge Tool
  - Merger: Custom
  - Merget Path: WinMergeUのパス
  - Arguments: $REMOTE $BASE

- External Diff Tool
  - Merger: Custom
  - Merget Path: WinMergeUのパス
  - Arguments: $REMOTE $LOCAL
