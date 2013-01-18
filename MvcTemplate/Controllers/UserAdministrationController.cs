﻿using System;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web.Mvc;
using System.Web.Security;
using MvcMembership;
using MvcTemplate.Models;
using MvcTemplate.Areas.UserAdministration.Models.UserAdministration;

namespace MvcTemplate.Controllers
{
    [Authorize(Roles="Administrator")]
    [HandleError(ExceptionType = typeof(DuplicateRoleException), View = "DuplicateRoleFound")]
    public class UserAdministrationController : Controller
    {
        private const int PageSize = 10;
        private const string ResetPasswordBody = "Your new password is: ";
        private const string ResetPasswordFromAddress = "from@domain.com";
        private const string ResetPasswordSubject = "Your New Password";
        private readonly IRolesService _rolesService;
        private readonly ISmtpClient _smtpClient;
        private readonly IUserService _userService;
        private readonly IPasswordService _passwordService;

        public UserAdministrationController()
            : this(
                    new AspNetMembershipProviderWrapper(Membership.Provider),
                    new AspNetMembershipProviderWrapper(Membership.Provider),
                    new AspNetRoleProviderWrapper(Roles.Provider),
                    new SmtpClientProxy(new SmtpClient()))
        {
        }

    public UserAdministrationController(IUserService userService, IPasswordService passwordService, IRolesService rolesService, ISmtpClient smtpClient)
    {
        _userService = userService;
        _passwordService = passwordService;
        _rolesService = rolesService;
        _smtpClient = smtpClient;
    }

public ViewResult Index(int? index)
{
var users = _userService.FindAll(index ?? 0, PageSize);
var roles = _rolesService.FindAll();

if(roles.Distinct().Count() != roles.Count())
throw new DuplicateRoleException("The list of Roles contains duplicates.");

return View(new IndexViewModel
{
Users = users,
Roles = roles
});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult CreateRole(string id)
{
_rolesService.Create(id);
return RedirectToAction("Index");
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult DeleteRole(string id)
{
_rolesService.Delete(id);
return RedirectToAction("Index");
}

public ViewResult Role(string id)
{
return View(new RoleViewModel
{
Role = id,
Users = _rolesService.FindUserNamesByRole(id).Select(username => _userService.Get(username))
});
}

public ViewResult Details(Guid id)
{
var user = _userService.Get(id);
var userRoles = _rolesService.FindByUser(user);
var roles = _rolesService.FindAll();

if (roles.Distinct().Count() != roles.Count())
throw new DuplicateRoleException("The list of Roles contains duplicates.");

return View(new DetailsViewModel
{
DisplayName = user.UserName,
User = user,
Roles = roles.ToDictionary(role=> role, role=> userRoles.Contains(role)),
Status = user.IsOnline
? DetailsViewModel.StatusEnum.Online
: !user.IsApproved
? DetailsViewModel.StatusEnum.Unapproved
: user.IsLockedOut
? DetailsViewModel.StatusEnum.LockedOut
: DetailsViewModel.StatusEnum.Offline
});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult Details(Guid id,
[Bind(Prefix = "User.Email")] string email,
[Bind(Prefix = "User.Comment")] string comment)
{
var user = _userService.Get(id);
user.Email = email;
user.Comment = comment;
_userService.Update(user);
return RedirectToAction("Details", new {id});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult DeleteUser(Guid id)
{
_userService.Delete(_userService.Get(id));
return RedirectToAction("Index");
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult ChangeApproval(Guid id, bool isApproved)
{
var user = _userService.Get(id);
user.IsApproved = isApproved;
_userService.Update(user);
return RedirectToAction("Details", new {id});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult Unlock(Guid id)
{
_passwordService.Unlock(_userService.Get(id));
return RedirectToAction("Details", new {id});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult ResetPassword(Guid id, string answer)
{
var user = _userService.Get(id);
var newPassword = _passwordService.ResetPassword(user, answer);

var body = ResetPasswordBody + newPassword;
_smtpClient.Send(new MailMessage(ResetPasswordFromAddress, user.Email, ResetPasswordSubject, body));

return RedirectToAction("Details", new {id});
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult AddToRole(Guid id, string role)
{
_rolesService.AddToRole(_userService.Get(id), role);
return RedirectToAction("Details", new { id });
}

[AcceptVerbs(HttpVerbs.Post)]
public RedirectToRouteResult RemoveFromRole(Guid id, string role)
{
_rolesService.RemoveFromRole(_userService.Get(id), role);
return RedirectToAction("Details", new { id });
}

public class DuplicateRoleException : ApplicationException
{
public DuplicateRoleException(string message) : base(message)
{
}
}
}
}