FROM ubuntu:xenial

ENV DPKG_FRONTEND noninteractive
ENV TERM xterm

# upgrade packages, install deps
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
    autoconf \
    automake \
    binutils \
    bison \
    bzip2 \
    curl \
    elixir \
    erlang \
    flex bison \
    g++ \
    gcc \
    git \
    golang \
    haskell-platform \
    htop \
    jq \
    libbison-dev \
    libbz2-dev \
    libc6-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libdjvulibre-dev \
    libexif-dev \
    libexpat1-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libgcrypt11-dev \
    libgdbm-dev \
    libgnutls28-dev \
    libgpg-error-dev \
    libgraphviz-dev \
    libgssapi-krb5-2 \
    libidn11-dev \
    libjasper-dev \
    libjasper-dev \
    libjbig-dev \
    libjpeg-dev \
    libkrb5-dev \
    liblcms2-dev \
    liblzma-dev \
    libmysqlclient-dev \
    libncursesw5-dev \
    libopenexr-dev \
    libp11-kit-dev \
    libpcre3-dev \
    libpng12-dev \
    libpq-dev \
    libreadline-dev \
    librsvg2-dev \
    librtmp-dev \
    libsqlite0-dev \
    libsqlite3-dev \
    libssl-dev \
    libtcl8.6 \
    libtiff5-dev \
    libtk8.6 \
    libtool-bin \
    libxml2-dev \
    libzmq3-dev \
    linux-libc-dev \
    lua5.2 \
    make \
    nano \
    ocaml \
    openjdk-8-jdk \
    patch \
    php \
    pkg-config \
    python \
    python-pip \
    python3-pip \
    ruby \
    ruby-dev \
    runit \
    rustc \
    rust-gdb \
    rust-lldb \
    telnet \
    vim \
    wget \
    zlib1g-dev \
    && apt-get -y autoremove && apt-get clean autoclean && \
    rm -rf /var/cache/apt/archives/* \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# install dumb-init to manage signal forwarding from the run scripts to the processes they call
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb && \
  dpkg -i dumb-init_*.deb && \
  rm dumb-init_*.deb

# Add nvm to all login shells
RUN echo 'export NVM_DIR="/home/nvm/.nvm"' > /etc/profile.d/nvm.sh
RUN echo 'source ${NVM_DIR}/nvm.sh' >> /etc/profile.d/nvm.sh

# add user for running your apps
RUN adduser --quiet --shell /bin/bash --disabled-password --disabled-login --gecos "" --no-create-home --home /app app

# install nvm and node versions
RUN adduser --quiet --shell /bin/bash --disabled-password --disabled-login --gecos "" --home /home/nvm nvm
USER nvm
COPY install-node.sh /usr/bin/install-node
RUN install-node

USER root
