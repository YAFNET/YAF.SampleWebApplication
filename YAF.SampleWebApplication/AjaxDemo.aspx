<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AjaxDemo.aspx.cs" Inherits="YAF.SampleWebApplication.AjaxDemo" %>

<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
  <h3>Ajax demo</h3>

  <%--Setup place holder for Razor MVC view content--%>
  <div id="razorViewContent">
  </div>

  <script type="text/javascript">
    $(function () {

      // Call MCV view on document completed
      $.ajax({
        type: "Get",
        url: "/RazorDemo/SomeAjaxCall",        
        data: 'id=55',              
        success: function (document) {
          $('#razorViewContent').html(document);
        }
      }); 
    });
</script>

</asp:Content>


