#!/usr/bin/env bash

touch ~/.bash_profile
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.3/install.sh | bash
. ~/.nvm/nvm.sh

nvm install 0.12.15
nvm install 4.5.0
nvm install 5.12.0
nvm install 6.5.0
