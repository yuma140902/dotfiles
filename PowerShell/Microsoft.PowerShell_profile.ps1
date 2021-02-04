function ShowSystemInfo {explorer ms-settings:about}
Set-Alias uname ShowSystemInfo

function MakeSymLink {
  Param([string]$LinkName, [string]$TargetPath)
  if($LinkName -eq "" -or $LinkName -eq "--help"){
    Write-Output "Usage:"
    Write-Output "mklink [link name] [target path]"
    Write-Output "  alias by yuma140902"
    return
  }
  sudo New-Item -Path $LinkName -Value $TargetPath -ItemType SymbolicLink
}
Set-Alias mklink MakeSymLink

# zsh-likeなタブ補完. タブを押すと入力済みのものから補完. 複数候補がある場合は使用可能なものの一覧を表示しつつ補完
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# posh-git (gitコマンドのタブ補完) を有効化
Import-Module posh-git

# 入力ミス時のビープ音を消す
Set-PSReadlineOption -BellStyle None

# enable StarShip
Invoke-Expression (&starship init powershell)
