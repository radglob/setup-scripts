#!/bin/bash

OH_MY_ZSH_DIR="$HOME/.oh-my-zsh"
RBENV_DIR="$HOME/.rbenv"
RUBY_VERSION="2.2.2"
NVM_DIR="$HOME/.nvm"
NODE_VERSION="0.12.4"

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y zsh \
  git \
  curl \
  ruby \
  libssl-dev

# Install oh-my-zsh
# Check if oh-my-zsh is already installed.
if [ ! -d "$OH_MY_ZSH_DIR" ]; then
	echo "Installing Oh My Zsh..."
	curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
else
	echo "Oh My Zsh is already installed!"
fi

# Install rbenv.
if [ ! -d "$RBENV_DIR" ]; then
	echo "Installing rbenv and ruby-build"
	git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.zshrc
	echo 'eval "$(rbenv init -)"' >> $HOME/.zshrc

	# Install ruby-build
	git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
else
	echo "rbenv and ruby-build are already installed."
fi

# Install new(ish) version of ruby.
if [ $(rbenv global) != "$RUBY_VERSION" ]; then
	rbenv install $RUBY_VERSION
	rbenv global $RUBY_VERSION
else
	echo "Ruby $RUBY_VERSION is already installed."
fi

# Install nvm.
if [ ! -d "$NVM_DIR" ]; then 
	echo "Downloading and installing nvm..."
	curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | PROFILE="$HOME/.zshrc" bash
else
	echo "nvm is already installed..."
fi

source $HOME/.nvm/nvm.sh

# Install recent version of node.
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
nvm use default

echo "zsh, ruby, and node are all installed. Configure things to your liking!"
