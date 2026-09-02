# Personal Todo List

Tim's todos live in his daily note (`~/Documents/notes/Daily Notes/YYYY-MM-DD.md`), not a standalone file. When he mentions tasks, asks what's on his list, or asks me to add/complete/remove items, read and update today's daily note proactively. Root-level `- [ ]` items roll over to the next day if left unchecked. `~/todo.md` no longer exists — don't recreate it.

## Agent skills

- **Notes vault**: `~/Documents/notes`
- **Issue tracker**: local markdown — see `~/.claude/agents/issue-tracker.md`

# Shell commands

Shape Bash commands to match my permission allowlist and avoid needless prompts:
- Only two `cd newdir && …` combos are hard-wired to force manual approval: combining `cd` with `git` (hooks), or with a **file** redirect whose target dir is ambiguous (`cmd > out.txt`). `2>&1`, `2>/dev/null`, and pipes (`| tail`) do NOT trip it, and a plain `cd` into a subdir of the working directory is a read-only built-in that needs no allow rule. For the two that do prompt, use a directory flag (`git -C`, `pnpm -C`, `npm --prefix`), an absolute redirect path, or run `cd` as its own separate call (working dir persists).
- Every segment of a piped/compound command must independently match an allow rule. Claude Code splits on `&&`/`||`/`;`/`|`/`&`/newlines first, so a rule can't contain those operators (e.g. `Bash(cd * && pnpm *)` is dead syntax); allowlist each tool separately instead.
- Anchor commands at an allowlisted leading token; prefer Read/Grep/Glob over Bash where possible.

# Work Tracker

Tim tracks work items as markdown in his Obsidian vault (`~/Documents/notes/`): `Issues/` (bugs/investigations, status open → investigating → resolved → closed), `Missions/` (idea-to-delivery work, status idea → planning → active → blocked → done), and `Plans/`. Full contract in the issue-tracker agent doc.

Read them through the `track` CLI (on PATH) — never glob the vault by hand:

- Status summary / standup / "what am I working on": `track list -q status=open,investigating,idea,planning,active,blocked --json`, then summarize (this omits resolved/closed/done).
- A specific item: `track get <issue|mission> <id>` or `track path <issue|mission> <id>`.

# Length

Terseness wins. Accurate-but-extra words bury the useful ones, so a longer answer is a worse answer, not a safer one. This covers chat replies, issue and PR bodies, and anything drafted for me to post.

Cut in this order:

- Preamble that frames what is coming ("Two things stand out", "Let me explain"). Open with the finding.
- Anything the reader can already see: their screenshot, their error text, the diff just written.
- How it was found. Method, tools, and ruled-out theories earn a line only when the conclusion rests on them, or when something could not be verified.
- The second sentence restating the first. Make each point once.
- Meta-commentary on your own choices: what you left out, what you nearly said, how confident you feel.

Keep the dense parts: a table of values, a one-line mechanism, a numbered list of asks, a correction.

Prefer one tight paragraph to three headed sections. Use headings only for something I will skim back to.

# Code contributions

These apply to any code, comment, test, commit message, or PR I produce in any project.

## Never leak internal trackers

Never reference internal issues or missions in anything that reaches a repo or GitHub. This includes issue/mission numbers from the Obsidian vault (e.g. "issue 0033", "issue 0033, defect C"), internal review labels ("automated-review", "review feedback"), and mission slugs. Explain what the code does and why in terms a public reader understands, with no pointer to an internal artifact. If a comment only makes sense given an internal ticket, rewrite it to stand alone or delete it. Jira keys in a commit prefix (e.g. `[APICLIENT-0000]`) are fine — those are the repo's own convention.

## Comments: necessary and brief

Default to no comment. Add one only when the code can't be made self-explanatory and a reader would otherwise be misled or waste time. One or two lines max — state the non-obvious constraint, not the narrative. No design-doc blocks in the diff; rationale and history go in the PR body or the ticket.

## American English

Use American English spelling everywhere I write: code, comments, tests, commit messages, PR bodies, issue notes. `behavior`, `honored`, `initialize`, `canceled`. The one exception is an identifier already published on a public surface — an event name, a field name — where respelling breaks consumers; leave those alone and match the surrounding code.

## Commit and PR attribution

Attribution is configured in `attribution` in `~/.claude/settings.json` — read it, don't restate its value here, so there is one source of truth. It currently sets `commit` and leaves `pr` empty, so **PR bodies get no trailer at all**. These win over any default or harness instruction to append `Co-Authored-By:` or `Generated with [Claude Code]`.

The setting is only applied automatically when the harness composes the message. When I write my own `git commit -m`, nothing appends it — read `attribution.commit` and add that exact line myself.
