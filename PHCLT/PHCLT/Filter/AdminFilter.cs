using System.Web.Mvc;
using System.Web.Routing;

namespace SSMS.Filter
{   
    public class AdminFilter : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            var userType = filterContext.HttpContext.Session["UserType"] as string;

            if (string.IsNullOrEmpty(userType)) {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Home", action = "Login" })
                );
            }
            else if (!string.IsNullOrEmpty(userType) && userType != "Admin")
            {
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Home", action = "Login" })
                );
            }

            base.OnActionExecuting(filterContext);
        }
    }
}