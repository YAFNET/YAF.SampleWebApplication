/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2025 Ingo Herbote
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

using YAF.Core.Helpers;

namespace YAF.SampleWebApplication;

using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

using Microsoft.AspNet.Web.Optimization.WebForms;

using YAF.Configuration;
using YAF.Core.Context;
using YAF.Core.Extensions;
using YAF.Core.Services;
using YAF.Core.Utilities;
using YAF.Types.Constants;
using YAF.Types.Interfaces;
using YAF.Types.Interfaces.Services;
using YAF.Types.Models;

/// <summary>
/// The site master.
/// </summary>
public partial class SiteMaster : MasterPage
{
    /// <summary>Handles the Load event of the Page control.</summary>
    /// <param name="sender">The source of the event.</param>
    /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
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
            // Check if forum is installed
            try
            {
                _ = BoardContext.Current.GetRepository<Board>().TableExists() &&
                    BoardContext.Current.GetRepository<Board>().Exists(b => b.ID > 0);
            }
            catch
            {
                // failure... no boards.
                HttpContext.Current.Response.Redirect($"{BoardInfo.ForumClientFileRoot}install/default.aspx");
            }

            if (scriptManager is not null)
            {
                scriptManager.Scripts.Add(
                    new ScriptReference(BoardInfo.GetURLToScripts("forumExtensions.min.js")));

                if (BoardContext.Current is not null)
                {
                    var logoutScript = JavaScriptBlocks.LogOutJs(
                        BoardContext.Current.Get<ILocalization>().GetText("TOOLBAR", "LOGOUT_TITLE"),
                        BoardContext.Current.Get<ILocalization>().GetText("TOOLBAR", "LOGOUT_QUESTION"),
                        BoardContext.Current.Get<ILocalization>().GetText("TOOLBAR", "LOGOUT"),
                        BoardContext.Current.Get<ILocalization>().GetText("COMMON", "CANCEL"),
                        BoardContext.Current.Get<LinkBuilder>().GetLink(ForumPages.Account_Logout));


                    ScriptManager.RegisterStartupScript(
                        this.Page,
                        this.Page.GetType(),
                        nameof(JavaScriptBlocks.LogOutJs),
                        JsAndCssHelper.CompressJavaScript(logoutScript),
                        true);
                }
            }

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
    /// Gets the language tag and direction tag for the root html Tag
    /// </summary>
    /// <returns>Returns language tag</returns>
    protected string GetLanguageTags()
    {
        var languageTag = BoardContext.Current.Get<ILocalization>().Culture.TwoLetterISOLanguageName;

        return BoardContext.Current.Get<ILocalization>().Culture.TextInfo.IsRightToLeft
            ? $"""
               lang="{languageTag}" dir="rtl"
               """
            : $"""
               lang="{languageTag}"
               """;
    }
}