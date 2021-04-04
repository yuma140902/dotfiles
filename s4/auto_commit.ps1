git pull
git add -N .
git add --all
$commit_msg = (git diff --name-only)
$commit_detail = (git diff --stat)
git commit -a -m "auto commit ${commit_msg}" -m "${commit_detail}\n"
git push