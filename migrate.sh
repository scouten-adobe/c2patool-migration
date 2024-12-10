#!/bin/bash
set -e

# Remove any previous copy of the repo.
rm -rf migration

# Obtain a local copy of the repo.
git clone https://github.com/contentauth/c2patool.git migration

# Start working in cloned repo dir.
cd migration

# Pull all other branches.
git fetch --all

# Set up local branches to track remote branches.
for branch in $(git branch -r | grep -v '\->'); do
    if [ $branch != "origin/main" ]; then
        git branch --track ${branch#origin/} $branch
    fi
done

# Disconnect from GitHub remote to prevent inadventent push to old repo.
git remote rm origin

# Bot-created branches (i.e. dependabot) will be discarded. (Reason: GitHub will automatically re-create those PRs after migration.)
git branch -D `git branch --list 'dependabot/*'`

# Delete nightly branch.
git branch -D nightly

# Delete some hand-selected stale branches.
git branch -D do_not_train # last updated 2023-07-14
git branch -D dyross/CAI-5197 # last updated 2023-12-20
git branch -D external_manifest # last updated 2022-08-17
git branch -D fmt_fix # @gpeacock last updated 2024-08-14
git branch -D hack_batch # last updated 2022-12-08
git branch -D hack_tree_dump # last updated 2022-12-12
git branch -D per-commit-builds # last updated 2023-05-17
git branch -D update-cargo-deny # @scouten last updated 2024-03-28

# The root of the c2patool repo will be moved down a level and placed in a folder named cli.
# The GitHub workflows will be exempted from this and will be separately merged into c2pa-rs's .github folder.
FILTER_BRANCH_SQUELCH_WARNING=1 git filter-branch \
    --tree-filter /Users/scouten/Projects/c2patool-migration/tree-filter.sh \
    --prune-empty \
    -- --all

# View resulting repo in SourceTree.
open -a /Applications/SourceTree.app/ .

# All release tags in the c2patool repo will be renamed from "v0.9.11" (as an example) to "c2patool-v0.9.11" to match the tag format used by release-plz.
# Fix broken links in c2patool's CHANGELOG.md which (incorrectly) point to c2pa-rs repo PRs.
# Commit comments that reference issues in the c2patool repo will be rewritten to point to PRs and issues in the c2patool repo (i.e. the #xxx syntax will be rewritten to say content-auth/c2patool#xxx so that the existing discussion remains).
echo "Not done yet"
exit 1
