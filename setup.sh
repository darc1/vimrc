#!/bin/bash
#
# uninstall vim: sudo apt remove vim vim-runtime gvim
#

mkdir -p ~/tmp
cd ~/tmp

#install pyenv
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

if grep -Fxq "pyenv" .bashrc
then
    echo "pyenv already in bashrc"
else
    #update .bashrc
    echo export PATH="/home/ubuntu/.pyenv/bin:\$PATH" >> ~/.bashrc
    echo eval "\$(pyenv init -)" >> ~/.bashrc
    echo "eval \"\$(pyenv virtualenv-init -)\"" >> ~/.bashrc
    source ~/.bashrc
fi

PY3_VER=3.8.3
PY2_VER=2.7.18
#configure python https://gist.github.com/klen/3d327e5f84e36dc04bd7
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -fk $PY3_VER
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install -fk $PY2_VER

PY_CONFIG=`pyenv prefix $PY2_VER/lib/python2.7/config`
PY3_PREFIX=`pyenv prefix $PY3_VER`
PY3_CONFIG=`$PY3_PREFIX/bin/python-config --configdir`

mkdir -p ~/lib
cd ~/lib
ln -s ../.pyenv/versions/$PY2_VER/lib/libpython2.7.so
ln -s ../.pyenv/versions/$PY3_VER/lib/libpython3.8.so

#download vim code
cd ~/tmp/
git clone https://github.com/vim/vim.git
cd vim/src
./configure                  \
    --with-features=huge                    \
    --enable-multibyte                      \
    --enable-pythoninterp=dynamic           \
    --enable-python3interp=dynamic          \
    --with-python-config-dir=$PY_CONFIG     \
    --with-python3-config-dir=$PY3_CONFIG   \
    --enable-cscope                         \
    --prefix=/usr
echo !!
make
sudo make install

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

