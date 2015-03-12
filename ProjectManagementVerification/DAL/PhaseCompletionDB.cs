using System.Data;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class PhaseCompletionDb : GlobalDb
    {
        # region Save
        public bool Save(PhaseCompletion phaseCompletion)
        {
            var query = "INSERT into PhaseCompletion values (" + phaseCompletion.ProjectId + ", "
                                                            + phaseCompletion.PhaseId + ", '"
                                                            + phaseCompletion.Status + "')";

            return SaveChanges(query);
            //return query;
        }
        #endregion



        # region ExistingValidationPhaseCompletion
        public DataTable ExistingCheck(int projectId, int phaseId)
        {
            var query = @"SELECT ProjectId from PhaseCompletion where ProjectId = " + projectId + " AND PhaseId = " + phaseId;
            return GetData(query);
        }
        #endregion 
        
        
        #region Search
        public DataTable Search(int projectId, int phaseId)
        {
            var query = @"SELECT ProjectId from PhaseCompletion where ProjectId = ProjectId";
            if (projectId > 0)
            {
                query += " AND ProjectId = "+projectId;
            }
            if (phaseId > 0)
            {
                query += " AND PhaseId = "+phaseId;
            }
            return GetData(query);
        }
        #endregion


        public bool Delete(int projectId, int phaseId)
        {
            var query = "DELETE FROM PhaseCompletion WHERE ProjectId = "+projectId+" AND PhaseId = "+phaseId;
            return SaveChanges(query);
        }


    }
}