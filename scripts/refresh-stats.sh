#!/usr/bin/env bash
# Re-pull every listed repo's stats from the GitHub API.
# Requires: gh (https://cli.github.com/), authenticated via `gh auth login`.
# Writes data/stats.tsv and prints a summary.
set -euo pipefail

cd "$(dirname "$0")/.."
command -v gh >/dev/null || { echo "gh not found. Install: https://cli.github.com/"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "Not authenticated. Run: gh auth login"; exit 1; }

out="data/stats.tsv"
printf "repo\tstars\tforks\tlicense\tpushed\tcreated\tlang\n" > "$out"

while IFS= read -r repo; do
  [ -z "$repo" ] && continue
  case "$repo" in \#*) continue ;; esac
  if ! gh api "repos/$repo" --jq \
    '[.full_name,(.stargazers_count|tostring),(.forks_count|tostring),(.license.spdx_id // "none"),(.pushed_at|.[0:10]),(.created_at|.[0:10]),(.language // "-")]|@tsv' >> "$out" 2>/dev/null
  then
    printf "%s\tGONE_OR_RENAMED\n" "$repo" >> "$out"
    echo "WARN: could not fetch $repo (deleted, renamed, or private)"
  fi
done < scripts/repos.txt

echo
echo "Refreshed $(( $(wc -l < "$out") - 1 )) repos -> $out"
echo "Snapshot date: $(date -u +%Y-%m-%d) UTC"
echo
column -t -s "$(printf '\t')" "$out"
echo
echo "Now diff these against README.md and update any that drifted."
echo "Reminder: also update the 'pulled ... on' date at the top of README.md."
