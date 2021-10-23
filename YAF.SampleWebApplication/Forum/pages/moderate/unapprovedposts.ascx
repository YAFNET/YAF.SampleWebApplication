﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Pages.Moderate.UnapprovedPosts" CodeBehind="UnapprovedPosts.ascx.cs" %>

<%@ Import Namespace="YAF.Types.Constants" %>
<%@ Import Namespace="YAF.Types.Models" %>
<%@ Import Namespace="YAF.Core.Services" %>
<%@ Import Namespace="YAF.Types.Interfaces.Services" %>
<%@ Import Namespace="YAF.Core.Extensions" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <h1><YAF:LocalizedLabel runat="server" LocalizedTag="UNAPPROVED" /></h1>
    </div>
</div>
<asp:Repeater ID="List" runat="server">
    <ItemTemplate>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-3">
                    <div class="card-header">
                        <YAF:IconHeader runat="server"
                                        IconName="comment" 
                                        LocalizedTag="Topic"></YAF:IconHeader>
                        <a id="TopicLink"
                           href='<%# this.Get<LinkBuilder>().GetLink(ForumPages.Posts, "t={0}&name={1}", ((Tuple<Topic, Message, User>)Container.DataItem).Item1.ID, ((Tuple<Topic, Message, User>)Container.DataItem).Item1.TopicName) %>'
                           runat="server" 
                           Visible="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item1.NumPosts > 0 %>"><%# ((Tuple<Topic, Message, User>)Container.DataItem).Item1.TopicName %></a>
                         <asp:Label id="TopicName" 
                                    runat="server" 
                                    Visible="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item1.NumPosts == 0 %>" 
                                    Text="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item1.TopicName %>"></asp:Label>
                        <div class="float-end text-muted">
                            <span class="fw-bold">
                                <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" LocalizedTag="POSTED" />
                            </span>
                            <%# this.Get<IDateTimeService>().FormatDateTimeShort(((Tuple<Topic, Message, User>)Container.DataItem).Item2.Posted)%>
                            <span class="fw-bold ps-1">
                                <YAF:LocalizedLabel ID="LocalizedLabel5" runat="server" 
                                                    LocalizedTag="POSTEDBY" LocalizedPage="REPORTPOST" />
                            </span>
                            <YAF:UserLink ID="UserName" runat="server" 
                                          ReplaceName="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item3.DisplayOrUserName() %>"
                                          Suspended="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item3.Suspended %>"
                                          Style="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item3.UserStyle %>"
                                          UserID="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item2.UserID %>" />
                            <YAF:ThemeButton ID="AdminUserButton" runat="server" 
                                             Size="Small"
                                             Visible="<%# this.PageContext.IsAdmin %>"
                                             TextLocalizedTag="ADMIN_USER" TextLocalizedPage="PROFILE"
                                             Icon="users-cog" 
                                             Type="Danger"
                                             NavigateUrl='<%# this.Get<LinkBuilder>().GetLink( ForumPages.Admin_EditUser,"u={0}", ((Tuple<Topic, Message, User>)Container.DataItem).Item2.UserID ) %>'>
                            </YAF:ThemeButton>
                        </div>
                    </div>
                    <div class="card-body">
                        <%# this.FormatMessage((Tuple<Topic, Message, User>)Container.DataItem)%>
                    </div>
                    <div class="card-footer text-center">
                        <YAF:ThemeButton ID="ApproveBtn" runat="server" 
                                         TextLocalizedPage="MODERATE_FORUM"
                                         TextLocalizedTag="APPROVE" 
                                         CommandName="Approve" CommandArgument="<%# ((Tuple<Topic, Message, User>)Container.DataItem).Item2.ID %>"
                                         Icon="check" Type="Success"/>
                        <YAF:ThemeButton ID="DeleteBtn" runat="server"
                                         TextLocalizedPage="MODERATE_FORUM" TextLocalizedTag="DELETE" 
                                         CommandName="Delete" CommandArgument='<%# string.Format("{0};{1}", ((Tuple<Topic, Message, User>)Container.DataItem).Item2.ID, ((Tuple<Topic, Message, User>)Container.DataItem).Item1.ID) %>'
                                         ReturnConfirmText='<%# this.GetText("ASK_DELETE") %>'
                                         Icon="trash" Type="Danger" />
                    </div>
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>