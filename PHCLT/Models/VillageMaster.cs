using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace PHCLT.Models
{
    public class VillageMaster
    {
        public int VillageMasterId { get; set; }
        public int PHCId { get; set; }
        public string phcname { get; set; }
        public int UserId { get; set; }
        public string VillageName { get; set; }

        public string Population { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public bool IsActive { get; set; }
    }

    public class Dreport
    {
        public string Tranno { get; set; }
        public DateTime Transdate { get; set; }
        public string Remarks { get; set; }
        public string Receiptamt { get; set; }
        public string Paymentamt { get; set; }

        public string Balanceamt { get; set; }
    }

}