﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Team" Codebehind="Team.ascx.cs" %>

<%@ Import Namespace="YAF.Types.Constants" %>
<%@ Import Namespace="YAF.Types.Interfaces" %>
<%@ Import Namespace="YAF.Types.Extensions" %>
<%@ Import Namespace="YAF.Core.Services" %>
<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col">
        <h2><YAF:LocalizedLabel runat="server" LocalizedTag="TITLE" /></h2>
    </div>
</div>
<div class="row">
    <div class="col">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="user-shield"
                                LocalizedTag="Admins"
                                LocalizedPage="TEAM"></YAF:IconHeader>
            </div>
            <div class="card-body">
                <asp:Repeater ID="AdminsList" runat="server" OnItemDataBound="AdminsList_OnItemDataBound">
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                        <HeaderTemplate>
                            <ul class="list-group">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="list-group-item list-group-item-action">
                             <div class="d-flex w-100 justify-content-between mb-3">
                                 <h5 class="mb-1 text-break">
                                     <asp:Image ID="AdminAvatar" runat="server"
                                                style="max-height: 50px; max-width:50px"
                                                CssClass="rounded img-fluid"/>
                                     <YAF:UserLink ID="AdminLink" runat="server"
                                                   IsGuest="False"
                                                   ReplaceName='<%#  this.Eval(this.PageContext.BoardSettings.EnableDisplayName ? "DisplayName" : "Name").ToString() %>'
                                                   Suspended='<%# this.Eval("Suspended").ToType<DateTime?>() %>'
                                                   UserID='<%# this.Eval("ID").ToType<int>() %>'
                                                   Style='<%# this.Eval("UserStyle") %>'  />
                                 </h5>
                                 <small>
                                     <span class="fw-bold">
                                         <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server"
                                                             LocalizedTag="FORUMS" />:
                                     </span>
                                     <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" LocalizedTag="FORUMS_ALL" LocalizedPage="TEAM" />
                                 </small>
                             </div>
                            <small>
                                <div class="btn-group" role="group">
                                    <YAF:ThemeButton ID="PM" runat="server"
                                                     Size="Small"
                                                     Visible="false"
                                                     TextLocalizedPage="POSTS" TextLocalizedTag="PM"
                                                     TitleLocalizedPage="POSTS" TitleLocalizedTag="PM_TITLE"
                                                     Icon="envelope" Type="Secondary"/>
                                    <YAF:ThemeButton ID="Email" runat="server"
                                                     Size="Small" Visible="false"
                                                     TextLocalizedPage="POSTS" TextLocalizedTag="EMAIL"
                                                     TitleLocalizedPage="POSTS" TitleLocalizedTag="EMAIL_TITLE"
                                                     Icon="at" Type="Secondary" />
                                    <YAF:ThemeButton ID="AdminUserButton" runat="server"
                                                     TitleLocalizedPage="PROFILE" TitleLocalizedTag="ADMIN_USER"
                                                     TextLocalizedTag="ADMIN_USER" TextLocalizedPage="PROFILE"
                                                     Size="Small"
                                                     Visible="false"
                                                     Icon="user-cog"
                                                     Type="Danger"
                                                     NavigateUrl='<%# this.Get<LinkBuilder>().GetLink(ForumPages.Admin_EditUser,"u={0}", this.Eval("ID").ToType<int>() ) %>'>
                                    </YAF:ThemeButton>
                                </div>
                            </small>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
            </div>
        </div>
    </div>
    <div class="col" id="ModsTable" runat="server">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="user-secret"
                                LocalizedTag="MODS"
                                LocalizedPage="TEAM"></YAF:IconHeader>
            </div>
            <div class="card-body">
                <asp:Repeater ID="ModeratorsList" runat="server" OnItemDataBound="ModeratorsList_OnItemDataBound">
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                        <HeaderTemplate>
                            <ul class="list-group">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="list-group-item list-group-item-action">
                             <div class="d-flex w-100 justify-content-between mb-3">
                                 <h5 class="mb-1 text-break">
                                     <asp:Image ID="ModAvatar" runat="server"
                                                style="max-height: 50px; max-width:50px"
                                                CssClass="rounded img-fluid"/>
                                     <YAF:UserLink ID="ModLink" runat="server"
                                                   Suspended='<%# this.Eval("Suspended").ToType<DateTime?>() %>'
                                                   ReplaceName='<%#  this.Eval(this.PageContext.BoardSettings.EnableDisplayName ? "DisplayName" : "Name").ToString() %>'
                                                   UserID='<%# this.Eval("ModeratorID").ToType<int>() %>'
                                                   IsGuest="False"
                                                   Style='<%# this.Eval("Style") %>'  />
                                 </h5>
                             </div>
                                <span class="fw-bold">
                                            <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server"
                                                                LocalizedTag="FORUMS" />:
                                        </span>
                                    <div class="input-group">
                                        <YAF:ThemeButton ID="GoToForumButton" runat="server"
                                                         Icon="external-link-alt"
                                                         Type="Secondary"
                                                         TextLocalizedTag="GO"
                                                         OnClick="GoToForum"></YAF:ThemeButton>
                                        <asp:DropDownList ID="ModForums" runat="server" CssClass="form-control">
                                        </asp:DropDownList>
                                    </div>
                            <small>
                                <div class="btn-group mt-2" role="group">
                                    <YAF:ThemeButton ID="PM" runat="server"
                                                     Size="Small" Visible="false"
                                                     TextLocalizedPage="POSTS" TextLocalizedTag="PM"
                                                     TitleLocalizedPage="POSTS" TitleLocalizedTag="PM_TITLE"
                                                     Icon="envelope" Type="Secondary" />
                                    <YAF:ThemeButton ID="Email" runat="server"
                                                     Size="Small" Visible="false"
                                                     TextLocalizedPage="POSTS" TextLocalizedTag="EMAIL"
                                                     TitleLocalizedPage="POSTS" TitleLocalizedTag="EMAIL_TITLE"
                                                     Icon="at" Type="Secondary" />
                                    <YAF:ThemeButton ID="AdminUserButton" runat="server"
                                                     Size="Small"
                                                     Visible="false"
                                                     TitleLocalizedPage="PROFILE" TitleLocalizedTag="ADMIN_USER"
                                                     TextLocalizedTag="ADMIN_USER" TextLocalizedPage="PROFILE"
                                                     Icon="user-cog"
                                                     Type="Danger"
                                                     NavigateUrl='<%# this.Get<LinkBuilder>().GetLink( ForumPages.Admin_EditUser,"u={0}", this.Eval("ModeratorID").ToType<int>() ) %>'>
                                    </YAF:ThemeButton>
                                </div>
                            </small>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
            </div>
        </div>
    </div>
</div>