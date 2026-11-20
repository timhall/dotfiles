# Package manifest for `brew bundle`, run by the provisioning script on every
# `chezmoi apply` where this file has changed.

# Casks install with --adopt, so an app already at the destination is taken
# over rather than reinstalled.

tap "oven-sh/bun", trusted: true
tap "roc-lang/roc", trusted: true

# Tools
brew "chezmoi"
brew "ffmpeg"
brew "fnm"
brew "gh"
brew "imagemagick"
brew "jpeg-xl"
brew "llvm@16"
brew "mkcert"
brew "mole"
brew "oven-sh/bun/bun"
brew "opencode"
brew "pngcrush"
brew "pyenv"
brew "roc-lang/roc/roc"
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
cask "claude-code"
cask "ghostty"
cask "google-chrome"
cask "obsidian"
cask "swiftbar"
cask "zed"
