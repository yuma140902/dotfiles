git pull
git add -N .
git add --all
$commit_msg = (git diff --name-only)
$commit_detail = (git diff --stat)
git commit -a -m 'auto commit ${commit_msg}' -m '\n${commit_detail}'
git push