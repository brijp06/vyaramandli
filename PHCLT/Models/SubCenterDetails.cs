
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace PHCLT.Models
{
    public class SubCenterDetails
    {
        public int SubCenterDetailsId { get; set; }
        public int PHCId { get; set; }
        public int UserId { get; set; }
        public string SubCenterName { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public bool IsActive { get; set; }
        public string PHCCenterName { get; set; }
        public string villagename { get; set; }
        public int villageid { get; set; }
    }

    public class InsertSubCenterDetails
    {
        public int PHCId { get; set; }
        public int villageid { get; set; }
        public int UserId { get; set; }
        public string SubCenterName { get; set; }
    }
    public class UpdateSubCenterDetails
    {
        public int SubCenterDetailsId { get; set; }
        public int PHCId { get; set; }
        public int UserId { get; set; }
        public string SubCenterName { get; set; }
        public int villageid { get; set; }
    }

}
