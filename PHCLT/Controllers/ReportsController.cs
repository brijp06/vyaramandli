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
        public ActionResult DailyReport(string ledgerid, string ledgername, string fromdate, string todate)
        {
            ViewBag.ledgerid = ledgerid;
            ViewBag.ledgername = ledgername;
            List<Dreport> Dreport = new List<Dreport>();
            var userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = new DataTable();
            if (ledgerid == "46")
            {
                //dt = ob.Returntable("Select Tranno,Transdate,Remarks,Receiptamt,Paymentamt from Transactionmaster where Partyaccountid=" + userId + " and PurchaseAccountId=" + ledgerid + " and TransDate between '" + fromdate.ToString() + "' and '" + todate.ToString() + "' order by Transdate");
                dt = ob.Returntable("exec SabhasadLedgerChikuKeri '" + fromdate.ToString() + "','" + todate.ToString() + "'," + ledgerid + "," + userId + ",0,0,0");
            }
            else
            {
                //dt = ob.Returntable("Select Tranno,Transdate,Remarks,Receiptamt as Credit,Paymentamt as Debit from Transactionmaster where Partyaccountid=" + userId + " and PurchaseAccountId=" + ledgerid + " and TransDate between '" + fromdate.ToString() + "' and '" + todate.ToString() + "' order by Transdate");
                dt = ob.Returntable("exec SabhasadLedgerChikuKeri '" + fromdate.ToString() + "','" + todate.ToString() + "'," + ledgerid + "," + userId + ",0,0,0");
            }
            double cr = 0;
            Double dr = 0;
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                cr += Convert.ToDouble(dt.Rows[i]["Credit"].ToString());
                dr += Convert.ToDouble(dt.Rows[i]["Debit"].ToString());
                double bal = 0;

                if (cr>dr)
                {
                    bal = cr - dr;
                }
                else
                {
                    bal = dr - cr;
                }
                Dreport dreport = new Dreport
                {
                    Tranno = dt.Rows[i]["Tranno"].ToString(),
                    Transdate = Convert.ToDateTime(dt.Rows[i]["Transdate"].ToString()),
                    Remarks = dt.Rows[i]["Remarks"].ToString(),
                    Receiptamt = dt.Rows[i]["Credit"].ToString(),
                    Paymentamt = dt.Rows[i]["Debit"].ToString(),
                    Balanceamt=bal.ToString("F2")
                };
            Dreport.Add(dreport);
        }
        ViewBag.rptdetail = Dreport;
            ViewBag.fromdt = fromdate;
            ViewBag.todate = todate;

            return View();
    }



}
}