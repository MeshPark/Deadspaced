# ╔══════════════════════════════════════════════════════════╗
# ║ WICH Zsh Config
# ╚══════════════════════════════════════════════════════════╝
# ── Oh My Zsh ───────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Theme — using Starship instead so this is blank
ZSH_THEME=""

# ── Plugins ─────────────────────────────────────────────────
plugins=(
  git
  rust
  docker
  docker-compose
  sudo
  copypath
  copyfile
  dirhistory
  history
  web-search
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"

# ── Environment Variables ───────────────────────────────────
export EDITOR="zed"
export VISUAL="zed"
export TERMINAL="ghostty"
export BROWSER="librewolf"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# ── History ──────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt AUTO_CD

# ── Completion ──────────────────────────────────────────────
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%F{purple}%d%f'

# ── Pacman Aliases ─────────────────────────────────────────────────

# Install
alias pac='sudo pacman -S'
alias pacint='sudo pacman -S --noconfirm'

# Remove
alias rem='sudo pacman -Rns'
alias purge='sudo pacman -Rns --noconfirm'

# Update
alias upt='sudo pacman -Syu'
alias uptf='sudo pacman -Syyu'

# Search
alias sch='sudo pacman -Ss'           # search remote
alias schd='sudo pacman -Qs'         # search locally installed

# Info
alias pkginfo='sudo pacman -Si'
alias pkginfl='sudo pacman -Qi'
alias pkgfiles='sudo pacman -Ql'

# Cleanup
alias cleanup='sudo pacman -Rns $(pacman -Qdtq)'   # remove orphans
alias clearc='sudo pacman -Sc'

# List
alias listpkg='sudo pacman -Qe'
alias listext='sudo pacman -Qm'          # foreign * AUR packages

# ── Yay (AUR's) Aliases ─────────────────────────────────────────

# Install
alias yins='yay -S'
alias yinsi='yay -S --noconfirm'

# Remove
alias yrem='yay -Rns'
alias ypurge='yay -Rns --noconfirm'

# Update
alias yupt='yay -Syu'
alias yuptf='yay -Syyu'

# Search
alias ysch='yay -Ss'
alias yschd='yay -Qs'

# Info
alias ypkginfo='yay -Si'
alias ypkginfl='yay -Qi'
alias ypkgfiles='yay -Ql'

# Cleanup
alias yclean='yay -Yc'                   # remove orphans (yay-aware)
alias yclearc='yay -Sc'

# List
alias ylistpkg='yay -Qe'
alias ylistaur='yay -Qm'                 # AUR-only packages



# ── Other Aliases ──────────────────────────────────────────────────

# Eza — modern ls
alias ls='eza --icons'
alias ll='eza --icons --long'
alias la='eza --icons --long --all'
alias lt='eza --icons --tree'
alias l='eza --icons --long --all --git'

# Bat — modern cat
alias cat='bat'
alias cath='bat --plain'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ez='z'

# Git
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'

# Rust/Cargo
alias cr='cargo run'
alias cb='cargo build'
alias ct='cargo test'
alias cc='cargo check'
alias cf='cargo fmt'
alias ccl='cargo clippy'

# Docker
alias dk='docker'
alias dkc='docker compose'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkimg='docker images'

# System
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='btop'
alias ports='ss -tulanp'

# Safety nets
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Misc
alias reload='source ~/.zshrc'
alias zshrc='zed ~/.zshrc'
alias cls='clear'
alias q='exit'

# ── Functions ────────────────────────────────────────────────

mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)  tar xjf "$1" ;;
      *.tar.gz)   tar xzf "$1" ;;
      *.bz2)      bunzip2 "$1" ;;
      *.rar)      unrar x "$1" ;;
      *.gz)       gunzip "$1" ;;
      *.tar)      tar xf "$1" ;;
      *.tbz2)     tar xjf "$1" ;;
      *.tgz)      tar xzf "$1" ;;
      *.zip)      unzip "$1" ;;
      *.Z)        uncompress "$1" ;;
      *.7z)       7z x "$1" ;;
      *)          echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

search() {
  grep -r "$1" . --color=auto
}

top10() {
  history | awk '{print $2}' | sort | uniq -c | sort -rn | head 10
}

gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

# ── Zoxide ───────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ── Starship Prompt ──────────────────────────────────────────
eval "$(starship init zsh)"

# ── Autosuggestion Settings ──────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585b70"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ── FZF ──────────────────────────────────────────────────────
export FZF_DEFAULT_OPTS="
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --border rounded
  --prompt '❯ '
  --pointer '▶'
"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ── Syntax Highlighting ──────────────────────────────────────
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
