if($args.Length -eq 0) {
  Add-Type -Assembly System.Windows.Forms
  [System.Windows.Forms.MessageBox]::Show("Usage:\n  extract_containing_files.ps1 [Path to directory]\n\nmade by yuma140902  2021/02/13", "")
  return
}

foreach($arg in $args){
  # 指定されたフォルダの中身をすべて一つ上の階層に移動します。
  $dir = Get-Item $arg
  Move-Item -Path ($dir.FullName + "\*") -Destination $dir.Parent
  if((Get-ChildItem $arg).Length -eq 0) {
    Remove-Item $arg
  }
}
