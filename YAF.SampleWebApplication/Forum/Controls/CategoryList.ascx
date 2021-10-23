﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Controls.CategoryList"
    CodeBehind="CategoryList.ascx.cs" %>
<%@ Import Namespace="YAF.Types.Objects.Model" %>
<%@ Import Namespace="YAF.Core.Extensions" %>
<%@ Import Namespace="ServiceStack.Text" %>

<%@ Register TagPrefix="YAF" TagName="ForumList" Src="ForumList.ascx" %>

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
                                            <%# this.HtmlEncode(((ForumRead)Container.DataItem).Category) %>
                                        </div>
                                        <div class="col-auto">
                                            <YAF:CollapseButton ID="CollapsibleImage" runat="server"
                                                                PanelID='<%# "categoryPanel{0}".Fmt(((ForumRead)Container.DataItem).CategoryID) %>'
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
                                                 CommandArgument="<%# this.PageContext.PageCategoryID != 0 ? this.PageContext.PageCategoryID.ToString() : null %>"
                                                 Visible="<%# !this.PageContext.IsGuest %>"/>
                                <YAF:ThemeButton runat="server" ID="MarkAll"
                                                 OnClick="MarkAllClick"
                                                 Type="Secondary"
                                                 Size="Small"
                                                 Icon="glasses"
                                                 TextLocalizedTag="MARKALL"
                                                 CommandArgument="<%# this.PageContext.PageCategoryID != 0 ? this.PageContext.PageCategoryID.ToString() : null %>"/>
                            </div>
                        </div>
                    </div>
            </FooterTemplate>
</asp:Repeater>