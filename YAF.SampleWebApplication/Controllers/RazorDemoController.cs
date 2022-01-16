/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2022 Ingo Herbote
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

namespace YAF.SampleWebApplication.Controllers
{
    using System.Web.Mvc;

    using YAF.SampleWebApplication.Controllers.BaseClass;
    using YAF.SampleWebApplication.Models;

    /// <summary>
    /// The razor demo controller.
    /// </summary>
    public class RazorDemoController : RazorController
    {
        /// <summary>
        /// The index.
        /// </summary>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        public ActionResult Index()
        {
            return this.RazorView();
        }

        /// <summary>
        /// Example render some other view
        /// </summary>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        public ActionResult RenderOtherView()
        {
            return this.RazorView("Hello");
        }

        /// <summary>
        /// Example Render view with Model
        /// </summary>
        /// <param name="id">
        /// The id.
        /// </param>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        public ActionResult Users(int id)
        {
            var model = new Users { UserId = id, UserName = "Testuser" };

            return this.RazorView(model);
        }

        /// <summary>
        /// The some ajax call.
        /// </summary>
        /// <param name="id">
        /// The id.
        /// </param>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        [HttpGet]
        public ActionResult SomeAjaxCall(int id)
        {
            var model = new Users { UserId = id, UserName = "Testuser" };

            return this.View("Users", model);
        }
    }
}