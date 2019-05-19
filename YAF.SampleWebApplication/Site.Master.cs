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
    using System.Web.UI;
    using System.Web.UI.HtmlControls;

    using Microsoft.AspNet.Web.Optimization.WebForms;

    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                var link = new HtmlLink { Href = "~/Forum/Content/Themes/yaf/bootstrap-forum.min.css" };
                link.Attributes.Add("rel", "stylesheet");
                link.Attributes.Add("type", "text/css");

                this.Page.Header.Controls.Add(link);

                var bundleReference = new BundleReference { Path = "~/Content/css" };

                this.Page.Header.Controls.Add(bundleReference);
            }
        }
    }
}