<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="RazorContent" ContentPlaceHolderID="MainContent" runat="server">
  <% this.Html.RenderPartial((string)this.ViewBag.ViewName); %>
</asp:Content>
