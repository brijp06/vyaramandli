using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace PHCLT.Helper
{
    public class SubscriptionCheckFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var userId = filterContext.HttpContext.Session["UserId"];

            if (userId == null)
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Home", action = "Login" })
                );
            }

            base.OnActionExecuting(filterContext);
        }
    }
}