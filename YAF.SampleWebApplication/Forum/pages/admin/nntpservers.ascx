<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.NntpServers"
    CodeBehind="NntpServers.ascx.cs" %>
<%@ Register TagPrefix="modal" TagName="Edit" Src="../../Dialogs/NntpServerEdit.ascx" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="newspaper"
                                    LocalizedPage="ADMIN_NNTPSERVERS"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <asp:Repeater ID="RankList" runat="server" OnItemCommand="RankListItemCommand">
            <HeaderTemplate>
                <ul class="list-group">
            </HeaderTemplate>
            <ItemTemplate>
                <li class="list-group-item list-group-item-action list-group-item-menu">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">
                            <%# this.Eval("Name") %>
                        </h5>
                    </div>
                    <p class="mb-1">
                        <span class="fw-bold">
                            <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" LocalizedTag="ADRESS" LocalizedPage="ADMIN_NNTPSERVERS" />:&nbsp;
                        </span>
                        <%# this.Eval("Address") %>
                    </p>
                    <small>
                        <div class="btn-group btn-group-sm">
                            <YAF:ThemeButton runat="server" 
                                             CommandName="edit" 
                                             CommandArgument='<%# this.Eval( "ID") %>' 
                                             Type="Info" 
                                             Size="Small"
                                             Icon="edit" 
                                             TextLocalizedTag="EDIT">
                            </YAF:ThemeButton>
                            <YAF:ThemeButton runat="server"  
                                             Type="Danger" 
                                             Size="Small"
                                             CommandName="delete" 
                                             CommandArgument='<%# this.Eval( "ID") %>'
                                             Icon="trash" 
                                             TextLocalizedTag="DELETE"
                                             ReturnConfirmText='<%#  this.GetText("ADMIN_NNTPSERVERS", "DELETE_SERVER") %>'>
                            </YAF:ThemeButton>
                        </div>
                    </small>
                    <div class="dropdown-menu context-menu" aria-labelledby="context menu">
                        <YAF:ThemeButton runat="server" 
                                         CommandName="edit" 
                                         CommandArgument='<%# this.Eval( "ID") %>' 
                                         Type="None" 
                                         CssClass="dropdown-item"
                                         Icon="edit" 
                                         TextLocalizedTag="EDIT">
                        </YAF:ThemeButton>
                        <YAF:ThemeButton runat="server"  
                                         Type="None" 
                                         CssClass="dropdown-item"
                                         CommandName="delete" 
                                         CommandArgument='<%# this.Eval( "ID") %>'
                                         Icon="trash" 
                                         TextLocalizedTag="DELETE"
                                         ReturnConfirmText='<%#  this.GetText("ADMIN_NNTPSERVERS", "DELETE_SERVER") %>'>
                        </YAF:ThemeButton>
                        <div class="dropdown-divider"></div>
                        <YAF:ThemeButton ID="NewServer" runat="server" 
                                         Type="None" 
                                         CssClass="dropdown-item"
                                         OnClick="NewServerClick"
                                         Icon="plus-square" 
                                         TextLocalizedTag="NEW_SERVER" />
                    </div>
                </li>
            </ItemTemplate>
                        <FooterTemplate>
                            </ul>
                        </FooterTemplate>
        </asp:Repeater>
                    </div>
                    <div class="card-footer text-center">
                        <YAF:ThemeButton ID="NewServer" runat="server" 
                                         Type="Primary" 
                                         OnClick="NewServerClick"
                                         Icon="plus-square" 
                                         TextLocalizedTag="NEW_SERVER" />
                    </div>
            </div>
        </div>
    </div>



<modal:Edit ID="EditDialog" runat="server" />