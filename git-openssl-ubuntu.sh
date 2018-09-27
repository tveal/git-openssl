#!/usr/bin/env bash
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# help set:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

function main() {
    sudo apt install git build-essential dpkg-dev checkinstall autoconf -y
    sudo apt install libcurl4-openssl-dev libexpat1-dev gettext libz-dev libssl-dev -y
    sudo apt install asciidoc xmlto docbook2x -y

    if [ -d "$THIS_DIR/git" ]; then
        cd "$THIS_DIR/git"
        git reset --hard HEAD
        git pull origin master
    else
        # make sure this runs relative to script dir
        cd "$THIS_DIR"
        cloneSource || wgetSourceZip
    fi

    # set version for custom git
    # https://github.com/git/git/blob/master/GIT-VERSION-GEN
    # This way, with 'git --version', you can tell when you last
    # ran this script to get/update Git-with-OpenSSL
    echo "`date +%Y-%m-%d`.openssl" > version

    sudo apt remove git -y
    sudo apt autoremove -y

    make configure
    ./configure --prefix=/usr
    make all doc info

    # Builds a package for easy uninstallation. Don't use this
    # for building distribution packages. Purely for local builds.
    sudo checkinstall --pkgversion "9:9.9.9-9${USER}0.9" sudo make install install-doc install-html install-info
}

function cloneSource() {
    git clone https://github.com/git/git.git
    cd git/
}

function wgetSourceZip() {
    wget https://github.com/git/git/archive/master.zip
    unzip master.zip
    rm master.zip
    cd git-master/
}

main "$@"
