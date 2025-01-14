#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."

  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
  then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

fi

function install() {
  app=$1
  cask=${2:-}

cat << EOF

-> Installing ${app}...
EOF

  if [[ x"$OS" == x"Windows" ]]; then
    scoop install ${app}
  else
    if [[ ! "$cask" ]]; then
      brew list ${app} >/dev/null || brew install ${app}
    else
      brew list ${app} --cask >/dev/null || brew install ${app} --cask
    fi
  fi

cat << EOF

-> ${app} installed
EOF
}

brew install openssl readline sqlite3 xz zlib
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

exit 0
