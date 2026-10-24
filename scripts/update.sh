#!/usr/bin/env bash
# Point bucket/whoisport.json at the latest whoisport release.
#
# GitHub publishes a sha256 digest for every release asset, so the hash comes straight from
# the API and nothing is downloaded. Needs `gh` (authenticated through GH_TOKEN) and `jq`.
set -euo pipefail

repo=dpologdvinity/whoisport
release=$(gh api "repos/$repo/releases/latest")
tag=$(jq -r .tag_name <<<"$release")
zip="whoisport-$tag-x86_64-pc-windows-msvc.zip"

digest=$(jq -r --arg name "$zip" '.assets[] | select(.name == $name) | .digest // empty' <<<"$release")
[[ $digest == sha256:* ]] || { echo "no sha256 digest for $zip in $tag" >&2; exit 1; }

cd "$(dirname "$0")/.."
jq --arg version "${tag#v}" \
   --arg url "https://github.com/$repo/releases/download/$tag/$zip" \
   --arg hash "${digest#sha256:}" \
   '.version = $version | .architecture."64bit".url = $url | .architecture."64bit".hash = $hash' \
   bucket/whoisport.json > bucket/whoisport.json.new
mv bucket/whoisport.json.new bucket/whoisport.json
echo "bucket/whoisport.json -> $tag"
