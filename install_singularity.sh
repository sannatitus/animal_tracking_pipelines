#!/bin/bash

# Copied from https://github.com/apptainer/singularity/blob/master/INSTALL.md

# Ensure repositories are up-to-date
sudo apt-get update

# Install debian packages for dependencies
sudo apt-get install -y \
    build-essential \
    libseccomp-dev \
    pkg-config \
    squashfs-tools \
    cryptsetup \
    curl wget git

# Install Go
export GOVERSION=1.17.3 OS=linux ARCH=amd64  # change this as you need
wget -O /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz \
  https://dl.google.com/go/go${GOVERSION}.${OS}-${ARCH}.tar.gz
sudo tar -C /usr/local -xzf /tmp/go${GOVERSION}.${OS}-${ARCH}.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# Clone the Singularity repo
git clone https://github.com/hpcng/singularity.git
cd singularity

# Checkout 3.8
git -c advice.detachedHead=false checkout v3.8.4

# Compile Singularity
./mconfig
cd ./builddir
make
sudo make install

# show version
singularity version
