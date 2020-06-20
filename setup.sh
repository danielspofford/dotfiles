#
# brew
#
brew install \
  asdf \
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
  sqlite \
  tmux \
  tree \
  unixodbc \
  unzip \
  wxmac \
  yamllint

brew cask install \
  iterm2 \
  rectangle \
  spotify \
  slack \
  docker \
  notion \
  squashfs \
  virtualbox

#
# asdf
#
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add python
asdf plugin-add java
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
echo -e "\n. $(brew --prefix asdf)/asdf.sh" >> ~/.zshrc

#
# xcode
#
xcode-select --install
