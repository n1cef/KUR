#!/bin/bash
set -xe

REPO_ROOT=$(git rev-parse --show-toplevel)
INDEX_FILE="$REPO_ROOT/pkgindex.kraken"

echo "Building package index..."
echo "format: 1.2" > "$INDEX_FILE"
echo "last_updated: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$INDEX_FILE"
echo "packages:" >> "$INDEX_FILE"

find pkgbuilds -name pkgbuild.kraken | while read -r pkgfile; do
    
    dir=$(dirname "$pkgfile")
    pkgname=$(basename "$dir")
    category=$(basename "$(dirname "$dir")")

    #  extract version
    pkgver=$(grep -E '^[[:space:]]*pkgver[[:space:]]*=' "$pkgfile" \
      | head -n1 \
      | sed -E 's/^[^=]*=[[:space:]]*"?([^"\r\n]+)"?/\1/')
    version=${pkgver:-0.0.0}

    # extract dependencies array
    deps=()
    raw_deps=$(sed -n '/^[[:space:]]*dependencies[[:space:]]*=(/,$p' "$pkgfile" \
               | sed '1d;/^[[:space:]]*)/,$d')
    if [[ -n "$raw_deps" ]]; then
        while IFS= read -r line; do
            dep_raw=$(echo "$line" | sed -E "s/^[[:space:]]*'?([^',]+)'?,?$/\1/")
            dep=$(echo "$dep_raw" | xargs)
            [[ -n "$dep" ]] && deps+=("$dep")
        done <<< "$raw_deps"
    fi

    # format deps as YAML list
    if (( ${#deps[@]} > 0 )); then
        dep_entries=$(printf '"%s",' "${deps[@]}")
        dep_entries="[${dep_entries%,}]"
    else
        dep_entries="[]"
    fi

    #  checksum for the pkgbuild.kraken file itself
    checksum=$(sha256sum "$pkgfile" | cut -d' ' -f1)

    # 4) build yaml object
    relative_path="${pkgfile#$REPO_ROOT/}"
    expr=".packages[\"$pkgname\"] = {\"category\":\"$category\",\"version\":\"$version\",\"path\":\"$relative_path\",\"dependencies\":$dep_entries,\"checksum\":\"sha256:$checksum\"}"

    # 5) update pkginde.kraken file 
    yq eval -i "$expr" "$INDEX_FILE"
done
