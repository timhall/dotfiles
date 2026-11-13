#!/bin/bash
# Rewrite any Co-Authored-By trailer in a git commit command to attribution.commit.
in=$(cat)
cmd=$(printf '%s' "$in" | jq -r '.tool_input.command // ""')
printf '%s' "$cmd" | grep -qEi 'git[^|;&]*commit' || exit 0
printf '%s' "$cmd" | grep -qi 'co-authored-by' || exit 0
attr=$(jq -r '.attribution.commit // empty' ~/.claude/settings.json)
[ -n "$attr" ] || exit 0
printf '%s' "$in" | jq --arg a "$attr" '
  .tool_input.command |= gsub("(?i)Co-Authored-By:[^\\n\"\\x27)]*"; $a)
  | {hookSpecificOutput: {hookEventName: "PreToolUse", permissionDecision: "allow", updatedInput: .tool_input}}'
