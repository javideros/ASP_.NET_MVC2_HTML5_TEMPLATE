﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcTemplate.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>Register.</h1>
        <h2>Create a new account.</h2>
    </hgroup>
    <p>
        Use the form below to create a new account. 
    </p>
    <p>
        Passwords are required to be a minimum of <%= Html.Encode(ViewData["PasswordLength"]) %> characters in length.
    </p>

    <% using (Html.BeginForm()) { %>
        <%= Html.AntiForgeryToken() %>
        <%= Html.ValidationSummary() %>
        <fieldset>
            <legend>Registration Form</legend>
            <ol>
                <li>
                    <%= Html.LabelFor(m => m.UserName) %>
                    <%= Html.TextBoxFor(m => m.UserName) %>
                </li>
                <li>
                    <%= Html.LabelFor(m => m.Password) %>
                    <%= Html.PasswordFor(m => m.Password) %>
                </li>
                <li>
                    <%= Html.LabelFor(m => m.ConfirmPassword) %>
                    <%= Html.PasswordFor(m => m.ConfirmPassword) %>
                </li>
            </ol>
            <input type="submit" value="Register" />
        </fieldset>
    <% } %>
</asp:Content>