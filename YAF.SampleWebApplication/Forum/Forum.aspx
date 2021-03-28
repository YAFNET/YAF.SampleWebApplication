<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forum.aspx.cs" Inherits="YAF.SampleWebApplication.Forum" ValidateRequest="false" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <YAF:Forum runat="server" ID="forum" BoardID="1" />
</asp:Content>
