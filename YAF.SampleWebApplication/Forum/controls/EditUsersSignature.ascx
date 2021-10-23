﻿<%@ Control Language="C#" AutoEventWireup="true" Inherits="YAF.Controls.EditUsersSignature" Codebehind="EditUsersSignature.ascx.cs" %>

<h2 runat="server" id="trHeader">
    <YAF:LocalizedLabel runat="server" 
                        LocalizedPage="EDIT_SIGNATURE" 
                        LocalizedTag="title" />
</h2>

<h4>
<YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" 
                    LocalizedPage="EDIT_SIGNATURE"
                    LocalizedTag="SIGNATURE_PREVIEW" />
</h4>
<div class="card mb-3">
    <div class="card-body">
        <asp:PlaceHolder id="PreviewLine" runat="server">
        </asp:PlaceHolder>
    </div>
</div>
<asp:PlaceHolder id="EditorLine" runat="server">
            <!-- editor goes here -->
</asp:PlaceHolder>
<div class="text-lg-center mt-3">
    <YAF:ThemeButton ID="preview" runat="server"
                     Type="Secondary"
                     Icon="image"
                     CssClass="me-2"
                     TextLocalizedTag="PREVIEW"/>
    <YAF:ThemeButton ID="save" runat="server"
                     Type="Primary" 
                     TextLocalizedTag="SAVE"
                     CssClass="me-2"
                     Icon="save"/>
    <YAF:ThemeButton ID="cancel" runat="server"
                     Type="Secondary" 
                     Icon="reply"
                     TextLocalizedTag="CANCEL"/>
</div>