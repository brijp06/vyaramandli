using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PHCLT.Controllers
{
    public class UserController : Controller
    {
        ClsSystem ob = new ClsSystem();
        // GET: User
        public ActionResult CreateUser()
        {
            return View();
        }
        public class Resultpass<T>
        {
            public bool opstatus { get; set; }
            public string opmessage { get; set; }
        }
        [HttpPost]
        public JsonResult CreateUser(string UserName, string Userpassword, string UserFullName)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                DateTime currentDate = DateTime.Now;

                // Add one day to the current date
                DateTime nextDate = currentDate.AddDays(1);
                var Userid = ob.FindOneString("select isnull(max(Userid),0)+1 as Userid from UserMaster"); 

                ob.excute("insert Into UserMaster(Userid, UserName, Password, UsesFullname, UserSubdate) values(" + Convert.ToInt64(Userid.ToString()) + ",'" + UserName.ToString() + "','" + Userpassword.ToString() + "','" + UserFullName.ToString() + "','" + Convert.ToDateTime(nextDate) + "')");
                result.opstatus = true;
                result.opmessage = Userid;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public ActionResult UserSubUpdate()
        {
            List<Usermaster> usermaster = GetUsermaster();
            ViewBag.Usermaster = usermaster;
            return View();
        }
        public JsonResult UpdateSubscription(string Userid,string Usersubdate)
        {
            int id = Convert.ToInt32(Userid);
            DateTime subdate = Convert.ToDateTime(Usersubdate);

           
            var Response = ob.excute($@"UPDATE UserMaster SET UserSubdate='{subdate}' WHERE Userid={id}");

            if (Response ==0)
            {
                var message = "User Subscription date has been Updated";
                return Json(message, JsonRequestBehavior.AllowGet);
            }
            var Error = "something Wrong!";
            return Json(Error, JsonRequestBehavior.AllowGet);
        }
        public class Usermaster
        {
            public int Id { get; set; }
            public string userfullname { get; set; }
        }
        private List<Usermaster> GetUsermaster()
        {
            List<Usermaster> usermast = new List<Usermaster>();


            DataTable dt = ob.Returntable("select * from UserMaster order by Userid");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                Usermaster Um = new Usermaster
                {
                    Id = (int)dt.Rows[i]["Userid"],
                    userfullname = dt.Rows[i]["UsesFullname"].ToString()
                };



                usermast.Add(Um);

            }
            return usermast;
        }
    }
}