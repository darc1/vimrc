#!/bin/bash

#install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
#update .bashrc
echo export PATH="/home/ubuntu/.pyenv/bin:$PATH" >> ~/.bashrc
echo eval "$(pyenv init -)" >> ~/.bashrc
echo "eval \"$(pyenv virtualenv-init -)\"" >> ~/.bashrc
#update locally
export PATH="/home/ubuntu/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

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
git clone https://github.com/vim/vim.git
./configure                  \
    --with-features=huge                    \
    --enable-multibyte                      \
    --enable-pythoninterp=dynamic           \
    --enable-python3interp=dynamic          \
    --with-python-config-dir=$PY_CONFIG     \
    --with-python3-config-dir=$PY3_CONFIG   \
    --enable-cscope                         \
    --prefix=/usr


