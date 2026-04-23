#!/usr/bin/env bash
# ~/dotfiles/macos/defaults.sh

echo "⚙️  套用 macOS 系統設定..."

# ── Finder ───────────────────────────────────────
# 顯示副檔名
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# 顯示隱藏檔案
defaults write com.apple.finder AppleShowAllFiles -bool true
# 預設以 List 模式開啟
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# 顯示路徑列
defaults write com.apple.finder ShowPathbar -bool true
# 顯示狀態列
defaults write com.apple.finder ShowStatusBar -bool true

# ── Dock ─────────────────────────────────────────
# 縮小 Dock 圖示
defaults write com.apple.dock tilesize -int 48
# 自動隱藏 Dock
defaults write com.apple.dock autohide -bool true
# 縮短 Dock 顯示延遲
defaults write com.apple.dock autohide-delay -float 0.1

# ── 鍵盤 ──────────────────────────────────────────
# 加快 Key Repeat 速度
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ── 截圖 ──────────────────────────────────────────
# 截圖存到 Downloads 而非 Desktop
defaults write com.apple.screencapture location -string "$HOME/Downloads"
# 截圖不含陰影
defaults write com.apple.screencapture disable-shadow -bool true

# ── 追蹤板 ───────────────────────────────────────
# 開啟輕點即點擊
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# ── Safari（開發用）──────────────────────────────
# 顯示完整 URL
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# 重啟受影響的應用程式
for app in Finder Dock SystemUIServer; do
  killall "$app" &>/dev/null || true
done

echo "✅ macOS 設定完成"
