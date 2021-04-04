git pull
git add -N .
git add --all
$commit_msg = (git diff --cached --name-only)
$commit_detail = (git diff --cached --stat)
#git commit -a -m "auto commit: ${commit_msg}" -m "${commit_detail} "
git commit -a -m "auto commit"
git push