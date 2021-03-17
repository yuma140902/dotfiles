# GIFファイルをMP4に変換します
# 2020/12/25
# yuma140902

$logFile = (Join-Path $PSScriptRoot "gif2mov.log")
$errFile = (Join-Path $PSScriptRoot "gif2mov-err.log")


function Convert-GifToMp4 {
  param (
    [String]$dir,
    [String]$fileBaseName
  )
  $inputFile = (Join-Path $dir ($fileBaseName + ".gif"))
  $outputFile = (Join-Path $dir ($fileBaseName + ".mp4"))
  #Write-LogToFile $inputFile
  #Write-LogToFile $outputFile
  $ffmpegArgs = '-i ' + '"' + $inputFile + '"' + '  -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" ' + '"' + $outputFile + '"'
  Start-Process -FilePath "ffmpeg.exe" -ArgumentList $ffmpegArgs -Wait    # -RedirectStandardError $errFile -RedirectStandardOutput $logFile
}

function Write-LogToFile {
  param (
    [Object]$value
  )
  Add-Content $logFile -Value $value
}

function Write-ErrorToFile {
  param (
    [Object]$value
  )
  Add-Content $errFile -Value $value
}

New-Item $logFile -ItemType File -Force
New-Item $errFile -ItemType File -Force

# ディレクトリの場合は中身を変換
if(Test-Path $args[0] -PathType Container){
  $gifDir = $args[0]
  $gifFiles = Get-ChildItem -Filter "*.gif" $gifDir
  foreach($gifFile in $gifFiles){
    $fileInfo = Get-ChildItem -Path (Resolve-Path $gifFile)
    Convert-GifToMp4 $fileInfo.Directory $fileInfo.BaseName
  }
  exit
}

# ファイルの場合
foreach($gifFile in $args){
  if(!(Test-Path $gifFile -PathType Leaf)){
    Write-Error "エラー: ファイルが見つかりません"
    Write-Error $gifFile
    continue
  }
  $fileInfo = Get-ChildItem -Path (Resolve-Path $gifFile)
  Convert-GifToMp4 $fileInfo.Directory $fileInfo.BaseName
}
