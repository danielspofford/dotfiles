mkdir artifacts

##
## brew
##
brew install \
  autoconf \
  automake \
  ccache \
  cmake \
  coreutils \
  curl \
  dfu-util \
  direnv \
  docker \
  docker-compose \
  fasd \
  fop \
  fwup \
  fzf \
  gh \
  gnu-sed \
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
  postgres \
  readline \
  ripgrep \
  rust-analyzer \
  sqlite \
  tmux \
  tree \
  unixodbc \
  unzip \
  wxmac \
  yamllint \

brew install \
  --cask \
  iterm2 \
  rectangle \
  spotify \
  slack \
  docker \
  notion \
  squashfs \
  virtualbox \
  wireshark \
  wireshark-chmodbpf \
  zerotier-one

##
## asdf
##
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add python
asdf plugin-add java
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.zshrc
echo -e "\n. $HOME/.asdf/completions/asdf.bas" >> ~/.zshrc

asdf install erlang 23.0.2
asdf global erlang 23.0.2
asdf install elixir 1.10.3-otp-23
asdf global elixir 1.10.3-otp-23

##
## xcode
##
xcode-select --install

#
# elixirls
#
git clone git@github.com:elixir-lsp/elixir-ls.git artifacts/elixir-ls
cd artifacts/elixir-ls
git checkout tags/v0.5.0
asdf local erlang 23.0.2
asdf local elixir 1.10.3-otp-23
mix local.hex --force
mix local.rebar --force
mix do deps.get, compile, elixir_ls.release -o rel
