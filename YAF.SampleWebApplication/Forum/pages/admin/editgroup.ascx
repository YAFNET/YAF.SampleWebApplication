﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.EditGroup"
    CodeBehind="EditGroup.ascx.cs" %>


<YAF:PageLinks runat="server" ID="PageLinks" />


    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="users"
                                    LocalizedPage="ADMIN_EDITGROUP"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <YAF:HelpLabel ID="HelpLabel1" runat="server"
                                           AssociatedControlID="Name"
                                           LocalizedTag="ROLE_NAME" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="Name" runat="server"
                                         required="required"
                                         CssClass="form-control" />
                            <div class="invalid-feedback">
                                <YAF:LocalizedLabel runat="server"
                                                    LocalizedTag="MSG_NAME" />
                            </div>
                        </div>
                        <div class="mb-3 col-md-6">
                            <YAF:HelpLabel ID="HelpLabel6" runat="server"
                                           AssociatedControlID="Description"
                                           LocalizedTag="DESCRIPTION" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="Description" runat="server"
                                         CssClass="form-control"/>
                        </div>
                    </div>
                    <asp:PlaceHolder runat="server" visible="false" id="IsGuestTR">
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel14" runat="server"
                                           AssociatedControlID="IsGuestX"
                                           LocalizedTag="IS_GUEST" LocalizedPage="ADMIN_EDITGROUP" />
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="IsGuestX" runat="server"
                                              Text="&nbsp;" />
                            </div>
                        </div>
                    </asp:PlaceHolder>
                    <div class="row">
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel2" runat="server"
                                           AssociatedControlID="IsStartX"
                                           LocalizedTag="IS_START" LocalizedPage="ADMIN_EDITGROUP" />
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="IsStartX" runat="server"
                                              Text="&nbsp;"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel3" runat="server"
                                           AssociatedControlID="IsModeratorX"
                                           LocalizedTag="FORUM_MOD" LocalizedPage="ADMIN_EDITGROUP" />
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="IsModeratorX" runat="server"
                                              Text="&nbsp;"></asp:CheckBox>
                            </div>
                        </div>
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel4" runat="server"
                                           AssociatedControlID="IsAdminX"
                                           LocalizedTag="IS_ADMIN" LocalizedPage="ADMIN_EDITGROUP" />
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="IsAdminX" runat="server"
                                              Text="&nbsp;"></asp:CheckBox>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <YAF:HelpLabel ID="HelpLabel12" runat="server"
                                       AssociatedControlID="Priority"
                                       LocalizedTag="PRIORITY" LocalizedPage="ADMIN_EDITGROUP" />
                        <asp:TextBox ID="Priority" runat="server"
                                     CssClass="form-control"
                                     TextMode="Number"
                                     MaxLength="5"
                                     Text="0" />
                    </div>
                    <div class="row">
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel5" runat="server"
                                           AssociatedControlID="PMLimit"
                                           LocalizedTag="PMMESSAGES" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="PMLimit" runat="server"
                                         CssClass="form-control"
                                         TextMode="Number"
                                         Text="0"/>
                        </div>
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel7" runat="server"
                                           AssociatedControlID="UsrSigChars"
                                           LocalizedTag="SIGNATURE_LENGTH" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="UsrSigChars" runat="server"
                                         Text="128"
                                         CssClass="form-control"
                                         TextMode="Number" />
                        </div>
                    </div>
                    <div class="mb-3">
                        <YAF:HelpLabel ID="HelpLabel8" runat="server"
                                       AssociatedControlID="UsrSigBBCodes"
                                       LocalizedTag="SIG_BBCODES" LocalizedPage="ADMIN_EDITGROUP" />
                        <asp:TextBox ID="UsrSigBBCodes" runat="server"
                                     CssClass="form-control"/>
                    </div>
                    <div class="row">
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel10" runat="server"
                                           AssociatedControlID="UsrAlbums"
                                           LocalizedTag="ALBUM_NUMBER" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="UsrAlbums" runat="server"
                                         Text="0"
                                         CssClass="form-control"
                                         TextMode="Number" />
                        </div>
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="HelpLabel11" runat="server"
                                           AssociatedControlID="UsrAlbumImages"
                                           LocalizedTag="IMAGES_NUMBER" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:TextBox ID="UsrAlbumImages" runat="server"
                                         Text="0"
                                         CssClass="form-control"
                                         TextMode="Number" />
                        </div>
                    </div>
                    <div class="mb-3">
                        <YAF:HelpLabel ID="HelpLabel13" runat="server"
                                       AssociatedControlID="StyleTextBox"
                                       LocalizedTag="STYLE" LocalizedPage="ADMIN_EDITGROUP" />
                        <asp:TextBox ID="StyleTextBox" runat="server"
                                     TextMode="MultiLine"
                                     CssClass="form-control" />
                    </div>
                    <asp:PlaceHolder runat="server" id="NewGroupRow">
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel15" runat="server"
                                           AssociatedControlID="AccessMaskID"
                                           LocalizedTag="INITIAL_MASK" LocalizedPage="ADMIN_EDITGROUP" />
                            <asp:DropDownList runat="server" ID="AccessMaskID"
                                              OnDataBinding="BindDataAccessMaskId"
                                              CssClass="form-select" />
                        </div>
                    </asp:PlaceHolder>
                    <asp:Repeater ID="AccessList" runat="server" OnItemDataBound="AccessList_OnItemDataBound">
                        <HeaderTemplate>
                            <div class="row">
                        </HeaderTemplate>
                        <FooterTemplate>
                            </div>
                        </FooterTemplate>
                        <ItemTemplate>
                            <div class="mb-3 col-md-4">
                                <asp:HiddenField ID="ForumID" runat="server" />
                                <asp:Label runat="server" ID="AccessMask"
                                           AssociatedControlID="AccessMaskID" />
                                <asp:DropDownList runat="server" ID="AccessMaskID"
                                                  CssClass="form-select" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton ID="Save" runat="server"
                                     CausesValidation="True"
                                     OnClick="SaveClick"
                                     CssClass="me-2"
                                     Type="Primary"
                                     Icon="save"
                                     TextLocalizedTag="SAVE">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton ID="Cancel" runat="server"
                                     OnClick="CancelClick"
                                     Type="Secondary"
                                     Icon="times"
                                     TextLocalizedTag="CANCEL">
                    </YAF:ThemeButton>
                </div>
            </div>
        </div>
    </div>


