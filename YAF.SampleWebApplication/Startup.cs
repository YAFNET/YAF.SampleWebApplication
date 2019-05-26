using Microsoft.Owin;

[assembly: OwinStartup(typeof(YAF.SampleWebApplication.Startup))]

namespace YAF.SampleWebApplication
{
    using Owin;

    /// <summary>
    /// The startup.
    /// </summary>
    public class Startup
    {
        /// <summary>Configurations the specified application.</summary>
        /// <param name="app">The application.</param>
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();
        }
    }
}