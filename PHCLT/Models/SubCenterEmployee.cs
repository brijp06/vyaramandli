using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PHCLT.Models
{
    public class SubCenterEmployee
    {
        public int SubCenterEmployeeId { get; set; }
        public int PHCId { get; set; }
        public string PHCName { get; set; }
        public int VillageId { get; set; }
        public string VillageName { get; set; }
        public int SubCenterDetailsId { get; set; }
        public string SubCenterName { get; set; }
        public int DesgnationId { get; set; }
        public string DesignationName { get; set; }
        public string EmployeeName { get; set; }
        public int UserId { get; set; }
        public DateTime CreatedAt { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? UpdatedBy { get; set; }
        public bool IsActive { get; set; }
    }

    public class DesignationMaster
    {
        public int DesignationMasterId { get; set; }
        public int UserId { get; set; }
        public string DesignationName { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public bool IsActive { get; set; }
    }
}