param(
    [string]$ToolkitPath = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

$ToolkitPath = (Resolve-Path -Path $ToolkitPath).Path
$TemplatePath = Join-Path -Path $ToolkitPath -ChildPath 'assets/template/index.html'

if (-not (Test-Path -Path $TemplatePath -PathType Leaf)) {
    throw "Template file not found: $TemplatePath"
}

# Look for JSON files in the toolkit root (non-recursive).
$JsonFiles = Get-ChildItem -Path $ToolkitPath -Filter '*.json' -File

if ($JsonFiles.Count -eq 0) {
    throw "No JSON files found in toolkit root: $ToolkitPath"
}

if ($JsonFiles.Count -gt 1) {
    throw "Multiple JSON files found in toolkit root. Keep one JSON file or update script to choose one explicitly. Found: $($JsonFiles.Name -join ', ')"
}

$JsonFile = $JsonFiles[0]
$FolderName = [System.IO.Path]::GetFileNameWithoutExtension($JsonFile.Name)
$TargetFolder = Join-Path -Path $ToolkitPath -ChildPath $FolderName

if (-not (Test-Path -Path $TargetFolder -PathType Container)) {
    New-Item -Path $TargetFolder -ItemType Directory | Out-Null
}

$TargetIndexPath = Join-Path -Path $TargetFolder -ChildPath 'index.html'
Copy-Item -Path $TemplatePath -Destination $TargetIndexPath -Force

$TargetSwaggerPath = Join-Path -Path $TargetFolder -ChildPath 'swagger.json'
Copy-Item -Path $JsonFile.FullName -Destination $TargetSwaggerPath -Force

$IndexContent = Get-Content -Path $TargetIndexPath -Raw
$UpdatedIndexContent = $IndexContent.Replace('%name%', $FolderName)

Set-Content -Path $TargetIndexPath -Value $UpdatedIndexContent -Encoding UTF8

Write-Host "Created/updated folder: $TargetFolder"
Write-Host "Copied template: $TargetIndexPath"
Write-Host "Copied JSON as: $TargetSwaggerPath"