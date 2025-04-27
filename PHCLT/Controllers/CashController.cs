using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PHCLT.Controllers
{
    public class CashController : Controller
    {
        // GET: Cash
        ClsSystem ob = new ClsSystem();
        string userId = "";
        public ActionResult Index()
        {
            List<userMaster> userMaster = GetiuserMasters();

            userId = HttpContext.Session["UserId"].ToString();
            DateTime currentDate = DateTime.Now;

            // Extract month and year  totalsales
            int month = currentDate.Month;
            int year = currentDate.Year;
            DataTable dt = ob.Returntable("select isnull(max(Billno),0)+1 as Billno from PaymentDetail where Userid=" + Convert.ToInt32(userId.ToString()) + "");
            ViewBag.saleamt = ob.FindOneString("SELECT isnull(SUM(Totalamt),0) AS MonthlyTotal FROM  BillMain where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            ViewBag.receiptamt = ob.FindOneString("SELECT isnull(SUM(debit),0) AS MonthlyTotal FROM  PaymentDetail where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            ViewBag.extraamt = ob.FindOneString("SELECT isnull(SUM(credit),0) AS MonthlyTotal FROM  PaymentDetail where  YEAR(BillDate) =" + year + " and Userid=" + userId + "");
            ViewBag.totalamt = Convert.ToDouble(ViewBag.saleamt)+ Convert.ToDouble(ViewBag.extraamt) - Convert.ToDouble(ViewBag.receiptamt);
            ViewBag.billno = dt.Rows[0]["Billno"].ToString();
            ViewBag.usermaster = userMaster;
            return View();
        }
        public class userMaster
        {
            public int Id { get; set; }
            public string username { get; set; }
        }

        private List<userMaster> GetiuserMasters()
        {
            List<userMaster> itemMaster = new List<userMaster>();
            var suserId = HttpContext.Session["uuserid"].ToString();
            var utype = HttpContext.Session["UserType"].ToString();
            DataTable dt = new DataTable();
            if (utype == "Main")
            {
                dt = ob.Returntable("select Code Userid, Name UsesFullname from khedutmaster where code=" + suserId + " order by Userid");

            }
            else
            {
                suserId = HttpContext.Session["uuserid"].ToString();
                dt = ob.Returntable("select Code Userid,Name UsesFullname from QualityMaster where Code=" + suserId + " order by Userid");

            }
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                userMaster distMaster = new userMaster
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Userid"]),
                    username = dt.Rows[i]["UsesFullname"].ToString()
                };
                itemMaster.Add(distMaster);
            }
            return itemMaster;
        }

        public class Resultpass<T>
        {
            public bool opstatus { get; set; }
            public string opmessage { get; set; }
        }
        [HttpPost]
        public JsonResult Addpayment(string Billno, string billdate, string userid, string qty,string nname)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                var dono = Billno;
                int mtype = 0;

                var suserId = HttpContext.Session["UserId"].ToString();
                var fullname= HttpContext.Session["UsesFullname"].ToString(); 
                ob.excute("Insert Into PaymentDetail(Billno, Billdate,Userid,credit,debit,rem) values(" + Billno + ",'" + billdate + "'," + suserId + ",0," + qty + ",N'" + nname  + " ને જમા આપ્યા." + "')");
                ob.excute("Insert Into PaymentDetail(Billno, Billdate,Userid,credit,debit,rem) values(" + Billno + ",'" + billdate + "'," + userid + "," + qty + ",0,N'" + fullname + " માંથી જમા આવ્યા." + "')");


                result.opstatus = true;
                result.opmessage = dono;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}