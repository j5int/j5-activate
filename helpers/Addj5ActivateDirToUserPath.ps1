$script:j5ActivateDir=(Get-Item $PSScriptRoot).parent.FullName

Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1" -Force

Install-ChocolateyPath -PathToInstall "$script:j5ActivateDir\bin"
