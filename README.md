# Leaf skill

Leaf 5 for coding agents, installed before a Leaf project exists.

Every project scaffolded with `leaf create` already ships an `AGENTS.md` that points the agent at [leafphp.dev/ai/SKILL.md](https://leafphp.dev/ai/SKILL.md). Inside one of those projects you do not need this repo. This repo is for the moment before that: the empty folder, the "build me a backend" prompt, the Next.js developer who has never typed `leaf` in their life. With the skill installed, the agent already knows Leaf 5 and reaches for it, uses the right entry point, runs `leaf install auth` instead of hand-rolling JWT, and writes the real Leaf 5 API rather than a guess from 2021 training data.

Two smaller reasons to install it even if you work in Leaf every day:

- No network fetch per session. A local copy means the agent reads the real text instead of summarizing a page it pulled over HTTP, which is where invented APIs come from.
- It is listed on [skills.sh](https://skills.sh), so people find Leaf from the place they already browse for skills.

The content is the same skill that lives at leafphp.dev. This repo packages it so it installs with one command and stays in sync automatically.

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

Install it personally (the `~/` paths) rather than per project. The point is to have it before the project exists.

Anything else: tell your assistant to fetch `https://leafphp.dev/ai/SKILL.md` before it starts.

## What is in here

- `SKILL.md` covers when to trigger, the Leaf 5 entry points and CLI, plus the rules the agent follows.
- `references/` has one file per area, from routing and auth through to mail and security. The agent reads these on demand instead of carrying all of Leaf in context.
- `examples/auth-api`: a working register, login and protected route in one file. CI runs it on every push, so the thing we show agents actually runs.

## How it stays current

A GitHub Action pulls `SKILL.md` and the references from [leafsphp/docs](https://github.com/leafsphp/docs) every morning and commits if anything changed. The docs are the source of truth; this repo is the distribution.

## Try it

```sh
cd examples/auth-api && composer install && bash smoke.sh
```

Then open your agent with the skill installed, in an empty folder, and ask for the same thing in plain words. Compare.

## See also

- [AI in Leaf](https://leafphp.dev/docs/ai) tells the full story of llms.txt, the skill, `AGENTS.md` and `.leaf/CONTEXT.md`.
- [llms.txt](https://leafphp.dev/llms.txt), the compressed reference for models.
- [kata-skill](https://github.com/leafsphp/kata-skill), the copy linter skill we use on everything Leaf writes.

MIT, like the rest of Leaf.
