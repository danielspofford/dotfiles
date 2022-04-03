# Path to your oh-my-zsh installation.
export ZSH=/Users/daniel/.oh-my-zsh

ZSH_THEME="spoff"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

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
# Add ssh keys
if ! ssh-add -l | grep dannyspofford &>/dev/null; then
  keys=(
    id_rsa
  )

  for key in ${keys[@]}; do
    keyfile="$HOME/.ssh/$key"
    if [[ -f $keyfile && -z "$(ssh-add -l | grep $key)" ]]; then
      ssh-add $keyfile
    fi
  done
fi

show_virtual_env() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

if [[ $PS1 != *"show_virtual_env"* ]]; then
  PS1='$(show_virtual_env)'$PS1
fi

eval "$(direnv hook zsh)"

export PATH="/usr/local/opt/openssl/bin:$PATH"

export SDKROOT="$(xcrun --sdk macosx --show-sdk-path)"

export PATH="/usr/local/sbin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

. ~/.asdf/plugins/java/set-java-home.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/daniel/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/daniel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/daniel/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/daniel/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

. $HOME/.asdf/asdf.sh

export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

export PATH="$HOME/.poetry/bin:$PATH"

export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

export PATH="$HOME/.docker/cli-plugins:$PATH"

export GPG_TTY=$(tty)
