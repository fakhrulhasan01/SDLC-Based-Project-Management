using System;
using System.Globalization;
using ProjectManagementVerification.BLL;
using ProjectManagementVerification.DAL;

namespace ProjectManagementVerification.Dashboard
{
    public partial class ProductsEdit : System.Web.UI.Page
    {
        ProductsDb _db = new ProductsDb();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var product = SessionManager.ProductsToEdit;
                if (product != null)
                {
                    txtProductName.Text = product.Name;
                    txtProductPrice.Text = product.Price.ToString(CultureInfo.InvariantCulture);
                    txtProductQuantity.Text = product.Quantity.ToString(CultureInfo.InvariantCulture);
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            
            var product = SessionManager.ProductsToEdit;
            product.Name = txtProductName.Text;
            product.Price = float.Parse(txtProductPrice.Text);
            product.Quantity = Convert.ToInt32(txtProductQuantity.Text);
            if (_db.Update(product))
            {
                lblMessage.Text = "Successfully Updated";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
        }

        
    }
}