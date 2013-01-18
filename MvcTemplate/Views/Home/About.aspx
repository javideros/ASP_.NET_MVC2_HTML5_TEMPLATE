<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    About Us
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup>
        <h1>About</h1>
        <h2><%= Html.Encode(ViewData["Message"]) %></h2>
    </hgroup>
    
    <article>
        <p>
           Put content here.
        </p>
        <p>
           Put content here.
        </p>
        <p>
           Put content here.
        </p>
    </article>

    <aside>
        <h3>Aside Title</h3>
        <p>
           Put content here.
        </p>
        <ul>
            <li><%= Html.ActionLink("Home", "Index", "Home") %></li>
            <li><%= Html.ActionLink("About", "About", "Home")%></li>
            <li><%= Html.ActionLink("Contact", "Contact", "Contact")%></li>
        </ul>
    </aside>
</asp:Content>
