using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_Configuration : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var LabelTime = (Label) View.FindControl("LabelTime");
            if (LabelTime.Text == null || LabelTime.Text == string.Empty || LabelTime.Text == "")
            {
            }
            else
            {
                var timer = Convert.ToInt32(LabelTime.Text);
                timer = timer/1000;

                LabelTime.Text = Convert.ToString(timer);
            }
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_No = @Editable_No";

            var Drop = (DropDownList) View.FindControl("Drop_No");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_No", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_No", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnShipper_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_Shipper = @Editable_Shipper";

            var Drop = (DropDownList) View.FindControl("Drop_Shipper");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Shipper", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Shipper", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnRegistration_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_Reg = @Editable_Reg";

            var Drop = (DropDownList) View.FindControl("Drop_Registration");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Reg", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Reg", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnLONO_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_LONO = @Editable_LONO";

            var Drop = (DropDownList) View.FindControl("Drop_LONO");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_LONO", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_LONO", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnQuantity_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_Quantity = @Editable_Quantity";

            var Drop = (DropDownList) View.FindControl("Drop_Quantity");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Quantity", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Quantity", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnProduct_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_Product = @Editable_Product";

            var Drop = (DropDownList) View.FindControl("Drop_Product");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Product", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Product", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnStatus_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET Editable_Status = @Editable_Status";

            var Drop = (DropDownList) View.FindControl("Drop_Status");

            if (Drop.SelectedValue == "True")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Status", true);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
            else if (Drop.SelectedValue == "False")
            {
                using (var myConnection = new SqlConnection(connectionString))
                {
                    myConnection.Open();
                    var myCommand = new SqlCommand(updateSql, myConnection);
                    myCommand.Parameters.AddWithValue("@Editable_Status", false);
                    myCommand.ExecuteNonQuery();
                    myConnection.Close();
                }
            }
        }

        protected void btnTime_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql = "UPDATE Settings SET ScreenTime = @ScreenTime";

            var txtTime = (TextBox) View.FindControl("txtTime");
            var time = Convert.ToInt32(txtTime.Text + "000");

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@ScreenTime", time);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var LabelTime = (Label) View.FindControl("LabelTime");

            LabelTime.Text = txtTime.Text;
        }
    }
}