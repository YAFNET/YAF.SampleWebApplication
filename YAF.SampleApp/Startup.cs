/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2024 Ingo Herbote
 * https://www.yetanotherforum.net/
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at

 * https://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

using Autofac;

using YAF.Core.Context;
using YAF.Core.Extensions;
using YAF.Core.Hubs;
using YAF.Core.Middleware;

namespace YAF.SampleApp;

/// <summary>
/// The startup.
/// </summary>
public class Startup : IHaveServiceLocator
{
    /// <summary>
    /// Initializes a new instance of the <see cref="Startup"/> class.
    /// </summary>
    /// <param name="configuration">The configuration.</param>
    /// <param name="env">The environment</param>
    public Startup(IConfiguration configuration, IWebHostEnvironment env)
    {
        this.Configuration = configuration;
        this.Environment = env;
    }

    /// <summary>
    ///   Gets ServiceLocator.
    /// </summary>
    public IServiceLocator ServiceLocator => BoardContext.Current.ServiceLocator;

    /// <summary>
    /// Gets the configuration.
    /// </summary>
    public IConfiguration Configuration { get; }

    /// <summary>
    /// Gets the environment.
    /// </summary>
    /// <value>The environment.</value>
    public IWebHostEnvironment Environment { get; }

    /// <summary>
    /// Configures the services.
    /// </summary>
    /// <param name="services">The services.</param>
    public void ConfigureServices(IServiceCollection services)
    {
        services.AddRazorPages(options =>
        {
            options.Conventions.AddAreaPageRoute("Forums", "/SiteMap", "/Sitemap.xml");
        });

        services.AddYafCore(this.Configuration);

        services.AddServerSideBlazor();
    }

    /// <summary>
    /// Configures the container.
    /// </summary>
    /// <param name="builder">The builder.</param>
    public void ConfigureContainer(ContainerBuilder builder)
    {
        builder.RegisterYafModules();
    }

    /// <summary>
    /// Configures the specified application.
    /// </summary>
    /// <param name="app">The application.</param>
    /// <param name="env">The env.</param>
    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        if (env.IsDevelopment())
        {
            app.UseDeveloperExceptionPage();
        }
        else
        {
            app.UseExceptionHandler("/Forums/Error");

            app.UseHsts();
        }

        app.RegisterAutofac();

        app.UseAntiXssMiddleware();

        app.UseStaticFiles();

        app.UseSession();

        app.UseYafCore(this.ServiceLocator, env);

        app.UseRobotsTxt(env);

        app.UseEndpoints(endpoints =>
        {
            endpoints.MapRazorPages();

            endpoints.MapBlazorHub();

            endpoints.MapFallbackToPage("/_Host");

			endpoints.MapAreaControllerRoute(
                name: "default",
                areaName:"Forums",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            endpoints.MapControllers();

            endpoints.MapHub<NotificationHub>("/NotificationHub");
            endpoints.MapHub<ChatHub>("/ChatHub");
        });
    }
}