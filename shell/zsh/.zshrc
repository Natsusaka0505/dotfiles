# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/shell/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc (via ZDOTDIR → dotfiles/shell/zsh/.zshrc)

# ── Oh My Zsh ────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# ── Powerlevel10k ────────────────────────────────
[[ -f $ZDOTDIR/.p10k.zsh ]] && source $ZDOTDIR/.p10k.zsh

# ── PATH ─────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
# Homebrew（Apple Silicon）
export PATH="/opt/homebrew/bin:$PATH"

# ── 語言版本管理 ──────────────────────────────────
# nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# ── Aliases ──────────────────────────────────────
[[ -f $ZDOTDIR/aliases.zsh ]] && source $ZDOTDIR/aliases.zsh

# ── 工具初始化 ────────────────────────────────────
# zoxide 取代 cd
eval "$(zoxide init zsh)"

# fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
