#!/bin/bash

#kernel sources
SOURCES=$1
#output dir
DIR=${2:-.}
FILE_NAME=${3:-cscope.files}
file="$DIR/${FILE_NAME}"

echo "generating cscope db for ${SOURCES} dest ${file}"

find ${SOURCES} -name '*.py' \
-o -name '*.java' \
-o -iname '*.[CH]' \
-o -name '*.cpp' \
-o -name '*.cc' \
-o -name '*.hpp'  \
> $file

cd $DIR
cscope -qb -i $file
ctags -L $file
