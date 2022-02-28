# timhall dotfiles

Your dotfiles are how you personalize your system. These are mine.

They're so personal I copied much of them from https://github.com/haacked/dotfiles / https://github.com/holman/dotfiles including the approach to install them.

## Install

Run this:

```sh
git clone https://github.com/haacked/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

### ZSH

Add the following to the bottom of your `~/.zshrc` file:

```bash
if [ -f ${HOME}/.dotfiles/zsh/.bash_exports ]; then
  . ${HOME}/.dotfiles/zsh/.bash_exports
fi
```
