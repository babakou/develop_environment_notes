# VSCode Keyboard Shortcut棚卸し
こんなカスタマイズをしていたらしい
```
// 既定値を上書きするには、このファイル内にキー バインドを挿入します
[
    {
        "key": "alt+r",
        "command": "editor.action.referenceSearch.trigger",
        "when": "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
    },
    {
        "key": "shift+f12",
        "command": "-editor.action.referenceSearch.trigger",
        "when": "editorHasReferenceProvider && editorTextFocus && !inReferenceSearchEditor && !isInEmbeddedEditor"
    },
    {
        "key": "alt+t",
        "command": "editor.action.goToDeclaration",
        "when": "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "f12",
        "command": "-editor.action.goToDeclaration",
        "when": "editorHasDefinitionProvider && editorTextFocus && !isInEmbeddedEditor"
    },
    {
        "key": "alt+n",
        "command": "emacs.cursorDown",
        "when": "inReferenceSearchEditor"
    },
    {
        "key": "alt+oem_comma ctrl+",
        "command": "workbench.action.navigateBack"
    },
    {
        "key": "alt+left",
        "command": "-workbench.action.navigateBack"
    },
    {
        "key": "ctrl+p",
        "command": "list.focusUp",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "up",
        "command": "-list.focusUp",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "ctrl+n",
        "command": "list.focusDown",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "down",
        "command": "-list.focusDown",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "ctrl+b",
        "command": "list.collapse",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "left",
        "command": "-list.collapse",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "ctrl+f",
        "command": "list.expand",
        "when": "listFocus && !inputFocus"
    },
    {
        "key": "right",
        "command": "-list.expand",
        "when": "listFocus && !inputFocus"
    }
]
```