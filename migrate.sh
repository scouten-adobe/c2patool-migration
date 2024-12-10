#!/bin/bash

# Remove any previous copy of the repo.
rm -rf migration

# Obtain a local copy of the repo.
git clone https://github.com/contentauth/c2patool.git migration




# Bot-created branches (i.e. dependabot) will be discarded. (Reason: GitHub will automatically re-create those PRs after migration.)
# The root of the c2patool repo will be moved down a level and placed in a folder named cli.
# The GitHub workflows will be exempted from this and will be separately merged into c2pa-rs's .github folder.
# All release tags in the c2patool repo will be renamed from "v0.9.11" (as an example) to "c2patool-v0.9.11" to match the tag format used by release-plz.
# Fix broken links in c2patool's CHANGELOG.md which (incorrectly) point to c2pa-rs repo PRs.
# Commit comments that reference issues in the c2patool repo will be rewritten to point to PRs and issues in the c2patool repo (i.e. the #xxx syntax will be rewritten to say content-auth/c2patool#xxx so that the existing discussion remains).
