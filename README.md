# FluentMigrator.Generator

[FluentMigrator](https://github.com/schambers/fluentmigrator) is a SQL migration framework designed to help version an application's database. This package allows a developer to quickly create a new migration from within Visual Studio's Package Manager console. 

A few notable features:

- Timestamp generation
- Migration file named correctly with timestamp
- Migration added to `Migrations` folder under current active project

It couldn't be easier!

## Getting Started

```console
PM > Install-Package FluentMigrator.Generator
```

Once installed, open the `Package Manager Console` in Visual Studio. To get there go to `View > Other Windows > Package Manager Console`. **Remember to select the active project, via the `Default Project` dropdown.**

In the new window type `Add-FluentMigration` followed by the name of your migration.

```console
Add-FluentMigration InitialMigration
```

You should see the following structure in your project.

```
ConsoleApplication1
|- /Migrations
    |- 20160219141436_InitialMigration.cs
```

and the contents of that file should look like the following.

```csharp
using FluentMigrator;

namespace ConsoleApplication1.Migrations
{
    [Migration(20160219141436)]
    public class InitialMigration : Migration
    {
        public override void Up()
        {
        }

        public override void Down()
        {
        }
    }
}
```