# Path to your oh-my-zsh installation.
export ZSH=/Users/daniel/.oh-my-zsh

ZSH_THEME="yass"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

# Aliases

source ~/.alias

eval "$(fasd --init auto)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export ERL_AFLAGS="-kernel shell_history enabled"

[[ -s "/Users/daniel/.gvm/scripts/gvm" ]] && source "/Users/daniel/.gvm/scripts/gvm"

export RG_IGNORE='\
  --glob "!.git/*" \
  --glob "!_build/*" \
  --glob "!client/node_modules/*" \
  --glob "!deps/*" \
  --glob "!dist/*" \
  --glob "!doc/*" \
  --glob "!elm-stuff/*" \
  --glob "!flow-typed/*" \
  --glob "!node_modules/*" \
  --glob "!tags" \
  --glob "!tmp/*" \
'

export PATH="$HOME/dev/dotfiles/bin:$PATH"

export FZF_DEFAULT_COMMAND='rg --hidden -l --glob "!.git/*" ""'

# Ensure SSH keys added to agent
if ! ssh-add -l | grep id_rsa &>/dev/null; then
  ssh-add ~/.ssh/id_rsa
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/daniel/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/daniel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/daniel/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/daniel/google-cloud-sdk/completion.zsh.inc'; fi

show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

if [[ $PS1 != *"show_virtual_env"* ]]; then
  PS1='$(show_virtual_env)'$PS1
fi

eval "$(direnv hook zsh)"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
export PATH="/usr/local/opt/openssl/bin:$PATH"

export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"
