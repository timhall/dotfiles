#!/bin/sh
#
# macOS defaults. `onchange` rather than `once`, so editing this file
# re-applies it.
#
# Only settings verified to take effect on this macOS version belong here.
# Check https://macos-defaults.com before adding one; a lot of the lists that
# circulate target much older releases and fail silently.
#
# Safari is deliberately absent. Its preferences live in a sandboxed container
# that TCC blocks, so `defaults write com.apple.Safari` does nothing unless the
# calling terminal has Full Disk Access. To add one, grant that, then diff
# `plutil -p ~/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist`
# before and after toggling the setting in Safari, and use the key that changes.

set -e

[ "$(uname)" = "Darwin" ] || exit 0

echo "› macOS defaults"

# Key repeat instead of the accent picker, and repeat fast.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1

# AirDrop over every interface, not just Wi-Fi.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Finder: list view, and hide nothing.
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
chflags nohidden ~/Library

# Finder and Dock only reread their preferences on launch.
killall Finder Dock 2>/dev/null || true
