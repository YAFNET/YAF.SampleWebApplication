<%@ Control Language="c#" AutoEventWireup="True" Inherits="YAF.Pages.Cookies" Codebehind="Cookies.ascx.cs" %>

<YAF:PageLinks runat="server" ID="PageLinks" />

<div class="row">
    <div class="col-xl-12">
        <h1><YAF:LocalizedLabel ID="LocalizedLabel1" runat="server" 
                                LocalizedTag="TITLE" />
        </h1>
    </div>
</div>
<div class="row">
    <div class="col-xl-12">
        <div class="card mb-3">
            <div class="card-header">
                <YAF:IconHeader runat="server"
                                IconName="cookie"></YAF:IconHeader>
            </div>
            <div class="card-body">
                <YAF:LocalizedLabel runat="server" LocalizedTag="COOKIES_TEXT" EnableBBCode="true" />
            </div>
        </div>
    </div>
</div>