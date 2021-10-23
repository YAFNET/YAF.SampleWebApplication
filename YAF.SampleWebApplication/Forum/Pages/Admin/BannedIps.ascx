﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.BannedIps" Codebehind="BannedIps.ascx.cs" %>

<%@ Import Namespace="YAF.Types.Interfaces" %>
<%@ Import Namespace="YAF.Types.Interfaces.Services" %>
<%@ Import Namespace="YAF.Core.Helpers" %>
<%@ Import Namespace="YAF.Types.Models" %>

<%@ Register TagPrefix="modal" TagName="Import" Src="../../Dialogs/BannedIpImport.ascx" %>
<%@ Register TagPrefix="modal" TagName="Edit" Src="../../Dialogs/BannedIpEdit.ascx" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <div class="row justify-content-between align-items-center">
                    <div class="col-auto">
                        <YAF:IconHeader runat="server"
                                        IconName="hand-paper"
                                        LocalizedPage="ADMIN_BANNEDIP"></YAF:IconHeader>
                    </div>
                    <div class="col-auto">
                        <div class="btn-toolbar" role="toolbar">
                            <div class="input-group input-group-sm me-2" role="group">
                                <div class="input-group-text">
                                    <YAF:LocalizedLabel ID="HelpLabel2" runat="server" LocalizedTag="SHOW" />:
                                </div>
                                <asp:DropDownList runat="server" ID="PageSize"
                                                  AutoPostBack="True"
                                                  OnSelectedIndexChanged="PageSizeSelectedIndexChanged"
                                                  CssClass="form-select">
                                </asp:DropDownList>
                            </div>
                            <div class="btn-group btn-group-sm" role="group">
                                <YAF:ThemeButton runat="server"
                                                 CssClass="dropdown-toggle"
                                                 DataToggle="dropdown"
                                                 Size="Small"
                                                 Type="Secondary"
                                                 Icon="filter"
                                                 TextLocalizedTag="FILTER_DROPDOWN"
                                                 TextLocalizedPage="ADMIN_USERS" />
                                <div class="dropdown-menu dropdown-menu-end dropdown-menu-lg-start">
                                    <div class="px-3 py-1">
                                        <div class="mb-3">
                                            <YAF:HelpLabel ID="HelpLabel1" runat="server"
                                                           AssociatedControlID="SearchInput"
                                                           LocalizedTag="MASK" LocalizedPage="ADMIN_BANNEDIP" />
                                            <asp:TextBox ID="SearchInput" runat="server"
                                                         CssClass="form-control"></asp:TextBox>
                                        </div>
                                        <div class="mb-3 d-grid gap-2">
                                            <YAF:ThemeButton ID="search" runat="server"
                                                             Type="Primary"
                                                             TextLocalizedTag="BTNSEARCH"
                                                             TextLocalizedPage="SEARCH"
                                                             Icon="search"
                                                             OnClick="Search_Click">
                                            </YAF:ThemeButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <asp:Repeater ID="list" runat="server" OnItemCommand="List_ItemCommand">
        <HeaderTemplate>
            <ul class="list-group">
            </HeaderTemplate>
        <ItemTemplate>
            <li class="list-group-item list-group-item-action list-group-item-menu">
                <div class="d-flex w-100 justify-content-between">
                    <asp:HiddenField ID="fID" Value='<%# this.Eval("ID") %>' runat="server"/>
                    <h5 class="mb-1 text-break">
                        <asp:HyperLink runat="server" ID="Mask"
                                       Href='<%# string.Format(this.PageContext.BoardSettings.IPInfoPageURL, IPHelper.GetIpAddressAsString(this.Eval("Mask").ToString())) %>'
                                       ToolTip='<%#this.GetText("COMMON", "TT_IPDETAILS") %>'
                                       Target="_blank">
                            <%# this.HtmlEncode(IPHelper.GetIpAddressAsString(this.Eval("Mask").ToString())) %>
                        </asp:HyperLink>
                    </h5>
                    <small class="d-none d-md-block">
                        <span class="fw-bold">
                            <YAF:LocalizedLabel ID="LocalizedLabel5" runat="server" LocalizedTag="SINCE" LocalizedPage="ADMIN_BANNEDIP" />
                        </span>
                        <%# this.Get<IDateTimeService>().FormatDateTime(((BannedIP)Container.DataItem).Since) %>

                    </small>
                </div>
                <p class="mb-1">
                    <span class="fw-bold">
                        <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" LocalizedTag="REASON" LocalizedPage="ADMIN_BANNEDIP" />
                    </span>
                    <%# this.Eval("Reason") %>
                </p>
                <small>
                    <div class="btn-group btn-group-sm">
                        <YAF:ThemeButton ID="ThemeButtonEdit"
                                         Type="Info"
                                         Size="Small"
                                         CommandName="edit" CommandArgument='<%# this.Eval("ID") %>'
                                         TextLocalizedTag="EDIT"
                                         TitleLocalizedTag="EDIT"
                                         Icon="edit" runat="server"></YAF:ThemeButton>
                        <YAF:ThemeButton ID="ThemeButtonDelete"
                                         Type="Danger" Size="Small"
                                         CommandName="delete" CommandArgument='<%# this.Eval("ID") %>'
                                         TextLocalizedTag="DELETE"
                                         ReturnConfirmText='<%# this.GetText("ADMIN_BANNEDIP", "MSG_DELETE") %>'
                                         TitleLocalizedTag="DELETE" Icon="trash" runat="server"></YAF:ThemeButton>
                    </div>
                </small>
                <div class="dropdown-menu context-menu" aria-labelledby="context menu">
                    <YAF:ThemeButton ID="ThemeButton1"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     CommandName="edit" CommandArgument='<%# this.Eval("ID") %>'
                                     TextLocalizedTag="EDIT"
                                     TitleLocalizedTag="EDIT"
                                     Icon="edit" runat="server"></YAF:ThemeButton>
                    <YAF:ThemeButton ID="ThemeButton2"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     CommandName="delete" CommandArgument='<%# this.Eval("ID") %>'
                                     TextLocalizedTag="DELETE"
                                     ReturnConfirmText='<%# this.GetText("ADMIN_BANNEDIP", "MSG_DELETE") %>'
                                     TitleLocalizedTag="DELETE" Icon="trash" runat="server"></YAF:ThemeButton>
                    <div class="dropdown-divider"></div>
                    <YAF:ThemeButton runat="server"
                                     Icon="plus-square"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     TextLocalizedTag="ADD_IP" TextLocalizedPage="ADMIN_BANNEDIP"
                                     CommandName="add"></YAF:ThemeButton>
                    <div class="dropdown-divider"></div>
                    <YAF:ThemeButton runat="server"
                                     Icon="upload"
                                     DataToggle="modal"
                                     DataTarget="ImportDialog"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     TextLocalizedTag="IMPORT_IPS" TextLocalizedPage="ADMIN_BANNEDIP"></YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CommandName="export"
                                     ID="Linkbutton4"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     Icon="download"
                                     TextLocalizedPage="ADMIN_BANNEDIP" TextLocalizedTag="EXPORT"></YAF:ThemeButton>
                </div>
            </li>
            </ItemTemplate>
        <FooterTemplate>
                </ul>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton runat="server"
                                     CssClass="mb-1"
                                     Icon="plus-square"
                                     Type="Primary"
                                     TextLocalizedTag="ADD_IP" TextLocalizedPage="ADMIN_BANNEDIP"
                                     CommandName="add"></YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CssClass="mb-1"
                                     Icon="upload"
                                     DataToggle="modal"
                                     DataTarget="ImportDialog"
                                     Type="Info"
                                     TextLocalizedTag="IMPORT_IPS" TextLocalizedPage="ADMIN_BANNEDIP"></YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CssClass="mb-1"
                                     CommandName="export"
                                     ID="Linkbutton4"
                                     Type="Warning"
                                     Icon="download"
                                     TextLocalizedPage="ADMIN_BANNEDIP" TextLocalizedTag="EXPORT"></YAF:ThemeButton>
                </div>
            </div>
        </FooterTemplate>
        </asp:Repeater>
            </div>
        </div>
    </div>
</div>
<div class="row justify-content-end">
    <div class="col-auto">
        <YAF:Pager ID="PagerTop" runat="server" OnPageChange="PagerTop_PageChange" />
    </div>
</div>


<modal:Import ID="ImportDialog" runat="server" />
<modal:Edit ID="EditDialog" runat="server" />