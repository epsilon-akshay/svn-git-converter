#!/bin/bash
# argument 1 is the file name where the repos are stored arguemnt 2 is the gitlab repo name
set -e

mkdir migration_dir
cd migration_dir

mkdir svnmigrate
git clone "$2"
filename=../$1
IFS="/" read -ra url <<< "$2"
repo="$2"
local_repo="${url[${#url[@]} - 1]}"

while read -r line; do
IFS="/" read -ra arr <<< "$line"
branch="${arr[${#arr[@]} - 1]}"
#

echo "$branch"
echo "$local_repo"
echo -e "migrating to git for branch and repo $line"

cd "$local_repo"; git checkout -b "$branch"; cd ..
ls -a "$local_repo" | grep -v ".git"  | xargs -I {} rm -rf "{}" || true

svn co "$line" ./svnmigrate/"$branch"

rm -rf ./svnmigrate/"$branch"/.svn || true
cp -a ./svnmigrate/"$branch"/. ./"$local_repo"
#rm -rf ./"$local_repo"/.svn

cd "$local_repo"
git add .
git commit -m "Initial commit from SVN"
cd ..
#push
done <"$filename"
