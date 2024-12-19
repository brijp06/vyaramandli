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
    public class SubCenterEmpController : Controller
    {
        // GET: PHCdetail
        ClsSystem ob = new ClsSystem();
        string userId = "";
        public ActionResult SubCenterEmp()
        {
            List<SubCenterEmployee> subCenterEmployeeList = new List<SubCenterEmployee>();
            subCenterEmployeeList = subCenterEmployees();
            var phcList = GetPHCdetailList();
            var designationList = GetDesignationMasterList();

            ViewBag.SubCenterEmployeeList = subCenterEmployeeList;
            ViewBag.PHCList = phcList;
            ViewBag.DesignationList = designationList;  

            return View();
        }

        public JsonResult GetSubCenterEmpList(int subCenterEmployeeId)
        {
            try
            {
                List<SubCenterEmployee> subCenterEmployeeList = new List<SubCenterEmployee>();
                subCenterEmployeeList = subCenterEmployees(subCenterEmployeeId);

                return Json(subCenterEmployeeList, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
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


        [HttpPost]
        public JsonResult InsertSubCenterEmployee(int PHCId, int VillageId, int SubCenterDetailsId,string EmployeeName,int DesgnationId)
        {
            try
            {
                int result = 0;
                userId = HttpContext.Session["UserId"].ToString();
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string insertStatement = $@"INSERT INTO SubCenterEmployee (PHCId, VillageId, SubCenterId, 
                                            DesgnationId, EmployeeName, UserId, CreatedAt, CreatedBy, IsActive)
                                            VALUES ({PHCId}, {VillageId}, {SubCenterDetailsId}, {DesgnationId}, '{EmployeeName}',
                                            {userId}, '{formattedDateTime}', {userId}, 1);";

                result = ob.excute(insertStatement);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpPost]
        public  JsonResult UpdateSubCenterEmployee(int SubCenterEmployeeId, int PHCId, int VillageId, int SubCenterDetailsId, string EmployeeName, int DesgnationId)
        {
            try
            {
                int result = 0;
                userId = HttpContext.Session["UserId"].ToString();
                string formattedDateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                string UpdateStatement = $@"UPDATE SubCenterEmployee
                                            SET
                                                PHCId = {PHCId},
                                                VillageId = {VillageId},
                                                SubCenterId = {SubCenterDetailsId},
                                                DesgnationId = {DesgnationId},
                                                EmployeeName = '{EmployeeName}',
                                                UserId = {userId},
                                                UpdatedAt = '{formattedDateTime}',
                                                UpdatedBy = {userId},
                                                IsActive = 1
                                            WHERE SubCenterEmployeeId = {SubCenterEmployeeId};";

                result = ob.excute(UpdateStatement);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [HttpGet]
        public JsonResult DeleteSubCenterEmployee(int SubCenterEmployeeId)
        {
            
            try
            {
                string sql = $@"DELETE FROM SubCenterEmployee
                                WHERE SubCenterEmployeeId = {SubCenterEmployeeId};";

                var result = ob.excute(sql);

                return Json(result, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                throw ex;
            }
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

        [HttpGet]
        public JsonResult GetSubCenterList(int Phcid,int VillageId)
        {
            try
            {
                List<SubCenterDetails> subCenterDetailsList = GetSubCenterDetailList(Phcid, VillageId);
                return Json(subCenterDetailsList, JsonRequestBehavior.AllowGet);
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

        private List<SubCenterDetails> GetSubCenterDetailList(int PHCId, int VillageId)
        {

            try
            {
                List<SubCenterDetails> subCenterDetailsList = new List<SubCenterDetails>();
                userId = HttpContext.Session["UserId"].ToString();
                string sql = $@"select SubCenterDetailsId,SubCenterName from SubCenterDetails
                            where UserId = {userId} and PHCId = {PHCId} and Village_id = {VillageId}";
                DataTable dt = ob.Returntable(sql);

                for (int i = 0; i <= dt.Rows.Count - 1; i++)
                {
                    SubCenterDetails subCenterDetails = new SubCenterDetails
                    {
                        SubCenterDetailsId = (int)dt.Rows[i]["SubCenterDetailsId"],
                        SubCenterName = dt.Rows[i]["SubCenterName"].ToString()
                    };
                    subCenterDetailsList.Add(subCenterDetails);
                }
                return subCenterDetailsList;
            }
            catch (Exception ex)
            {
                throw ex;
            }
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
    }
}