﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Account.Register" Codebehind="Register.ascx.cs" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col">
        <div class="card">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconType="text-secondary"
                                LocalizedTag="CREATE_USER"
                                IconName="user-plus"/>
            </div>
            <asp:Panel runat="server" ID="Message" CssClass="card-body text-center" Visible="False">
                <YAF:Alert runat="server" Type="success">
                    <asp:Literal ID="AccountCreated" runat="server" />
                </YAF:Alert>
            </asp:Panel>
            <asp:Panel ID="BodyRegister" runat="server" CssClass="card-body">
                <div class="row">
                    <div class="mb-3 col-md-6">
                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">
                            <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server"
                                                LocalizedTag="USERNAME" />
                            </asp:Label>

                        <asp:TextBox ID="UserName" runat="server"
                                     CssClass="form-control"
                                     required="required"></asp:TextBox>
                        <YAF:LocalizedRequiredFieldValidator ID="UserNameRequired" runat="server"
                                                             ControlToValidate="UserName"
                                                             LocalizedTag="NEED_USERNAME"
                                                             CssClass="invalid-feedback" />
                    </div>
                    <asp:PlaceHolder runat="server" ID="DisplayNamePlaceHolder" Visible="false">
                        <div class="mb-3 col-md-6">
                            <asp:Label ID="DisplayNameLabel" runat="server" AssociatedControlID="DisplayName">
                                <YAF:LocalizedLabel ID="LocalizedLabel1" runat="server" LocalizedTag="DISPLAYNAME" />
                                </asp:Label>

                            <asp:TextBox ID="DisplayName" runat="server"
                                         CssClass="form-control"></asp:TextBox>
                        </div>

                    </asp:PlaceHolder>
                </div>
                <div class="mb-3">
                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">
                        <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" LocalizedTag="EMAIL" />
                    </asp:Label>
                    <asp:TextBox ID="Email" runat="server"
                                 TextMode="Email"
                                 CssClass="form-control"
                                 required="required"
                                 placeholder="name@example.com"></asp:TextBox>
                    <YAF:LocalizedRequiredFieldValidator ID="EmailRequired" runat="server"
                                                         ControlToValidate="Email"
                                                         LocalizedTag="NEED_EMAIL"
                                                         CssClass="invalid-feedback" />
                    <asp:RegularExpressionValidator ID="EmailValid" runat="server"
                                                    ControlToValidate="Email"
                                                    ValidationExpression="^([0-9a-zA-Z]+[-._+&])*[0-9a-zA-Z]+@([-0-9a-zA-Z]+[.])+[a-zA-Z]{2,10}$"
                                                    CssClass="invalid-feedback">
                    </asp:RegularExpressionValidator>
                </div>
                <div class="row">
                            <div class="mb-3 col-md-6">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">
                                    <YAF:LocalizedLabel ID="LocalizedLabel4" runat="server" LocalizedTag="PASSWORD" />
                                    </asp:Label>
                                <asp:TextBox ID="Password" runat="server"
                                             TextMode="Password"
                                             CssClass="form-control"
                                             autocomplete="new-password"
                                             required="required"></asp:TextBox>
                                <div class="d-none" id="passwordStrength">
                                    <small class="form-text text-body-secondary mb-2" id="passwordHelp"></small>
                                    <div class="progress">
                                        <div id="progress-password" class="progress-bar" aria-label="password strength" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                </div>
                            <YAF:LocalizedRequiredFieldValidator ID="PasswordRequired" runat="server"
                                                                 ControlToValidate="Password"
                                                                 LocalizedTag="NEED_PASSWORD"
                                                                 CssClass="invalid-feedback"/>
                            </div>
                            <div class="mb-3 col-md-6">
                                <asp:Label ID="ConfirmPasswordLabel" runat="server"
                                           AssociatedControlID="ConfirmPassword">
                                    <YAF:LocalizedLabel ID="LocalizedLabel5" runat="server"
                                                        LocalizedTag="CONFIRM_PASSWORD" />
                                    </asp:Label>
                                <asp:TextBox ID="ConfirmPassword" runat="server"
                                             TextMode="Password"
                                             CssClass="form-control"
                                             autocomplete="new-password"
                                             required="required"></asp:TextBox>
                                <YAF:LocalizedRequiredFieldValidator ID="ConfirmPasswordRequired" runat="server"
                                                                     ControlToValidate="ConfirmPassword"
                                                                     LocalizedTag="RETYPE_PASSWORD"
                                                                     CssClass="invalid-feedback" />
                                 <div class="invalid-feedback" id="PasswordInvalid"></div>

                            </div>
                        </div>
                
                <asp:Repeater runat="server" ID="CustomProfile" Visible="False" OnItemDataBound="CustomProfile_OnItemDataBound">
                    <HeaderTemplate>
                        <hr/>
                        <h4>
                            <YAF:LocalizedLabel ID="LocalizedLabel16" runat="server"
                                                LocalizedPage="EDIT_PROFILE"
                                                LocalizedTag="OTHER" />
                        </h4>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="mb-3">
                            <asp:HiddenField runat="server" ID="DefID" />
                            <asp:Label runat="server" ID="DefLabel" />
                            <asp:TextBox runat="server" ID="DefText" Visible="False" />

                            <asp:PlaceHolder runat="server" ID="CheckPlaceHolder" Visible="False">
                                <div class="form-check form-switch">
                                    <asp:CheckBox runat="server" ID="DefCheck" />
                                </div>
                            </asp:PlaceHolder>
                            <div class="invalid-feedback">
                                <YAF:LocalizedLabel runat="server" ID="RequiredMessage" LocalizedTag="NEED_CUSTOM" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>
            <asp:Panel runat="server" ID="Footer"
                       CssClass="card-footer text-center">
                <YAF:ThemeButton ID="CreateUser" runat="server"
                                 CausesValidation="True"
                                 TextLocalizedTag="CREATE_USER"
                                 Icon="user-plus"
                                 Type="Primary"
                                 CssClass="btn-loading m-1"
                                 OnClick="RegisterClick" />
                <YAF:ThemeButton runat="server" ID="LoginButton"
                                 CausesValidation="False"
                                 TextLocalizedTag="LOGIN_INSTEAD"
                                 CssClass="m-1"
                                 Type="OutlineSecondary"
                                 Visible="False"
                                 Icon="sign-in-alt" />
            </asp:Panel>
        </div>
    </div>
</div>