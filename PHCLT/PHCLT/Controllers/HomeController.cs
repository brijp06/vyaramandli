using System;
using System.Web.Mvc;
using System.Web.Routing;
using PHCLT.Controllers;
using PHCLT.Models;

namespace HRMS.Controllers
{
    public class HomeController : Controller
    {
      
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login(string isAuth ="")
        {
            return View();
        }

        
        public ActionResult Dashboard()
        {
            return View();
        }

      
        public ActionResult UserDashboard()
        {
            return View();
        }

        public ActionResult UserReport()
        {

            var CustomerId = 0;
            var UserName = "";


            if (!String.IsNullOrEmpty(Convert.ToString(Session["CustomerId"])))
            {
                CustomerId = Convert.ToInt32(Session["CustomerId"]);
            }
            if (!String.IsNullOrEmpty(Convert.ToString(Session["UserName"])))
            {
                UserName = Convert.ToString(Session["UserName"]);
            }

            ViewBag.CustomerId = CustomerId;
            ViewBag.UserName = UserName;

            return View();
        }

        [HttpPost]
        public ActionResult verify(Login log)
        {
            ClsSystem ob = new ClsSystem();

            LoginResponse loginResponse = ob.VerifyUser(log.Username,log.Password);

            if (!String.IsNullOrEmpty(loginResponse.UserType))
            {
                Session["UserType"] = loginResponse.UserType;
                Session["CustomerId"] = loginResponse.CustomerId;
                Session["UserName"] = loginResponse.Username;
                Session["UserId"] = loginResponse.UserId;
                Session["UsesFullname"] = loginResponse.UsesFullname;




                Session.Timeout = 10;

                if (loginResponse.UserType == "User") {                    
                    return RedirectToAction("UserDashboard", "Home");
                }

                return RedirectToAction("Dashboard", "Home");
            }
            else
            {
                var routeValues = new RouteValueDictionary(new { isAuth = "false" });
                return RedirectToAction("Login", "Home", routeValues);
            }
        }

        public ActionResult Logout()
        {
            // Clear the user session
            Session.Clear();

            // Redirect to the login page            
            return RedirectToAction("Login", "Home");
        }
    }
}