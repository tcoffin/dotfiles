#!/bin/bash

# iterates through the files in links directory and create the necessary symbolic links in home
function installSymLinks() {
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
}

function uninstallSymLinks() {
	for i in `ls $linksWD`
	do
		file=`basename $i`

		# remove it if its a symbolic link
		if [ -h ~/.$file ]; then
			rm ~/.$file

			# if the backup exists, restore it
			if [ -e ~/.$file$bakSuffix ]; then
				mv ~/.$file$bakSuffix ~/.$file
			fi
		fi
	done
}

bakSuffix=.bak-dotfiles
linksWD=$PWD/`dirname $0`/links
uninstall=0

# check the arguments (otherwise assume install)
for i in "$@"
do
	if [[ "$i" == "-u" ]]; then
		uninstall=1
	elif [[ "$i" == "-h" ]]; then
		printf "usage: install.sh [-u]\n\tdefault invokation with no arguments will install the contents of links directory in to your home (~) making a backup of existing files/directories/links.\n\t-u uninstall the symbolics links from home(~)\n\n"
	fi
done

if [ $uninstall -eq 1 ]; then
	uninstallSymLinks
else
	installSymLinks
fi


