<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="YAF.SampleWebApplication._Default" %>

<%@ Register TagPrefix="YAF" TagName="ForumActiveDiscussion" Src="forum/controls/ForumActiveDiscussion.ascx" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Welcome to ASP.NET and the YAF.NET Sample Application!</h1>
        <p class="lead">
            This Is a Sample Demo Application that shows the Integration of YAF.NET as a Control in to an existing ASP.NET Application.
        </p>
        <p>
            To learn more about YAF.NET visit <a href="http://www.yetanotherforum.net" title="YAF.NET Website">YAF.NET Website</a>.
        </p>
    </div>

    <div class="row">
        <div class="col">
            <h2>YAF What's New</h2>
            <div class="yafWhatsNew">
                <YAF:ForumActiveDiscussion ID="ActiveDiscussions" runat="server" />
            </div>
        </div>
    </div>

</asp:Content>
