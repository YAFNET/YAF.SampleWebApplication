﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserMenu.ascx.cs" Inherits="YAF.Controls.UserMenu" %>
<%@ Import Namespace="YAF.Types.Constants" %>
<%@ Import Namespace="YAF.Core.Extensions" %>

<li class="nav-item dropdown">
    <YAF:Themebutton runat="server" ID="UserDropDown">
        <span class="badge bg-light text-dark p-0 border border-light me-1">
            <asp:Image runat="server" ID="UserAvatar"
                       AlternateText="avatar"
                       CssClass="img-navbar-avatar rounded"/>
        </span>
        <%= this.HtmlEncode(this.PageContext.User.DisplayOrUserName()) %>
        <asp:PlaceHolder runat="server" id="UnreadPlaceHolder">
            <asp:Label runat="server" ID="UnreadLabel"
                       CssClass="ms-1 badge bg-danger">
            </asp:Label>
        </asp:PlaceHolder>
    </YAF:Themebutton>
    <div class="dropdown-menu" aria-labelledby="userDropdown">
        <asp:PlaceHolder id="MyProfile" runat="server"></asp:PlaceHolder>
        <a href="#" data-bs-toggle="dropdown"
               class="dropdown-item dropdown-submenu dropdown-toggle<%= this.PageContext.ForumPageType == ForumPages.Profile_EditProfile ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_EditSettings ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_ChangePassword  ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_Attachments  ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_EditAvatar ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_EditSignature  ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_Subscriptions  ||
                                                                        this.PageContext.ForumPageType == ForumPages.Profile_BlockOptions  ? " active" : ""%>"><i class="fa fa-user-cog fa-fw"></i>&nbsp;<YAF:LocalizedLabel runat="server"
                                                                           LocalizedTag="MYSETTINGS" LocalizedPage="TOOLBAR"></YAF:LocalizedLabel></a>
            <div class="dropdown-menu">
                <asp:PlaceHolder runat="server" ID="MySettings"></asp:PlaceHolder>
            </div>

        <div class="dropdown-divider"></div>
        <asp:PlaceHolder ID="MyInboxItem" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="MyBuddiesItem" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="MyAlbumsItem" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="MyTopicItem" runat="server"></asp:PlaceHolder>
        <asp:PlaceHolder ID="LogutItem" runat="server" Visible="false">
            <div class="dropdown-divider"></div>
            <YAF:ThemeButton ID="LogOutButton" runat="server"
                             TextLocalizedTag="LOGOUT"
                             TextLocalizedPage="TOOLBAR"
                             TitleLocalizedTag="LOGOUT"
                             Icon="sign-out-alt"
                             CssClass="dropdown-item">
            </YAF:ThemeButton>
        </asp:PlaceHolder>
    </div>
</li>
<asp:PlaceHolder runat="server" ID="MyNotifications">
    <li class="nav-item dropdown dropdown-notify<%= this.PageContext.ForumPageType == ForumPages.Notification ? " active" : ""%>">
        <YAF:Themebutton runat="server" ID="NotifyItem"
                         Type="None"
                         DataToggle="dropdown"
                         CssClass="nav-link dropdown-toggle notify-toggle"
                         TitleLocalizedTag="MYNOTIFY_TITLE"
                         TitleLocalizedPage="TOOLBAR">
            <YAF:Icon runat="server" ID="UnreadIcon"
                      IconName="dot-circle"
                      IconType="fa-xs text-primary unread"></YAF:Icon>
            <YAF:Icon runat="server" ID="NotifyIcon"
                      IconName="bell"></YAF:Icon>

        </YAF:Themebutton>
        <div class="dropdown-menu">
            <YAF:NotifyPopMenu runat="server" ID="NotifyPopMenu">
            </YAF:NotifyPopMenu>
            <div class="dropdown-item d-none" ID="MarkRead">
                <YAF:ThemeButton runat="server" OnClick="MarkAll_Click" ID="MarkAll"
                                 TextLocalizedTag="MARK_ALL_ASREAD" TextLocalizedPage="DEFAULT"
                                 Type="Secondary"
                                 Size="Small"
                                 Icon="glasses"/>
            </div>
        </div>
    </li>
</asp:PlaceHolder>