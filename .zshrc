if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- SYSTEM & ENVS ---
export EDITOR=nvim
export FZF_DEFAULT_OPTS='--preview "if [[ -d {} ]]; then eza --color=always --icons --group-directories-first -L 2 -AT --git-ignore {} && echo && [[ -f {}/README.md ]] && bat --color=always --line-range=:20 {}/README.md; else bat --color=always --style=numbers --line-range=:500 {}; fi"'

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/bc/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/lachau/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/lachau/.bun/_bun" ] && source "/Users/lachau/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

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

# --- COMPLETIONS & STYLING ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'bat --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'bat --color=always $realpath'

autoload -Uz compinit
if [[ -f ~/.zcompdump ]] && [[ $(find ~/.zcompdump -mtime -1 2>/dev/null) ]]; then
  compinit -C
else
  compinit
fi

# --- PLUGINS ---
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- ALIASES ---
alias ls='eza --icons -la --group-directories-first'
alias tree='eza --icons -la --group-directories-first --git-ignore --tree'

# --- SHELL INTEGRATIONS ---
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"
