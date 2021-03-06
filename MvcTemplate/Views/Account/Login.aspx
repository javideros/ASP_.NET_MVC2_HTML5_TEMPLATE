﻿<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MvcTemplate.Models.LoginModel>" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Log in
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup>
        <h1>Log in.</h1>
    </hgroup>
    
    <section id="loginForm">
        <h2>Use your account to log in.</h2>
        <% using (Html.BeginForm( new {ReturnUrl = ViewData["ReturnUrl"]})) { %>
            <%= Html.AntiForgeryToken() %>
            <%= Html.ValidationSummary(true) %>

            <fieldset>
                <legend>Log in Form</legend>
                <ol>
                    <li>
                        <%= Html.LabelFor(m => m.UserName) %>
                        <%= Html.TextBoxFor(m => m.UserName) %>
                        <%= Html.ValidationMessageFor(m => m.UserName) %>
                    </li>
                    <li>
                        <%= Html.LabelFor(m => m.Password) %>
                        <%= Html.PasswordFor(m => m.Password)%>
                        <%= Html.ValidationMessageFor(m => m.Password) %>
                    </li>
                    <li>
                        <%= Html.CheckBoxFor(m => m.RememberMe) %>
                        <%= Html.LabelFor(m => m.RememberMe) %>
                    </li>
                </ol>
                <input type="submit" value="Log in" />
                <p>
                    <%= Html.ActionLink("Register", "Register") %> if you don't have an account.
                </p>
                <% } %>
            </fieldset>
    </section>
</asp:Content>
