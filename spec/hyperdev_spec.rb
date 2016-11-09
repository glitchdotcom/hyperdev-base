require "serverspec"
require "docker-api"

describe "Dockerfile" do

  image = ::Docker::Image.build_from_dir( '.', 't' => 'fogcreek/hyperdev-base:latest') do |v|
    if (log = JSON.parse(v)) && log.has_key?("stream")
      $stdout.puts log["stream"]
    end
  end

  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  it "Installs the correct OS release" do
    expect(file("/etc/lsb-release")).to contain("DISTRIB_ID=Ubuntu")
    expect(file("/etc/lsb-release")).to contain("DISTRIB_RELEASE=16.04")
  end

  it "Creates the app user" do
    expect(user("app")).to exist
  end

  it "Installs toolchain and libraries" do
    %w[
      autoconf
      automake
      binutils
      bison
      bzip2
      curl
      flex bison
      g++
      gcc
      git
      golang
      jq
      libbison-dev
      libbz2-dev
      libc6-dev
      libcairo2-dev
      libcurl4-openssl-dev
      libdjvulibre-dev
      libexif-dev
      libexpat1-dev
      libfontconfig1-dev
      libfreetype6-dev
      libgcrypt11-dev
      libgdbm-dev
      libgnutls28-dev
      libgpg-error-dev
      libgraphviz-dev
      libgssapi-krb5-2
      libidn11-dev
      libjasper-dev
      libjasper-dev
      libjbig-dev
      libjpeg-dev
      libkrb5-dev
      liblcms2-dev
      liblzma-dev
      libmysqlclient-dev
      libncursesw5-dev
      libopenexr-dev
      libp11-kit-dev
      libpcre3-dev
      libpng12-dev
      libpq-dev
      libreadline-dev
      librsvg2-dev
      librtmp-dev
      libsqlite0-dev
      libsqlite3-dev
      libssl-dev
      libtcl8.6
      libtiff5-dev
      libtk8.6
      libtool-bin
      libxml2-dev
      libzmq3-dev
      linux-libc-dev
      make
      nano
      patch
      pkg-config
      python
      python-pip
      runit
      vim
      wget
      zlib1g-dev
    ].each do |package_name|
      expect(package( package_name )).to be_installed
    end
  end


  it "Installs required node.js versions and NVM" do
    expect(file("/home/nvm/.nvm/nvm.sh")).to exist
    expect(file("/home/nvm/.nvm/bin/node-v4.5.0-linux-x64")).to exist
    expect(file("/home/nvm/.nvm/bin/node-v5.12.0-linux-x64")).to exist
    expect(file("/home/nvm/.nvm/bin/node-v6.9.1-linux-x64")).to exist
    expect(file("/home/nvm/.nvm/bin/node-v0.12.15-linux-x64")).to exist
  end

end
