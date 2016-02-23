#!/usr/bin/env bash

# install_symlink(file, location)
# @desc - install a file as a symlink
# @param file - location of the source file
# @param location - directory to place the symlink
# @note - when 'file' does not exist, it is a programming error, and exit is called
#         when 'location' already exists, and not because it is already properly installed,
#         the user is prompted whether to overwrite it (so long as it is not a directory),
#         otherwise it is skipped and 1 is returned
#         when the directory for 'location' does not exist, it will be created
install_symlink() {
	file="$1"
	location="$2"
	target="$(pwd)"/"$file"
	location_dir=$(dirname "$file")

	if [[ ! -a "$file" ]]; then echo "Source file '$file' does not exist, quitting..."; exit 1; fi

	if [[ -a "$location" ]]
	then
		if [[ ! -L "$location" && ! "$location" -ef "$target" ]]
		then
			if [[ -d "$location" ]]
			then
				echo "File '$location' already exists, and is a directory, skipping..."
				return 1
			else
				echo "File '$location' already exists"
				echo -n "Replace? (Y/n) "
				read response
				if [[ "$response" = "" || "$reponse" = "y" || "$response" = "Y" ]]
				then
					rm "$location"
					ln -s "$target" "$location"
				else
					echo "Skipping..."
					return 1
				fi
			fi
		fi
	else
		[[ ! -d "$location_dir" ]] && mkdir -p "$location_dir"
		ln -s "$target" "$location"
	fi
}
export -f install_symlink

if [[ -z "$@" ]]; then echo "No sources listed, quitting..."; exit 1; fi

for var in "$@"
do
	if [[ ! -d "$var" ]]; then echo "No such source named '$var', quitting..."; exit 1; fi

	>/dev/null cd "$var"
		if [[ ! -f ./install.sh ]]; then echo "No install script found for source named '$var', quitting..."; exit 1; fi

		if ./install.sh
		then
			echo "Install script for source named '$var' completed successfully."
		else
			echo "Install script failed for source named '$var', quitting..."
			exit 1
		fi
	>/dev/null cd -
done

echo "All install scripts completed successfully"
