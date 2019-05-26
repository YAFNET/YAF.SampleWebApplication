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

    using YAF.Core;
    using YAF.Types.Interfaces;

    /// <summary>
    /// The chat.
    /// </summary>
    public partial class Chat : Page
    {
        /// <summary>
        /// The user name.
        /// </summary>
        public string UserName = "test";

        /// <summary>
        /// The user id.
        /// </summary>
        public int UserId;

        /// <summary>
        /// The user image.
        /// </summary>
        public string UserImage;

        /// <summary>Handles the Load event of the Page control.</summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.PageContext().IsGuest)
            {
                this.UserName = this.PageContext().PageUserName;
                this.UserId = this.PageContext().PageUserID;

                this.GetUserImage(this.UserName);
            }
            else
            {
                this.Response.Redirect("Login.aspx");
            }

            this.Header.DataBind();
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            this.Session.Clear();
            this.Session.Abandon();
            this.Response.Redirect("Login.aspx");
        }

        public void GetUserImage(string Username)
        {
            if (Username != null)
            {
                // string query = "select Photo from tbl_Users where UserName='" + Username + "'";
                this.UserImage = YafContext.Current.Get<IAvatars>().GetAvatarUrlForCurrentUser();
            }
        }
    }
}