#!/bin/sh
#
# macOS defaults. `onchange` rather than `once`, so editing this file
# re-applies it.
#
# Originally from holman's dotfiles, in turn from mathiasbynens.

set -e

[ "$(uname)" = "Darwin" ] || exit 0

echo "› macOS defaults"

# Key repeat instead of the accent picker, and repeat fast.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1

# AirDrop over every interface, not just Wi-Fi.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Finder: list view everywhere, show mounted volumes on the desktop.
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
chflags nohidden ~/Library

# Screensaver in the bottom-left hot corner.
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Safari: no bookmark bar, developer menus on.
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Finder and Dock only reread their preferences on launch.
killall Finder Dock 2>/dev/null || true
