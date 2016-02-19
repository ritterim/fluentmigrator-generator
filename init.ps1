param($installPath, $toolsPath, $package)

if (Get-Module | ?{ $_.Name -eq "FluentMigrator" })
{
    Remove-Module FluentMigrator
}

Import-Module (Join-Path $toolsPath "FluentMigrator.psd1")
