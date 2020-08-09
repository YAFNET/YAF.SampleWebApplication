/* Yet Another Forum.NET
 * Copyright (C) 2003-2005 Bjørnar Henden
 * Copyright (C) 2006-2013 Jaben Cargman
 * Copyright (C) 2014-2020 Ingo Herbote
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
    using System.Collections.Generic;
    using System.Globalization;
    using System.Linq;
    using System.Threading.Tasks;

    using Microsoft.AspNet.SignalR;
    using YAF.Core.Context;
    using YAF.Core.Extensions;
    using YAF.SampleWebApplication.Models;
    using YAF.Types.Interfaces;
    using YAF.Types.Models;

    /// <summary>
    /// The chat hub.
    /// </summary>
    public class ChatHub : Hub
    {
        /// <summary>
        /// The connected users.
        /// </summary>
        private static readonly List<Users> ConnectedUsers = new List<Users>();

        /// <summary>
        /// The current message.
        /// </summary>
        private static readonly List<Messages> CurrentMessage = new List<Messages>();

        /// <summary>Connects the specified user name.</summary>
        /// <param name="userName">Name of the user.</param>
        /// <param name="userId">The user identifier.</param>
        public void Connect(string userName, int userId)
        {
            var id = this.Context.ConnectionId;

            if (ConnectedUsers.Count(x => x.ConnectionId == id) != 0)
            {
                return;
            }

            var userImg = this.GetUserImage(userId);
            var loginTime = DateTime.Now.ToString(CultureInfo.InvariantCulture);

            ConnectedUsers.Add(
                new Users { ConnectionId = id, UserName = userName, UserId = userId, UserImage = userImg, LoginTime = loginTime });

            // send to caller
            this.Clients.Caller.onConnected(id, userName, userId, ConnectedUsers, CurrentMessage);

            // send to all except caller client
            this.Clients.AllExcept(id).onNewUserConnected(id, userName, userId, userImg, loginTime);
        }

        /// <summary>
        /// The send message to all.
        /// </summary>
        /// <param name="userName">
        /// The user name.
        /// </param>
        /// <param name="userId">
        /// The user id.
        /// </param>
        /// <param name="message">
        /// The message.
        /// </param>
        /// <param name="time">
        /// The time.
        /// </param>
        public void SendMessageToAll(string userName, int userId, string message, string time)
        {
            var userImg = this.GetUserImage(userId);

            // store last 100 messages in cache
            AddMessageInCache(userName, userId, message, time, userImg);

            // Broad cast message
            this.Clients.All.messageReceived(userName, message, time, userImg);
        }

        /// <summary>
        /// Clear Chat History
        /// </summary>
        public void clearTimeout()
        {
            CurrentMessage.Clear();
        }

        /// <summary>
        /// The get user image.
        /// </summary>
        /// <param name="userId">
        /// The user id.
        /// </param>
        /// <returns>
        /// The <see cref="string"/>.
        /// </returns>
        public string GetUserImage(int userId)
        {
            var user = BoardContext.Current.GetRepository<User>().GetById(userId);
           return BoardContext.Current.Get<IAvatars>().GetAvatarUrlForUser(user);
        }

        /// <summary>
        /// The on disconnected.
        /// </summary>
        /// <param name="stopCalled">
        /// The stop called.
        /// </param>
        /// <returns>
        /// The <see cref="Task"/>.
        /// </returns>
        public override Task OnDisconnected(bool stopCalled)
        {
            var item = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == this.Context.ConnectionId);

            if (item == null)
            {
                return base.OnDisconnected(stopCalled);
            }

            ConnectedUsers.Remove(item);

            var id = this.Context.ConnectionId;
            this.Clients.All.onUserDisconnected(id, item.UserName);

            return base.OnDisconnected(stopCalled);
        }

        /// <summary>
        /// The send private message.
        /// </summary>
        /// <param name="toUserId">
        /// The to user id.
        /// </param>
        /// <param name="message">
        /// The message.
        /// </param>
        public void SendPrivateMessage(string toUserId, string message)
        {
            var fromUserId = this.Context.ConnectionId;

            var toUser = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == toUserId);
            var fromUser = ConnectedUsers.FirstOrDefault(x => x.ConnectionId == fromUserId);

            if (toUser == null || fromUser == null)
            {
                return;
            }

            var currentDateTime = DateTime.Now.ToString(CultureInfo.InvariantCulture);
            var userImg = this.GetUserImage(fromUser.UserId);

            // send to 
            this.Clients.Client(toUserId).sendPrivateMessage(
                fromUserId,
                fromUser.UserName,
                message,
                userImg,
                currentDateTime);

            // send to caller user
            this.Clients.Caller.sendPrivateMessage(toUserId, fromUser.UserName, message, userImg, currentDateTime);
        }

        /// <summary>
        /// Add message in cache.
        /// </summary>
        /// <param name="userName">
        /// The user name.
        /// </param>
        /// <param name="userId">
        /// The user id.
        /// </param>
        /// <param name="message">
        /// The message.
        /// </param>
        /// <param name="time">
        /// The time.
        /// </param>
        /// <param name="userImage">
        /// The user image.
        /// </param>
        private static void AddMessageInCache(string userName, int userId, string message, string time, string userImage)
        {
            CurrentMessage.Add(new Messages { UserName = userName, UserId = userId, Message = message, Time = time, UserImage = userImage });

            if (CurrentMessage.Count > 100)
            {
                CurrentMessage.RemoveAt(0);
            }
        }
    }
}