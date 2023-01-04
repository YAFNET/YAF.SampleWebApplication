/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2023 Ingo Herbote
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

namespace YAF.SampleWebApplication.Controllers.BaseClass
{
    using System;
    using System.Web.Mvc;

    /// <summary>
    /// The razor controller.
    /// </summary>
    public class RazorController : Controller
    {
        /// <summary>
        /// The razor view.
        /// </summary>
        /// <param name="viewName">
        /// The view name.
        /// </param>
        /// <param name="model">
        /// The model.
        /// </param>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        public ActionResult RazorView(string viewName, object model)
        {
            // pass the viewname to RazorView.aspx
            // the view will be rendered as partial view
            this.ViewBag.ViewName = viewName;

            return this.View("RazorView", model);
        }

        /// <summary>
        /// The razor view.
        /// </summary>
        /// <param name="model">
        /// The model.
        /// </param>
        /// <returns>
        /// The <see cref="ActionResult"/>.
        /// </returns>
        public ActionResult RazorView(object model)
        {
            return this.RazorView(this.GetCurrentViewName(), model);
        }

        public ActionResult RazorView(string viewName)
        {
            return this.RazorView(viewName, null);
        }

        public ActionResult RazorView()
        {
            return this.RazorView(this.GetCurrentViewName(), null);
        }

        private String GetCurrentViewName()
        {
            var result = $"{this.Url.RequestContext.RouteData.Values["action"]}";

            return result;
        }
    }
}