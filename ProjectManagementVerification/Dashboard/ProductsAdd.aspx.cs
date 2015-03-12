using System;
using ProjectManagementVerification.DAL;
using ProductsBLL = ProjectManagementVerification.BLL.Products;

namespace ProjectManagementVerification.Dashboard
{
    
    public partial class ProductsAdd : System.Web.UI.Page
    {
        readonly ProductsDb _db = new ProductsDb();

        public static int SearchType { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            var products = new ProductsBLL
            {
                Name = txtProductName.Text,
                Price = float.Parse(txtProductPrice.Text),
                Quantity = Convert.ToInt32(txtProductPrice.Text)
            };
            if (_db.Save(products))
            {
                Response.Write("Successfully inserted");
            }
        }

        protected void GridView1_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            var dataKey = GridView1.DataKeys[e.NewEditIndex];
            if (dataKey != null)
            {
                var id = Convert.ToInt32(dataKey.Value);
                SessionManager.ProductsToEdit = _db.ProductById(id);
                Response.Redirect("ProductsEdit.aspx");
            }
            //Response.Write("Hi");
        }

        protected void GridView1_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (SearchType == 0)
            {
                GridView1.DataSource = _db.GetData(txtSearch.Text, 0);
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = _db.GetData(string.Empty, 1);
                GridView1.DataBind();
            }
        }

        
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchType = 0;
            GridView1.DataSource = _db.GetData(txtSearch.Text, SearchType);
            GridView1.DataBind();
            Response.Write(_db.GetData(txtSearch.Text, SearchType));
        }

        protected void btnSearchAll_Click(object sender, EventArgs e)
        {
            SearchType = 1;
            GridView1.DataSource = _db.GetData(string.Empty, SearchType);
            GridView1.DataBind();
        }

        protected void GridView1_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            var dataKey = GridView1.DataKeys[e.RowIndex];
            var id = 0;
            if (dataKey != null)
            {
                id = Convert.ToInt32(dataKey.Value);
            }

            txtId.Text = id.ToString();

            var product = new ProductsBLL
            {
                Id = id
            };

            if (!_db.Delete(product)) return;
            lblMessage.Text = "Successfully Deleted";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }


    }
}