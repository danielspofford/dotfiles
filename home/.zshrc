# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

export ERL_AFLAGS="-kernel shell_history enabled"

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

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

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. /opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash

# has to happen after sourcing asdf
export PATH=$PATH:$(go env GOPATH)/bin

fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
eval "$(fasd --init auto)"

dotfiles_setup() {
  cd $HOME/repos/danielspofford/dotfiles
  ./setup.sh
}

dotfiles_symlink() {
  cd $HOME/repos/danielspofford/dotfiles
  ./symlink.sh
}

dotfiles_lsp() {
  npm i -g bash-language-server
  go install mvdan.cc/sh/v3/cmd/shfmt@latest
}
