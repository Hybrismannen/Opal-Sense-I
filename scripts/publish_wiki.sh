#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WIKI="https://github.com/Hybrismannen/Opal-Sense-I.wiki.git"
git ls-remote "$WIKI" HEAD >/dev/null 2>&1 || {
 echo "First create Home in the repository Wiki tab. Use docs/wiki-seed/Home.md."
 exit 3
}
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
git clone "$WIKI" "$TMP/wiki"
for source in "$ROOT"/docs/wiki-seed/*.md; do
 target="$TMP/wiki/$(basename "$source")"
 if [[ ! -f "$target" ]]; then cp "$source" "$target"; fi
done
cd "$TMP/wiki"
git add -- '*.md'
if git diff --cached --quiet; then echo "No new pages"; exit 0; fi
git commit -m "Publish reference Wiki pages"
git push origin HEAD
