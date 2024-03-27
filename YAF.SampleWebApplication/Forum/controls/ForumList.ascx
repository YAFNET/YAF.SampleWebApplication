﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Controls.ForumList"
    EnableViewState="false" Codebehind="ForumList.ascx.cs" %>
<%@ Import Namespace="YAF.Types.Extensions" %>
<%@ Import Namespace="YAF.Types.Objects.Model" %>
<%@ Import Namespace="YAF.Core.Helpers" %>
<%@ Register TagPrefix="YAF" TagName="ForumLastPost" Src="ForumLastPost.ascx" %>
<%@ Register TagPrefix="YAF" TagName="ForumModeratorList" Src="ForumModeratorList.ascx" %>
<%@ Register TagPrefix="YAF" TagName="ForumSubForumList" Src="ForumSubForumList.ascx" %>

<asp:Repeater ID="ForumList1" runat="server" OnItemDataBound="ForumList1_ItemCreated">
    <SeparatorTemplate>
        <div class="row">
            <div class="col">
                <hr/>
            </div>
        </div>
    </SeparatorTemplate>
    <ItemTemplate>
        <div class="row">
            <div class='<%# ((ForumRead)Container.DataItem).RemoteURL.IsNotSet() ? "col-md-8" : "col" %>'>
                <h5>
                    <asp:PlaceHolder runat="server" ID="ForumIcon"></asp:PlaceHolder>
                    <asp:Image id="ForumImage1" Visible="false" runat="server" />

                    <%# this.GetForumLink((ForumRead)Container.DataItem) %>

                    <asp:Label CssClass='<%# StringHelper.GetTextBgColor("badge text-bg-light") %>' runat="server"
                               Visible="<%# ((ForumRead)Container.DataItem).Viewing > 0 %>">
                        <%# this.GetViewing((ForumRead)Container.DataItem) %>
                    </asp:Label>
                    <asp:PlaceHolder runat="server" Visible="<%# ((ForumRead)Container.DataItem).RemoteURL.IsNotSet() && ((ForumRead)Container.DataItem).ReadAccess  %>">
                        <asp:Label runat="server"
                                   CssClass='<%# StringHelper.GetTextBgColor("badge text-bg-light me-1") %>'
                                   ToolTip='<%# this.GetText("TOPICS") %>'
                                   data-bs-toggle="tooltip">
                            <YAF:Icon runat="server"
                                      IconName="comments"
                                      IconStyle="far"></YAF:Icon>
                            <%# this.Topics((ForumRead)Container.DataItem) %>
                        </asp:Label>
                        <asp:Label runat="server"
                                   CssClass='<%# StringHelper.GetTextBgColor("badge text-bg-light") %>'
                                   ToolTip='<%# this.GetText("Posts") %>'
                                   data-bs-toggle="tooltip">
                            <YAF:Icon runat="server"
                                      IconName="comment"
                                      IconStyle="far"></YAF:Icon>
                            <%# this.Posts((ForumRead)Container.DataItem) %>
                        </asp:Label>
                    </asp:PlaceHolder>
                    <YAF:ForumModeratorList ID="ForumModeratorListMob" runat="server"
                                            Visible="false" />
                </h5>
                <h6 class="card-subtitle text-body-secondary mb-1" runat="server" Visible="<%# ((ForumRead)Container.DataItem).Description.IsSet()  %>">
                    <%# ((ForumRead)Container.DataItem).Description  %>
                </h6>
            </div>
            <asp:PlaceHolder runat="server" Visible="<%# ((ForumRead)Container.DataItem).RemoteURL.IsNotSet() %>">
                <div class="col-md-4 text-secondary">
                    <div class="<%# StringHelper.GetTextBgColor("card text-bg-light card-post-last") %>">
                        <div class="card-body py-1 ps-2">
                            <YAF:ForumLastPost ID="lastPost" runat="server"
                                               DataSource="<%# (ForumRead)Container.DataItem %>"/>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
        </div>
        <div class="row">
            <div class="col">
                <YAF:ForumSubForumList ID="SubForumList" runat="server"
                                       DataSource="<%# this.GetSubForums((ForumRead)Container.DataItem) %>"
                                       Visible="<%# this.HasSubForums((ForumRead)Container.DataItem) %>" />
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
