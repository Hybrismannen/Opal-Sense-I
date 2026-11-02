#!/usr/bin/env bash
set -euo pipefail
OWNER=Hybrismannen
REPO=Opal-Sense-I
TITLE="The Opal — Editorial & Archive Operations"
command -v gh >/dev/null && command -v jq >/dev/null || { echo "Install gh and jq first"; exit 2; }
gh auth status >/dev/null || { echo "Authenticate with gh auth login"; exit 2; }
gh project list --owner "$OWNER" --format json >/dev/null || { echo "Run: gh auth refresh -s project"; exit 3; }
number="$(gh project list --owner "$OWNER" --format json | jq -r --arg title "$TITLE" '.projects[]? | select(.title==$title) | .number' | head -n 1)"
if [[ -z "$number" ]]; then
 number="$(gh project create --owner "$OWNER" --title "$TITLE" --format json | jq -r '.number')"
fi
[[ "$number" =~ ^[0-9]+$ ]] || exit 4
gh project link "$number" --owner "$OWNER" --repo "$OWNER/$REPO" >/dev/null 2>&1 || true
gh project edit "$number" --owner "$OWNER" --description "Fashion research, editorial production and archive governance" >/dev/null
add_field() {
 local name="$1" type="$2" options="$3"
 if gh project field-list "$number" --owner "$OWNER" --format json | jq -e --arg name "$name" '.fields[]? | select(.name==$name)' >/dev/null; then return; fi
 if [[ "$type" == SINGLE_SELECT ]]; then
  gh project field-create "$number" --owner "$OWNER" --name "$name" --data-type SINGLE_SELECT --single-select-options "$options" >/dev/null
 else
  gh project field-create "$number" --owner "$OWNER" --name "$name" --data-type "$type" >/dev/null
 fi
}
add_field "Editorial Phase" SINGLE_SELECT "Backlog,Sourcing,Researching,Fact-check,Drafting,Editing,Published"
add_field "Desk" SINGLE_SELECT "Culture & Identity,Garments & Traditions,Designers & Houses,Objects & Engineering,Global Observer,Reading Room,Platform"
add_field "Priority" SINGLE_SELECT "P0,P1,P2,P3"
add_field "Evidence" SINGLE_SELECT "Unverified,Partially sourced,Source verified,Reviewed"
add_field "Next Review" DATE ""
existing="$(gh project item-list "$number" --owner "$OWNER" --format json --limit 1000 | jq -r '.items[]? | .content.url // empty')"
while IFS= read -r link; do
 [[ -n "$link" ]] || continue
 if ! grep -Fxq "$link" <<< "$existing"; then gh project item-add "$number" --owner "$OWNER" --url "$link" >/dev/null; fi
done < <(gh issue list --repo "$OWNER/$REPO" --state all --limit 200 --json url --jq '.[].url')
echo "Done: https://github.com/users/$OWNER/projects/$number"
