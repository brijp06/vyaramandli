using System;
using System.Web.Mvc;
using System.Web.Routing;
using PHCLT.Controllers;
using PHCLT.Models;
using System.Data;
using System.Collections.Generic;
using Newtonsoft.Json;
using System.Linq;

namespace HRMS.Controllers
{
    public class HomeController : Controller
    {
        ClsSystem ob = new ClsSystem();
        string userId = "";
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult NewDashboard()
        {
            DateTime currentDate = DateTime.Now;

            // Extract month and year  totalsales
            int month = currentDate.Month;
            int year = currentDate.Year;
            userId = HttpContext.Session["UserId"].ToString();
            ViewBag.sales = ob.FindOneString("SELECT isnull(SUM(Totalamt),0) AS MonthlyTotal FROM  BillMain where MONTH(BillDate) =" + month + " and YEAR(BillDate) =" + year + " and Userid=" + userId + " GROUP BY  YEAR(BillDate), MONTH(BillDate)");
            ViewBag.totalsales = ob.FindOneString("SELECT isnull(SUM(Totalamt),0) AS MonthlyTotal FROM  BillMain where  YEAR(BillDate) =" + year + " and Userid=" + userId + " GROUP BY  YEAR(BillDate), MONTH(BillDate)");
            var saleamt = ob.FindOneString("SELECT isnull(SUM(Totalamt),0) AS MonthlyTotal FROM  BillMain where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            ViewBag.receiptamt = ob.FindOneString("SELECT isnull(SUM(debit),0) AS MonthlyTotal FROM  PaymentDetail where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            var extraamt = ob.FindOneString("SELECT isnull(SUM(credit),0) AS MonthlyTotal FROM  PaymentDetail where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            ViewBag.pendingamt = Convert.ToDouble(saleamt) + Convert.ToDouble(extraamt) - Convert.ToDouble(ViewBag.receiptamt);
            if (ViewBag.sales == "")
            {
                ViewBag.sales = 0;
            }
            if (ViewBag.totalsales == "")
            {
                ViewBag.totalsales = 0;
            }
            List<itemstock> itemstock = Getitemstock();
            ViewBag.itemmast = itemstock;
            return View();
        }
        //private List<itemstock> Getitemstock()
        //{
        //    List<itemstock> itemMaster = new List<itemstock>();


        //    DataTable dt = ob.Returntable("select * from itemmaster  order by itemcode");

        //    for (int i = 0; i <= dt.Rows.Count - 1; i++)
        //    {
        //        var balamt = getbal(dt.Rows[i]["itemcode"].ToString());
        //        itemstock distMaster = new itemstock
        //        {
        //            balanceqty = balamt.ToString(),
        //            itemname = dt.Rows[i]["Name"].ToString()
        //        };
        //        itemMaster.Add(distMaster);

        //    }
        //    return itemMaster;
        //}
        //private double getbal(string itemid)
        //{
        //    userId = HttpContext.Session["UserId"].ToString();
        //    var sale = ob.FindOneString("select ISNULL(SUM(TQty), 0) from Billdetail where Itemid=" + itemid + " and Userid=" + userId + "");
        //    var instock = ob.FindOneString("select ISNULL(SUM(InQty), 0) from ItemTrans where Itemid=" + itemid + " and Userid=" + userId + "");
        //    var outstock = ob.FindOneString("select ISNULL(SUM(Outqty), 0) from ItemTrans where Itemid=" + itemid + " and Userid=" + userId + "");

        //    double total = 0;
        //    total = total + Convert.ToDouble(instock);
        //    total = total - Convert.ToDouble(outstock);
        //    total = total - Convert.ToDouble(sale);


        //    return total;
        //}

        private List<itemstock> Getitemstock()
        {
            string userId = HttpContext.Session["UserId"].ToString();

            string query = $@"
        SELECT 
            im.itemcode,
            im.Name,
            ISNULL(SUM(it.InQty), 0) AS InQty,
            ISNULL(SUM(it.OutQty), 0) AS OutQty,
            ISNULL(s.SaleQty, 0) AS SaleQty
        FROM itemmaster im
        LEFT JOIN ItemTrans it ON it.Itemid = im.itemcode AND it.Userid = {userId}
        LEFT JOIN (
            SELECT Itemid, SUM(TQty) AS SaleQty 
            FROM Billdetail 
            WHERE Userid = {userId}
            GROUP BY Itemid
        ) s ON s.Itemid = im.itemcode
        GROUP BY im.itemcode, im.Name, s.SaleQty
        ORDER BY im.itemcode";

            DataTable dt = ob.Returntable(query);
            List<itemstock> itemStockList = new List<itemstock>();

            foreach (DataRow row in dt.Rows)
            {
                double inQty = Convert.ToDouble(row["InQty"]);
                double outQty = Convert.ToDouble(row["OutQty"]);
                double saleQty = Convert.ToDouble(row["SaleQty"]);

                double balance = inQty - outQty - saleQty;

                itemStockList.Add(new itemstock
                {
                    itemname = row["Name"].ToString(),
                    balanceqty = balance.ToString()
                });
            }

            return itemStockList;
        }

        [HttpGet]
        public ActionResult Login(string isAuth = "")
        {
            return View();
        }
        public class MembMaster
        {
            public int Id { get; set; }
            public string Name { get; set; }
        }

        public class itemMaster
        {
            public int Id { get; set; }
            public string itemname { get; set; }

        }
        public class talukamaster
        {
            public string talukaid { get; set; }
            public string talukaname { get; set; }

        }
        public class itemgroup
        {
            public int groupid { get; set; }
            public string groupname { get; set; }

        }

        public class itemstock
        {
            public string balanceqty { get; set; }
            public string itemname { get; set; }

        }
        [HttpGet]
        public JsonResult Getrate(string itemid)
        {
            try
            {
                var rate = ob.FindOneString("select isnull(SalesRate,0) from ItemMaster where ItemCode=" + itemid + "");
                var result = new
                {
                    rate = rate,
                };
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        public ActionResult Dashboard()
        {
            List<MembMaster> distMasters = GetMembMasters();
            List<itemMaster> ItemMasters = GetitemMasters();
            List<talukamaster> talukamaster = GettalukaMasters();
            List<itemgroup> itemgroup = GetitemgroupMasters();
            userId = HttpContext.Session["UserId"].ToString();




            ViewBag.ItemGroups = itemgroup;
            DataTable dt = ob.Returntable("select isnull(max(Billno),0)+1 as Billno from billmain where Userid=" + Convert.ToInt32(userId.ToString()) + "");
            ViewBag.billno = dt.Rows[0]["Billno"].ToString();
            ViewBag.DistMasters = distMasters;
            ViewBag.itemmast = ItemMasters;
            ViewBag.taluka = talukamaster;
            return View();
        }
        public JsonResult GetVillagesByDistrict(string districtId)
        {
            var dt = ob.Returntable("SELECT code, name FROM CityMaster WHERE Taluka = N'" + districtId + "'");
            var villages = dt.AsEnumerable().Select(row => new
            {
                code = row["code"].ToString(),
                name = row["name"].ToString()
            });
            return Json(villages, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetItemsByGroup(string groupId)
        {
            var dt = ob.Returntable("SELECT itemcode AS Id, Name AS itemname FROM itemmaster WHERE ItemGroupID = '" + groupId + "'");
            var items = dt.AsEnumerable().Select(row => new
            {
                Id = row["Id"].ToString(),
                itemname = row["itemname"].ToString()
            });
            return Json(items, JsonRequestBehavior.AllowGet);
        }
        private List<MembMaster> GetMembMasters()
        {
            List<MembMaster> membMasters = new List<MembMaster>();


            DataTable dt = ob.Returntable("select * from SabhasadMaster order by Code");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                MembMaster distMaster = new MembMaster
                {
                    Id = Convert.ToInt32(dt.Rows[i]["code"]),
                    Name = dt.Rows[i]["Name"].ToString()
                };



                membMasters.Add(distMaster);

            }
            return membMasters;
        }
        private List<itemMaster> GetitemMasters()
        {
            List<itemMaster> itemMaster = new List<itemMaster>();


            DataTable dt = ob.Returntable("select * from itemmaster  order by itemcode");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                itemMaster distMaster = new itemMaster
                {
                    Id = Convert.ToInt32(dt.Rows[i]["itemcode"]),
                    itemname = dt.Rows[i]["Name"].ToString()
                };



                itemMaster.Add(distMaster);

            }
            return itemMaster;
        }
        private List<talukamaster> GettalukaMasters()
        {
            List<talukamaster> taluka = new List<talukamaster>();


            DataTable dt = ob.Returntable("SELECT DISTINCT taluka AS code, taluka AS name  FROM citymaster");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                talukamaster ta = new talukamaster
                {
                    talukaid = dt.Rows[i]["code"].ToString(),
                    talukaname = dt.Rows[i]["name"].ToString()
                };



                taluka.Add(ta);

            }
            return taluka;
        }

        private List<itemgroup> GetitemgroupMasters()
        {
            List<itemgroup> itm = new List<itemgroup>();


            DataTable dt = ob.Returntable("SELECT code groupid,name groupname FROM itemgroup");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                itemgroup it = new itemgroup
                {
                    groupid = Convert.ToInt32(dt.Rows[i]["groupid"]),
                    groupname = dt.Rows[i]["groupname"].ToString()
                };



                itm.Add(it);

            }
            return itm;
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
                Session["uuserid"] = loginResponse.uuserid;
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
        public class Resultpass<T>
        {
            public bool opstatus { get; set; }
            public string opmessage { get; set; }
        }
        public class Product
        {
            public string ItemName { get; set; } // Corresponds to the 'itemName' from the table
            public string Qty { get; set; }

            public string Itemid { get; set; }

            public string rate { get; set; }
            public string amout { get; set; }

            public string itemgroup { get; set; }
        }
        [HttpPost]
        public JsonResult Addsale(string Billno, string billdate, string Membid, string MembName, string Ismem, string Ptype, string totalamt,string villageid,string talukaname, string products)
        {
            Resultpass<object> result = new Resultpass<object>();
            List<Product> productList = JsonConvert.DeserializeObject<List<Product>>(products);
            try
            {
                var dono = Billno;
                int mtype = 0;
                if (Ismem == "Yes")
                {
                    mtype = 1;
                }
                userId = HttpContext.Session["UserId"].ToString();
                ob.excute("Insert Into billmain(Billno, BillDate, Membid, MembName, Ptype, Ismem, Userid,Totalamt,talukaname,villageid) values(" + Billno + ",N'" + billdate + "'," + Membid + ",N'" + MembName + "','" + Ptype + "'," + mtype + "," + userId + "," + totalamt + ",N'" + talukaname + "'," + villageid + ")");

                foreach (var product in productList)
                {
                    ob.excute("Insert Into Billdetail(Billno,BillDate ,Itemid, Itemname, TQty, Ptype, Trate,Tnetamt, Userid,groupid) values(" + Billno + ",'" + billdate + "'," + product.Itemid + ",N'" + product.ItemName + "'," + product.Qty + ",'" + Ptype + "'," + product.rate + "," + product.amout + "," + userId + "," + product.itemgroup + ")");

                }

                result.opstatus = true;
                result.opmessage = dono;
                return Json(result, JsonRequestBehavior.AllowGet);
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