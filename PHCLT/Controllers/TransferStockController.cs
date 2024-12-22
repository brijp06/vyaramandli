using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace PHCLT.Controllers
{
    public class TransferStockController : Controller
    {
        // GET: TransferStock
        ClsSystem ob = new ClsSystem();
        string userId = "";
        public ActionResult Index()
        {
            List<itemMaster> ItemMasters = GetitemMasters();
            List<userMaster> userMaster = GetiuserMasters();

            userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = ob.Returntable("select isnull(max(Billno),0)+1 as Billno from ItemTrans where Userid=" + Convert.ToInt32(userId.ToString()) + "");
            ViewBag.billno = dt.Rows[0]["Billno"].ToString();
            ViewBag.itemmast = ItemMasters;
            ViewBag.usermaster = userMaster;

            return View();
        }
        public class itemMaster
        {
            public int Id { get; set; }
            public string itemname { get; set; }
        }
        public class userMaster
        {
            public int Id { get; set; }
            public string username { get; set; }
        }
        private List<itemMaster> GetitemMasters()
        {
            List<itemMaster> itemMaster = new List<itemMaster>();

            DataTable dt = ob.Returntable("select * from itemmaster where itype='Bhandar' order by itemcode");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                itemMaster distMaster = new itemMaster
                {
                    Id = (int)dt.Rows[i]["itemcode"],
                    itemname = dt.Rows[i]["Name"].ToString()
                };
                itemMaster.Add(distMaster);
            }
            return itemMaster;
        }
        private List<userMaster> GetiuserMasters()
        {
            List<userMaster> itemMaster = new List<userMaster>();
            var suserId = HttpContext.Session["UserId"].ToString();
            var utype = HttpContext.Session["UserType"].ToString();
            DataTable dt = new DataTable();
            if (utype == "Admin")
            {
                dt = ob.Returntable("select * from UserMaster where uuserid=" + suserId + " order by Userid");

            }
            else
            {
                suserId = HttpContext.Session["uuserid"].ToString();
                dt = ob.Returntable("select * from UserMaster where userid=" + suserId + " order by Userid");

            }
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                userMaster distMaster = new userMaster
                {
                    Id = (int)dt.Rows[i]["Userid"],
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
        public JsonResult Addstock(string Billno, string billdate, string userid, string itemid, string itemname,string qty)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                var dono = Billno;
                int mtype = 0;
               
                var suserId = HttpContext.Session["UserId"].ToString();
                ob.excute("Insert Into ItemTrans(Billno, Billdate,Userid, InQty, Outqty, Itemid, Itemname) values(" + Billno + ",'" + billdate + "'," + suserId + ",0," + qty + "," + itemid + ",N'" + itemname + "')");
                ob.excute("Insert Into ItemTrans(Billno, Billdate,Userid, InQty, Outqty, Itemid, Itemname) values(" + Billno + ",'" + billdate + "'," + userid + "," + qty + ",0," + itemid + ",N'" + itemname + "')");


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