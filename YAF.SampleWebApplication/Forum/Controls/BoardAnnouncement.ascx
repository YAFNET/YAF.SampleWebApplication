<%@ Control Language="C#" AutoEventWireup="true" EnableViewState="false"
    Inherits="YAF.Controls.BoardAnnouncement" Codebehind="BoardAnnouncement.ascx.cs" %>

<div class="row">
    <div class="col">
        <asp:Panel ID="Announcement" runat="server">
            <asp:Label runat="server" ID="Badge">
                <i class="fas fa-bullhorn me-1"></i><YAF:LocalizedLabel runat="server" LocalizedTag="ANNOUNCEMENT"></YAF:LocalizedLabel>
            </asp:Label>
            <asp:Label runat="server" ID="Message"></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close">
            </button>
        </asp:Panel>
    </div>
</div>