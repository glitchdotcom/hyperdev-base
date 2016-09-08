FROM ubuntu:xenial

# upgrade packages, install deps
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
    autoconf \
    automake \
    binutils \
    bison \
    bzip2 \
    curl \
    flex bison \
    g++ \
    gcc \
    git \
    golang \
    jq \
    libbison-dev \
    libbz2-dev \
    libc-dev \
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
    libsqlite-dev \
    libssl-dev \
    libtcl8.6 \
    libtiff-dev \
    libtk8.6 \
    libtool-bin \
    libxml2-dev \
    libzmq3-dev \
    linux-libc-dev \
    make \
    nano \
    patch \
    pkg-config \
    python \
    python-pip \
    runit \
    wget \
    zlib1g-dev \
    && apt-get -y autoremove && apt-get clean autoclean && \
    rm -rf /var/cache/apt/archives/* \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# install dumb-init to manage signal forwarding from the run scripts to the processes they call
RUN wget https://github.com/Yelp/dumb-init/releases/download/v1.1.3/dumb-init_1.1.3_amd64.deb && \
  dpkg -i dumb-init_*.deb && \
  rm dumb-init_*.deb

# install nvm and node versions
COPY install-node.sh /usr/bin/install-node
RUN install-node
