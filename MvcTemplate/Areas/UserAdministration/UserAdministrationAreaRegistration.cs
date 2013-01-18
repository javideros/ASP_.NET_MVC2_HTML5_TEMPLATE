﻿using System.Web.Mvc;
using MvcTemplate.Areas.UserAdministration.Controllers;


namespace MvcTemplate.Areas.UserAdministration
{
    public class UserAdministrationAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "UserAdministration";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "UserAdministration_default",
                "UserAdministration/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                    new[] { typeof(UserAdministrationController).Namespace }
            );
        }
    }
}
