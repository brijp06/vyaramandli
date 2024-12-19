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
    public class TransactionController : Controller
    {
        // GET: PHCdetail
        ClsSystem ob = new ClsSystem();
        string userId = "";

        public ActionResult DailyCollectionEntry()
        {
            List<SubCenterEmployee> subCenterEmployeeList = new List<SubCenterEmployee>();
            subCenterEmployeeList = subCenterEmployees();
            var phcList = GetPHCdetailList();
            var designationList = GetDesignationMasterList();
            List<DailyCollectionEntry> dailyCollectionEntryList = getDailyCollectionEntryList();

            ViewBag.SubCenterEmployeeList = subCenterEmployeeList;
            ViewBag.PHCList = phcList;
            ViewBag.DesignationList = designationList;
            ViewBag.DailyCollectionEntryList = dailyCollectionEntryList;

            return View();            
        }

        private List<SubCenterEmployee> subCenterEmployees(int subCenterEmployeeId = 0)
        {
            try
            {
                List<SubCenterEmployee> subCenterEmployeeList = new List<SubCenterEmployee>();
                userId = HttpContext.Session["UserId"].ToString();

                string sql;
                if (subCenterEmployeeId > 0)
                {
                    sql = $@"SELECT 
                             SCE.SubCenterEmployeeId,
                             SCE.PHCId,
                             PD.PHCName,
                             SCE.VillageId,
                             VM.VillageName,
                             SCD.SubCenterDetailsId,
                             SCD.SubCenterName,
                             SCE.DesgnationId,
                             DM.DesignationName,
                             SCE.EmployeeName,
                             SCE.UserId,
                             SCE.CreatedAt,
                             SCE.CreatedBy,
                             SCE.UpdatedAt,
                             SCE.UpdatedBy,
                             SCE.IsActive
                         FROM 
                             SubCenterEmployee SCE
                         JOIN 
                             phcdetail PD ON SCE.PHCId = PD.phcid AND SCE.UserId = PD.userid
                         JOIN 
                             SubCenterDetails SCD ON SCE.SubCenterId = SCD.SubCenterDetailsId AND SCE.UserId = SCD.userid
                         JOIN 
                             VillageMaster VM ON SCE.VillageId = VM.VillageMasterId AND SCE.UserId = VM.userid
                         JOIN 
                             DesignationMaster DM ON SCE.DesgnationId = DM.DesignationMasterId 
                         WHERE SCE.UserId = {userId} AND SubCenterEmployeeId = {subCenterEmployeeId}
                         ";
                }
                else
                {
                    sql = $@"SELECT 
                             SCE.SubCenterEmployeeId,
                             SCE.PHCId,
                             PD.PHCName,
                             SCE.VillageId,
                             VM.VillageName,
                             SCD.SubCenterDetailsId,
                             SCD.SubCenterName,
                             SCE.DesgnationId,
                             DM.DesignationName,
                             SCE.EmployeeName,
                             SCE.UserId,
                             SCE.CreatedAt,
                             SCE.CreatedBy,
                             SCE.UpdatedAt,
                             SCE.UpdatedBy,
                             SCE.IsActive
                         FROM 
                             SubCenterEmployee SCE
                         JOIN 
                             phcdetail PD ON SCE.PHCId = PD.phcid AND SCE.UserId = PD.userid
                         JOIN 
                             SubCenterDetails SCD ON SCE.SubCenterId = SCD.SubCenterDetailsId AND SCE.UserId = SCD.userid
                         JOIN 
                             VillageMaster VM ON SCE.VillageId = VM.VillageMasterId AND SCE.UserId = VM.userid
                         JOIN 
                             DesignationMaster DM ON SCE.DesgnationId = DM.DesignationMasterId
                         WHERE SCE.UserId = {userId}
                         ";
                }

                DataTable dt = ob.Returntable(sql);
                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    SubCenterEmployee subCenterEmployee = new SubCenterEmployee
                    {
                        SubCenterEmployeeId = Convert.ToInt32(dt.Rows[i]["SubCenterEmployeeId"]),
                        PHCId = Convert.ToInt32(dt.Rows[i]["PHCId"]),
                        PHCName = dt.Rows[i]["PHCName"].ToString(),
                        VillageId = Convert.ToInt32(dt.Rows[i]["VillageId"]),
                        VillageName = dt.Rows[i]["VillageName"].ToString(),
                        SubCenterDetailsId = Convert.ToInt32(dt.Rows[i]["SubCenterDetailsId"]),
                        SubCenterName = dt.Rows[i]["SubCenterName"].ToString(),
                        DesgnationId = Convert.ToInt32(dt.Rows[i]["DesgnationId"]),
                        DesignationName = dt.Rows[i]["DesignationName"].ToString(),
                        EmployeeName = dt.Rows[i]["EmployeeName"].ToString(),
                        UserId = Convert.ToInt32(dt.Rows[i]["UserId"]),
                        CreatedAt = Convert.ToDateTime(dt.Rows[i]["CreatedAt"]),
                        CreatedBy = Convert.ToInt32(dt.Rows[i]["CreatedBy"]),
                        UpdatedAt = dt.Rows[i]["UpdatedAt"] == DBNull.Value ? null : (DateTime?)dt.Rows[i]["UpdatedAt"],
                        UpdatedBy = dt.Rows[i]["UpdatedBy"] == DBNull.Value ? null : (int?)dt.Rows[i]["UpdatedBy"],
                        IsActive = Convert.ToBoolean(dt.Rows[i]["IsActive"])
                    };
                    subCenterEmployeeList.Add(subCenterEmployee);
                }

                return subCenterEmployeeList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
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

        private List<DesignationMaster> GetDesignationMasterList()
        {

            try
            {
                List<DesignationMaster> designationMasterList = new List<DesignationMaster>();
                userId = HttpContext.Session["UserId"].ToString();
                string sql = $@"select DesignationMasterId,DesignationName from DesignationMaster";

                DataTable dt = ob.Returntable(sql);

                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    DesignationMaster designationMaster = new DesignationMaster
                    {
                        DesignationMasterId = (int)dt.Rows[i]["DesignationMasterId"],
                        DesignationName = dt.Rows[i]["DesignationName"].ToString()
                    };
                    designationMasterList.Add(designationMaster);
                }
                return designationMasterList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<SubCenterEmployeeDetails> getSubCenterEmployeeDetails(int PHCId, int VillageId)
        {
            try
            {
                List<SubCenterEmployeeDetails> subCenterEmployeeDetailsList = new List<SubCenterEmployeeDetails>();
                userId = HttpContext.Session["UserId"].ToString();
                string sql = $@"select SCE.SubCenterEmployeeId,SCE.EmployeeName,sce.DesgnationId,SCE.EmployeeName,SCE.SubCenterId,
                        SC.SubCenterName,dm.DesignationName,SCE.PHCId,PHC.phcname,sce.VillageId,vm.VillageName
                        from SubCenterEmployee SCE
                        inner join SubCenterDetails SC on SCE.SubCenterId = SC.SubCenterDetailsId and sc.UserId = SCE.UserId
                        inner join DesignationMaster DM on dm.DesignationMasterId = sce.DesgnationId 
                        inner join VillageMaster VM on VM.VillageMasterId = SCE.VillageId and VM.UserId = SCE.UserId
                        inner join phcdetail PHC on SCE.PHCId = PHC.phcid and PHC.UserId = SCE.UserId
                        where sce.userid = {userId} and sce.VillageId = {VillageId} and sce.PHCId = {PHCId}";
                DataTable dt = ob.Returntable(sql);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    SubCenterEmployeeDetails subCenterEmployeeDetails = new SubCenterEmployeeDetails
                    {
                        SubCenterEmployeeId = Convert.ToInt32(dt.Rows[i]["SubCenterEmployeeId"]),
                        EmployeeName = dt.Rows[i]["EmployeeName"].ToString(),
                        DesgnationId = Convert.ToInt32(dt.Rows[i]["DesgnationId"]),
                        SubCenterId = Convert.ToInt32(dt.Rows[i]["SubCenterId"]),
                        SubCenterName = dt.Rows[i]["SubCenterName"].ToString(),
                        DesignationName = dt.Rows[i]["DesignationName"].ToString(),
                        PHCId = Convert.ToInt32(dt.Rows[i]["PHCId"]),
                        PHCName = dt.Rows[i]["phcname"].ToString(),
                        VillageId = Convert.ToInt32(dt.Rows[i]["VillageId"]),
                        VillageName = dt.Rows[i]["VillageName"].ToString()
                    };
                    subCenterEmployeeDetailsList.Add(subCenterEmployeeDetails);
                }
                return subCenterEmployeeDetailsList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult GetSubCenterEmployeeDetails(int PHCId, int VillageId)
        {
            try
            {
                List<SubCenterEmployeeDetails> subCenterEmployeeDetails = new List<SubCenterEmployeeDetails>();
                subCenterEmployeeDetails = getSubCenterEmployeeDetails(PHCId,VillageId);

                return Json(subCenterEmployeeDetails, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                throw;
            }
        }

        private List<DailyCollectionEntry> getDailyCollectionEntryList(int DailyCollectionEntryId = 0)
        {
            try
            {
                List<DailyCollectionEntry> dailyCollectionEntryList = new List<DailyCollectionEntry>();
                userId = HttpContext.Session["UserId"].ToString();
                string sql;

                if (DailyCollectionEntryId > 0)
                {
                    sql = $@"select distinct DCE.DailyCollectionEntryId,EntryDate,DCE.Hour24,DCE.Total,DCE.Daily,SCE.SubCenterEmployeeId,SCE.EmployeeName,sce.DesgnationId,SCE.EmployeeName,SCE.SubCenterId,
                        SC.SubCenterName,dm.DesignationName,SCE.PHCId,PHC.phcname,sce.VillageId,vm.VillageName
                        from SubCenterEmployee SCE
						inner join DailyCollectionEntry DCE on SCE.SubCenterEmployeeId = dce.SubCenterEmployeeId
                        inner join SubCenterDetails SC on SCE.SubCenterId = SC.SubCenterDetailsId and sc.UserId = SCE.UserId
                        inner join DesignationMaster DM on dm.DesignationMasterId = sce.DesgnationId 
                        inner join VillageMaster VM on VM.VillageMasterId = SCE.VillageId and VM.UserId = SCE.UserId
                        inner join phcdetail PHC on SCE.PHCId = PHC.phcid and PHC.UserId = SCE.UserId
                        where sce.userid = {userId} and DailyCollectionEntryId = {DailyCollectionEntryId}";
                }
                else
                {
                    sql = $@"select distinct DCE.DailyCollectionEntryId,EntryDate,DCE.Hour24,DCE.Total,DCE.Daily,SCE.SubCenterEmployeeId,SCE.EmployeeName,sce.DesgnationId,SCE.EmployeeName,SCE.SubCenterId,
                        SC.SubCenterName,dm.DesignationName,SCE.PHCId,PHC.phcname,sce.VillageId,vm.VillageName
                        from SubCenterEmployee SCE
						inner join DailyCollectionEntry DCE on SCE.SubCenterEmployeeId = dce.SubCenterEmployeeId
                        inner join SubCenterDetails SC on SCE.SubCenterId = SC.SubCenterDetailsId and sc.UserId = SCE.UserId
                        inner join DesignationMaster DM on dm.DesignationMasterId = sce.DesgnationId 
                        inner join VillageMaster VM on VM.VillageMasterId = SCE.VillageId and VM.UserId = SCE.UserId
                        inner join phcdetail PHC on SCE.PHCId = PHC.phcid and PHC.UserId = SCE.UserId
                        where sce.userid = {userId}";
                }

                DataTable dt = ob.Returntable(sql);

                foreach (DataRow row in dt.Rows)
                {
                    DailyCollectionEntry entry = new DailyCollectionEntry
                    {
                        DailyCollectionEntryId = Convert.ToInt32(row["DailyCollectionEntryId"]),
                        Hour24 = Convert.ToDecimal(row["Hour24"]),
                        Total = Convert.ToDecimal(row["Total"]),
                        Daily = Convert.ToDecimal(row["Daily"]),
                        SubCenterEmployeeId = Convert.ToInt32(row["SubCenterEmployeeId"]),
                        EmployeeName = row["EmployeeName"].ToString(),
                        DesignationId = Convert.ToInt32(row["DesgnationId"]),
                        SubCenterId = Convert.ToInt32(row["SubCenterId"]),
                        SubCenterName = row["SubCenterName"].ToString(),
                        DesignationName = row["DesignationName"].ToString(),
                        PHCId = Convert.ToInt32(row["PHCId"]),
                        PHCName = row["phcname"].ToString(),
                        VillageId = Convert.ToInt32(row["VillageId"]),
                        VillageName = row["VillageName"].ToString(),
                        EntryDate = Convert.ToDateTime(row["EntryDate"]).ToString("dd/MM/yyyy")
                    };
                    dailyCollectionEntryList.Add(entry);
                }
                return dailyCollectionEntryList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private int checkIfCollectionEntryExist(int SubCenterEmployeeId,string Entrydate)
        {
            try
            {
                int response = 0;
                userId = HttpContext.Session["UserId"].ToString();
                string sql = $@"select SubCenterEmployeeId from DailyCollectionEntry
                                where entrydate = '{Entrydate}' and SubCenterEmployeeId = {SubCenterEmployeeId} and userid = {userId}";

                DataTable dt = ob.Returntable(sql);

                foreach (DataRow row in dt.Rows)
                {
                    response = Convert.ToInt32(row["SubCenterEmployeeId"]);                    
                }
                return response;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public JsonResult InsertDailyCollectionEntry(List<InsertDailyCollectionEntryDTO> entries)
        {
            try
            {
                int userId = Convert.ToInt32(HttpContext.Session["UserId"]);
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                int result = 0;

                foreach (var entry in entries)
                {
                    string formattedEntryDate = entry.EntryDate.ToString("yyyy-MM-dd");
                    if (checkIfCollectionEntryExist(entry.SubCenterEmployeeId, formattedEntryDate) > 0) {
                        return Json(-1, JsonRequestBehavior.AllowGet);
                    }

                    
                    string insertStatement = $@"INSERT INTO DailyCollectionEntry (SubCenterEmployeeId, EntryDate, Daily, 
                                        Hour24, Total, CreatedBy, CreatedAt, IsActive, UserId)
                                        VALUES ({entry.SubCenterEmployeeId}, '{formattedEntryDate}', 
                                        {entry.Daily}, {entry.Hour24}, {entry.Total}, {userId}, 
                                        '{formattedDateTime}', 1, {userId});";

                    result = ob.excute(insertStatement);
                }                

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public JsonResult UpdateDailyCollectionEntry(UpdateDailyCollectionEntryDTO request)
        {
            try
            {
                int result = 0;
                userId = HttpContext.Session["UserId"].ToString();
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                var formattedEntryDate = request.EntryDate.ToString("yyyy-MM-dd");

                string UpdateStatement = $@"UPDATE DailyCollectionEntry
                                            SET SubCenterEmployeeId = {request.SubCenterEmployeeId}, 
                                                EntryDate = '{formattedEntryDate}',
                                                Daily = {request.Daily},
                                                Hour24 = {request.Hour24},
                                                Total = {request.Total},
                                                UpdatedBy = {userId},
                                                UpdatedAt = '{formattedDateTime}',
                                                IsActive = 1,
                                                UserId = {userId}
                                            WHERE DailyCollectionEntryId = {request.DailyCollectionEntryId}";

                result = ob.excute(UpdateStatement);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult DeleteDailyCollectionEntry(int DailyCollectionEntryId)
        {

            try
            {
                string sql = $@"DELETE FROM DailyCollectionEntry WHERE DailyCollectionEntryId = {DailyCollectionEntryId};";

                var result = ob.excute(sql);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult GetDailyEntryById(int DailyCollectionEntryId)
        {

            try
            {
                List<DailyCollectionEntry> DailyCollectionEntry = getDailyCollectionEntryList(DailyCollectionEntryId);

                return Json(DailyCollectionEntry, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}