#!/bin/sh
#
# Language toolchains that Homebrew only bootstraps: rust, node, python, and pnpm.
# Each step is skipped when already present, so this is safe to re-run.

set -e

[ "$(uname)" = "Darwin" ] || exit 0

eval "$(/opt/homebrew/bin/brew shellenv)"

if [ ! -x "$HOME/.cargo/bin/rustup" ]; then
  echo "› installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi

if command -v fnm >/dev/null && [ -z "$(fnm list | grep default)" ]; then
  echo "› installing node (lts)"
  fnm install --lts
  fnm default lts-latest
fi

if command -v pyenv >/dev/null && [ "$(pyenv versions --bare | wc -l)" -eq 0 ]; then
  echo "› installing python 3.11"
  pyenv install 3.11
  pyenv global "$(pyenv versions --bare | head -1)"
fi

# pnpm is a standalone binary, but its installer runs on node. It also appends
# PNPM_HOME to ~/.zshrc, which .zshenv already sets, so put .zshrc back.
if command -v fnm >/dev/null && ! command -v pnpm >/dev/null; then
  echo "› installing pnpm"
  eval "$(fnm env --shell bash)"
  zshrc_backup="$(mktemp)"
  cp "$HOME/.zshrc" "$zshrc_backup"
  npx --yes get-pnpm
  cp "$zshrc_backup" "$HOME/.zshrc"
  rm "$zshrc_backup"
fi

# Yarn Classic as a launcher: repos pin their own release via yarnPath, so no
# corepack. pnpm's global bin dir is already on PATH via .zshenv.
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME/bin:$PNPM_HOME:$PATH"
if command -v pnpm >/dev/null && ! command -v yarn >/dev/null; then
  echo "› installing yarn"
  pnpm add -g yarn
fi
