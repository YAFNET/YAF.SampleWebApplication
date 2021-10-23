﻿<%@ Control Language="C#" AutoEventWireup="true"
    Inherits="YAF.Pages.Friends" Codebehind="Friends.ascx.cs" %>
<%@ Register TagPrefix="YAF" TagName="BuddyList" Src="../controls/BuddyList.ascx" %>


<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-sm-auto">
        <YAF:ProfileMenu runat="server"></YAF:ProfileMenu>
    </div>
<div class="col">
<div class="row">
    <asp:Panel id="BuddiesTabs" runat="server" CssClass="col">
        <ul class="nav nav-tabs" role="tablist">
            <li class="nav-item">
                <a href="#BuddyListTab" class="nav-link" data-bs-toggle="tab" role="tab">
                    <YAF:LocalizedLabel ID="LocalizedLabel2" runat="server" LocalizedTag="BUDDYLIST" LocalizedPage="FRIENDS" />
                </a>
            </li>
            <li class="nav-item">
                <a href="#PendingRequestsTab" class="nav-link" data-bs-toggle="tab" role="tab">
                    <YAF:LocalizedLabel ID="LocalizedLabel1" runat="server" LocalizedTag="PENDING_REQUESTS" LocalizedPage="FRIENDS" />
                </a>
            </li>
            <li class="nav-item">
                <a href="#YourRequestsTab" class="nav-link" data-bs-toggle="tab" role="tab">
                    <YAF:LocalizedLabel ID="LocalizedLabel3" runat="server" LocalizedTag="YOUR_REQUESTS" LocalizedPage="FRIENDS" />
                </a>
            </li>
        </ul>
        <div class="tab-content">
            <div id="BuddyListTab" class="tab-pane" role="tabpanel">
                <YAF:BuddyList runat="server" ID="BuddyList1" />
            </div>
            <div id="PendingRequestsTab" class="tab-pane" role="tabpanel">
                <YAF:BuddyList runat="server" ID="PendingBuddyList" />
            </div>
            <div id="YourRequestsTab" class="tab-pane" role="tabpanel">
                <YAF:BuddyList runat="server" ID="BuddyRequested" />
            </div>
        </div>
    </asp:Panel>
</div>



<asp:HiddenField runat="server" ID="hidLastTab" Value="BuddyListTab" />
</div>
    </div>