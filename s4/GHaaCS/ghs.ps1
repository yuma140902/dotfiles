Param(
  [parameter(mandatory)][ValidateSet("status", "commit")][String]$operation,
  [String]$target_repositry = ""
)


$repos_dir = Get-Item "~\repos"
$auto_commit_repositries = @("local-settings", "school")
$repositries = Get-ChildItem -Directory $repos_dir
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
    Push-Location $repo
    &..\auto_commit.ps1
    Pop-Location
  }
}