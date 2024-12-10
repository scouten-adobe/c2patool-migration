#/bin/bash
sed 's/#\([0-9]\{1,3\}\)/contentauth\/c2patool#\1/g' | sed 's/(IGNORE) /chore: /g' | sed 's/\[IGNORE\] /chore: /g' | sed 's/(MINOR) /feat: /g'
