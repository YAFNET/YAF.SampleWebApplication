/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2019 Ingo Herbote
 * http://www.yetanotherforum.net/
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
    using System.Web;
    using System.Web.UI.WebControls;

    using YAF.Types.Extensions;
    using YAF.Utils;
    using YAF.Utils.Helpers;

    /// <summary>
    /// Class SiteMaster
    /// </summary>
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        /// <summary>
        /// The get return url.
        /// </summary>
        /// <returns>
        /// The url.
        /// </returns>
        protected string GetReturnUrl()
        {
            return
                HttpContext.Current.Server.UrlEncode(
                    HttpContext.Current.Request.QueryString.GetFirstOrDefault("ReturnUrl").IsSet()
                        ? General.GetSafeRawUrl(HttpContext.Current.Request.QueryString.GetFirstOrDefault("ReturnUrl"))
                        : General.GetSafeRawUrl());
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            var loginLink = this.HeadLoginView.FindControlAs<HyperLink>("LoginLink");

            if (loginLink != null)
            {
                loginLink.NavigateUrl = "~/forum/forum.aspx?g=login&ReturnUrl={0}".FormatWith(this.GetReturnUrl());
            }
        }
    }
}
