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
# that TCC blocks, so `defaults write com.apple.Safari` silently does nothing
# unless the calling terminal has Full Disk Access — a grant far too broad to
# be worth one checkbox. Safari settings are in the README's manual list.

set -e

[ "$(uname)" = "Darwin" ] || exit 0

echo "› macOS defaults"

# Key repeat instead of the accent picker, and repeat fast.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 1

# No autocorrect or smart substitution; they mangle code and commit messages.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Dark mode. Takes effect at next login; the UI toggle applies it immediately.
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# AirDrop over every interface, not just Wi-Fi.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Dock: left edge, hidden until needed, small tiles, no recents, no launch bounce.
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool false

# Finder: list view, and hide nothing.
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
chflags nohidden ~/Library

# Menu bar clock: digital, 12-hour with AM/PM, day of week, no date, no seconds.
defaults write com.apple.menuextra.clock IsAnalog -bool false
defaults write com.apple.menuextra.clock ShowAMPM -bool true
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowSeconds -bool false

# Show where the pointer clicked in screen recordings.
defaults write com.apple.screencapture showsClicks -bool true

# These only reread their preferences on launch.
killall Finder Dock ControlCenter 2>/dev/null || true
