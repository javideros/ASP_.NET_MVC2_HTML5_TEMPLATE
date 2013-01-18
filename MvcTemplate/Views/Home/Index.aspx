<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Home Page
</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup>
                <h1>Home Page.</h1>
                <h2><%= Html.Encode(ViewData["Message"]) %></h2>
            </hgroup>
            <p>
                To learn more about ASP.NET MVC visit <a href="http://asp.net/mvc" title="ASP.NET MVC Website">http://asp.net/mvc</a>.
            </p>
        </div>
    </section>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
    <h3>We suggest the following:</h3>
    <ol class="round">
        <li class="one">
            <h5>Test</h5>
            Testing
        </li>
        <li class="two">
            <h5>Test</h5>
            Testing
        </li>
        <li class="three">
            <h5>Test</h5>
            Testing
        </li>
    </ol>
</asp:Content>
