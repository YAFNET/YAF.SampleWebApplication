﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.Boards" Codebehind="Boards.ascx.cs" %>

<%@ Import Namespace="YAF.Types.Extensions" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="globe"
                                    LocalizedPage="ADMIN_BOARDS"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="List" runat="server">
                        <HeaderTemplate>
                            <ul class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
                <li
                    class='list-group-item list-group-item-action list-group-item-menu <%# this.Eval("ID").ToType<int>() != this.PageContext.PageBoardID ? "" : "active" %>'>
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">
                        <%# this.HtmlEncode(this.Eval( "Name")) %>
                    </h5>
                    <small>
                        <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server"
                                            LocalizedTag="ID"
                                            LocalizedPage="ADMIN_BOARDS" />: <%# this.Eval( "ID") %>
                    </small>
                </div>
                <small>
                    <div class="btn-group btn-group-sm">
                        <YAF:ThemeButton ID="ThemeButtonEdit" runat="server"
                                         Type="Info"
                                         Size="Small"
                                         CommandName="edit"
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         TitleLocalizedTag="EDIT"
                                         TextLocalizedTag="EDIT"
                                         Icon="edit">
                        </YAF:ThemeButton>
                        <YAF:ThemeButton ID="ThemeButtonDelete" runat="server"
                                         Type="Danger"
                                         Size="Small"
                                         CommandName="delete"
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         TitleLocalizedTag="DELETE"
                                         TextLocalizedTag="DELETE"
                                         Icon="trash"
                                         ReturnConfirmText='<%# this.GetText("ADMIN_BOARDS", "CONFIRM_DELETE") %>'
                                         Visible="<%# this.List.Items.Count > 1  %>">
                        </YAF:ThemeButton>
                    </div>
                </small>
                    <div class="dropdown-menu context-menu" aria-labelledby="context menu">
                        <YAF:ThemeButton ID="ThemeButton1" runat="server"
                                         Type="None"
                                         CssClass="dropdown-item"
                                         CommandName="edit"
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         TitleLocalizedTag="EDIT"
                                         TextLocalizedTag="EDIT"
                                         Icon="edit">
                        </YAF:ThemeButton>
                        <YAF:ThemeButton ID="ThemeButton2" runat="server"
                                         Type="None"
                                         CssClass="dropdown-item"
                                         CommandName="delete"
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         TitleLocalizedTag="DELETE"
                                         TextLocalizedTag="DELETE"
                                         Icon="trash"
                                         ReturnConfirmText='<%# this.GetText("ADMIN_BOARDS", "CONFIRM_DELETE") %>'>
                        </YAF:ThemeButton>
                        <div class="dropdown-divider"></div>
                        <YAF:ThemeButton ID="New" runat="server"
                                         Type="None"
                                         CssClass="dropdown-item"
                                         TextLocalizedTag="NEW_BOARD"
                                         Icon="plus-square"></YAF:ThemeButton>
                    </div>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton ID="New" runat="server"
                                     Type="Primary"
                                     TextLocalizedTag="NEW_BOARD"
                                     Icon="plus-square"></YAF:ThemeButton>
                </div>
            </div>
        </div>
    </div>


