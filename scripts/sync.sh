#!/usr/bin/env bash
# Pulls the skill from leafsphp/docs (the source of truth) so this repo never drifts from leafphp.dev/ai.
set -euo pipefail
cd "$(dirname "$0")/.."
BASE="https://raw.githubusercontent.com/leafsphp/docs/v5.x/src/public/ai"
mkdir -p references
curl -fsSL "$BASE/SKILL.md" -o SKILL.md
# The skill installs under the folder name, so the frontmatter name is "leaf".
sed -i '0,/^name: .*/s//name: leaf/' SKILL.md
# References are bundled so agents can read them offline; the URLs in SKILL.md still work too.
for ref in advanced app-config auth cors database dates lite mail-fetch-cache middleware mvc request response routing security utilities views; do
  curl -fsSL "$BASE/references/$ref.md" -o "references/$ref.md"
done
echo "synced $(date -u +%Y-%m-%dT%H:%MZ)"
