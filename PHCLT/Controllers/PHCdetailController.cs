using PHCLT.Helper;
using PHCLT.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;


namespace PHCLT.Controllers
{
    [SessionCheckFilter]
    public class PHCdetailController : Controller
    {
        // GET: PHCdetail
        ClsSystem ob = new ClsSystem();
        string userId = "";
        public ActionResult PHCDetail()
        {
            List<DistMaster> distMasters = GetDistMasters();
            userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = ob.Returntable("select isnull(max(phcid),0)+1 as phcid from phcdetail where userid=" + Convert.ToInt32(userId.ToString()) + "");
            ViewBag.phcid = dt.Rows[0]["phcid"].ToString();
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
        public class Resultpass<T>
        {
            public bool opstatus { get; set; }
            public string opmessage { get; set; }
        }
        [HttpPost]
        public JsonResult AddPHCdetail(string id, string phcname, string disid, string talukaid, string phccode, string phcPopulation)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                userId = HttpContext.Session["UserId"].ToString();
                ob.excute("delete from phcdetail where phcid=" + Convert.ToInt32(id.ToString()) + " and userid=" + Convert.ToInt32(userId.ToString()) + "");
                ob.excute("insert Into phcdetail(phcid, phcname, disid, talukaid, phccode, phcPopulation,userid) values(" + Convert.ToInt64(id.ToString()) + ",'" + phcname.ToString() + "'," + Convert.ToInt64(disid.ToString()) + "," + Convert.ToInt64(talukaid.ToString()) + ",'" + phccode.ToString() + "'," + Convert.ToDouble(phcPopulation.ToString()) + "," + userId + ")");
                var dono = ob.FindOneString("select isnull(max(phcid),0)+1 as phcid from phcdetail where userid=" + Convert.ToInt32(userId.ToString()) + "");
                result.opstatus = true;
                result.opmessage = dono;
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;               
            }
        }

        public ActionResult PHCdetailList()
        {
            List<PHCdetailList> distMasters = GetPHCdetailList();
            ViewBag.PHCdetailList = distMasters;
            return View();
        }
        private List<PHCdetailList> GetPHCdetailList()
        {
            List<PHCdetailList> distMasters = new List<PHCdetailList>();
            userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = ob.Returntable("select * from phcdetail where userid=" + userId + " order by phcid");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                PHCdetailList distMaster = new PHCdetailList
                {
                    id = (int)dt.Rows[i]["phcid"],
                    phcname = dt.Rows[i]["phcname"].ToString(),
                    phcpop = dt.Rows[i]["phcPopulation"].ToString()
                };
                distMasters.Add(distMaster);
            }
            return distMasters;
        }
        [HttpGet]
        public JsonResult GetVillageList(int Phcid)
        {
            try
            {
                List<VillageList> villmast = GetVillageListFromDatabase(Phcid);
                return Json(villmast, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        private List<VillageList> GetVillageListFromDatabase(int Phcid)
        {
            List<VillageList> villageLists = new List<VillageList>();
            userId = HttpContext.Session["UserId"].ToString();
            DataTable dt = ob.Returntable("select * from VillageMaster where UserId=" + userId + " and phcid=" + Phcid + " order by phcid");
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                VillageList villmast = new VillageList
                {
                    VillageMasterId = (int)dt.Rows[i]["VillageMasterId"],
                    VillageName = dt.Rows[i]["VillageName"].ToString(),
                };
                villageLists.Add(villmast);
            }
            return villageLists;
        }
        public ActionResult Edit(int ID)
        {
            userId = HttpContext.Session["UserId"].ToString();
            ViewBag.phcid = ID;
            DataTable dt = ob.Returntable("select * from phcdetail where userid=" + userId + " and phcid=" + ID + " order by phcid");
            if (dt.Rows.Count > 0)
            {
                ViewBag.phcname = dt.Rows[0]["phcname"].ToString();
                List<DistMaster> distMasters = GetDistMasters();
                ViewBag.DistMasters = distMasters;
                ViewBag.SelectedDistrictId = (int)dt.Rows[0]["disid"];
                ViewBag.phccode = dt.Rows[0]["phccode"].ToString();
                ViewBag.Population = Convert.ToDouble(dt.Rows[0]["phcPopulation"]);
                ViewBag.talikaid= (int)dt.Rows[0]["talukaid"];
            }
            return View("~/Views/PHCdetail/PHCdetail.cshtml");
        }
        [HttpPost]
        public JsonResult DeleteId(string id)
        {
            userId = HttpContext.Session["UserId"].ToString();
            ob.excute("delete from phcdetail where phcid=" + Convert.ToInt32(id.ToString()) + " and userid=" + Convert.ToInt32(userId.ToString()) + "");

            return Json("Save", JsonRequestBehavior.AllowGet);
        }

        public ActionResult SubCenter(int subCenterId=0)
        {
            List<PHCdetailList> pHCCenter = GetPHCdetailList();

        

            ViewBag.phcCenter = pHCCenter;
    


            return View();
        }

        public ActionResult SubCenterList()
        {
            List<SubCenterDetails> subCenterDetailsList = getAllSubCenter();

            ViewBag.SubCenterDetailsList = subCenterDetailsList;

            return View();
        }

        [HttpGet]
        public JsonResult GetAllSubCenter()
        {
            try
            {
                List<SubCenterDetails> subCenterDetailsList = getAllSubCenter();
                return Json(subCenterDetailsList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult GetSubCenterById(int SubCenterDetailsId)
        {
            try
            {
                List<SubCenterDetails> subCenterDetailsList = getSubCenterById(SubCenterDetailsId);
                return Json(subCenterDetailsList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult InsertSubCenterDetails(InsertSubCenterDetails request)
        {
            try
            {
                int result = insertSubCenterDetails(request);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult UpdateSubCenterDetails(UpdateSubCenterDetails request)
        {
            try
            {
                int result = updateSubCenterDetails(request);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult DeleteSubCenterDetails(int SubCenterDetailsId)
        {
            try
            {
                int result = deleteSubCenterDetails(SubCenterDetailsId);
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        private List<SubCenterDetails> getAllSubCenter()
        {
            List<SubCenterDetails> subCenterDetailsList = new List<SubCenterDetails>();
            userId = HttpContext.Session["UserId"].ToString();

            DataTable dt = ob.Returntable($"SELECT SubCenterDetailsId, SCD.PHCId, SCD.UserId, SubCenterName,phcname as PHCCenterName,VillageName FROM SubCenterDetails SCD inner join phcdetail PHC on PHC.phcid = SCD.PHCId inner join VillageMaster vil on SCD.Village_id=vil.VillageMasterId and SCD.PHCId=vil.PHCId where SCD.UserId = {Convert.ToInt32(userId.ToString())} and phc.userid = {Convert.ToInt32(userId.ToString())}");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SubCenterDetails subCenterDetails = new SubCenterDetails
                {
                    SubCenterDetailsId = Convert.ToInt32(dt.Rows[i]["SubCenterDetailsId"]),
                    PHCId = Convert.ToInt32(dt.Rows[i]["PHCId"]),
                    UserId = Convert.ToInt32(dt.Rows[i]["UserId"]),
                    SubCenterName = dt.Rows[i]["SubCenterName"].ToString(),
                    PHCCenterName = dt.Rows[i]["PHCCenterName"].ToString(),
                    villagename=dt.Rows[i]["VillageName"].ToString()
                };

                subCenterDetailsList.Add(subCenterDetails);
            }

            return subCenterDetailsList;
        }

        private List<SubCenterDetails> getSubCenterById(int SubCenterDetailsId)
        {
            List<SubCenterDetails> subCenterDetailsList = new List<SubCenterDetails>();
            userId = HttpContext.Session["UserId"].ToString();

            DataTable dt = ob.Returntable($@"SELECT SubCenterDetailsId, SCD.PHCId, SCD.UserId, SubCenterName,phcname as PHCCenterName, Village_id, CreatedBy, CreatedAt, UpdatedBy, UpdatedAt, IsActive FROM SubCenterDetails SCD
inner join phcdetail PHC on PHC.phcid = SCD.PHCId and SubCenterDetailsId = {SubCenterDetailsId} and phc.userid = {Convert.ToInt32(userId.ToString())}");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                SubCenterDetails subCenterDetails = new SubCenterDetails
                {
                    SubCenterDetailsId = Convert.ToInt32(dt.Rows[i]["SubCenterDetailsId"]),
                    PHCId = Convert.ToInt32(dt.Rows[i]["PHCId"]),
                    UserId = Convert.ToInt32(dt.Rows[i]["UserId"]),
                    SubCenterName = dt.Rows[i]["SubCenterName"].ToString(),
                    CreatedBy = Convert.ToInt32(dt.Rows[i]["CreatedBy"]),
                    CreatedAt = Convert.ToDateTime(dt.Rows[i]["CreatedAt"]),
                    UpdatedBy = dt.Rows[i]["UpdatedBy"] != DBNull.Value ? Convert.ToInt32(dt.Rows[i]["UpdatedBy"]) : (int?)null,
                    UpdatedAt = dt.Rows[i]["UpdatedAt"] != DBNull.Value ? Convert.ToDateTime(dt.Rows[i]["UpdatedAt"]) : (DateTime?)null,
                    IsActive = Convert.ToBoolean(dt.Rows[i]["IsActive"]),
                    PHCCenterName = dt.Rows[i]["PHCCenterName"].ToString(),
                    villageid= Convert.ToInt32(dt.Rows[i]["Village_id"])
                };

                subCenterDetailsList.Add(subCenterDetails);
            }

            return subCenterDetailsList;
        }

        private int insertSubCenterDetails(InsertSubCenterDetails request)
        {
            try
            {
                int result = 0;
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string insertStatement = $@"INSERT INTO SubCenterDetails 
                                (PHCId, UserId, SubCenterName, Village_id, CreatedBy, CreatedAt,IsActive) 
                                VALUES 
                                ({request.PHCId}, {request.UserId}, '{request.SubCenterName}', {request.villageid},{request.UserId}, '{formattedDateTime}',1);";

                result = ob.excute(insertStatement);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private int updateSubCenterDetails(UpdateSubCenterDetails request)
        {
            try
            {
                int result = 0;
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string updateStatement = $@"UPDATE SubCenterDetails
                                            SET PHCId = {request.PHCId},
                                                UserId ={request.UserId},
                                                SubCenterName = '{request.SubCenterName}',
                                                Village_id='{request.villageid}',
                                                UpdatedBy = {request.UserId},
                                                UpdatedAt ='{formattedDateTime}'
                                            WHERE SubCenterDetailsId = {request.SubCenterDetailsId}";

                result = ob.excute(updateStatement);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private int deleteSubCenterDetails(int SubCenterDetailsId)
        {
            try
            {
                int result = 0;

                string deleteStatement = $@"delete from SubCenterDetails                                            
                                            WHERE SubCenterDetailsId = {SubCenterDetailsId}";

                result = ob.excute(deleteStatement);

                return result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult VilageList()
        {
            List<VillageMaster> villageList = GetVillageListScript();
            ViewBag.VillageList = villageList;
            return View();
        }

        private List<VillageMaster> GetVillageListScript(int id = 0)
        {
            List<VillageMaster> villageList = new List<VillageMaster>();
            userId = HttpContext.Session["UserId"].ToString();
            string sql;
            if (id > 0)
            {
                 sql = $@"select VillageMasterId,VM.PHCId,phcname,VM.UserId,VillageName,Population,CreatedBy,CreatedAt,UpdatedBy,UpdatedAt,IsActive
                            from VillageMaster VM
                            inner join  phcdetail PHC on PHC.phcid = VM.PHCId AND VM.UserId = {userId} AND PHC.UserId = {userId} and VillageMasterId = {id}";
            }
            else
            {
                 sql = $@"select VillageMasterId,VM.PHCId,phcname,VM.UserId,VillageName,Population,CreatedBy,CreatedAt,UpdatedBy,UpdatedAt,IsActive
                            from VillageMaster VM
                            inner join  phcdetail PHC on PHC.phcid = VM.PHCId AND VM.UserId = {userId} AND PHC.UserId = {userId}";
            }

            DataTable dt = ob.Returntable(sql);
            for (int i = 0; i <= dt.Rows.Count - 1; i++)
            {
                VillageMaster villageMaster = new VillageMaster
                {
                    VillageMasterId = Convert.ToInt32(dt.Rows[i]["VillageMasterId"]),
                    PHCId = Convert.ToInt32(dt.Rows[i]["PHCId"]),
                    phcname = dt.Rows[i]["phcname"].ToString(),
                    UserId = Convert.ToInt32(dt.Rows[i]["UserId"]),
                    VillageName = dt.Rows[i]["VillageName"].ToString(),
                    CreatedBy = Convert.ToInt32(dt.Rows[i]["CreatedBy"]),
                    CreatedAt = Convert.ToDateTime(dt.Rows[i]["CreatedAt"]),
                    UpdatedBy = dt.Rows[i]["UpdatedBy"] == DBNull.Value ? (int?)null : Convert.ToInt32(dt.Rows[i]["UpdatedBy"]),
                    UpdatedAt = dt.Rows[i]["UpdatedAt"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dt.Rows[i]["UpdatedAt"]),
                    IsActive = Convert.ToBoolean(dt.Rows[i]["IsActive"]),
                    Population= dt.Rows[i]["Population"].ToString()
                };
                villageList.Add(villageMaster);
            }
            return villageList;
        }

        [HttpPost]
        public JsonResult AddVillageDetails(int PHCId, string VillageName,string VillagePopulation)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                userId = HttpContext.Session["UserId"].ToString();
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string sql = $@"INSERT INTO VillageMaster (PHCId, UserId, VillageName,Population, CreatedBy, CreatedAt, IsActive)
                                VALUES ({PHCId},{userId}, '{VillageName}',{VillagePopulation}, {userId}, '{formattedDateTime}', 1);";

                ob.excute(sql);                

                result.opstatus = true;
                result.opmessage = "";
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public JsonResult UpdateVillageDetails(int PHCId, string VillageName,int VillageMasterId, string VillagePopulation)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                userId = HttpContext.Session["UserId"].ToString();
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string sql = $@"UPDATE VillageMaster
                             SET PHCId = {PHCId}, 
                                 UserId = {userId},
                                 VillageName = '{VillageName}',
                                 UpdatedBy = {userId},
                                 UpdatedAt = '{formattedDateTime}',
                                 Population={VillagePopulation},
                                 IsActive = 1
                             WHERE VillageMasterId = {VillageMasterId};
                             ";

                ob.excute(sql);

                result.opstatus = true;
                result.opmessage = "";
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult GetVillageDetails(int VillageMasterId)
        {            
            try
            {
                List<VillageMaster> villageList = GetVillageListScript(VillageMasterId);

                return Json(villageList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult DeleteVillage(int VillageMasterId)
        {
            Resultpass<object> result = new Resultpass<object>();
            try
            {
                string sql = $@"delete from villagemaster where VillageMasterId = {VillageMasterId}";

                ob.excute(sql);

                result.opstatus = true;
                result.opmessage = "";
                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ActionResult VillageDetails(int ID = 0)
        {
            try
            {
                if (ID > 0) {
                    List<VillageMaster> villageList = GetVillageListScript(ID);
                    if (villageList != null && villageList.Count > 0)
                    {
                        ViewBag.phcid = villageList[0].PHCId;
                        ViewBag.villageName = villageList[0].VillageName;
                        ViewBag.VillageMasterId = villageList[0].VillageMasterId;
                        ViewBag.villagePopulation = villageList[0].Population;
                    }
                }
                
                ViewBag.PHCCenterList = GetPHCdetailList();
                return View("~/Views/PHCdetail/VillageDetails.cshtml");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }
    }
}