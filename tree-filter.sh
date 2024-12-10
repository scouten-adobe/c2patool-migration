#!/bin/bash
mkdir cli

# The GitHub workflows will be exempted from this and will be separately merged into c2pa-rs's .github folder.
GLOBIGNORE="cli:.github:Cargo.lock"
mv * cli

# Fix broken links in c2patool's CHANGELOG.md which (incorrectly) point to c2pa-rs repo PRs.
if [ -f "cli/CHANGELOG.md" ]; then
    sed 's/#\([0-9]\{1,3\}\)/contentauth\/c2patool#\1/g' cli/CHANGELOG.md > cli/NEW-CHANGELOG.md
    sed 's/github\.com\/contentauth\/c2pa\-rs\/pull/github\.com\/contentauth\/c2patool\/pull/g' cli/NEW-CHANGELOG.md > cli/CHANGELOG.md
    rm cli/NEW-CHANGELOG.md
fi
