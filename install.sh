#!/usr/bin/env bash

# ================================================================================
#  Exported helper functions
# ================================================================================

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

# default_install()
# @desc - the default install method when a source does not provide a script
# @note - simply installs all files in the source
#         skips vim tempfiles for less headaches
#         skips the script that calls this function, so this can be used as a stub/fallback in a script
default_install() {
	dir="$HOME"
	skipped=0

	shopt -s dotglob
	for file in *
	do
		if [[ -e "$file" && ! "$file" -ef "$0" && "${file##*.}" != "swp" ]] # Don't install the caller script, or vim temporary files
		then
			if ! install_symlink "$file" "$dir"/"$file"; then skipped=1; fi
		fi
	done

	if [[ "$skipped" = 1 ]]
	then
		echo "One or more file conflicts encountered.  Please resolve the conflicts and run this script again."
		exit 1
	fi
}
export -f default_install


# ================================================================================
#  Installation procedure
# ================================================================================

# Handle arguments
if [[ -z "$@" ]]; then echo "No sources listed, quitting..."; exit 1; fi

# Ensure submodules are updated
git submodule init
git submodule update

# Install selected sources
for var in "$@"
do
	if [[ ! -d "$var" ]]; then echo "No such source named '$var', quitting..."; exit 1; fi

	>/dev/null cd "$var"
	if [[ -f ./install.sh ]]
	then
		if ./install.sh
		then
			echo "Install script for source named '$var' completed successfully."
		else
			echo "Install script failed for source named '$var', quitting..."
			exit 1
		fi
	else
		if default_install
		then
			echo "Install script for source named '$var' completed successfully."
		else
			echo "Install script failed for source named '$var', quitting..."
			exit 1
		fi
	fi
	>/dev/null cd -
done

# Quit
echo "All install scripts completed successfully"
