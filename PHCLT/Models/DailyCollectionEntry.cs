using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PHCLT.Models
{
    public class DailyCollectionEntry
    {
        public int DailyCollectionEntryId { get; set; }
        public int SubCenterEmployeeId { get; set; }
        public string EntryDate { get; set; }
        public decimal Daily { get; set; }
        public decimal Hour24 { get; set; }
        public decimal Total { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public bool IsActive { get; set; }
        public int UserId { get; set; }
        public string EmployeeName { get; set; }
        public int DesignationId { get; set; }
        public int SubCenterId { get; set; }
        public string SubCenterName { get; set; }
        public string DesignationName { get; set; }
        public int PHCId { get; set; }
        public string PHCName { get; set; }
        public int VillageId { get; set; }
        public string VillageName { get; set; }
    }

    public class SubCenterEmployeeDetails
    {
        public int SubCenterEmployeeId { get; set; }
        public string EmployeeName { get; set; }
        public int DesgnationId { get; set; }
        public int SubCenterId { get; set; }
        public string SubCenterName { get; set; }
        public string DesignationName { get; set; }
        public int PHCId { get; set; }
        public string PHCName { get; set; }
        public int VillageId { get; set; }
        public string VillageName { get; set; }
    }

    public class InsertDailyCollectionEntryDTO
    {
        public int SubCenterEmployeeId { get; set; }
        public DateTime EntryDate { get; set; }
        public decimal Daily { get; set; }
        public decimal Hour24 { get; set; }
        public decimal Total { get; set; }
    }

    public class UpdateDailyCollectionEntryDTO
    {
        public int DailyCollectionEntryId { get; set; }
        public int SubCenterEmployeeId { get; set; }
        public DateTime EntryDate { get; set; }
        public decimal Daily { get; set; }
        public decimal Hour24 { get; set; }
        public decimal Total { get; set; }
    }

}