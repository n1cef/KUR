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

   
    pkgver=$(grep -E '^[[:space:]]*pkgver[[:space:]]*=' "$pkgfile" \
      | head -n1 \
      | sed -E 's/^[^=]*=[[:space:]]*\"?([^\"]+)\"?/\1/')
    version=${pkgver:-0.0.0}

   
    deps=()
    raw_deps=$(sed -n '/^[[:space:]]*dependencies[[:space:]]*=(/,$p' "$pkgfile" \
               | sed '1d;/^[[:space:]]*)/,$d')
    if [[ -n "$raw_deps" ]]; then
        while IFS= read -r line; do
            
            dep_raw=$(echo "$line" | sed -E "s/^[[:space:]]*'?([^',]+)'?,?$/\1/")
           
            dep=$(echo "$dep_raw" | xargs)
           
            if [[ -n "$dep" ]]; then
                deps+=("$dep")
            fi
        done <<< "$raw_deps"
    fi

   
    if [[ ${#deps[@]} -gt 0 ]]; then
        dep_entries=$(printf '"%s",' "${deps[@]}")
        dep_entries="[${dep_entries%,}]"
    else
        dep_entries="[]"
    fi

    
    checksum=$(sha256sum "$pkgfile" | cut -d' ' -f1)

   
    yq -i -y ".packages[\"$pkgname\"] = {
        category: \"$category\",
        version: \"$version\",
        path: \"${pkgfile#$REPO_ROOT/}\",
        dependencies: $dep_entries,
        checksum: \"sha256:$checksum\"
    }" "$INDEX_FILE"
done
