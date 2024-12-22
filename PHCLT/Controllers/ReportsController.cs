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
                    Billtype = dt.Rows[i]["Billtype"].ToString()
                };
                Dreport.Add(dreport);
            }
            ViewBag.rptdetail = Dreport;
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

        private List<itemledreport> Getitemlegreport(string itemid, string fromdate, string todate)
        {
            List<itemledreport> itemMaster = new List<itemledreport>();
            var userId = HttpContext.Session["UserId"].ToString();
            ob.excute("delete from tmpitemledreport where userid=" + userId + "");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty) select billno,'Sales',BillDate,itemid,userid,0,TQty from Billdetail where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + "");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty) select billno,'inword',BillDate,itemid,userid,InQty,0 from ItemTrans where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + " and inqty<>0");
            ob.excute("insert into tmpitemledreport(billno, billtype,BillDate, itemid, userid, inqty, outqty) select billno,'outword',BillDate,itemid,userid,0,Outqty from ItemTrans where itemid=" + itemid + " and billdate between '" + fromdate + "' and '" + todate + "' and userid=" + userId + " and Outqty<>0");
            DataTable dt = ob.Returntable("select * from tmpitemledreport where userid=" + userId + "");
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
                    inqty= dt.Rows[i]["inqty"].ToString(),
                    outqty = dt.Rows[i]["outqty"].ToString(),
                    Balanqty= bal.ToString("F2")
                };
                itemMaster.Add(distMaster);
            }
            return itemMaster;
        }
    }
}