﻿<%@ Control Language="c#" AutoEventWireup="True"
    Inherits="YAF.Pages.Admin.PageAccessEdit" Codebehind="PageAccessEdit.ascx.cs" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server" ID="IconHeader"
                                    IconName="building"/>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="AccessList" OnItemDataBound="AccessList_OnItemDataBound" runat="server">
                        <HeaderTemplate>
                            <ul class="list-group">
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li class="list-group-item list-group-item-action">
                                <span class="fw-bold">
                                    <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server"
                                                        LocalizedTag="PAGE"
                                                        LocalizedPage="ADMIN_PAGEACCESSEDIT" />:
                                </span>
                                <asp:Label ID="PageName" runat="server"
                                           AssociatedControlID="ReadAccess" />
                                <div class="form-check form-switch">
                                    <asp:CheckBox  ID="ReadAccess" runat="server"
                                                   Text='<%# this.GetText("CANACCESS") %>'/>
                                </div>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton ID="Save" runat="server"
                                     OnClick="SaveClick"
                                     CssClass="mt-1"
                                     Type="Primary"
                                     Icon="save"
                                     TextLocalizedTag="SAVE"
                                     TextLocalizedPage="ADMIN_PAGEACCESSEDIT" />&nbsp;
                    <YAF:ThemeButton ID="GrantAll" runat="server"
                                     OnClick="GrantAllClick"
                                     CssClass="mt-1"
                                     Type="Info"
                                     Icon="check"
                                     TextLocalizedTag="GRANTALL"
                                     TextLocalizedPage="ADMIN_PAGEACCESSEDIT" />&nbsp;
                    <YAF:ThemeButton ID="RevokeAll" runat="server"
                                     OnClick="RevokeAllClick"
                                     CssClass="mt-1"
                                     Type="Danger"
                                     Icon="trash"
                                     TextLocalizedTag="REVOKEALL"
                                     TextLocalizedPage="ADMIN_PAGEACCESSEDIT" />&nbsp;
                    <YAF:ThemeButton ID="Cancel" runat="server"
                                     OnClick="CancelClick"
                                     CssClass="mt-1"
                                     Type="Secondary"
                                     Icon="times"
                                     TextLocalizedTag="CANCEL"
                                     TextLocalizedPage="ADMIN_PAGEACCESSEDIT" />
                </div>
            </div>
        </div>
    </div>


