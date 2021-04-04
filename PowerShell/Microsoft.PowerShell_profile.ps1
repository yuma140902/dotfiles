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

function CargoCompete {
  cargo compete $args
}
Set-Alias atc CargoCompete

# zsh-like�ȃ^�u�⊮. �^�u�������Ɠ��͍ς݂̂��̂���⊮. ������₪����ꍇ�͎g�p�\�Ȃ��̂̈ꗗ��\�����⊮
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# posh-git (git�R�}���h�̃^�u�⊮) ��L����
#Import-Module posh-git

# ���̓~�X���̃r�[�v��������
Set-PSReadlineOption -BellStyle None

# enable StarShip
Invoke-Expression (&starship init powershell)
