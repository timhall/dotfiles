# timhall dotfiles

Your dotfiles are how you personalize your system. These are mine, machine configuration managed with [chezmoi](https://chezmoi.io). Previously a [holman](https://github.com/holman/dotfiles)-style repo with a `script/bootstrap` symlinker.

## Requirements

Xcode Command Line Tools. It opens a GUI dialog, so it can't be scripted:

```sh
xcode-select --install
```

Everything else, including Homebrew, is installed by `chezmoi apply`.

## New machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply timhall
```

That installs chezmoi, clones this repo to `~/.local/share/chezmoi`, runs the
provisioning scripts, and writes `$HOME`. There is nothing to install first:
`brew install chezmoi` would be circular, since chezmoi is what installs
Homebrew.

To look before it writes, drop `--apply`, then run `chezmoi diff` and
`chezmoi apply -v` separately.

## No templates

There are none, and that's deliberate. `chezmoi re-add`, the one command that
pulls a live edit back into the repo, refuses to touch templates. Every
templated file therefore leaves that fast path permanently and drifts instead.

Where something genuinely has to vary, use the tool's own local-override
mechanism rather than a chezmoi template: git `[include]` and
`includeIf gitdir:`, zsh `source`, `CLAUDE.md` `@import`, Claude's
`settings.local.json`. Routing by directory beats routing by machine, because
it is identical everywhere.

A file earns template status only when a value truly differs between machines.
A path appearing in it is not enough.

## Day-to-day

| Task                                                    | Command                                                 |
| ------------------------------------------------------- | ------------------------------------------------------- |
| Preview pending changes                                 | `chezmoi diff`                                          |
| Apply source -> `$HOME`                                 | `chezmoi apply -v`                                      |
| Edit a managed file (edits source, then apply)          | `chezmoi edit ~/.claude/settings.json && chezmoi apply` |
| Pull an ad-hoc edit from a live file back into the repo | `chezmoi re-add`                                        |
| Start managing a new file                               | `chezmoi add ~/.somefile`                               |
| Make a file a template                                  | `chezmoi chattr +template ~/.somefile`                  |

The source lives at `~/.local/share/chezmoi`, chezmoi's default. A symlink at
`~/dev/timhall/dotfiles` points to it, so it sits alongside everything else in
`~/dev` for editing: same directory, two paths. It is a normal git repo; commit
and push as usual, or use `chezmoi git -- <args>` / `chezmoi cd`.

## What's here

- **shell**: `.zshenv` (PATH and toolchain), `.zshrc` (aliases and shell
  integration), `.zprofile` (secrets, seeded once; see below).
- **git**: `.gitconfig`, `.gitconfig.aliases`, `.gitignore`.
- **ssh**: `.ssh/config`.
- **`dot_claude/`** -> `~/.claude/`: Claude Code global config. `CLAUDE.md` and
  `settings.json` (curated permission allowlist).
- **`.config/zed/`**: `settings.json` and `keymap.json`.
- **`.npmrc`**: reads `${NPM_TOKEN}` from the environment rather than storing a
  token, so npm and yarn share one value and the repo stays clean.
- **`Brewfile`** and three `run_` scripts: install Homebrew, reconcile packages,
  and set macOS defaults.

## After a fresh install

Two things `chezmoi apply` deliberately does not do.

**Fill in `~/.zprofile`.** It ships with placeholders and carries the
`CIRCLECI_TOKEN` and `NPM_TOKEN` values, which live in 1Password. chezmoi
creates that file only if it is absent and never overwrites it, so real values
are safe there. The file itself tells you which items to look for.

**Clone the repos on `PATH`.** `.zshenv` adds `~/dev/scripts/bin`,
`~/dev/timhall/skills/bin`, and `~/dev/scratch/project-guide/packages/cli/dist`.
Missing entries are harmless, but the tools won't be there until you clone them.

## What's _not_ synced

No secrets in any form, not even encrypted. The repo is public, so ciphertext
in it would be a permanent bet on the cipher and the key. Credentials are either
generated per machine by their own tool (`gh auth login`) or typed once from
1Password into `~/.zprofile`.

`~/.claude/settings.local.json` is machine-local scratch, auto-filled by
"always allow" prompts, and is chezmoi-ignored on purpose (see
`.chezmoiignore`). Durable, portable grants belong in `settings.json`.

Shell history, Zed's caches, and similar state are ignored too.

## Related

Agent _capabilities_ (skills and the `track` CLI) live in
[timhall/skills](https://github.com/timhall/skills), installed separately via
`npx skills add`. This repo carries the _config_; that repo carries the
_behavior_. Seed `~/.claude/CLAUDE.md` from its `system-instructions.md`.
