# ~/dotfiles/shell/zsh/aliases.zsh

# ── 導航 ──────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias dev="cd ~/Developer"

# ── ls 替換為 eza ──────────────────────────────────
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --icons -L 2"

# ── cat 替換為 bat ─────────────────────────────────
alias cat="bat"

# ── Git 常用縮寫 ───────────────────────────────────
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"

# ── 系統 ──────────────────────────────────────────
alias reload="source $ZDOTDIR/.zshrc"
alias dotfiles="cd ~/dotfiles"
alias brewup="brew update && brew upgrade && brew cleanup"
