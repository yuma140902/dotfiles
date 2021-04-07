git pull
git add -N .
git add --all
$tmp_file = New-TemporaryFile
$commit_msg = (git diff --cached --name-only)
$commit_detail = (git diff --cached --stat)
Set-Content -Encoding sjis -Path $tmp_file -Value $commit_msg
$commit_msg = Get-Content $tmp_file
Set-Content -Encoding sjis -Path $tmp_file -Value $commit_detail
$commit_detail = Get-Content $tmp_file
git commit -a -m "auto commit: ${commit_msg}" -m "${commit_detail} "
Remove-Item -Path $tmp_file
git push
