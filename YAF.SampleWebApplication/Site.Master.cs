/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2021 Ingo Herbote
 * https://www.yetanotherforum.net/
 * 
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at

 * http://www.apache.org/licenses/LICENSE-2.0

 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

namespace YAF.SampleWebApplication
{
    using System;
    using System.Linq;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;

    using Microsoft.AspNet.Web.Optimization.WebForms;

    using YAF.Configuration;
    using YAF.Core;
    using YAF.Core.Extensions;
    using YAF.Types.Constants;
    using YAF.Types.Extensions;
    using YAF.Types.Interfaces;
    using YAF.Types.Models;
    using YAF.Utils;

    /// <summary>
    /// The site master.
    /// </summary>
    public partial class SiteMaster : MasterPage
    {
        /// <summary>
        /// The get return url.
        /// </summary>
        /// <returns>
        /// The url.
        /// </returns>
        protected string GetReturnUrl()
        {
            return HttpContext.Current.Server.UrlEncode(
                HttpContext.Current.Request.QueryString.GetFirstOrDefault("ReturnUrl").IsSet()
                    ? General.GetSafeRawUrl(HttpContext.Current.Request.QueryString.GetFirstOrDefault("ReturnUrl"))
                    : General.GetSafeRawUrl());
        }

        /// <summary>Handles the Load event of the Page control.</summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if forum is installed
            try
            {
                var boards = BoardContext.Current.GetRepository<Board>().GetAll();
                var isForumInstalled = boards.Any();
            }
            catch
            {
                // failure... no boards.    
                HttpContext.Current.Response.Redirect($"{BoardInfo.ForumClientFileRoot}install/default.aspx");
            }

            var scriptManager = ScriptManager.GetCurrent(this.Page);

            var forum = this.MainContent.FindControl("forum");

            if (forum != null)
            {
                var link = new HtmlLink { Href = "~/Content/Site.css" };
                link.Attributes.Add("rel", "stylesheet");
                link.Attributes.Add("type", "text/css");

                this.Page.Header.Controls.Add(link);
            }
            else
            {
                scriptManager.Scripts.Insert(
                    0,
                    new ScriptReference(BoardInfo.GetURLToScripts($"jquery-{Config.JQueryVersion}.min.js")));

                scriptManager.Scripts.Add(
                    new ScriptReference(BoardInfo.GetURLToScripts("jquery.ForumExtensions.min.js")));

                var link = new HtmlLink();

                link.Attributes.Add("rel", "stylesheet");
                link.Attributes.Add("type", "text/css");

                link.Href = BoardContext.Current != null
                    ? BoardContext.Current.Get<ITheme>().BuildThemePath("bootstrap-forum.min.css")
                    : "~/Forum/Content/Themes/yaf/bootstrap-forum.min.css";

                this.Page.Header.Controls.Add(link);

                var linkForum = new HtmlLink { Href = "~/Forum/Content/forum.min.css" };
                linkForum.Attributes.Add("rel", "stylesheet");
                linkForum.Attributes.Add("type", "text/css");

                this.Page.Header.Controls.Add(linkForum);

                var bundleReference = new BundleReference { Path = "~/Content/css" };

                this.Page.Header.Controls.Add(bundleReference);
            }
        }

        /// <summary>
        /// The login link_ on click.
        /// </summary>
        /// <param name="sender">
        /// The sender.
        /// </param>
        /// <param name="e">
        /// The e.
        /// </param>
        protected void LoginLink_OnClick(object sender, EventArgs e)
        {
            this.Response.Redirect(BuildLink.GetLink(ForumPages.Login, "ReturnUrl={0}", this.GetReturnUrl()));
        }

        /// <summary>
        /// The register link_ on click.
        /// </summary>
        /// <param name="sender">
        /// The sender.
        /// </param>
        /// <param name="e">
        /// The e.
        /// </param>
        protected void RegisterLink_OnClick(object sender, EventArgs e)
        {
            this.Response.Redirect(BuildLink.GetLink(ForumPages.Register));
        }
    }
}