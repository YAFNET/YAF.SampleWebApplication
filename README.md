# YAF.NET Sample Application

[![Build](https://github.com/YAFNET/YAF.SampleWebApplication/actions/workflows/build.yml/badge.svg)](https://github.com/YAFNET/YAF.SampleWebApplication/actions/workflows/build.yml)
[![YAFNET.RazorPages](https://img.shields.io/nuget/v/YAFNET.RazorPages.svg?label=YAFNET.RazorPages)](https://www.nuget.org/packages/YAFNET.RazorPages/)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE.md)

A standard ASP.NET Core application (.NET 11) with the [YAF.NET](https://www.yetanotherforum.net/) forum integrated as an area. Use it to see how the integration works, or as the starting point for your own site.

- **Forum as an area**: the complete forum from the `YAFNET.RazorPages` package runs at `/Forums`, inside the layout of the site.
- **One login, one theme**: the forum accounts are the accounts of the site. The header shows the login state of the forum on every page, and the theme chosen in the forum admin (including light and dark mode) styles the whole site.
- **Your pages, forum data**: the home page reads the board statistics and the latest topics through the repositories of the forum.
- **Real-time chat**: the optional `YAFNET.UI.Chat` package adds a chat room at `/Chat`.
- **Blazor**: Blazor Server components run next to the forum, as a routable component and inside a Razor Page.
- **Getting started page**: the running application explains itself at `/GettingStarted`.

> [!NOTE]
> The [netfx branch](https://github.com/YAFNET/YAF.SampleWebApplication/tree/netfx) contains the .NET Framework version with YAF.NET 3.2.x.

## Requirements

- [.NET 11 SDK](https://dotnet.microsoft.com/download) (or Visual Studio with the ASP.NET workload)
- Microsoft SQL Server (Express and LocalDB work too). MySQL, PostgreSQL and SQLite are supported as well, see [Using another database](#using-another-database).
- Optional: an SMTP server for the registration and notification mails

## Getting started

1. **Get the code**

   ```bash
   git clone https://github.com/YAFNET/YAF.SampleWebApplication.git
   cd YAF.SampleWebApplication
   ```

   Or download the source of a [release](https://github.com/YAFNET/YAF.SampleWebApplication/releases).

2. **Set the connection string**

   Create an empty database (e.g. `yafnet`) and enter the connection string in `YAF.SampleApp/appsettings.json`:

   ```json
   "ConnectionStrings": {
     "DefaultConnection": "data source=(local);initial catalog=yafnet;Integrated Security=True;TrustServerCertificate=True;"
   }
   ```

   To keep the connection string of your machine out of git, put it in `appsettings.Development.json` (ignored by git) or in the user secrets:

   ```bash
   cd YAF.SampleApp
   dotnet user-secrets init
   dotnet user-secrets set "ConnectionStrings:DefaultConnection" "<your connection string>"
   ```

   The user secrets are only read in the `Development` environment (`dotnet run` and Visual Studio use it).

3. **Run the application**

   ```bash
   cd YAF.SampleApp
   dotnet run
   ```

   Or open `YAF.SampleApp.slnx` in Visual Studio and press <kbd>F5</kbd>.

4. **Install the forum**

   The first request redirects to the installation wizard (`/Forums/Install/Install`). It tests the connection, creates the tables and asks for the name of the board and your admin account. When it is done, log in with that account.

## Project structure

| File | What it does |
|------|--------------|
| `Program.cs` | Registers YAF.NET (Autofac, services, middleware, hubs), the chat and Blazor |
| `appsettings.json` | Connection string, mail server and the `BoardConfiguration` of the forum (`Area` and `StaticFilesRoot` put the forum at `/Forums`) |
| `Pages/Shared/_Layout.cshtml` | The layout of your own pages, with the theme of the forum |
| `Pages/Shared/_SiteHeader.cshtml`, `_SiteFooter.cshtml` | Header and footer of all pages, also of the forum and the chat |
| `Areas/Forums/Pages/Shared/_Layout.cshtml` | Replaces the forum layout of the package: the site header around the forum navigation |
| `Areas/Chat/Pages/Shared/_Layout.cshtml` | The same for the chat page |
| `Pages/Index.cshtml(.cs)` | The home page, reads statistics and the latest topics from the forum |
| `Pages/GettingStarted.cshtml` | The getting started guide inside the application |
| `Pages/Counter.razor`, `Pages/CounterPage.cshtml` | The Blazor demos |
| `wwwroot/css/site.css` | The styles of the sample pages |

The forum comes from these NuGet packages:

| Package | Contains |
|---------|----------|
| [YAFNET.RazorPages](https://www.nuget.org/packages/YAFNET.RazorPages/) | All forum pages and their static files |
| [YAFNET.Data.SqlServer](https://www.nuget.org/packages/YAFNET.Data.SqlServer/) | The data provider for SQL Server |
| [YAFNET.UI.Chat](https://www.nuget.org/packages/YAFNET.UI.Chat/) | Optional: the chat area |

## Using another database

Replace the `YAFNET.Data.SqlServer` package with the package of your database, then set the connection string and `BoardConfiguration:ConnectionProviderName` (both have examples in the comments of `appsettings.json`):

| Database | Package | `ConnectionProviderName` |
|----------|---------|--------------------------|
| Microsoft SQL Server | `YAFNET.Data.SqlServer` | `Microsoft.Data.SqlClient` |
| MySQL / MariaDB | `YAFNET.Data.MySQL` | `MySql.Data.MySqlClient` |
| PostgreSQL | `YAFNET.Data.PostgreSQL` | `Npgsql Data Provider` |
| SQLite | `YAFNET.Data.Sqlite` | `System.Data.SQLite` |

For example, for SQLite:

```bash
cd YAF.SampleApp
dotnet remove package YAFNET.Data.SqlServer
dotnet add package YAFNET.Data.Sqlite
```

```json
"ConnectionStrings": {
  "DefaultConnection": "Data Source=yafnet.db;Version=3;"
},
"BoardConfiguration": {
  "ConnectionProviderName": "System.Data.SQLite",
  ...
}
```

## Customizing

- **Your own pages** use `BoardContext.Current` to get the current forum user, the board settings and the services of the forum. See `Pages/Shared/_SiteHeader.cshtml` and `Pages/Index.cshtml.cs`.
- **Forum pages**: a file at the same path as in the `YAFNET.RazorPages` package replaces the one of the package, as `Areas/Forums/Pages/Shared/_Layout.cshtml` does. Start from the [original of the same version](https://github.com/YAFNET/YAFNET/tree/master/yafsrc/YAFNET.UI/YAFNET.RazorPages/Areas/Forums/Pages).
- **Themes**: choose a theme in *Admin › Board Settings*, or build your own with [@yafnet/theme-kit](https://www.npmjs.com/package/@yafnet/theme-kit), see [Customization](https://github.com/YAFNET/YAFNET/wiki/Customization).

## Updating YAF.NET

1. Update the `YAFNET.*` packages to the same new version (all of them together).
2. Compare the files you have overridden (e.g. `Areas/Forums/Pages/Shared/_Layout.cshtml`) with the originals of the new version and take over their changes.
3. Start the application: the first request upgrades the database automatically. Back up the database first.

See [Upgrade YAF.NET v4.x.x](https://github.com/YAFNET/YAFNET/wiki/Upgrade-YAF.NET-v4.x.x) for details.

## Documentation and support

- [Integrate YAF.NET into an existing ASP.NET Core application](https://github.com/YAFNET/YAFNET/wiki/YAF.NET-Integration-in-to-an-existing-ASP.NET-Core-Application): the same steps for your own project
- [BoardConfiguration settings](https://github.com/YAFNET/YAFNET/wiki/BoardConfiguration-Settings)
- [YAF.NET wiki](https://github.com/YAFNET/YAFNET/wiki) and [YAF.NET source](https://github.com/YAFNET/YAFNET)
- [Support forum](https://forum.yetanotherforum.net/)

## License

[Apache License 2.0](LICENSE.md)
