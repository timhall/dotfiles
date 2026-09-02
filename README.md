# timhall dotfiles

Your dotfiles are how you personalize your system. These are mine — machine configuration managed with [chezmoi](https://chezmoi.io). Previously a [holman](https://github.com/holman/dotfiles)-style repo with a `script/bootstrap` symlinker.

## Requirements

Xcode Command Line Tools, which can't be scripted — it opens a GUI dialog:

```sh
xcode-select --install
```

Everything else, including Homebrew, is installed by `chezmoi apply`.

## New machine

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply timhall
```

That installs chezmoi, clones this repo to `~/.local/share/chezmoi`, runs the
provisioning scripts, and writes `$HOME`. There is nothing to install first —
`brew install chezmoi` would be circular, since chezmoi is what installs
Homebrew.

To look before it writes, drop `--apply`, then run `chezmoi diff` and
`chezmoi apply -v` separately.

## No templates

There are none, and that's deliberate. `chezmoi re-add` — the one command that
pulls a live edit back into the repo — refuses to touch templates, so every
templated file leaves that fast path permanently and drifts instead.

Where something genuinely has to vary, use the tool's own local-override
mechanism rather than a chezmoi template: git `[include]` and
`includeIf gitdir:`, zsh `source`, `CLAUDE.md` `@import`, Claude's
`settings.local.json`. Routing by directory beats routing by machine, because
it is identical everywhere.

A file earns template status only when a value truly differs between machines —
never merely because a path appears in it.

## Day-to-day

| Task                                                    | Command                                                 |
| ------------------------------------------------------- | ------------------------------------------------------- |
| Preview pending changes                                 | `chezmoi diff`                                          |
| Apply source → `$HOME`                                  | `chezmoi apply -v`                                      |
| Edit a managed file (edits source, then apply)          | `chezmoi edit ~/.claude/settings.json && chezmoi apply` |
| Pull an ad-hoc edit from a live file back into the repo | `chezmoi re-add`                                        |
| Start managing a new file                               | `chezmoi add ~/.somefile`                               |
| Make a file a template                                  | `chezmoi chattr +template ~/.somefile`                  |

The source lives at `~/.local/share/chezmoi`, chezmoi's default. A symlink at
`~/dev/timhall/dotfiles` points to it, so it sits alongside everything else in
`~/dev` for editing — same directory, two paths. It is a normal git repo; commit
and push as usual, or use `chezmoi git -- <args>` / `chezmoi cd`.

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
