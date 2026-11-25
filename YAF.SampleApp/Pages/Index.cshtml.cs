/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2026 Ingo Herbote
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

using Microsoft.AspNetCore.Mvc.RazorPages;

using YAF.Core.Extensions;
using YAF.Core.Model;
using YAF.Types.Constants;
using YAF.Types.Extensions;
using YAF.Types.Models;
using YAF.Types.Objects;
using YAF.Types.Objects.Model;

namespace YAF.SampleApp.Pages;

/// <summary>
/// The home page of the sample. Shows how a page of the host application can read
/// data of the forum: with <see cref="IHaveServiceLocator"/> the page gets the same
/// services and repositories (GetRepository&lt;T&gt;) the forum pages use.
/// </summary>
public class IndexModel : PageModel, IHaveServiceLocator
{
    /// <summary>
    /// The number of topics shown in the "latest topics" list.
    /// </summary>
    private const int LatestTopicsCount = 5;

    /// <summary>
    /// Gets the service locator.
    /// </summary>
    public IServiceLocator ServiceLocator => BoardContext.Current.ServiceLocator;

    /// <summary>
    /// Gets the post statistics of the board.
    /// </summary>
    public BoardStat Statistics { get; private set; }

    /// <summary>
    /// Gets the number of members of the board.
    /// </summary>
    public long MemberCount { get; private set; }

    /// <summary>
    /// Gets the latest topics the current user can read.
    /// </summary>
    public List<LatestTopic> LatestTopics { get; private set; } = [];

    /// <summary>
    /// Loads the forum data shown on the home page.
    /// </summary>
    public async Task OnGetAsync()
    {
        var context = BoardContext.Current;

        // the same cache entries as the statistics of the forum index, so both show the same numbers
        this.Statistics = await this.Get<IDataCache>().GetOrSetAsync(
            Constants.Cache.BoardStats,
            () => this.GetRepository<Board>().PostStatsAsync(context.PageBoardID, true),
            TimeSpan.FromMinutes(context.BoardSettings.ForumStatisticsCacheTimeout));

        this.MemberCount = await this.Get<IDataCache>().GetOrSetAsync(
            Constants.Cache.BoardMembers,
            () => this.GetRepository<User>().BoardMembersAsync(context.PageBoardID),
            TimeSpan.FromMinutes(context.BoardSettings.BoardUserStatsCacheTimeout));

        // only topics of forums the current user (or guest) can read
        this.LatestTopics = this.GetRepository<Topic>().Latest(
            context.PageBoardID,
            0,
            LatestTopicsCount,
            context.PageUserID,
            context.BoardSettings.NoCountForumsInActiveDiscussions,
            false);
    }
}
