#!/bin/bash

set -eou pipefail

echo "dotfiles: setup.sh running"

# install brew
if ! which brew >/dev/null; then
    echo "Homebrew is not installed. Installing now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

mkdir -p artifacts

##
## brew
##
brew install -q \
  asdf \
  autoconf \
  automake \
  ccache \
  cmake \
  coreutils \
  curl \
  dfu-util \
  direnv \
  docker-compose \
  fop \
  fwup \
  fzf \
  gawk \
  gh \
  git-lfs \
  gnu-sed \
  gpg \
  gpg \
  homebrew/core/make \
  htop \
  jq \
  libtool \
  libxslt \
  libyaml \
  mosquitto \
  neovim \
  ninja \
  openssl \
  pkg-config \
  podman \
  postgresql@16 \
  readline \
  ripgrep \
  shellcheck \
  sqlite \
  terraform \
  tmux \
  tree \
  unixodbc \
  wxwidgets \
  yaml-language-server \
  yamllint

git lfs install

brew install -q --cask \
  alacritty \
  docker \
  podman-desktop \
  zerotier-one
  # wireshark \
  # wireshark-chmodbpf \
  # virtualbox \
  # rectangle \
  # spotify \
  # slack \
  # notion \

if [ -z "$ZSH" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

##
## asdf
##
. /opt/homebrew/opt/asdf/libexec/asdf.sh

asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add python
asdf plugin-add java
# bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf install golang latest
asdf global golang latest
asdf global nodejs latest:20
asdf install erlang latest
asdf global erlang latest
asdf install elixir latest
asdf global elixir latest

##
## xcode
##
set +e
xcode-select --install
set -e

#
# elixir lexical lsp
#
lexicalPath="$HOME/repos/lexical-lsp/lexical"

if [ ! -d $lexicalPath ]; then
  git clone git@github.com:elixir-lsp/elixir-ls.git $lexicalPath
else
  echo "$lexicalPath already exists"
fi

cd $lexicalPath
mix deps.get
mix package
# this produces a binary at: $lexicalPath/_build/dev/package/lexical/bin/start_lexical.sh

#
# elixirls
#
# if [ ! -d "artifacts/elixir-ls" ]; then
#   git clone git@github.com:elixir-lsp/elixir-ls.git artifacts/elixir-ls
# fi
# cd artifacts/elixir-ls
# git add -A
# git reset --hard HEAD
# git checkout tags/v0.20.0
# asdf local erlang latest
# asdf local elixir latest
# mix local.hex --force
# mix local.rebar --force
# mix do deps.get, compile, elixir_ls.release -o rel
# cd ../..

# zPath="$HOME/repos/rupa/z"

# if [ ! -d $zPath ]; then
#   git clone git@github.com:rupa/z.git $zPath
# fi
echo "dotfiles: setup.sh finished"
