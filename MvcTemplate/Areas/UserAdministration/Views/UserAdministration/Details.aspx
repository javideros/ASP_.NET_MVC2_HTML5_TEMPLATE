<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcTemplate.Areas.UserAdministration.Models.UserAdministration.DetailsViewModel>" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    User Details:
    <%= Model.DisplayName %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <link href='<% =Url.Content("~/Content/MvcMembership.css") %>' rel="stylesheet" type="text/css" />
    <hgroup>
    <h2 class="mvcMembership">
        User Details:
        <%= Model.DisplayName %>
        [<% =Model.Status %>]</h2>
    </hgroup>
    <ul class="mvcMembership-tabs">
        <li>Details</li>
        <li>
            <% =Html.ActionLink("Password", "Password", "UserAdministration", new { area = "UserAdministration", id = Model.User.ProviderUserKey }, null) %></li>
        <li>
            <% =Html.ActionLink("Roles", "UsersRoles", "UserAdministration", new{area = "UserAdministration", id = Model.User.ProviderUserKey}, null) %></li>
    </ul>
    <h3 class="mvcMembership">
        Account</h3>
    <div class="mvcMembership-account">
        <dl class="mvcMembership">
            <dt>User Name:</dt>
            <dd>
                <%= Model.User.UserName %></dd>
            <dt>Email Address:</dt>
            <dd>
                <a href="mailto: <%= Model.User.Email %>">
                    <%= Model.User.Email %></a></dd>
            <% if (Model.User.LastActivityDate == Model.User.CreationDate)
               { %>
            <dt>Last Active:</dt>
            <dd>
                <em>Never</em></dd>
            <dt>Last Login:</dt>
            <dd>
                <em>Never</em></dd>
            <% }
               else
               { %>
            <dt>Last Active:</dt>
            <dd>
                <% =Model.User.LastActivityDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
            <dt>Last Login:</dt>
            <dd>
                <% =Model.User.LastLoginDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
            <% } %>
            <dt>Created:</dt>
            <dd>
                <% =Model.User.CreationDate.ToString("MMMM dd, yyyy h:mm:ss tt", CultureInfo.InvariantCulture) %></dd>
        </dl>
        <% using (Html.BeginForm("ChangeApproval", "UserAdministration", new { id = Model.User.ProviderUserKey }))
           { %>
        <% =Html.Hidden("isApproved", !Model.User.IsApproved) %>
        <input type="submit" value='<% =(Model.User.IsApproved ? "Unapprove" : "Approve") %> Account' />
        <% } %>
        <% using (Html.BeginForm("DeleteUser", "UserAdministration", new { id = Model.User.ProviderUserKey }))
           { %>
        <input type="submit" value="Delete Account" />
        <% } %>
    </div>
    <h3 class="mvcMembership">
        Email Address & Comments</h3>
    <div class="mvcMembership-emailAndComments">
        <% using (Html.BeginForm("Details", "UserAdministration", new { id = Model.User.ProviderUserKey }))
           { %>
        <fieldset>
           <legend>Account Information</legend>
            <ol>
                <li>
                    <label for="email">
                        Email Address:</label>
                    <% =Html.TextBox("email", Model.User.Email) %>
                </li>
                <li>
                    <label for="comments">
                        Comments:</label>
                    <% =Html.TextArea("comments", Model.User.Comment) %>
                </li>
            </ol>
            <input type="submit" value="Save Email Address and Comments" />
        </fieldset>
        <% } %>
    </div>
</asp:Content>
