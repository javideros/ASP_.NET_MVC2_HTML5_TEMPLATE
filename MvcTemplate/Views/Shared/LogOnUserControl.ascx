<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<% if (Request.IsAuthenticated) { %>
    Hello, <%= Html.ActionLink(Page.User.Identity.Name, "ChangePassword", "Account", new { Area = "" }, new { @class = "username", title = "Manage" })%>!
    <% using (Html.BeginForm("LogOff", "Account", new { Area = "" }, FormMethod.Post, new { id = "logoutForm" }))
       { %>
        <%= Html.AntiForgeryToken() %>
        <a href="javascript:document.getElementById('logoutForm').submit()">Log off</a>
    <% } %>
<%
    }
    else {
%>      <ul>
            <li><%= Html.ActionLink("Register", "Register", "Account", new { Area = "" }, new { })%></li>
            <li><%= Html.ActionLink("Log in", "Login", "Account", new { Area = "" }, new { }) %></li>
     </ul>
  <%   }
%>
