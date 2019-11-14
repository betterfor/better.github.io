#!/bin/bash
set -ev

# get clone master
git clone https://${GITHUB_REF} ./blog

cd ./blog && git checkout hugo
# generate public file
../hugo

# add git config
git config user.name "betterfor"
git config user.email "1697606384@qq.com"

# mv generate docs
cp ./public ../
cd ./blog && git checkout master

echo "will to delete template files"
# delete other files
rm -rf archetypes content data layouts resources static themes .travis.yml config.toml publish-to-pages.sh
mv ../public/* ./


git add .
git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"

# push to master
git push --force --quiet "https://${TOKEN_GITHUB}@${GITHUB_REF}" master:master