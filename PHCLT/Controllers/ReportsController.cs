using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using Newtonsoft.Json;
using PHCLT.Models;

namespace PHCLT.Controllers
{
    public class ReportsController : Controller
    {
        // GET: Reports
        ClsSystem ob = new ClsSystem();
        public ActionResult DailyReport(string fromdate, string todate)
        {

            List<Dreport> Dreport = new List<Dreport>();
            var userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = new DataTable();
            List<Dreport> DreportList = new List<Dreport>();
            dt = ob.Returntable("Select Billno Tranno,BillDate Transdate,MembName Remarks,Totalamt as Paymentamt,Ptype as Billtype from BillMain where Userid=" + userId + " and BillDate between '" + fromdate.ToString() + "' and '" + todate.ToString() + "' order by Billdate,billno");


            double cr = 0;
            Double dr = 0;
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {

                Dreport dreport = new Dreport
                {
                    Tranno = dt.Rows[i]["Tranno"].ToString(),
                    Transdate = Convert.ToDateTime(dt.Rows[i]["Transdate"].ToString()),
                    Remarks = dt.Rows[i]["Remarks"].ToString(),
                    Paymentamt = dt.Rows[i]["Paymentamt"].ToString(),
                    Billtype = dt.Rows[i]["Billtype"].ToString(),
                    Items = new List<BillItem>()
                };

                string tranno = dt.Rows[i]["Tranno"].ToString();
                DataTable itemTable = ob.Returntable("SELECT * FROM Billdetail WHERE BillNo = '" + tranno + "' and Userid=" + userId + "");

                foreach (DataRow itemRow in itemTable.Rows)
                {
                    BillItem item = new BillItem
                    {
                        ItemName = itemRow["ItemName"].ToString(),
                        Qty = Convert.ToInt32(itemRow["TQty"]),
                        Rate = Convert.ToDecimal(itemRow["TRate"]),
                        Total = Convert.ToDecimal(itemRow["Tnetamt"]),
                        Unit= itemRow["Unit"].ToString(),
                    };

                    dreport.Items.Add(item);
                }

                DreportList.Add(dreport);
                //Dreport.Add(dreport);
            }
            ViewBag.rptdetail = DreportList;
            ViewBag.fromdt = fromdate;
            ViewBag.todate = todate;

            return View();
        }
       
        public class itemMaster
        {
            public int Id { get; set; }
            public string itemname { get; set; }
        }
        public ActionResult ItemledReport(string fromdate, string todate, string itemid)
        {
            List<itemledreport> Dreport = new List<itemledreport>();
            if (itemid != null)
            {
                Dreport = Getitemlegreport(itemid, fromdate, todate);
            }
            List<itemMaster> ItemMasters = GetitemMasters();
            ViewBag.itemmast = ItemMasters;
            ViewBag.rptdetail = Dreport;
            ViewBag.fromdt = fromdate;
            ViewBag.todate = todate;
            return View();
        }
        public ActionResult AcLedReport(string fromdate, string todate)
        {
            List<itemledreport> Dreport = new List<itemledreport>();
            var userId = HttpContext.Session["UserId"].ToString();
            ob.excute("delete from Tmpacled where userid=" + userId + "");
            ob.excute("insert into Tmpacled(billno, billtype,BillDate, Cramt, Dramt,userid) select billno,N'વેચાણ',BillDate,Totalamt,0,Userid from billmain where  billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + "");
            ob.excute("insert into Tmpacled(billno, billtype,BillDate, Cramt, Dramt,userid) select billno,rem,BillDate,credit,debit,Userid from paymentdetail where billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + "");
            DataTable dt = ob.Returntable("select * from Tmpacled where userid=" + userId + " order by BillDate");
            double cr = 0;
            Double dr = 0;
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                cr += Convert.ToDouble(dt.Rows[i]["Cramt"].ToString());
                dr += Convert.ToDouble(dt.Rows[i]["Dramt"].ToString());
                double bal = 0;

                if (cr > dr)
                {
                    bal = cr - dr;
                }
                else
                {
                    bal = dr - cr;
                }
                itemledreport distMaster = new itemledreport
                {
                    Tranno = dt.Rows[i]["billno"].ToString(),
                    Transdate = Convert.ToDateTime(dt.Rows[i]["BillDate"].ToString()),
                    Billtype = dt.Rows[i]["billtype"].ToString(),
                    inqty = dt.Rows[i]["Cramt"].ToString(),
                    outqty = dt.Rows[i]["Dramt"].ToString(),
                    Balanqty = bal.ToString("F2")
                };
                Dreport.Add(distMaster);
            }


            ViewBag.rptdetail = Dreport;
            ViewBag.fromdt = fromdate;
            ViewBag.todate = todate;
            return View();
        }
        private List<itemMaster> GetitemMasters()
        {
            List<itemMaster> itemMaster = new List<itemMaster>();

            DataTable dt = ob.Returntable("select * from itemmaster order by itemcode");
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

        private List<itemledreport> Getitemlegreport(string itemid, string fromdate, string todate)
        {
            List<itemledreport> itemMaster = new List<itemledreport>();
            var userId = HttpContext.Session["UserId"].ToString();
            ob.excute("delete from tmpitemledreport where userid=" + userId + "");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty,Unit) select billno,'Sales',BillDate,itemid,userid,0,TQty,Unit from Billdetail where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + "");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty,Unit) select billno,remarks,BillDate,itemid,userid,InQty,0,Unit from ItemTrans where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + " and inqty<>0");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty,Unit) select billno,remarks,BillDate,itemid,userid,0,Outqty,Unit from ItemTrans where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + " and Outqty<>0");
            DataTable dt = ob.Returntable("select * from tmpitemledreport where userid=" + userId + " order by BillDate");
            double cr = 0;
            Double dr = 0;
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                cr += Convert.ToDouble(dt.Rows[i]["inqty"].ToString());
                dr += Convert.ToDouble(dt.Rows[i]["outqty"].ToString());
                double bal = 0;

                if (cr > dr)
                {
                    bal = cr - dr;
                }
                else
                {
                    bal = dr - cr;
                }

                itemledreport distMaster = new itemledreport
                {
                    Tranno = dt.Rows[i]["billno"].ToString(),
                    Transdate = Convert.ToDateTime(dt.Rows[i]["BillDate"].ToString()),
                    Billtype = dt.Rows[i]["billtype"].ToString(),
                    inqty = dt.Rows[i]["inqty"].ToString(),
                    outqty = dt.Rows[i]["outqty"].ToString(),
                    Balanqty = bal.ToString("F2"),
                    Unit= dt.Rows[i]["Unit"].ToString() 
                };
                itemMaster.Add(distMaster);
            }
            return itemMaster;
        }
    }
}