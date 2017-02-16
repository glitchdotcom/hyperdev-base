#!/usr/bin/env bash
set -e

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
export NVM_DIR="/home/nvm/.nvm"
source ${NVM_DIR}/nvm.sh

nvm install 6.9.1
nvm install 6.5.0
nvm install 5.12.0
nvm install 4.5.0
nvm install 0.12.15
