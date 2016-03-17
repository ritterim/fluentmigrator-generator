function Add-FluentMigration
{
    [CmdletBinding(DefaultParameterSetName = 'Name')]
    param (
        [parameter(Position = 0,
            Mandatory = $true)]
        [string] $Name)
    $timestamp = (Get-Date -Format yyyyMMddHHmmss)

    $project = Get-Project
    $namespace = $project.Properties.Item("DefaultNamespace").Value.ToString() + ".Migrations"
    $projectPath = [System.IO.Path]::GetDirectoryName($project.FullName)
    $migrationsPath = [System.IO.Path]::Combine($projectPath, "Migrations")
    $outputPath = [System.IO.Path]::Combine($migrationsPath, "$timestamp" + "_$name.cs")

    if (-not (Test-Path $migrationsPath))
    {
        [System.IO.Directory]::CreateDirectory($migrationsPath)
    }

    "using FluentMigrator;

namespace $namespace
{
    [Migration($timestamp)]
    public class $name : Migration
    {
        public override void Up()
        {
        }

        public override void Down()
        {
        }
    }
}" | Out-File -Encoding "UTF8" -Force $outputPath

    $project.ProjectItems.AddFromFile($outputPath)
    $project.Save()
}

Export-ModuleMember @( 'Add-FluentMigration' )
