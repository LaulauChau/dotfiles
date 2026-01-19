# --- SYSTEM & ENVS ---
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--preview "if [[ -d {} ]]; then tree -C --gitignore -L 2 {} && echo && [[ -f {}/README.md ]] && bat --color=always --line-range=:20 {}/README.md; else bat --color=always --style=numbers --line-range=:500 {}; fi"'

if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$HOME/go/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/lachau/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# --- HISTORY ---
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# --- KEYBINDINGS ---
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey -s ^f "tmux-sessionizer\n"

# --- ZINIT (Plugin Manager) ---
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

zinit wait lucid for \
  zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# --- COMPLETIONS & STYLING ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

autoload -Uz compinit
if [[ -f ~/.zcompdump ]] && [[ $(find ~/.zcompdump -mtime -1 2>/dev/null) ]]; then
  compinit -C
else
  compinit
fi
zinit cdreplay -q

# --- ALIASES ---
alias bat='bat --theme="Catppuccin Mocha"'
alias c="open $1 -a \"Cursor\""
alias ls='ls -lah --color'
alias vim='nvim'

# --- SHELL INTEGRATIONS ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
