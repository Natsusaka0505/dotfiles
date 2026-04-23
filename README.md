# dotfiles

個人 macOS 開發環境設定。clone 一次、跑一個腳本，還原完整環境。

## 快速開始

```bash
git clone git@github.com:yourname/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh
```

腳本跑完重開終端機，然後 `p10k configure` 設定 prompt 主題。

## 目錄結構

```
dotfiles/
├── shell/zsh/         # .zshenv / .zshrc / .zprofile / aliases.zsh
├── git/               # .gitconfig / .gitignore_global
├── homebrew/Brewfile  # brew / cask / tap 清單
├── ssh/config         # SSH host 設定（不含私鑰）
├── macos/defaults.sh  # Finder / Dock / 鍵盤 / 截圖等系統偏好
├── iterm2/            # Dracula color scheme（install.sh 自動下載）
├── install.sh         # 主安裝腳本
└── README.md
```

## install.sh 做了什麼

1. 安裝 Homebrew
2. `brew bundle` 裝 Brewfile 所有套件
3. 安裝 Oh My Zsh、zsh-autosuggestions、zsh-syntax-highlighting、powerlevel10k
4. 在 `~/` 建立 symlink 指回 repo（原檔已存在會備份為 `.bak`）
5. 跑 `macos/defaults.sh` 套系統偏好
6. 裝 fzf shell 整合
7. 下載並匯入 Dracula iTerm2 配色

## 首次使用前的手動調整

- 改 `git/.gitconfig` 的 `[user] name / email` 成自己的
- 改 `ssh/config` 裡的金鑰檔名（若不是 `id_ed25519`）

## 腳本無法自動處理的項目

- [ ] 產生 SSH 金鑰：`ssh-keygen -t ed25519 -C "you@example.com"`
- [ ] 公鑰加到 GitHub：`gh ssh-key add ~/.ssh/id_ed25519.pub --title "My MacBook"`
- [ ] 執行 `p10k configure`
- [ ] 登入 1Password / Raycast / Docker Desktop 等 GUI app
- [ ] 在 iTerm2 `Preferences → Profiles → Colors → Color Presets` 選 Dracula
- [ ] CLI 工具登入：`gh auth login`、`aws configure` 等

## 維護

匯出當前 brew 狀態覆蓋 Brewfile：

```bash
brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force
```

新增一個設定檔到版控：把原檔搬進 repo → 在 `install.sh` 加一行 `link`。

## 平台備註

- 本 repo 僅支援 **macOS**（Apple Silicon 優先，Intel 有 fallback）
- shell 腳本用 **LF** 行結尾。在 Windows 上編輯時請確認 editor / git `core.autocrlf=input` 沒把它們轉成 CRLF
- `install.sh` 與 `macos/defaults.sh` 在 macOS clone 後若沒執行權限：`chmod +x install.sh macos/defaults.sh`

## 授權

個人使用。
