﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Controls.CategoryList"
    CodeBehind="CategoryList.ascx.cs" %>
<%@ Import Namespace="YAF.Types.Objects.Model" %>
<%@ Import Namespace="YAF.Core.Extensions" %>
<%@ Import Namespace="YAF.Core.Services" %>
<%@ Import Namespace="YAF.Types.Extensions" %>

<%@ Register TagPrefix="YAF" TagName="ForumList" Src="ForumList.ascx" %>

<asp:UpdatePanel runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Repeater ID="Categories" runat="server">
    <ItemTemplate>
                    <div class="row">
                        <div class="col">
                            <div class="card mb-3">
                                <div class="card-header">
                                    <div class="row justify-content-between align-items-center">
                                        <div class="col-auto">
                                            <div class="d-none d-md-inline-block icon-category">
                                                <%#  this.GetCategoryImage((ForumRead)Container.DataItem) %>
                                            </div>
                                            <a href="<%#this.Get<LinkBuilder>().GetCategoryLink(((ForumRead)Container.DataItem).CategoryID, ((ForumRead)Container.DataItem).Category)%>">
                                                <%# this.HtmlEncode(((ForumRead)Container.DataItem).Category) %>
                                            </a>
                                        </div>
                                        <div class="col-auto">
                                            <YAF:CollapseButton ID="CollapsibleImage" runat="server"
                                                                PanelID='<%# "categoryPanel{0}".FormatWith(((ForumRead)Container.DataItem).CategoryID) %>'
                                                                AttachedControlID="body"
                                                                CssClass="ps-0" />
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" id="body" runat="server">
                                    <YAF:ForumList runat="server"
                                                   Visible="true"
                                                   ID="forumList"
                                                   DataSource="<%# this.GetForums((ForumRead)Container.DataItem) %>"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    <div class="d-flex flex-row-reverse mb-3">
                        <div>
                           <div class="btn-group" role="group" aria-label="Tools">
                                <YAF:ThemeButton runat="server" ID="WatchForum"
                                                 OnClick="WatchAllClick"
                                                 Type="Secondary"
                                                 Size="Small"
                                                 Icon="eye"
                                                 TextLocalizedTag="WATCHFORUM_ALL"
                                                 TitleLocalizedTag="WATCHFORUM_ALL_HELP"
                                                 CommandArgument="<%# this.PageBoardContext.PageCategoryID != 0 ? this.PageBoardContext.PageCategoryID.ToString() : null %>"
                                                 Visible="<%# !this.PageBoardContext.IsGuest %>"/>
                                <YAF:ThemeButton runat="server" ID="MarkAll"
                                                 OnClick="MarkAllClick"
                                                 Type="Secondary"
                                                 Size="Small"
                                                 Icon="glasses"
                                                 TextLocalizedTag="MARKALL"
                                                 CommandArgument="<%# this.PageBoardContext.PageCategoryID != 0 ? this.PageBoardContext.PageCategoryID.ToString() : null %>"/>
                            </div>
                        </div>
                    </div>
            </FooterTemplate>
</asp:Repeater>
        <div class="text-center">
            <YAF:Alert runat="server" id="ForumsShown" Type="light" Visible="False">
                <asp:Label runat="server" id="ForumsShownLabel" CssClass="me-3 align-top"></asp:Label>
                <YAF:ThemeButton runat="server" ID="ShowMore"
                                 OnClick="ShowMoreClick"
                                 CssClass="mb-3"
                                 Type="OutlineSecondary"
                                 Size="Small"
                                 Icon="spinner"
                                 TextLocalizedTag="LOAD_MORE"/>
            </YAF:Alert>
            
        </div>
    </ContentTemplate>

</asp:UpdatePanel>