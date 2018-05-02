Set-Location -Path $PSScriptRoot
$src_dir = @((Get-ChildItem ..\..\*\j5\src\j5-app.yml).Directory.Parent.Parent.FullName)
if ($src_dir.Length -eq 0) {
  Write-Warning "Could not locate j5 framework"
  [Environment]::Exit(1)
} elseif ($src_dir.Length -eq 1) {
  Write-Host $src_dir
} else {
  $host.ui.WriteErrorLine("Found multiple j5 framework directories. Cannot determine which to activate")
  ForEach ($d in $src_dir) { $host.ui.WriteErrorLine($d) }
  [Environment]::Exit(1)
}
