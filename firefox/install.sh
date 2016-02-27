#!/usr/bin/env bash

install_symlink .pentadactylrc ~/.pentadactylrc
install_symlink stylish.sqlite ~/.mozilla/firefox/*.default/stylish.sqlite

if [[ "$skipped" = 1 ]]
then
	echo "One or more file conflicts encountered.  Please resolve the conflicts and run this script again."
	exit 1
fi
