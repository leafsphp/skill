# Leaf skill

Leaf 5 for coding agents. Install this once and Claude Code, Codex, Gemini CLI or Cursor builds with Leaf the way a Leaf developer would: the right entry point, `leaf install auth` instead of hand-rolled JWT, `db()` and `auth()` instead of a pile of boilerplate, and the real Leaf 5 API rather than a guess from 2021 training data.

It is the same skill that lives at [leafphp.dev/ai/SKILL.md](https://leafphp.dev/ai/SKILL.md), packaged as a repo so it installs with one command and stays in sync automatically.

## Install

With the [skills](https://skills.sh) CLI (works for Claude Code, Codex, Cursor, Gemini CLI and most others):

```sh
npx skills add leafsphp/skill
```

Or copy the folder where your agent looks for skills:

| Agent | Personal | Project |
| --- | --- | --- |
| Claude Code | `~/.claude/skills/leaf/` | `.claude/skills/leaf/` |
| Codex | `~/.codex/skills/leaf/` | `.codex/skills/leaf/` |
| Gemini CLI | `~/.gemini/skills/leaf/` | `.gemini/skills/leaf/` |
| Cursor | `~/.cursor/skills/leaf/` | `.cursor/skills/leaf/` |

```sh
git clone https://github.com/leafsphp/skill ~/.claude/skills/leaf
```

Anything else: tell your assistant to fetch `https://leafphp.dev/ai/SKILL.md` before it starts.

## What is in here

- `SKILL.md`: when to trigger, Leaf 5 entry points, CLI, conventions, and the rules the agent follows.
- `references/`: one file per area (routing, auth, database, request, response, middleware, MVC, views, mail, security and more). The agent reads these on demand instead of carrying all of Leaf in context.
- `examples/auth-api`: a working register, login and protected route in one file. CI runs it on every push, so the thing we show agents actually runs.

## How it stays current

A GitHub Action pulls `SKILL.md` and the references from [leafsphp/docs](https://github.com/leafsphp/docs) every morning and commits if anything changed. The docs are the source of truth; this repo is the distribution.

## Try it

```sh
cd examples/auth-api && composer install && bash smoke.sh
```

Then open your agent with the skill installed and ask for the same thing in plain words. Compare.

## See also

- [AI in Leaf](https://leafphp.dev/docs/ai) for the full story: llms.txt, the skill and `.leaf/CONTEXT.md`.
- [llms.txt](https://leafphp.dev/llms.txt), the compressed reference for models.
- [kata-skill](https://github.com/leafsphp/kata-skill), the copy linter skill we use on everything Leaf writes.

MIT, like the rest of Leaf.
