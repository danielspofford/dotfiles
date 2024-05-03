#!/bin/bash

set -euo pipefail

# create directories but not files
rsync -avq --include '*/' --exclude '*' ./home/ $HOME


link_file() {
  src="$PWD/${1#./}"
  dest="$HOME/${1#./}"

  # check if the file already exists
  if [ -f "$dest" ] || [ -L "$dest" ]; then
      if [ -L "$dest" ]; then

      ln_src=$(readlink $dest)
        if [ "$ln_src" = "$src" ]; then
	      echo "already symlinked source ($ln_src) target ($dest)"
	      return 0
	else
	      echo "removing symlink source ($ln_src) target ($dest)"
	      rm "$dest"
	fi
    else
      mv $dest "$dest.old"
      echo "$dest already exists, moving to $dest.old before writing"
    fi
  else
	  # no file or symlink
	  echo ""
  fi

  echo "ln -s $src $dest"
  ln -s "$src" "$dest"
}

export -f link_file

cd ./home
find . -type f -exec bash -c 'link_file "$1"' _ {} \;
