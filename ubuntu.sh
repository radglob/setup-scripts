#!/bin/bash

apt-get update
apt-get upgrade -y

apt-get install -y zsh \
  git \
  curl \
  ruby \
  libssl-dev

# Install oh-my-zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

chsh $USER -s $(which zsh)

echo "Configure zsh to your liking."

# Install rbenv.
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc

# Install ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.zshrc

# Install new(ish) version of ruby.
rbenv install 2.2.2

# Install nvm.
# Set PROFILE so nvm appends to correct file.
echo 'export PROFILE="~/.zshrc"' >> ~/.zshrc && source ~/.zshrc

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | zsh

# Install recent version of node.
nvm install 0.12.4

echo "zsh, ruby, and node are all installed. Configure things to your liking!"
