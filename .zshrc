export GPG_TTY=$(tty)

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

if [ -x "$(command -v tmux)" ] && [ -z "${TMUX}" ]; then
  (tmux attach || tmux) >/dev/null 2>&1
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(git zsh-completions zsh-syntax-highlighting pyautoenv)
source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"
alias ssh='TERM=xterm-256color \ssh'
alias nv="nvim"
alias hn="clx"
alias k="kubectl"

__git_files () {
    _wanted files expl 'local files' _files
}

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export NVM_DIR="$HOME/.nvm"
if [[ "$(uname)" == "Darwin" ]]; then
  NVM_SH="/opt/homebrew/opt/nvm/nvm.sh"
  NVM_BASH_COMPLETION="/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  NVM_SH="$NVM_DIR/nvm.sh"
  NVM_BASH_COMPLETION="$NVM_DIR/bash_completion"
fi
[ -s "$NVM_SH" ] && \. "$NVM_SH"
[ -s "$NVM_BASH_COMPLETION" ] && \. "$NVM_BASH_COMPLETION"

eval "$(starship init zsh)"
