# dotfiles

個人 macOS 開發環境設定。clone 一次、跑一個腳本，還原完整環境。

## 快速開始

```bash
git clone git@github.com:yourname/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

腳本跑完後：

1. 重開終端機讓 `.zshrc` 生效
2. `p10k configure` 設定 prompt 主題
3. `mise trust ~/dotfiles/mise/config.toml` 信任版本管理設定
4. `mise install` 依預設版本一次裝齊 Node / Python / Go / Java

## 目錄結構

```
dotfiles/
├── shell/zsh/         # .zshenv / .zshrc / .zprofile / aliases.zsh
├── git/               # .gitconfig / .gitignore_global
├── homebrew/Brewfile  # brew / cask / tap 清單
├── mise/config.toml   # 統一管 Node / Python / Go / Java / Flutter 版本
├── ssh/config         # SSH host 設定（不含私鑰）
├── macos/defaults.sh  # Finder / Dock / 鍵盤 / 截圖等系統偏好
├── iterm2/            # Dracula color scheme（install.sh 自動下載）
├── install.sh         # 主安裝腳本
└── README.md
```

## install.sh 做了什麼

1. 安裝 Homebrew
2. `brew bundle` 裝 Brewfile 所有套件（含 mise）
3. 安裝 Oh My Zsh、zsh-autosuggestions、zsh-syntax-highlighting、powerlevel10k
4. 在 `~/` 建立 symlink 指回 repo（原檔已存在會備份為 `.bak`）
   - 含 `~/.config/mise/config.toml`
5. 跑 `macos/defaults.sh` 套系統偏好
6. 裝 fzf shell 整合
7. 下載並匯入 Dracula iTerm2 配色

## 語言版本管理（mise）

統一用 [mise](https://mise.jdx.dev/) 管 Node / Python / Go / Java / Flutter，取代以前的 nvm + pyenv。

**全域預設版本**寫在 `mise/config.toml`（symlink 到 `~/.config/mise/config.toml`），目前是：

| 語言 | 版本 |
|------|------|
| Node | `lts` |
| Python | `3.12` |
| Go | `1.22` |
| Java | `temurin-21` |
| Flutter | 不設全域（per-project） |

**每專案覆寫**：在專案 repo 跑 `mise use node@20`，會產生 `.mise.toml`，commit 進該 repo。

**安裝目錄**：`~/.local/share/mise/installs/<語言>/<版本>/`。`JAVA_HOME` 由 mise 自動設定，`go install` 的 binary 在 `~/go/bin`（已加進 PATH）。

## 首次使用前的手動調整

- 改 `git/.gitconfig` 的 `[user] name / email` 成自己的
- 改 `ssh/config` 裡的金鑰檔名（若不是 `id_ed25519`）

## 腳本無法自動處理的項目

### 帳號 / 金鑰

- [ ] 產生 SSH 金鑰：`ssh-keygen -t ed25519 -C "you@example.com"`
- [ ] 公鑰加到 GitHub：`gh ssh-key add ~/.ssh/id_ed25519.pub --title "My MacBook"`
- [ ] CLI 工具登入：`gh auth login`、`aws configure` 等

### 介面 / GUI

- [ ] 執行 `p10k configure`
- [ ] 登入 1Password / Raycast / Docker Desktop 等 GUI app
- [ ] 在 iTerm2 `Preferences → Profiles → Colors → Color Presets` 選 Dracula

### 語言版本

- [ ] `mise trust ~/dotfiles/mise/config.toml`
- [ ] `mise install` 依設定一次裝齊 Node / Python / Go / Java
- [ ] 需要 Flutter 時：`mise use -g flutter@stable`（記得 Android Studio / Xcode 要另外裝）
- [ ] **從舊機器遷移**：先用 `nvm ls` / `pyenv versions` 抄下舊版本 → `mise install node@<舊版> python@<舊版>` → `brew uninstall nvm pyenv && rm -rf ~/.nvm ~/.pyenv`

## 維護

匯出當前 brew 狀態覆蓋 Brewfile：

```bash
brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force
```

更新全域語言預設版本：直接編輯 `mise/config.toml`，下次新終端機自動生效。

新增一個設定檔到版控：把原檔搬進 repo → 在 `install.sh` 加一行 `link`。

## 平台備註

- 本 repo 僅支援 **macOS**（Apple Silicon 優先，Intel 有 fallback）
- shell 腳本用 **LF** 行結尾。在 Windows 上編輯時請確認 editor / git `core.autocrlf=input` 沒把它們轉成 CRLF
- `install.sh` 與 `macos/defaults.sh` 在 macOS clone 後若沒執行權限：`chmod +x install.sh macos/defaults.sh`

## 授權

個人使用。
