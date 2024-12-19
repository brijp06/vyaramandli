using System;
using System.Web.Mvc;
using System.Web.Routing;
using PHCLT.Controllers;
using PHCLT.Models;
using System.Data;
namespace HRMS.Controllers
{
    public class HomeController : Controller
    {
        ClsSystem ob = new ClsSystem();
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login(string isAuth = "")
        {
            return View();
        }


        public ActionResult Dashboard()
        {
            ViewBag.chiku = ob.FindOneString("select isnull(abs(sum(isnull(ReceiptAmt,0)) - sum(isnull(paymentamt,0))),0) from transactionmaster where partyaccountid=" + Convert.ToInt32(Session["UserId"]) + " and PurchaseAccountId=46");
            ViewBag.keri = ob.FindOneString("select isnull(abs(sum(isnull(ReceiptAmt,0)) - sum(isnull(paymentamt,0))),0) from transactionmaster where partyaccountid=" + Convert.ToInt32(Session["UserId"]) + " and PurchaseAccountId=80");
            ViewBag.saving = ob.FindOneString("select isnull(abs(sum(isnull(ReceiptAmt,0)) - sum(isnull(paymentamt,0))),0) from transactionmaster where partyaccountid=" + Convert.ToInt32(Session["UserId"]) + " and PurchaseAccountId=42");
            ViewBag.udhar = ob.FindOneString("select isnull(abs(sum(isnull(ReceiptAmt,0)) - sum(isnull(paymentamt,0))),0) from transactionmaster where partyaccountid=" + Convert.ToInt32(Session["UserId"]) + " and PurchaseAccountId=51");
            ViewBag.notice = ob.FindOneString("select Rem from Notice");

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

        [HttpGet]
        public JsonResult verify(string Username, string Password)
        {
            ClsSystem ob = new ClsSystem();

            LoginResponse loginResponse = ob.VerifyUser(Username, Password);

            if (!String.IsNullOrEmpty(loginResponse.UserType))
            {
                Session["UserType"] = loginResponse.UserType;
                Session["CustomerId"] = loginResponse.CustomerId;
                Session["UserName"] = loginResponse.Username;
                Session["UserId"] = loginResponse.UserId;
                Session["UsesFullname"] = loginResponse.UsesFullname;
                Session.Timeout = 10;

                if (loginResponse.UserType == "User")
                {
                    //return RedirectToAction("UserDashboard", "Home");
                    return Json(loginResponse, JsonRequestBehavior.AllowGet);
                }

                //return RedirectToAction("Dashboard", "Home");
                return Json(loginResponse, JsonRequestBehavior.AllowGet);
            }
            else
            {
                var routeValues = new RouteValueDictionary(new { isAuth = "false" });
                //return RedirectToAction("Login", "Home", routeValues);
                return Json(loginResponse, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Logout()
        {
            // Clear the user session
            Session.Clear();

            // Redirect to the login page            
            return RedirectToAction("Login", "Home");
        }

        [HttpGet]
        public JsonResult CheckUserSubScription()
        {
            try
            {
                ClsSystem ob = new ClsSystem();

                var userId = HttpContext.Session["UserId"].ToString();

                LoginResponse loginResponse = ob.CheckUserSubScription(userId);


                return Json(loginResponse, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult getgantri(string gantridate)
        {
            try
            {
                string msg = "";
                string msg1 = "";
                string msg2 = "";
                string msg3 = "";
                string msg4 = "";
                string msg5 = "";

                DataTable dts = ob.Returntable("select * from  JantryData where Dt='" + gantridate + "'");
                msg = dts.Rows[0]["JantryOn"].ToString();
                msg1 = dts.Rows[0]["Rate"].ToString();
                DataTable dt = ob.Returntable("EXEC SMSSPsingal '" + gantridate + "'," + Convert.ToInt32(Session["UserId"]) + "");
                Double tw = 0;
                Double trate = 0;

                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i <= dt.Rows.Count - 1; i++)
                    {
                        DateTime transDate = Convert.ToDateTime(dt.Rows[i]["TransDate"]);
                        string formattedDate = transDate.ToString("dd/MM/yyyy");
                        if (dt.Rows[i]["Grad"].ToString() == "1")
                        {
                            msg3 = "તારીખ:-" + formattedDate + " ના રોજ ગ્રેડ=" + dt.Rows[i]["Grad"] + " વજન=" + dt.Rows[i]["dweight"] + " જંત્રી=" + dt.Rows[i]["Ratio"] + "   ભાવ=" + dt.Rows[i]["Rate"] + " રકમ=" + dt.Rows[i]["Amount"] + "";
                        }
                        if (dt.Rows[i]["Grad"].ToString() == "2")
                        {
                            if (msg3 == "")
                            {
                                msg3 = "તારીખ:-" + formattedDate + " ના રોજ ";
                            }
                            else
                            {
                                msg3 = msg3 + " ગ્રેડ=" + dt.Rows[i]["Grad"] + " વજન=" + dt.Rows[i]["dweight"] + " જંત્રી=" + dt.Rows[i]["Ratio"] + "  ભાવ=" + dt.Rows[i]["Rate"] + " રકમ=" + dt.Rows[i]["Amount"] + "";
                            }
                        }
                        if (dt.Rows[i]["Grad"].ToString() == "3")
                        {
                            if (msg3 == "")
                            {
                                msg3 = "તારીખ:-" + formattedDate + " ના રોજ";
                            }
                            else
                            {
                                msg3 = msg3 + " ગ્રેડ=" + dt.Rows[i]["Grad"] + " વજન=" + dt.Rows[i]["dweight"] + " જંત્રી=" + dt.Rows[i]["Ratio"] + "  ભાવ=" + dt.Rows[i]["Rate"] + " રકમ=" + dt.Rows[i]["Amount"] + "";
                            }
                        }
                        tw = tw + Convert.ToDouble(dt.Rows[i]["dweight"]);
                        trate = trate + Convert.ToDouble(dt.Rows[i]["Amount"]);
                    }
                    if (msg3 != "")
                    {
                        DataTable dtg = ob.Returntable("exec SabhasadLedgerChikuKeri '2024/07/01','" + gantridate + "',46," + Convert.ToInt32(Session["UserId"]) + ",0,0,0");
                        double crd = 0;
                        Double drd = 0;
                        for (int jk = 0; jk <= dtg.Rows.Count - 1; jk++)
                        {
                            if (Convert.ToDouble(dtg.Rows[jk]["Transactionid"].ToString()) != 0)
                            {
                                crd += Convert.ToDouble(dtg.Rows[jk]["Credit"].ToString());
                                drd += Convert.ToDouble(dtg.Rows[jk]["Debit"].ToString());
                                double bal = 0;

                                if (crd > drd)
                                {
                                    bal = crd - drd;
                                }
                                else
                                {
                                    bal = drd - crd;
                                }
                            }
                        }
                        string cr = crd.ToString();
                        string dr = drd.ToString();
                        string twb = ob.FindOneString("select isnull(sum(ts.Weight),0) from transactionmaster as Tr Inner join StockDetail ts on tr.TransactionId=ts.TransactionId where PartyAccountId=" + Convert.ToInt32(Session["UserId"]) + " and transdate between '2024/07/01' and '2025/06/30'");
                        msg3 = msg3 + " રાશ:-=" + ((trate / tw) * 20).ToString("F2") + " નેટ વજન=" + tw + " નેટ રકમ=" + trate + "  કુલ રકમ=" + cr + "";
                    }


                }
                var Jantridata = ob.ReturnDataList("select * from  JantryData where Dt='" + gantridate + "'");
                var result = new
                {
                    Message1 = msg,
                    Message2 = msg1,
                    Message3 = Jantridata,
                    Message4 = msg3,
                    Message5 = msg4,
                    Message6 = msg5,
                };

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}