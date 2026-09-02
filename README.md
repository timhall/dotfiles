# timhall dotfiles

Your dotfiles are how you personalize your system. These are mine — machine configuration managed with [chezmoi](https://chezmoi.io). Previously a [holman](https://github.com/holman/dotfiles)-style repo with a `script/bootstrap` symlinker.

## Requirements

```sh
brew install chezmoi
```

## New machine

The source directory is pinned to `~/dev/timhall/dotfiles` (set in
`.chezmoi.toml.tmpl`), so clone it there:

```sh
git clone https://github.com/timhall/dotfiles.git ~/dev/timhall/dotfiles
chezmoi init --source ~/dev/timhall/dotfiles
chezmoi diff            # preview what would change in $HOME
chezmoi apply -v        # write it
```

`init` prompts for the machine-specific paths below — press Enter to accept the
defaults. After the first `init`, chezmoi remembers the source dir, so plain
`chezmoi` commands work from anywhere.

## Machine-specific values

Templated via chezmoi's data, prompted on `init`, stored in
`~/.config/chezmoi/chezmoi.toml`:

| Variable | Prompt           | Default             |
| -------- | ---------------- | ------------------- |
| `vault`  | Notes vault path | `~/Documents/notes` |
| `todo`   | Todo file path   | `~/todo.md`         |

Referenced in templates as `{{ .vault }}` / `{{ .todo }}`. To
change them later, re-run `chezmoi init` (re-prompts) or edit
`~/.config/chezmoi/chezmoi.toml` directly.

## Day-to-day

| Task                                                    | Command                                                 |
| ------------------------------------------------------- | ------------------------------------------------------- |
| Preview pending changes                                 | `chezmoi diff`                                          |
| Apply source → `$HOME`                                  | `chezmoi apply -v`                                      |
| Edit a managed file (edits source, then apply)          | `chezmoi edit ~/.claude/settings.json && chezmoi apply` |
| Pull an ad-hoc edit from a live file back into the repo | `chezmoi re-add`                                        |
| Start managing a new file                               | `chezmoi add ~/.somefile`                               |
| Make a file a template                                  | `chezmoi chattr +template ~/.somefile`                  |

The source is a normal git repo — `cd ~/dev/timhall/dotfiles` and commit/push as
usual (or `chezmoi git -- <args>`).

## What's here

- **`dot_claude/`** → `~/.claude/` — Claude Code global config: `CLAUDE.md`
  (templated with `vault`/`todo`) and `settings.json` (curated permission
  allowlist).

## What's _not_ synced

`~/.claude/settings.local.json` is machine-local scratch — auto-filled by
"always allow" prompts — and is chezmoi-ignored on purpose (see
`.chezmoiignore`). Durable, portable grants belong in `settings.json`.

## Migration status

Being converted from holman to chezmoi, one topic at a time. Not yet converted,
and chezmoi-ignored until they are:

- `bin/`, `git/`, `homebrew/`, `macos/`, `script/`

Remove each from `.chezmoiignore` as it's ported to chezmoi's source format. The
live, still-bootstrapped holman checkout remains at `~/.dotfiles` until the
cutover is complete.

## Related

Agent _capabilities_ — skills and the `track` CLI — live in
[timhall/skills](https://github.com/timhall/skills), installed separately via
`npx skills add`. This repo carries the _config_; that repo carries the
_behavior_. Seed `~/.claude/CLAUDE.md` from its `system-instructions.md`.
