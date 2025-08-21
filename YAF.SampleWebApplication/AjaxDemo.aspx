<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AjaxDemo.aspx.cs" Inherits="YAF.SampleWebApplication.AjaxDemo" %>

<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">
  <h3>Ajax demo</h3>

  <%--Setup placeholder for Razor MVC view content--%>
  <div id="razorViewContent">
  </div>

  <script type="text/javascript">
	  document.addEventListener("DOMContentLoaded", function () {
		  // Call MCV view on document completed
		  fetch("/RazorDemo/SomeAjaxCall?id=55", {
			  method: "GET"
		  })
		  .then(response => {
			  if (!response.ok) {
				  throw new Error("Network response was not ok");
			  }
			  return response.text();
		  })
		  .then(documentHtml => {
			  document.getElementById("razorViewContent").innerHTML = documentHtml;
		  })
		  .catch(error => {
			  console.error("Fetch error:", error);
		  });
	  });
  </script>

</asp:Content>


