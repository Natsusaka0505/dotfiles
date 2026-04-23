# ~/.zprofile (via ZDOTDIR → dotfiles/shell/zsh/.zprofile)
# Login shell 啟動時執行一次。在 Apple Silicon mac 上先把 brew 的 PATH、
# MANPATH 等環境變數注入，後續 .zshrc 才能找到 brew 安裝的工具。

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  # Intel mac fallback
  eval "$(/usr/local/bin/brew shellenv)"
fi
