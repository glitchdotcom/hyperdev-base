#!/usr/bin/env bash

PARALLELISM=10

curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash 2>&1
export NVM_DIR="/home/nvm/.nvm"
source ${NVM_DIR}/nvm.sh

read -r -d '' VERSIONS << EOM
8.6.0 8.5.0 8.4.0 8.3.0 8.2.1 8.1.4 8.0.0
7.10.1 7.9.0 7.8.0 7.7.4 7.6.0 7.5.0 7.4.0 7.3.0 7.2.1 7.1.0 7.0.0
6.11.3 6.10.3 6.9.5 6.8.1 6.7.0 6.6.0 6.5.0 6.4.0 6.3.1 6.2.2 6.1.0 6.0.0
4.8.4 4.7.3 4.6.2 4.5.0 4.4.7 4.3.2 4.2.6 4.1.2
0.12.18
EOM

base_dir=/home/nvm/.nvm/versions/node

install_version() {
  local version=$1
  local dest_dir=${base_dir}/v${version}
  # redirect stderr to /dev/null to not show progress bar
  nvm install ${version} 2> /dev/null
  echo "cache=/tmp/.npm/" > ${dest_dir}/etc/npmrc
}

parallel=0
for version in ${VERSIONS}; do
  install_version ${version} &
  parallel=$(($parallel + 1))
  if [ ${parallel} -eq ${PARALLELISM} ]; then
    wait
    parallel=0
  fi
done
wait

nvm cache clear
