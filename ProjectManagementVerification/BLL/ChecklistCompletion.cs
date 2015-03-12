using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProjectManagementVerification.BLL
{
    public class ChecklistCompletion
    {
        public int ProjectId { get; set; }
        public int ChecklistId { get; set; }
        public string Status { get; set; }

    }
}