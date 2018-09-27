#!/usr/bin/env bash

# help set:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

# Uses standard Git-with-GnuTLS to get source to build Git-with-OpenSSL
sudo apt install git build-essential dpkg-dev checkinstall autoconf -y
sudo apt install libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev -y
sudo apt install asciidoc xmlto docbook2x -y

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GIT_DIR="$THIS_DIR/git"

if [ -d "$GIT_DIR" ]; then
  cd "$GIT_DIR"
  git reset --hard HEAD
  git pull origin master
else
  # dropped the 's' from https so Git-with-GnuTLS can get it
  git clone http://github.com/git/git.git
  cd "$GIT_DIR"
fi

# set version for custom git
# https://github.com/git/git/blob/master/GIT-VERSION-GEN
# This way, with 'git --version', you can tell when you last
# ran this script to get/update Git-with-OpenSSL
echo "`date +%Y-%m-%d`.openssl" > "$GIT_DIR/version"

sudo apt remove git -y
sudo apt autoremove -y

make configure
./configure --prefix=/usr
make all doc info

# Builds a package for easy uninstallation. Don't use this
# for building distribution packages. Purely for local builds.
sudo checkinstall --pkgversion "9:9.9.9-9${USER}0.9" sudo make install install-doc install-html install-info
