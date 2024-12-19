using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace PHCLT.Controllers
{
    public class PHCdetailController : Controller
    {
        // GET: PHCdetail
        ClsSystem ob = new ClsSystem();
        public ActionResult PHCDetail()
        {
            List<DistMaster> distMasters = GetDistMasters();

            ViewBag.DistMasters = distMasters;
            return View();
        }
        public class DistMaster
        {
            public int Id { get; set; }
            public string DisName { get; set; }
        }
        private List<DistMaster> GetDistMasters()
        {
            List<DistMaster> distMasters = new List<DistMaster>();
           

            DataTable dt = ob.Returntable("select * from DistrictMaster order by DisName");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                DistMaster distMaster = new DistMaster
                {
                    Id = (int)dt.Rows[i]["Id"],
                    DisName = dt.Rows[i]["DisName"].ToString()
                };

               

                distMasters.Add(distMaster);
                
            }
            return distMasters;
        }
        public class TalukaMaster
        {
            public int Id { get; set; }
            public int Distid { get; set; }
            public string Talukaname { get; set; }
        }
        [HttpGet]
        public JsonResult GetTalukasByDistinctId(int distinctId)
        {
            try
            {
                List<TalukaMaster> talukas = GetTalukasByDistinctIdFromDatabase(distinctId);
                return Json(talukas, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        private List<TalukaMaster> GetTalukasByDistinctIdFromDatabase(int distinctId)
        {
            List<TalukaMaster> talukas = new List<TalukaMaster>();

            // Assuming you have a method to retrieve talukas based on distinctId from the database
            DataTable dt = ob.Returntable($"SELECT * FROM TalukaMastar WHERE Distid = {distinctId}");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                TalukaMaster taluka = new TalukaMaster
                {
                    Id = (int)dt.Rows[i]["Id"],
                    Talukaname = dt.Rows[i]["TalukaName"].ToString(),
                    Distid = (int)dt.Rows[i]["Distid"]
                    // Add other properties as needed
                };

                talukas.Add(taluka);
            }

            return talukas;
        }

    }
}