using System.Web;
using ProjectManagementVerification.BLL;

namespace ProjectManagementVerification.DAL
{
    public class SessionManager
    {
        public static Products ProductsToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["ProductsToEdit"] == null)
                    return null;
                else
                    return (Products)HttpContext.Current.Session.Contents["ProductsToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["ProductsToEdit"] = value;
            }
        }


        public static Country CountryToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["CountryToEdit"] == null)
                    return null;
                else
                    return (Country)HttpContext.Current.Session.Contents["CountryToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["CountryToEdit"] = value;
            }
        }


        public static City CityToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["CityToEdit"] == null)
                    return null;
                else
                    return (City)HttpContext.Current.Session.Contents["CityToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["CityToEdit"] = value;
            }
        }


        public static Department DepartmentToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["DepartmentToEdit"] == null)
                    return null;
                else
                    return (Department)HttpContext.Current.Session.Contents["DepartmentToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["DepartmentToEdit"] = value;
            }
        }


        public static Student CurrentLoginStudent
        {
            get
            {
                if (HttpContext.Current.Session.Contents["CurrentLoginStudent"] == null)
                    return null;
                else
                    return (Student)HttpContext.Current.Session.Contents["CurrentLoginStudent"];
            }
            set
            {
                HttpContext.Current.Session.Contents["CurrentLoginStudent"] = value;
            }
        }



        public static Student StudentToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["StudentToEdit"] == null)
                    return null;
                else
                    return (Student)HttpContext.Current.Session.Contents["StudentToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["StudentToEdit"] = value;
            }
        }



        public static Teacher CurrentLoginTeacher
        {
            get
            {
                if (HttpContext.Current.Session.Contents["CurrentLoginTeacher"] == null)
                    return null;
                else
                    return (Teacher)HttpContext.Current.Session.Contents["CurrentLoginTeacher"];
            }
            set
            {
                HttpContext.Current.Session.Contents["CurrentLoginTeacher"] = value;
            }
        }




        public static StudentGroup StudentGroupToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["StudentGroupToEdit"] == null)
                    return null;
                else
                    return (StudentGroup)HttpContext.Current.Session.Contents["StudentGroupToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["StudentGroupToEdit"] = value;
            }
        }


        public static CreateProjectGroup CreateProjectGroupToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["CreateProjectGroupToEdit"] == null)
                    return null;
                else
                    return (CreateProjectGroup)HttpContext.Current.Session.Contents["CreateProjectGroupToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["CreateProjectGroupToEdit"] = value;
            }
        }

        public static StudentAssignToGroup StudentAssignToGroupEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["StudentAssignToGroupEdit"] == null)
                    return null;
                else
                    return (StudentAssignToGroup)HttpContext.Current.Session.Contents["StudentAssignToGroupEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["StudentAssignToGroupEdit"] = value;
            }
        }


        public static ProjectType ProjectTypeToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["ProjectTypeToEdit"] == null)
                    return null;
                else
                    return (ProjectType)HttpContext.Current.Session.Contents["ProjectTypeToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["ProjectTypeToEdit"] = value;
            }
        }


        public static ProjectPhase ProjectPhaseToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["ProjectPhaseToEdit"] == null)
                    return null;
                else
                    return (ProjectPhase)HttpContext.Current.Session.Contents["ProjectPhaseToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["ProjectPhaseToEdit"] = value;
            }
        }


        public static Checklist ChecklistToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["ChecklistToEdit"] == null)
                    return null;
                else
                    return (Checklist)HttpContext.Current.Session.Contents["ChecklistToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["ChecklistToEdit"] = value;
            }
        }


        public static ProjectRegistration ProjectRegistrationToEdit
        {
            get
            {
                if (HttpContext.Current.Session.Contents["ProjectRegistrationToEdit"] == null)
                    return null;
                else
                    return (ProjectRegistration)HttpContext.Current.Session.Contents["ProjectRegistrationToEdit"];
            }
            set
            {
                HttpContext.Current.Session.Contents["ProjectRegistrationToEdit"] = value;
            }
        }




    }
}