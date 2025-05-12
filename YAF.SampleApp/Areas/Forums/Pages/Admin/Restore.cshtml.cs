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

using YAF.Types.Objects.Model;

namespace YAF.Pages.Admin;

using System.Collections.Generic;

using Microsoft.AspNetCore.Mvc.Rendering;

using YAF.Core.Extensions;
using YAF.Core.Helpers;
using YAF.Core.Model;
using YAF.Types.Models;

/// <summary>
/// The Admin Restore Topics Page
/// </summary>
public class RestoreModel : AdminPage
{
    /// <summary>
    /// Gets or sets the filter.
    /// </summary>
    /// <value>The filter.</value>
    [BindProperty]
    public string Filter { get; set; }

    /// <summary>
    /// Gets or sets the deleted topics.
    /// </summary>
    /// <value>The deleted topics.</value>
    [BindProperty]
    public List<PagedTopic> DeletedTopics { get; set; }

    /// <summary>
    /// Gets or sets the deleted messages.
    /// </summary>
    /// <value>The deleted messages.</value>
    [BindProperty]
    public List<PagedMessage> DeletedMessages { get; set; }

    /// <summary>
    /// Gets or sets the size of the messages page.
    /// </summary>
    /// <value>The size of the messages page.</value>
    [BindProperty]
    public int MessagesPageSize { get; set; }

    /// <summary>
    /// Gets or sets the pageSize List.
    /// </summary>
    public SelectList MessagesPageSizeList { get; set; }

    /// <summary>
    /// Initializes a new instance of the <see cref="RestoreModel"/> class.
    /// </summary>
    public RestoreModel()
        : base("ADMIN_RESTORE", ForumPages.Admin_Restore)
    {
    }

    /// <summary>
    /// Creates page links for this page.
    /// </summary>
    public override void CreatePageLinks()
    {
        this.PageBoardContext.PageLinks.AddAdminIndex();
        this.PageBoardContext.PageLinks.AddLink(this.GetText("ADMIN_RESTORE", "TITLE"), string.Empty);
    }

    /// <summary>
    /// Handles the Load event of the Page control.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    public void OnGet(int p, int p2)
    {
        this.BindData(p, p2);
    }

    /// <summary>
    /// The page size on selected index changed.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    public void OnPost(int p, int p2)
    {
        this.BindData(p, p2);
    }

    /// <summary>
    /// The refresh click.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    public void OnPostRefresh(int p, int p2)
    {
        this.BindData(p, p2);
    }

    /// <summary>
    /// Restore topic.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <param name="topicId">The topic identifier.</param>
    /// <param name="forumId">The forum identifier.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostRestoreTopic(int p, int p2, int topicId, int forumId)
    {
        var getFirstMessage = this.GetRepository<Message>()
            .GetSingle(m => m.TopicID == topicId && m.Position == 0);

        if (getFirstMessage != null)
        {
            this.GetRepository<Message>().Restore(
                forumId,
                topicId,
                getFirstMessage);
        }

        var topic = this.GetRepository<Topic>().GetById(topicId);

        var flags = topic.TopicFlags;

        flags.IsDeleted = false;

        this.GetRepository<Topic>().UpdateOnly(
            () => new Topic { Flags = flags.BitValue },
            t => t.ID == topicId);

        this.BindData(p, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_RESTORED"), MessageTypes.success);
    }

    /// <summary>
    /// Delete topic.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <param name="topicId">The topic identifier.</param>
    /// <param name="forumId">The forum identifier.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostDeleteTopic(int p, int p2, int topicId, int forumId)
    {
        this.GetRepository<Topic>().Delete(forumId, topicId, true);

        this.BindData(p, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_DELETED"), MessageTypes.success);
    }

    /// <summary>
    /// Delete all topics.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostDeleteAllTopics(int p, int p2)
    {
        var deletedTopics = this.GetRepository<Topic>()
            .GetDeletedTopics(this.PageBoardContext.PageBoardID, this.Filter);

        deletedTopics.ForEach(
            x => this.GetRepository<Topic>().Delete(x.Item2.ForumID, x.Item2.ID, true));

        this.BindData(0, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_DELETED"), MessageTypes.success);
    }

    /// <summary>
    /// Delete all topics with no posts.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostDeleteZeroTopics(int p, int p2)
    {
        var deletedTopics = this.GetRepository<Topic>().Get(t => (t.Flags & 8) == 8 && t.NumPosts.Equals(0));

        deletedTopics.ForEach(
            topic => this.GetRepository<Topic>().Delete(topic.ForumID, topic.ID, true));

        this.BindData(p, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_DELETED"), MessageTypes.success);
    }

    /// <summary>
    /// Restore post.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <param name="topicId">The topic identifier.</param>
    /// <param name="forumId">The forum identifier.</param>
    /// <param name="messageId">The message identifier.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostRestorePost(int p, int p2, int topicId, int forumId, int messageId)
    {
        var message = this.GetRepository<Message>().GetById(messageId);

        this.GetRepository<Message>().Restore(
            forumId,
            topicId,
            message);

        this.BindData(p, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_RESTORED"), MessageTypes.success);
    }

    /// <summary>
    /// Delete post.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <param name="topicId">The topic identifier.</param>
    /// <param name="forumId">The forum identifier.</param>
    /// <param name="messageId">The message identifier.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostDeletePost(int p, int p2, int topicId, int forumId, int messageId)
    {
        var message = this.GetRepository<Message>().GetById(messageId);

        // delete message
        this.GetRepository<Message>().Delete(
            forumId,
            topicId,
            message,
            true,
            string.Empty,
            true,
            true);

        this.BindData(p, p2);

        return this.PageBoardContext.Notify(this.GetText("MSG_DELETED"), MessageTypes.success);
    }

    /// <summary>
    /// Delete all posts.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    /// <returns>IActionResult.</returns>
    public IActionResult OnPostDeleteAllPosts(int p, int p2)
    {
        var messages = this.GetRepository<Message>()
            .GetDeletedMessages(this.PageBoardContext.PageBoardID);

        messages.ForEach(
            x => this.GetRepository<Message>().Delete(
                x.Item1.ID,
                x.Item3.TopicID,
                x.Item3,
                true,
                string.Empty,
                true,
                true));

        this.BindData(p, 0);

        return this.PageBoardContext.Notify(this.GetText("MSG_DELETED"), MessageTypes.success);
    }

    /// <summary>
    /// Binds the data.
    /// </summary>
    /// <param name="p">The topics page index.</param>
    /// <param name="p2">The messages page index.</param>
    private void BindData(int p, int p2)
    {
        this.PageSizeList = new SelectList(
            StaticDataHelper.PageEntries(),
            nameof(SelectListItem.Value),
            nameof(SelectListItem.Text));

        this.MessagesPageSizeList = new SelectList(
            StaticDataHelper.PageEntries(),
            nameof(SelectListItem.Value),
            nameof(SelectListItem.Text));

        this.MessagesPageSize = this.PageBoardContext.PageUser.PageSize;

        this.BindDeletedTopics(p);

        this.BindDeletedMessages(p2);
    }

    /// <summary>
    /// Binds the deleted topics.
    /// </summary>
    /// <param name="p">
    /// The page index.
    /// </param>
    private void BindDeletedTopics(int p)
    {
        var deletedTopics =
            this.GetRepository<Topic>().GetDeletedTopicsPaged(this.PageBoardContext.PageBoardID, this.Filter, p - 1, this.Size);

        this.DeletedTopics = deletedTopics;
    }

    /// <summary>
    /// Bind deleted Messages.
    /// </summary>
    /// <param name="p2">
    /// The page index.
    /// </param>
    private void BindDeletedMessages(int p2)
    {
        var deletedMessages = this.GetRepository<Message>()
            .GetDeletedMessagesPaged(this.PageBoardContext.PageBoardID, p2 - 1, this.MessagesPageSize);

        this.DeletedMessages = deletedMessages;
    }
}