﻿<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Admin.Digest"
    CodeBehind="Digest.ascx.cs" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="envelope"
                                    LocalizedPage="ADMIN_DIGEST"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="LocalizedLabel4" runat="server" 
                                           AssociatedControlID="DigestEnabled"
                                           LocalizedTag="DIGEST_ENABLED"
                                           LocalizedPage="ADMIN_DIGEST" />
                            <asp:Label ID="DigestEnabled" runat="server"
                                       CssClass="badge bg-secondary"></asp:Label>
                        </div>
                        <div class="mb-3 col-md-4">
                            <YAF:HelpLabel ID="LocalizedLabel5" runat="server" 
                                           AssociatedControlID="LastDigestSendLabel"
                                           LocalizedTag="DIGEST_LAST" LocalizedPage="ADMIN_DIGEST" />
                            <asp:Label ID="LastDigestSendLabel" runat="server" 
                                       CssClass="badge bg-secondary"></asp:Label>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-center">
                <YAF:ThemeButton ID="Button2" runat="server" OnClick="ForceSendClick" Type="Primary"
                                 Icon="paper-plane" TextLocalizedTag="FORCE_SEND">
                </YAF:ThemeButton>
            </div>
        </div>
            <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="envelope"
                                    LocalizedTag="HEADER2" 
                                    LocalizedPage="ADMIN_DIGEST"></YAF:IconHeader>
           </div>
                <div class="card-body">
        <asp:PlaceHolder ID="DigestHtmlPlaceHolder" runat="server" Visible="false">
                 
                    <YAF:LocalizedLabel ID="LocalizedLabel6" runat="server" LocalizedTag="DIGEST_GENERATE"
                        LocalizedPage="ADMIN_DIGEST" />
                 
                <p>
                    <asp:HtmlIframe id="DigestFrame" runat="server" style="width: 100%; height: 500px"></asp:HtmlIframe>
                </p>
        </asp:PlaceHolder>
</div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton ID="GenerateDigest" runat="server" OnClick="GenerateDigestClick" Type="Primary"
                                     Icon="envelope" TextLocalizedTag="GENERATE_DIGEST">
                    </YAF:ThemeButton>
            </div>
        </div>
                <div class="card mb-3">
                <div class="card-header">
                    <YAF:IconHeader runat="server"
                                    IconName="envelope"
                                    LocalizedTag="HEADER3" 
                                    LocalizedPage="ADMIN_DIGEST"></YAF:IconHeader>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <YAF:HelpLabel ID="LocalizedLabel7" runat="server" 
                                       AssociatedControlID="TextSendEmail"
                                       LocalizedTag="DIGEST_EMAIL" LocalizedPage="ADMIN_DIGEST" />
                        <asp:TextBox ID="TextSendEmail" runat="server" 
                                     CssClass="form-control" 
                                     TextMode="Email"></asp:TextBox>
                    </div>
                </div>
                <div class="card-footer text-center">
                    <YAF:ThemeButton ID="TestSend" runat="server" OnClick="TestSendClick" Type="Primary"
                                     Icon="paper-plane" TextLocalizedTag="SEND_TEST">
                    </YAF:ThemeButton>
                </div>
            </div>
        </div>
    </div>


