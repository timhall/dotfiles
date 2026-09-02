#!/bin/sh
#
# Homebrew has to exist before anything else can be installed, and before any
# file is written, hence `before`. Runs once per machine.

set -e

[ "$(uname)" = "Darwin" ] || exit 0

# Check the install locations rather than PATH. This runs `before`, so the
# .zshenv that puts brew on PATH has not been written yet, and a second user
# account on a machine that already has Homebrew would otherwise reinstall it.
command -v brew >/dev/null && exit 0
[ -x /opt/homebrew/bin/brew ] && exit 0
[ -x /usr/local/bin/brew ] && exit 0

echo "› installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
