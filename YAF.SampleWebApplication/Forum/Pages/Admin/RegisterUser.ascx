<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.RegisterUser" Codebehind="RegisterUser.ascx.cs" %>


<YAF:PageLinks id="PageLinks" runat="server" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="user-plus"
                                    LocalizedTag="HEADER2" 
                                    LocalizedPage="ADMIN_REGUSER"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <asp:Label runat="server" AssociatedControlID="UserName">
                                <YAF:LocalizedLabel ID="LocalizedLabel5" runat="server" 
                                                    LocalizedTag="USERNAME" LocalizedPage="REGISTER"></YAF:LocalizedLabel>:
                            </asp:Label>
                            <asp:TextBox CssClass="form-control" id="UserName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator id="Requiredfieldvalidator1" runat="server" 
                                                        ControlToValidate="UserName" 
                                                        ErrorMessage="User Name is required." 
                                                        CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-3 col-md-6">
                            <asp:Label runat="server" AssociatedControlID="Email">
                                <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" 
                                                    LocalizedTag="EMAIL" LocalizedPage="REGISTER"></YAF:LocalizedLabel>:
                            </asp:Label>
                            <asp:TextBox id="Email" runat="server" 
                                         CssClass="form-control"
                                         TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator id="Requiredfieldvalidator5" runat="server" 
                                                        ControlToValidate="Email" 
                                                        ErrorMessage="Email address is required." 
                                                        CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <asp:Label runat="server" AssociatedControlID="Password">
                                <YAF:LocalizedLabel ID="LocalizedLabel7" runat="server" 
                                                    LocalizedTag="PASSWORD" LocalizedPage="ADMIN_REGUSER"></YAF:LocalizedLabel>
                            </asp:Label>
                            <asp:TextBox id="Password" runat="server" 
                                         TextMode="Password"
                                         CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator id="Requiredfieldvalidator2" runat="server" 
                                                        ControlToValidate="Password" 
                                                        ErrorMessage="Password is required." 
                                                        CssClass="form-text text-danger"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-3 col-md-6">
                            <asp:Label runat="server" AssociatedControlID="Password2">
                                <YAF:LocalizedLabel ID="LocalizedLabel8" runat="server" 
                                                    LocalizedTag="CONFIRM_PASSWORD" LocalizedPage="REGISTER"></YAF:LocalizedLabel>:
                            </asp:Label>
                            <asp:TextBox id="Password2" runat="server" 
                                         TextMode="Password"
                                         CssClass="form-control" ></asp:TextBox>
                            <asp:CompareValidator id="Comparevalidator1" runat="server" 
                                                  Name="Comparevalidator1" 
                                                  ControlToValidate="Password2" 
                                                  ErrorMessage="Passwords didnt match." 
                                                  ControlToCompare="Password"
                                                  CssClass="form-text text-danger"></asp:CompareValidator>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton id="ForumRegister" runat="server" 
                                     Onclick="ForumRegisterClick" 
                                     CausesValidation="True"
                                     CssClass="me-1"
                                     Type="Primary"
                                     Icon="user-plus" 
                                     TextLocalizedTag="REGISTER" 
                                     TextLocalizedPage="ADMIN_REGUSER">
                    </YAF:ThemeButton>
                    <YAF:ThemeButton id="cancel" runat="server" 
                                     Onclick="CancelClick" 
                                     Type="Secondary"
                                     Icon="times" 
                                     TextLocalizedTag="CANCEL">
                    </YAF:ThemeButton>
                </div>
            </div>
        </div>
    </div>


