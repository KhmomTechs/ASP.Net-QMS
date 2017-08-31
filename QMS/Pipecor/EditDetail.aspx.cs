using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_EditDetail : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            SqlEditSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();

            var resulting = Request.QueryString["STATUS"];
            var theID = Request.QueryString["id"];
            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                lblPopUp.Text = "Order edited successfully";
            }

            var type = (Label) FormEdit.FindControl("LabelType");
            var LocalTable = (Panel) FormEdit.FindControl("LocalTable");
            var ExportTable = (Panel) FormEdit.FindControl("ExportTable");

            if (string.IsNullOrEmpty(theID))
            {
                Response.Redirect("QueueEdit.aspx");
            }
            else
            {
                try
                {
                    if (type.Text == "Export")
                    {
                        LocalTable.Visible = false;
                    }
                    else if (type.Text == "Local")
                    {
                        ExportTable.Visible = false;
                    }
                }
                catch
                {
                    Response.Redirect("QueueEdit.aspx");
                }
            }

            var lblEditable_No = (Label) View.FindControl("lblEditable_No");
            var lblEditable_Reg = (Label) View.FindControl("lblEditable_Reg");
            var Editable_LONO = (Label) View.FindControl("Editable_LONO");
            var lblEditable_Quantity = (Label) View.FindControl("lblEditable_Quantity");
            var lblEditable_Product = (Label) View.FindControl("lblEditable_Product");

            var NoExport = (TextBox) FormEdit.FindControl("Queue_NoExport");
            var NoLocal = (TextBox) FormEdit.FindControl("Queue_NoTxt");

            var RegistrationExport = (TextBox) FormEdit.FindControl("RegistrationExport");
            var RegistrationLocal = (TextBox) FormEdit.FindControl("RegistrationLocal");

            var LONOTExport = (TextBox) FormEdit.FindControl("LONOTExport");
            var LONOLocal = (TextBox) FormEdit.FindControl("LONOLocal");

            var Quantity = (TextBox) FormEdit.FindControl("QuantityTxt");

            var Product = (TextBox) FormEdit.FindControl("ProductTxt");
            var MSP = (TextBox) FormEdit.FindControl("MSPtxt");
            var AGO = (TextBox) FormEdit.FindControl("AGOtxt");
            var KERO = (TextBox) FormEdit.FindControl("KEROtxt");
            var JET = (TextBox) FormEdit.FindControl("JETtxt");

            //check editable
            if (lblEditable_No.Text == "False")
            {
                NoLocal.ReadOnly = true;
                NoLocal.Enabled = false;
            }

            if (lblEditable_Reg.Text == "False")
            {
                RegistrationLocal.ReadOnly = true;
                RegistrationLocal.Enabled = false;
            }

            if (Editable_LONO.Text == "False")
            {
                LONOLocal.ReadOnly = true;
                LONOLocal.Enabled = false;
            }
            if (lblEditable_Quantity.Text == "False")
            {
                Quantity.ReadOnly = true;
                MSP.ReadOnly = true;
                AGO.ReadOnly = true;
                KERO.ReadOnly = true;
                JET.ReadOnly = true;

                Quantity.Enabled = false;
                MSP.Enabled = false;
                AGO.Enabled = false;
                KERO.Enabled = false;
                JET.Enabled = false;
            }
            if (lblEditable_Product.Text == "False")
            {
                Product.ReadOnly = true;

                Product.Enabled = false;
            }
        }

        protected void LocalBtn_Click(object sender, EventArgs e)
        {
            var No = (TextBox) FormEdit.FindControl("Queue_NoTxt");
            var Registration = (TextBox) FormEdit.FindControl("RegistrationLocal");
            var Trailer = (TextBox) FormEdit.FindControl("TextTRAILER_TEXT");
            var LONO = (TextBox) FormEdit.FindControl("LONOLocal");
            var MSP = (TextBox) FormEdit.FindControl("MSPtxt");
            var AGO = (TextBox) FormEdit.FindControl("AGOtxt");
            var KERO = (TextBox) FormEdit.FindControl("KEROtxt");
            var JET = (TextBox) FormEdit.FindControl("JETtxt");

            var id = Convert.ToInt32(Request.QueryString["id"]);
            var updateStatus =
                "UPDATE NewQueue SET Queue_No = @Queue_No, Registration = @Registration, TRAILER_TEXT = @TRAILER_TEXT, LO_NO = @LO_NO, MSP = @MSP, AGO = @AGO, KERO = @KERO, JET = @JET WHERE ID = @ID";

            using (var myConnection = new SqlConnection(strConnection))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Queue_No", No.Text);
                myCommand.Parameters.AddWithValue("@Registration", Registration.Text);
                myCommand.Parameters.AddWithValue("@TRAILER_TEXT", Trailer.Text);
                myCommand.Parameters.AddWithValue("@LO_NO", LONO.Text);
                myCommand.Parameters.AddWithValue("@MSP", MSP.Text);
                myCommand.Parameters.AddWithValue("@AGO", AGO.Text);
                myCommand.Parameters.AddWithValue("@KERO", KERO.Text);
                myCommand.Parameters.AddWithValue("@JET", JET.Text);
                myCommand.Parameters.AddWithValue("@ID", id);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var Type = (Label) FormEdit.FindControl("Type");
            var Shipper = (Label) FormEdit.FindControl("Shipper");
            var QueueID = (Label) FormEdit.FindControl("QueueID");

            //save to log
            var changeTime = DateTime.Now;
            var companyNo = User.Identity.Name;
            var updateRecord =
                "INSERT INTO Pipecor_Edit(CompNumber, TimeOfEdit, Type, TruckGuidModified, QueueNo, Shipper, Registration, LO_NO) VALUES (@CompNumber, @TimeOfEdit, @Type, @TruckGuidModified, @QueueNo, @Shipper, @Registration, @LO_NO)";

            using (var myConnection = new SqlConnection(strConnection))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateRecord, myConnection);
                myCommand.Parameters.AddWithValue("@CompNumber", companyNo);
                myCommand.Parameters.AddWithValue("@TimeOfEdit", changeTime);
                myCommand.Parameters.AddWithValue("@Type", Type.Text);
                myCommand.Parameters.AddWithValue("@TruckGuidModified", QueueID.Text);
                myCommand.Parameters.AddWithValue("@QueueNo", No.Text);
                myCommand.Parameters.AddWithValue("@Shipper", Shipper.Text);
                myCommand.Parameters.AddWithValue("@Registration", Registration.Text);
                myCommand.Parameters.AddWithValue("@LO_NO", LONO.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            Response.Redirect("EditDetail.aspx?status=ok&ID=" + id);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("QueueEdit.aspx");
        }
    }
}