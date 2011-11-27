#!/bin/bash

dotfilesWD=$PWD/`dirname $0`

# iterates through the files in this top-level directory and create the necessary symbolic links in home
for i in `ls $dotfilesWD`
do
	file=`basename $i`
	echo "ln -s $dotfilesWD/$file ~/.$file"
done
