#!/usr/bin/env bash

dir="$HOME"
skipped=0

shopt -s dotglob
for file in *
do
	if [[ ! "$file" -ef "$0" && "${file##*.}" != "swp" ]] # Don't install this script, or vim temporary files
	then
		if ! install_symlink "$file" "$dir"/"$file"; then skipped=1; fi
	fi
done

if [[ "$skipped" = 1 ]]
then
	echo "One or more files were skipped because they already exist"
	exit 1
fi
