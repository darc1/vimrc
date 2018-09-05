#!/bin/bash

#kernel sources
SOURCES=$1
#output dir
DIR=${2:-.}
FILE_NAME=${3:-cscope.files}
file="$DIR/${FILE_NAME}"

echo "generating cscope db for ${SOURCES} dest ${file}"
find  $SOURCES                                                                	\
-path "$SOURCES/arch/*" ! -path "$SOURCES/arch/x86*" -prune -o               	\
-path "$SOURCES/include/asm-*" ! -path "$SOURCES/include/asm-generic*" -prune -o \
-path "$SOURCES/tmp*" -prune -o                                           	\
-path "$SOURCES/Documentation*" -prune -o                                 	\
-path "$SOURCES/scripts*" -prune -o                                       	\
-path "$SOURCES/drivers*" -prune -o                                       	\
-path "$SOURCES/sound*" -prune -o                                       	\
-path "$SOURCES/firmware*" -prune -o                                       	\
-path "$SOURCES/tools*" -prune -o                                       	\
    -name "*.[chxsS]" -print > $file

cd $DIR
cscope -kqb -i $file
ctags -L $file
