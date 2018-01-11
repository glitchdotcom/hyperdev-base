#!/usr/bin/env bash

curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash 2>&1
export NVM_DIR="/home/nvm/.nvm"
source ${NVM_DIR}/nvm.sh

read -r -d '' VERSIONS << EOM
9.4.0 9.3.0 9.2.1 9.1.0 9.0.0
8.9.4 8.8.1 8.7.0 8.6.0 8.5.0 8.4.0 8.3.0 8.2.1 8.1.4 8.0.0
6.12.3 6.11.5 6.10.3 6.9.5 6.8.1 6.7.0 6.6.0 6.5.0 6.4.0 6.3.1 6.2.2 6.1.0 6.0.0
EOM

base_dir=/home/nvm/.nvm/versions/node

install_version() {
  local version=$1
  local dest_dir=${base_dir}/v${version}
  # redirect stderr to /dev/null to not show progress bar
  nvm install ${version} 2> /dev/null
  echo "cache=/tmp/.npm/" > ${dest_dir}/etc/npmrc
  npm install -g pnpm
}

for version in ${VERSIONS}; do
  install_version ${version}
done

nvm cache clear
