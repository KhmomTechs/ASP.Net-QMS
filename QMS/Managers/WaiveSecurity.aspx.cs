using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Managers
{
    public partial class Managers_WaiveSecurity : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var resulting = Request.QueryString["STATUS"];
            var theID = Request.QueryString["ID"];
            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This truck has been waived and sentto STOCK CONTROL";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This truck has been sent to REJECTED QUEUE";
            }

            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            TextOmc.Text = Helper.getShipper(TextOmc.Text);
        }


        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var savedTime = DateTime.Now;
            e.NewValues["SavedTime_B"] = savedTime;
            e.NewValues["StatusTime"] = savedTime;

            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            e.NewValues["SavedBy_B"] = currentUserId;

            e.NewValues["EntryStatus"] = "False";


            var chk27 = (CheckBox) FormView1Ai.FindControl("NecessaryPPE_28");
            if (chk27.Checked)
            {
                chk27.Checked = true;
                e.NewValues["NecessaryPPE_28"] = chk27.Checked;
            }
            else
            {
                chk27.Checked = false;
                e.NewValues["NecessaryPPE_28"] = chk27.Checked;
            }

            var chk28 = (CheckBox) FormView1Ai.FindControl("CabinFree_29");
            if (chk28.Checked)
            {
                chk28.Checked = true;
                e.NewValues["CabinFree_29"] = chk28.Checked;
            }
            else
            {
                chk28.Checked = false;
                e.NewValues["CabinFree_29"] = chk28.Checked;
            }

            var chk29 = (CheckBox) FormView1Ai.FindControl("ContainersRemoved_30");
            if (chk29.Checked)
            {
                chk29.Checked = true;
                e.NewValues["ContainersRemoved_30"] = chk29.Checked;
            }
            else
            {
                chk29.Checked = false;
                e.NewValues["ContainersRemoved_30"] = chk29.Checked;
            }

            var chk30 = (CheckBox) FormView1Ai.FindControl("IgnitionSources_31");
            if (chk30.Checked)
            {
                chk30.Checked = true;
                e.NewValues["IgnitionSources_31"] = chk30.Checked;
            }
            else
            {
                chk30.Checked = false;
                e.NewValues["IgnitionSources_31"] = chk30.Checked;
            }

            var chk31 = (CheckBox) FormView1Ai.FindControl("BottomValvesSealed_32");
            if (chk31.Checked)
            {
                chk31.Checked = true;
                e.NewValues["BottomValvesSealed_32"] = chk31.Checked;
            }
            else
            {
                chk31.Checked = false;
                e.NewValues["BottomValvesSealed_32"] = chk31.Checked;
            }

            var chk32 = (CheckBox) FormView1Ai.FindControl("ValidDL_33");
            if (chk32.Checked)
            {
                chk32.Checked = true;
                e.NewValues["ValidDL_33"] = chk32.Checked;
            }
            else
            {
                chk32.Checked = false;
                e.NewValues["ValidDL_33"] = chk32.Checked;
            }

            var chk33 = (CheckBox) FormView1Ai.FindControl("DriverIDTallies_34");
            if (chk33.Checked)
            {
                chk33.Checked = true;
                e.NewValues["DriverIDTallies_34"] = chk33.Checked;
            }
            else
            {
                chk33.Checked = false;
                e.NewValues["DriverIDTallies_34"] = chk33.Checked;
            }

            var chk34 = (CheckBox) FormView1Ai.FindControl("EmergencyInstGiven_35");
            if (chk34.Checked)
            {
                chk34.Checked = true;
                e.NewValues["EmergencyInstGiven_35"] = chk34.Checked;
            }
            else
            {
                chk34.Checked = false;
                e.NewValues["EmergencyInstGiven_35"] = chk34.Checked;
            }
        }

        protected void FormView1Ai_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            var ID = Request.QueryString["id"];
            Response.Redirect("WaiveSecurity.aspx?status=ok&ID=" + ID);
            LabelResults.Visible = true;
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var txtWaiveComment = (TextBox) FormView1Ai.FindControl("txtWaiveComment");

            var releaseTime = DateTime.Now;

            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE SafetySecurity_B SET EntryStatus = @EntryStatus, EntryStatusTime = @EntryStatusTime, SecurityWaiver = @SecurityWaiver, SecurityComment = @SecurityComment, SecurityWaived = @SecurityWaived WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@EntryStatus", true);
                myCommand.Parameters.AddWithValue("@SecurityWaived", true);
                myCommand.Parameters.AddWithValue("@EntryStatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@SecurityComment", txtWaiveComment.Text.Trim());
                myCommand.Parameters.AddWithValue("@SecurityWaiver", currentUserId);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var updateStatus =
                "UPDATE NewQueue SET Status = @Status, Entitlement = @Entitlement, StatusTime = @StatusTime, SecurityInspection = @SecurityInspection WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "STK");
                myCommand.Parameters.AddWithValue("@Entitlement", string.Empty);
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@SecurityInspection", false);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            Response.Redirect("WaiveSecurity.aspx?status=ok&ID=" + ID);

            //LabelResults.Visible = true;
            //LabelResults.Text = "This truck has been Waived-Approved and CALLED TO LOADING BAY";
            //ParaResult.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeclinedSecurity.aspx");
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeclinedSecurity.aspx");
        }

        protected void RejectBtn_Click(object sender, EventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateStatus =
                "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime, Rejected = @Rejected, RejectedTime = @RejectedTime, RejectedBy = @RejectedBy, RejectedReason = @RejectedReason WHERE QueueID = @QueueID";

            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var txtWaiveComment = (TextBox) FormView1Ai.FindControl("txtWaiveComment");
            var releaseTime = DateTime.Now;
            var named = User.Identity.Name;

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "REJDM");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@Rejected", "True");
                myCommand.Parameters.AddWithValue("@RejectedTime", releaseTime);
                myCommand.Parameters.AddWithValue("@RejectedBy", named);
                myCommand.Parameters.AddWithValue("@RejectedReason", txtWaiveComment.Text.Trim());
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
            Response.Redirect("WaiveSecurity.aspx?status=done&ID=" + ID);
        }
    }
}