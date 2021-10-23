﻿<%@ Control Language="c#" Debug="true" AutoEventWireup="True"
    Inherits="YAF.Pages.Admin.ReplaceWords" Codebehind="ReplaceWords.ascx.cs" %>

<%@ Register TagPrefix="modal" TagName="Import" Src="../../Dialogs/ReplaceWordsImport.ascx" %>
<%@ Register TagPrefix="modal" TagName="Edit" Src="../../Dialogs/ReplaceWordsEdit.ascx" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

    <asp:Repeater ID="list" runat="server">
        <HeaderTemplate>
            <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="sticky-note"
                                    LocalizedPage="ADMIN_REPLACEWORDS"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <ul class="list-group">
        </HeaderTemplate>
        <ItemTemplate>
            <li class="list-group-item list-group-item-action list-group-item-menu">
                <div class="d-flex w-100 justify-content-between">
                    <h5 class="mb-1">
                        <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" LocalizedTag="BAD" LocalizedPage="ADMIN_REPLACEWORDS" />:
                        <%# this.HtmlEncode(this.Eval("badword")) %>
                    </h5>
                </div>
                <p class="mb-1">
                    <span class="fw-bold">
                    <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" LocalizedTag="GOOD" LocalizedPage="ADMIN_REPLACEWORDS" />: &nbsp;
                    </span>
                    <%# this.HtmlEncode(this.Eval("goodword")) %>
                </p>
                <small>
                    <div class="btn-group btn-group-sm">
                        <YAF:ThemeButton ID="btnEdit" runat="server"
                                         Type="Info"
                                         Size="Small"
                                         CommandName="edit"
                                         CommandArgument='<%# this.Eval("ID") %>'
                                         TextLocalizedTag="EDIT"
                                         TitleLocalizedTag="EDIT"
                                         Icon="edit">
                        </YAF:ThemeButton>
                        <YAF:ThemeButton ID="ThemeButtonDelete" runat="server"
                                         Type="Danger"
                                         Size="Small"
                                         CommandName="delete"
                                         TextLocalizedTag="DELETE"
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         TitleLocalizedTag="DELETE"
                                         Icon="trash"
                                         ReturnConfirmText='<%# this.GetText("ADMIN_REPLACEWORDS", "MSG_DELETE") %>'>
                        </YAF:ThemeButton>
                    </div>
                </small>
                <div class="dropdown-menu context-menu" aria-labelledby="context menu">
                    <YAF:ThemeButton ID="ThemeButton1" runat="server"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     CommandName="edit"
                                     CommandArgument='<%# this.Eval("ID") %>'
                                     TextLocalizedTag="EDIT"
                                     TitleLocalizedTag="EDIT"
                                     Icon="edit">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton ID="ThemeButton2" runat="server"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     CommandName="delete"
                                     TextLocalizedTag="DELETE"
                                     CommandArgument='<%# this.Eval( "ID") %>'
                                     TitleLocalizedTag="DELETE"
                                     Icon="trash"
                                     ReturnConfirmText='<%# this.GetText("ADMIN_REPLACEWORDS", "MSG_DELETE") %>'>
                    </YAF:ThemeButton>
                    <div class="dropdown-divider"></div>
                    <YAF:ThemeButton runat="server"
                                     CommandName="add"
                                     ID="Linkbutton3"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     Icon="plus-square"
                                     TextLocalizedTag="ADD"
                                     TextLocalizedPage="ADMIN_REPLACEWORDS">
                    </YAF:ThemeButton>
                    <div class="dropdown-divider"></div>
                    <YAF:ThemeButton runat="server"
                                     Icon="upload"
                                     DataToggle="modal"
                                     DataTarget="ReplaceWordsImportDialog"
                                     ID="Linkbutton5"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     TextLocalizedTag="IMPORT"
                                     TextLocalizedPage="ADMIN_REPACEWORDS">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CommandName="export"
                                     ID="Linkbutton4"
                                     Type="None"
                                     CssClass="dropdown-item"
                                     Icon="download"
                                     TextLocalizedTag="EXPORT"
                                     TextLocalizedPage="ADMIN_REPLACEWORDS">
                    </YAF:ThemeButton>
                </div>
            </li>
        </ItemTemplate>
        <FooterTemplate>
                    </ul>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton runat="server"
                                     CommandName="add"
                                     CssClass="mb-1"
                                     ID="Linkbutton3"
                                     Type="Primary"
                                     Icon="plus-square"
                                     TextLocalizedTag="ADD"
                                     TextLocalizedPage="ADMIN_REPLACEWORDS">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CssClass="mb-1"
                                     Icon="upload"
                                     DataToggle="modal"
                                     DataTarget="ReplaceWordsImportDialog"
                                     ID="Linkbutton5"
                                     Type="Info"
                                     TextLocalizedTag="IMPORT"
                                     TextLocalizedPage="ADMIN_REPACEWORDS">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton runat="server"
                                     CssClass="mb-1"
                                     CommandName="export"
                                     ID="Linkbutton4"
                                     Type="Warning"
                                     Icon="download"
                                     TextLocalizedTag="EXPORT"
                                     TextLocalizedPage="ADMIN_REPLACEWORDS">
                    </YAF:ThemeButton>
                </div>
            </div>
        </div>
    </div>
        </FooterTemplate>
    </asp:Repeater>



<modal:Import ID="ImportDialog" runat="server" />
<modal:Edit ID="EditDialog" runat="server" />