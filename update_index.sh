#!/bin/bash
set -xe

REPO_ROOT=$(git rev-parse --show-toplevel)
INDEX_FILE="$REPO_ROOT/pkgindex.kraken"

echo "Building package index..."
echo "format: 1.2" > "$INDEX_FILE"
echo "last_updated: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "$INDEX_FILE"
echo "packages:" >> "$INDEX_FILE"

find pkgbuilds -name pkgbuild.kraken | while read -r pkgfile; do
    # derive names and categories
    dir=$(dirname "$pkgfile")
    pkgname=$(basename "$dir")
    category=$(basename "$(dirname "$dir")")

    # 1) extract version from pkgver=
    pkgver=$(grep -E '^[[:space:]]*pkgver[[:space:]]*=' "$pkgfile" \
      | head -n1 \
      | sed -E 's/^[^=]*=[[:space:]]*\"?([^\"]+)\"?/\1/')
    version=${pkgver:-0.0.0}

    # 2) extract dependencies (multiline array)
    deps=()
    raw_deps=$(sed -n '/^[[:space:]]*dependencies[[:space:]]*=(/,$p' "$pkgfile" \
               | sed '1d;/^[[:space:]]*)/,$d')
    if [[ -n "$raw_deps" ]]; then
        while IFS= read -r line; do
            # strip whitespace, quotes, commas
            dep_raw=$(echo "$line" | sed -E "s/^[[:space:]]*'?([^',]+)'?,?$/\1/")
            # trim whitespace (removes tabs/spaces)
            dep=$(echo "$dep_raw" | xargs)
            # only add non-empty entries
            if [[ -n "$dep" ]]; then
                deps+=("$dep")
            fi
        done <<< "$raw_deps"
    fi

    # format deps as YAML list
    if [[ ${#deps[@]} -gt 0 ]]; then
        dep_entries=$(printf '"%s",' "${deps[@]}")
        dep_entries="[${dep_entries%,}]"
    else
        dep_entries="[]"
    fi

    # 3) compute SHA-256 checksum
    checksum=$(sha256sum "$pkgfile" | cut -d' ' -f1)

    # 4) write into the index
    yq -i -y ".packages[\"$pkgname\"] = {
        category: \"$category\",
        version: \"$version\",
        path: \"${pkgfile#$REPO_ROOT/}\",
        dependencies: $dep_entries,
        checksum: \"sha256:$checksum\"
    }" "$INDEX_FILE"
done
