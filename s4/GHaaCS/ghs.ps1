Param(
  [parameter(mandatory)][ValidateSet("status", "commit")][String]$operation,
  [String]$target_repositry = ""
)

$repos_dir = Get-Item "~\repos"
$auto_commit_repositries = @("local-settings", "school")
$repositries = Get-ChildItem -Directory $repos_dir

function auto_commit {
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
}


if(-Not([string]::IsNullorEmpty($target_repositry))) {
  $auto_commit_repositries = @(Join-Path $repos_dir $target_repositry)
  $repositries = @(Join-Path $repos_dir $target_repositry)
}

if($operation -eq "status"){
  
  foreach($repo in $repositries) {
    $name = Split-Path -Leaf $repo
    Write-Host "■ ${name} ----------------------"
    Push-Location $repo
    git status
    Pop-Location
    Write-Host "---------------------------------------"
  }
}
elseif($operation -eq "commit"){
  foreach($repo in $auto_commit_repositries) {
    $name = $repo
    $repo = Join-Path $repos_dir $name
    Write-Host "■ ${name} ----------------------"
    Push-Location $repo
    auto_commit
    Pop-Location
    Write-Host "---------------------------------------"
  }
}
