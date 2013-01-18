<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="contactTitle" ContentPlaceHolderID="TitleContent" runat="server">
	Contact
</asp:Content>

<asp:Content ID="contactContent" ContentPlaceHolderID="MainContent" runat="server">
   <hgroup>
    <h1>Contact</h1>
    <h2><%= Html.Encode(ViewData["Message"]) %></h2>
   </hgroup>
   <section class="contact">
        <header>
            <h3>Phone:</h3>
        </header>
        <p>
            <span class="label">Main:</span>
            <span>425.555.0100</span>
        </p>
   </section> 
</asp:Content>
