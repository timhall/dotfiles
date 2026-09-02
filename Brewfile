# Package manifest for `brew bundle`, run by the provisioning script on every
# `chezmoi apply` where this file has changed.

# Casks install with --adopt, so an app already at the destination is taken
# over rather than reinstalled.

# Tools
brew "awscli"
brew "chezmoi"
brew "ffmpeg"
brew "fnm"
brew "gh"
brew "imagemagick"
brew "jpeg-xl"
brew "llvm@16"
brew "mkcert"
brew "mole"
brew "pngcrush"
brew "pyenv"
brew "uv"
brew "zig"

# pyenv needs these present to compile Python. Some are also pulled in as
# dependencies elsewhere; they are listed so removing an unrelated formula
# cannot quietly break python builds.
brew "openssl@3"
brew "readline"
brew "sqlite3"
brew "xz"
brew "zlib"

# Applications
cask "docker-desktop"
cask "ghostty"
cask "google-chrome"
cask "obsidian"
cask "raycast"
cask "zed"