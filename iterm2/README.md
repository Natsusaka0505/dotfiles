# iTerm2 Color Scheme

Dracula `.itermcolors` 檔沒預先放進 repo，由 `install.sh` 在 macOS 上執行時用 `curl` 抓到這個目錄再 `open` 匯入。

## 手動取得

```bash
curl -o ~/dotfiles/iterm2/Dracula.itermcolors \
  https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors
```

或從官網 <https://draculatheme.com/iterm> 下載後搬進來。

## 手動匯入 iTerm2

```bash
open ~/dotfiles/iterm2/Dracula.itermcolors
```

iTerm2 會跳出確認視窗，點 OK。接著到 `Preferences → Profiles → Colors → Color Presets...` 選 `Dracula` 套用。
