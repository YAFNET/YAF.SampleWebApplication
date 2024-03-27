﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.Restore" CodeBehind="Restore.ascx.cs" %>
<%@ Import Namespace="YAF.Types.Constants" %>
<%@ Import Namespace="YAF.Core.Services" %>
<%@ Import Namespace="YAF.Types.Objects.Model" %>
<%@ Import Namespace="YAF.Types.Extensions" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row justify-content-between align-items-center">
                    <div class="col-auto">
                        <YAF:IconHeader runat="server"
                                        IconType="text-secondary"
                                        IconName="trash-restore"
                                        LocalizedPage="ADMIN_RESTORE"></YAF:IconHeader>
                    </div>
                <div class="col-auto">
                    <div class="btn-toolbar" role="toolbar">
                        <div class="input-group input-group-sm me-2" role="group">
                        <div class="input-group-text">
                            <YAF:LocalizedLabel ID="LocalizedLabel1" runat="server" LocalizedTag="SHOW" />:
                        </div>
                        <asp:DropDownList runat="server" ID="PageSize"
                                          AutoPostBack="True"
                                          OnSelectedIndexChanged="PageSizeSelectedIndexChanged"
                                          CssClass="form-select">
                        </asp:DropDownList>
                    </div>
                    <YAF:ThemeButton runat="server"
                                     CssClass="dropdown-toggle"
                                     DataToggle="dropdown"
                                     Size="Small"
                                     Type="Secondary"
                                     Icon="filter"
                                     TextLocalizedTag="FILTER_DROPDOWN"
                                     TextLocalizedPage="ADMIN_USERS"></YAF:ThemeButton>
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start">
                        <div class="px-3 py-1">
                            <div class="mb-3">
                                <YAF:HelpLabel ID="HelpLabel2" runat="server"
                                               AssociatedControlID="Filter"
                                               LocalizedTag="FILTER" LocalizedPage="ADMIN_RESTORE" />
                                <asp:TextBox runat="server" ID="Filter"
                                             CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3 d-grid gap-2">
                                <YAF:ThemeButton runat="server"
                                                 Icon="sync-alt"
                                                 Type="Primary"
                                                 TextLocalizedTag="SEARCH"
                                                 TextLocalizedPage="ADMIN_RESTORE"
                                                 OnClick="RefreshClick"></YAF:ThemeButton>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
                    </div>
            </div>
                <asp:Repeater runat="server" ID="DeletedTopics" OnItemCommand="List_ItemCommand">
                    <HeaderTemplate>
                        <div class="card-body">
                        <ul class="list-group">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">
                                    <%# ((PagedTopic)Container.DataItem).Subject %>
                                    <YAF:ThemeButton runat="server" ID="ThemeButton1"
                                                     Type="Link"
                                                     Icon="external-link-alt"
                                                     Visible="<%# ((PagedTopic)Container.DataItem).NumPosts > 0 %>"
                                                     NavigateUrl="<%# this.Get<LinkBuilder>().GetLink(ForumPages.Posts, new { t = ((PagedTopic)Container.DataItem).TopicID, name = ((PagedTopic)Container.DataItem).Subject }) %>">
                                </YAF:ThemeButton>
                                </h5>
                                <small><%# "{0} {1}".FormatWith(((PagedTopic)Container.DataItem).NumPosts, this.GetText("POSTS")) %></small>
                            </div>
                            <p class="mb-1">

                            </p>
                            <small>
                                <div class="btn-group">
                                    <YAF:ThemeButton runat="server" ID="Restore"
                                                     TextLocalizedTag="RESTORE_TOPIC"
                                                     Icon="trash-restore"
                                                     Type="Success"
                                                     CommandName="restore"
                                                     Visible="<%# ((PagedTopic)Container.DataItem).NumPosts > 0 %>"
                                                     CommandArgument='<%# ((PagedTopic)Container.DataItem).TopicID + ";" + ((PagedTopic)Container.DataItem).ForumID %>'></YAF:ThemeButton>
                                    <YAF:ThemeButton runat="server" ID="Delete"
                                                     TextLocalizedTag="DELETE"
                                                     Type="Danger"
                                                     Icon="trash"
                                                     CommandName="delete"
                                                     CommandArgument='<%# ((PagedTopic)Container.DataItem).TopicID + ";" + ((PagedTopic)Container.DataItem).ForumID %>'>
                                    </YAF:ThemeButton>
                                </div>
                            </small>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    <YAF:Alert runat="server" ID="NoInfo"
                               Type="success"
                               Visible="<%# this.DeletedTopics.Items.Count == 0 %>">
                        <YAF:Icon runat="server" IconName="check" />
                        <YAF:LocalizedLabel runat="server"
                                            LocalizedTag="NO_ENTRY"></YAF:LocalizedLabel>
                    </YAF:Alert>
                        </div>
                    <asp:PlaceHolder runat="server" Visible="<%# this.DeletedTopics.Items.Count > 0 %>">
                        <div class="card-footer text-center">
                            <YAF:ThemeButton runat="server"
                                             CommandName="delete_all"
                                             CssClass="me-2"
                                             ID="Linkbutton4"
                                             Type="Danger"
                                             Icon="dumpster"
                                             TextLocalizedTag="DELETE_ALL"
                                             TextLocalizedPage="ADMIN_EVENTLOG">
                            </YAF:ThemeButton>
                            <YAF:ThemeButton runat="server"
                                             CommandName="delete_zero"
                                             ID="ThemeButton2"
                                             Type="Danger"
                                             Icon="dumpster"
                                             TextLocalizedTag="DELETE_ALL_ZERO"
                                             TextLocalizedPage="ADMIN_RESTORE">
                            </YAF:ThemeButton>
                        </div>
                    </asp:PlaceHolder>
                    </FooterTemplate>
                </asp:Repeater>
            </div>

        </div>
</div>
<div class="row justify-content-end">
<div class="col-auto">
    <YAF:Pager ID="PagerTop" runat="server"
               OnPageChange="PagerTop_PageChange" />
</div>
</div>
<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row justify-content-between align-items-center">
                    <div class="col-auto">
                        <YAF:IconHeader runat="server"
                                        IconType="text-secondary"
                                        IconName="trash-restore"
                                        LocalizedTag="TITLE_MESSAGE"
                                        LocalizedPage="ADMIN_RESTORE"></YAF:IconHeader>
                    </div>
                    <div class="col-auto">
                        <div class="input-group input-group-sm me-2" role="group">
                            <div class="input-group-text">
                                <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" LocalizedTag="SHOW" />:
                            </div>
                            <asp:DropDownList runat="server" ID="PageSizeMessages"
                                              AutoPostBack="True"
                                              OnSelectedIndexChanged="PageSizeSelectedIndexChanged"
                                              CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
                <asp:Repeater runat="server" ID="DeletedMessages" OnItemCommand="Messages_ItemCommand">
                    <HeaderTemplate>
                        <div class="card-body">
                        <ul class="list-group">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li class="list-group-item list-group-item-action">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">
                                    <%# ((PagedMessage)Container.DataItem).Topic %>
                                    <YAF:ThemeButton runat="server" ID="ThemeButton1"
                                                     Type="Link"
                                                     Icon="external-link-alt"
                                                     NavigateUrl="<%# this.Get<LinkBuilder>().GetLink(ForumPages.Posts, new { m = ((PagedMessage)Container.DataItem).MessageID, name = ((PagedMessage)Container.DataItem).Topic }) %>">
                                </YAF:ThemeButton>
                                </h5>
                            </div>
                            <p class="mb-1">
                                <%# ((PagedMessage)Container.DataItem).Message %>
                            </p>
                            <small>
                                <div class="btn-group">
                                    <YAF:ThemeButton runat="server" ID="Restore"
                                                     TextLocalizedTag="RESTORE_MESSAGE"
                                                     Icon="trash-restore"
                                                     Type="Success"
                                                     CommandName="restore"
                                                     CommandArgument='<%# ((PagedMessage)Container.DataItem).MessageID + ";" + ((PagedMessage)Container.DataItem).ForumID + ";" + ((PagedMessage)Container.DataItem).TopicID %>'></YAF:ThemeButton>
                                    <YAF:ThemeButton runat="server" ID="Delete"
                                                     TextLocalizedTag="DELETE"
                                                     Type="Danger"
                                                     Icon="trash"
                                                     CommandName="delete"
                                                     CommandArgument='<%# ((PagedMessage)Container.DataItem).MessageID + ";" + ((PagedMessage)Container.DataItem).ForumID + ";" + ((PagedMessage)Container.DataItem).TopicID %>'>
                                    </YAF:ThemeButton>
                                </div>
                            </small>
                        </li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    <YAF:Alert runat="server" ID="NoInfo"
                               Type="success"
                               Visible="<%# this.DeletedMessages.Items.Count == 0 %>">
                        <YAF:Icon runat="server" IconName="check" />
                        <YAF:LocalizedLabel runat="server"
                                            LocalizedTag="NO_ENTRY"></YAF:LocalizedLabel>
                    </YAF:Alert>
                    </div>
                    <asp:PlaceHolder runat="server" Visible="<%# this.DeletedMessages.Items.Count > 0 %>">
                        <div class="card-footer text-center">
                            <YAF:ThemeButton runat="server"
                                             CommandName="delete_all"
                                             ID="Linkbutton4"
                                             Type="Danger"
                                             Icon="dumpster"
                                             TextLocalizedTag="DELETE_ALL"
                                             TextLocalizedPage="ADMIN_EVENTLOG">
                            </YAF:ThemeButton>
                        </div>
                    </asp:PlaceHolder>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
    </div>
</div>
<div class="row justify-content-end">
    <div class="col-auto">
        <YAF:Pager ID="PagerMessages" runat="server"
                   OnPageChange="PagerTop_PageChange" />
    </div>
</div>