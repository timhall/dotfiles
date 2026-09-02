#!/bin/sh
#
# Homebrew has to exist before anything else can be installed, and before any
# file is written, hence `before`. Runs once per machine.

set -e

[ "$(uname)" = "Darwin" ] || exit 0
command -v brew >/dev/null && exit 0

echo "› installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
