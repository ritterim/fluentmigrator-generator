function Add-FluentMigration
{
    [CmdletBinding(DefaultParameterSetName = 'Name')]
    param (
        [parameter(Position = 0,
            Mandatory = $true)]
        [string] $Name,
        [string] $ProjectName,
        [switch] $AddTimeStampToClassName)
    $timestamp = (Get-Date -Format yyyyMMddHHmmss)
    $class_name_timestamp = (Get-Date -Format yyyyMMdd_HHmmss)

    if ($ProjectName) {
        $project = Get-Project $ProjectName
        if ($project -is [array])
        {
            throw "More than one project '$ProjectName' was found. Please specify the full name of the one to use."
        }
    }
    else {
        $project = Get-Project
    }
    
    # if the $name parameter contains a string '{T}', then replace it with the timestamp but with a underscore between the
    # yyyyMMdd part and the HHmmss part
    $name = [System.String]::Replace($name, "{T}", $class_name_timestamp)

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
