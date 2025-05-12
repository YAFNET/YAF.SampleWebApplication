﻿/* Yet Another Forum.NET
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

namespace YAF.Types.InputModels;

/// <summary>
/// The input model.
/// </summary>
public class EditBoardInputModel
{
    /// <summary>
    /// Gets or sets the identifier.
    /// </summary>
    /// <value>The identifier.</value>
    public int Id { get; set; }

    /// <summary>
    /// Gets or sets the name.
    /// </summary>
    /// <value>The name.</value>
    public string Name { get; set; }

    /// <summary>
    /// Gets or sets the culture.
    /// </summary>
    /// <value>The culture.</value>
    public string Culture { get; set; }

    /// <summary>
    /// Gets or sets a value indicating whether [create admin user].
    /// </summary>
    /// <value><c>true</c> if [create admin user]; otherwise, <c>false</c>.</value>
    public bool CreateAdminUser { get; set; }

    /// <summary>
    /// Gets or sets the name of the user.
    /// </summary>
    /// <value>The name of the user.</value>
    public string UserName { get; set; }

    /// <summary>
    /// Gets or sets the user email.
    /// </summary>
    /// <value>The user email.</value>
    public string UserEmail { get; set; }

    /// <summary>
    /// Gets or sets the user pass1.
    /// </summary>
    /// <value>The user pass1.</value>
    public string UserPass1 { get; set; }

    /// <summary>
    /// Gets or sets the user pass2.
    /// </summary>
    /// <value>The user pass2.</value>
    public string UserPass2 { get; set; }
}