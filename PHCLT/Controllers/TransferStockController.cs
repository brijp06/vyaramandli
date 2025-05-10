using Newtonsoft.Json;
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

            DataTable dt = ob.Returntable("select itemcode,Name from itemmaster  order by itemcode");
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
        private List<userMaster> GetiuserMasters()
        {
            List<userMaster> itemMaster = new List<userMaster>();
            var suserId = HttpContext.Session["UserId"].ToString();
            var utype = HttpContext.Session["UserType"].ToString();
            DataTable dt = new DataTable();
            if (utype == "Main")
            {
                dt = ob.Returntable("select StaffId Userid, Name UsesFullname from OfficerMaster where SName=" + suserId + " order by Userid");
                DataTable dss = new DataTable();
                var sid = HttpContext.Session["uuserid"].ToString();
                dss = ob.Returntable("select Code Userid, Name UsesFullname from KhedutMaster where Code=" + sid + " order by Code");
                for (int ij = 0; ij <= dss.Rows.Count - 1; ij++)
                {
                    userMaster distMaster = new userMaster
                    {
                        Id = Convert.ToInt32(dss.Rows[ij]["Userid"]),
                        username = dss.Rows[ij]["UsesFullname"].ToString()
                    };
                    itemMaster.Add(distMaster);
                }

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
        public class Product
        {
            public string ItemName { get; set; } // Corresponds to the 'itemName' from the table
            public string Qty { get; set; }

            public string Itemid { get; set; }

            public string unit { get; set; }


        }
        [HttpPost]
        public JsonResult Addstock(string Billno, string billdate, string userid,string username, string products)
        {
            Resultpass<object> result = new Resultpass<object>();
            List<Product> productList = JsonConvert.DeserializeObject<List<Product>>(products);
            try
            {
                var dono = Billno;
                int mtype = 0;
               
                var suserId = HttpContext.Session["UserId"].ToString();
                var fullname = HttpContext.Session["UsesFullname"].ToString();
                foreach (var product in productList)
                {
                    ob.excute("Insert Into ItemTrans(Billno, Billdate,Userid, InQty, Outqty, Itemid, Itemname,remarks,Unit ) values(" + Billno + ",'" + billdate + "'," + suserId + ",0," + product.Qty + "," + product.Itemid + ",N'" + product.ItemName + "',N'" + username.ToString().Trim() + " ને ટ્રાન્સફર આપ્યા.',N'" + product.unit.ToString().Trim() + "')");
                    ob.excute("Insert Into ItemTrans(Billno, Billdate,Userid, InQty, Outqty, Itemid, Itemname,remarks,Unit ) values(" + Billno + ",'" + billdate + "'," + userid + "," + product.Qty + ",0," + product.Itemid + ",N'" + product.ItemName + "',N'" + fullname.ToString().Trim() + " માંથી  ટ્રાન્સફર આવ્યા.',N'" + product.unit.ToString().Trim() + "')");
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
    }
}