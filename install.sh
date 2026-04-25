#!/usr/bin/env bash
# ~/dotfiles/install.sh
# 新 MacBook 一鍵還原環境。使用方式：
#   git clone <this-repo> ~/dotfiles && bash ~/dotfiles/install.sh

set -e  # 任何指令失敗就停止

DOTFILES="$HOME/dotfiles"
echo "🚀 開始設定 dotfiles..."

# ── 1. 安裝 Homebrew ──────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "📦 安裝 Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Apple Silicon 需要加到 PATH
eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || true

# ── 2. 安裝 Homebrew 套件 ─────────────────────────
echo "📦 安裝 Brewfile 套件..."
brew bundle --file="$DOTFILES/homebrew/Brewfile"

# ── 3. 安裝 Oh My Zsh ────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🐚 安裝 Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ── 4. 安裝 Oh My Zsh 插件 ───────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k \
    "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ── 5. 建立 symlinks ──────────────────────────────
echo "🔗 建立 symlinks..."

# 建立 symlink 的輔助函式（已存在且非 symlink 則先備份為 .bak）
link() {
  local src="$1"
  local dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  備份已存在的 $dst → ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  ✓ $dst → $src"
}

link "$DOTFILES/shell/zsh/.zshenv"         "$HOME/.zshenv"
link "$DOTFILES/git/.gitconfig"            "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global"     "$HOME/.gitignore_global"

mkdir -p "$HOME/.config/mise"
link "$DOTFILES/mise/config.toml"          "$HOME/.config/mise/config.toml"

mkdir -p "$HOME/.ssh"
link "$DOTFILES/ssh/config"                "$HOME/.ssh/config"
chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"

# ── 6. macOS 系統設定 ─────────────────────────────
echo "⚙️  套用 macOS 設定..."
bash "$DOTFILES/macos/defaults.sh"

# ── 7. fzf 安裝 shell 整合 ────────────────────────
"$(brew --prefix)/opt/fzf/install" --all --no-update-rc 2>/dev/null || true

# ── 8. 匯入 iTerm2 Dracula color scheme ──────────
DRACULA_SCHEME="$DOTFILES/iterm2/Dracula.itermcolors"

if [ ! -f "$DRACULA_SCHEME" ]; then
  echo "🎨 下載 Dracula iTerm2 color scheme..."
  curl -fsSL -o "$DRACULA_SCHEME" \
    https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors || \
    echo "  ⚠️  下載失敗，請稍後手動處理"
fi

if [ -f "$DRACULA_SCHEME" ]; then
  echo "🎨 匯入 iTerm2 Dracula color scheme..."
  open "$DRACULA_SCHEME" || true
  echo "  ✓ 請在 iTerm2 彈出的視窗點 OK 確認匯入"
  echo "  然後至 Preferences → Profiles → Colors → Color Presets 選擇 Dracula"
fi

echo ""
echo "✅ 完成！請重新開啟終端機以套用所有設定。"
echo "   如需設定 Powerlevel10k，執行：p10k configure"
