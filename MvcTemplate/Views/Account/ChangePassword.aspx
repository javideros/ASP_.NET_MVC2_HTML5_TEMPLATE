<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcTemplate.Models.ChangePasswordModel>" %>

<asp:Content ID="changePasswordTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Change Password
</asp:Content>

<asp:Content ID="changePasswordContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h2>Change Password</h2>
    </hgroup>
    <p>
        Use the form below to change your password. 
    </p>
    <p>
        New passwords are required to be a minimum of <%= Html.Encode(ViewData["PasswordLength"]) %> characters in length.
    </p>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <%= Html.ValidationSummary(true, "Password change was unsuccessful. Please correct the errors and try again.") %>
        <div>
            <fieldset>
                <legend>Account Information</legend>
                <ol>
                    <li>
                        <%= Html.LabelFor(m => m.OldPassword) %>
                        <%= Html.PasswordFor(m => m.OldPassword) %>
                    </li>
                    <li>
                        <%= Html.LabelFor(m => m.NewPassword) %>
                        <%= Html.PasswordFor(m => m.NewPassword) %>
                    </li>
                    <li>
                        <%= Html.LabelFor(m => m.ConfirmPassword) %>
                        <%= Html.PasswordFor(m => m.ConfirmPassword) %>
                    </li>
                </ol>
                <input type="submit" value="Change password" />
            </fieldset>
        </div>
    <% } %>
</asp:Content>
