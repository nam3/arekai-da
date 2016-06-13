#!/bin/sh
# update JumpeiArashi/dominator module dependency

SHA1=$1
sed -i "s/\(dominator\"\:\ [a-zA-Z0-9:@+\"\/.-]*#\)[a-zA-Z0-9.]*/\1${SHA1}/g" package.json
git add package.json
git commit --message "update dominator dependency to $SHA1" \
  --message "See https://github.com/JumpeiArashi/dominator/commit/${SHA1} for detail"
git push origin master
