using YAF.Core.Extensions;

namespace YAF.SampleApp;

/// <summary>
/// Class Program.
/// </summary>
public class Program
{
    /// <summary>
    /// Defines the entry point of the application.
    /// </summary>
    /// <param name="args">
    /// The arguments.
    /// </param>
    /// <returns>
    /// The <see cref="Task"/>.
    /// </returns>
    public static Task Main(string[] args)
    {
        var host = Host.CreateDefaultBuilder(args).UseAutofacServiceProviderFactory()
            .ConfigureYafAppConfiguration().ConfigureYafLogging()
            .ConfigureWebHostDefaults(webHostBuilder => webHostBuilder.UseStartup<Startup>()).Build();

        return host.RunAsync();
    }
}