#!/bin/bash

bakSuffix=.bak-dotfiles
linksWD=$PWD/`dirname $0`/links


# iterates through the files in this top-level directory and create the necessary symbolic links in home
for i in `ls $linksWD`
do
	file=`basename $i`

	# if the destination already exists, rename it as a backup
	if [ -e ~/.$file ]; then
		if [ ! -e ~/.$file$bakSuffix ]; then
			mv ~/.$file ~/.$file$bakSuffix
		else
			continue
		fi
	fi

	ln -s $linksWD/$file ~/.$file
done
