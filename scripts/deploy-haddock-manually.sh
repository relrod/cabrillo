#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
cd "$cwd/.."
f=`mktemp -d`
git clone "git@github.com:relrod/cabrillo.git" "$f/cabrillo.git"
cabal haddock
pushd "$f/cabrillo.git"
  git checkout gh-pages && git rm -rf *
popd
mv dist/doc/html/cabrillo/* "$f/cabrillo.git/"
pushd "$f/cabrillo.git"
  git add -A
  git commit -m "Manual docs deploy."
  git push origin gh-pages
popd
rm -rf "$f"

if [ $? == 0 ]; then
  echo "*** Done: http://relrod.github.io/cabrillo/"
  exit 0
else
  echo "*** ERROR!!! Fix the above and try again."
  exit 1
fi
