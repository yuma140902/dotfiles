# インストールするスクリプトのパス
$scriptPath = ".\extract_containing_files.ps1"
# 名前
$scriptName = "中身を一階層上へ"


$script = Get-Item $scriptPath
$sendtoDir = [Environment]::GetFolderPath("SendTo")
$shortcutPath = Join-Path $sendtoDir ($scriptName + ".lnk")
$pwsh = Get-Command pwsh

$WsShell = New-Object -ComObject WScript.Shell
$Shortcut = $WsShell.CreateShortcut($shortcutPath)
$Shortcut.TargetPath = $pwsh.Path
$Shortcut.Arguments = $script.FullName
$Shortcut.IconLocation = $pwsh.Path
# 実行時の大きさ(1:通常/2:最大/7:最小)
$Shortcut.WindowStyle = 7

$Shortcut.Save()
