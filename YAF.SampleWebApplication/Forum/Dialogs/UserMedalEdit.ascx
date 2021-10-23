﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserMedalEdit.ascx.cs" Inherits="YAF.Dialogs.UserMedalEdit" %>


<div class="modal fade" id="UserEditDialog" tabindex="-1" role="dialog" aria-labelledby="UserEditDialog" aria-hidden="true">
    <div class="modal-dialog" role="document">

                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">
                            <asp:Label runat="server" ID="UserMedalEditTitle" />
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Modal Content START !-->
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel23" runat="server"
                                           AssociatedControlID="UserName"
                                           LocalizedTag="MEDAL_USER" LocalizedPage="ADMIN_EDITMEDAL"/>
                            <div class="input-group">
                                <asp:DropDownList runat="server" ID="UserNameList"
                                                  Visible="false"
                                                  CssClass="select2-select"/>
                                <asp:TextBox ID="UserName" runat="server"
                                             required="required"
                                             CssClass="form-control"/>
                                <YAF:ThemeButton runat="server" ID="FindUsers"
                                                 Icon="search"
                                                 OnClick="FindUsersClick"
                                                 Type="Info"
                                                 TextLocalizedTag="FIND"/>
                                <YAF:ThemeButton runat="server" ID="Clear"
                                                 Icon="trash"
                                                 OnClick="ClearClick"
                                                 Visible="false"
                                                 Type="Info"
                                                 TextLocalizedTag="CLEAR"/>
                                <asp:TextBox Visible="false" ID="UserID" runat="server"
                                             CssClass="form-control"/>
                            </div>
                            <div class="invalid-feedback">
                                <YAF:LocalizedLabel runat="server"
                                                    LocalizedPage="ADMIN_EDITMEDAL"
                                                    LocalizedTag="MSG_VALID_USER" />
                            </div>
                        </div>
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel19" runat="server"
                                           AssociatedControlID="UserMessage"
                                           LocalizedTag="OVERRIDE_MESSAGE" LocalizedPage="ADMIN_EDITMEDAL"/>
                            <asp:TextBox ID="UserMessage" runat="server"
                                         MaxLength="100"
                                         CssClass="form-control"/>
                        </div>
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel20" runat="server"
                                           AssociatedControlID="UserSortOrder"
                                           LocalizedTag="OVERRIDE_ORDER" LocalizedPage="ADMIN_EDITMEDAL"/>
                            <asp:TextBox ID="UserSortOrder" runat="server"
                                         CssClass="form-control"
                                         TextMode="Number"/>
                        </div>
                        <div class="mb-3">
                            <YAF:HelpLabel ID="HelpLabel22" runat="server"
                                           AssociatedControlID="UserHide"
                                           LocalizedTag="HIDE" LocalizedPage="ADMIN_EDITMEDAL"/>
                            <div class="form-check form-switch">
                                <asp:CheckBox runat="server" ID="UserHide"
                                              Checked="false"
                                              Text="&nbsp;"/>
                            </div>
                        </div>
                        <!-- Modal Content END !-->
                    </div>
                    <div class="modal-footer">
                        <YAF:ThemeButton runat="server"
                                         OnClick="Save_OnClick"
                                         CssClass="me-2"
                                         ID="AddUserSave"
                                         Type="Primary"
                                         Icon="save"
                                         TextLocalizedTag="SAVE"
                                         CausesValidation="True" />
                        <YAF:ThemeButton runat="server" ID="Cancel"
                                         DataDismiss="modal"
                                         TextLocalizedTag="CANCEL"
                                         Type="Secondary"
                                         Icon="times">
                        </YAF:ThemeButton>
                    </div>
                </div>
    </div>
</div>
