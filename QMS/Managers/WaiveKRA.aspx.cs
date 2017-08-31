using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Managers
{
    public partial class Managers_WaiveKRA : Page
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
                lblPopUp.Text = "This order has been waived and sent to OMC CLEARANCE";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been sent to REJECTED QUEUE";
            }
            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            TextOmc.Text = Helper.getShipper(TextOmc.Text);
        }


        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var savedTime = DateTime.Now;
            e.NewValues["SavedTime_C"] = savedTime;
            e.NewValues["StatusTime"] = savedTime;
            e.NewValues["OperationsOut"] = savedTime;

            e.NewValues["Passed"] = false;

            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.NewValues["SavedBy_C"] = User.Identity.Name;
        }

        protected void FormView1Ai_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            LabelResults.Visible = true;
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var releaseTime = DateTime.Now;
            var theID = Request.QueryString["ID"];
            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            var named = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE SafetySecurity_C SET Passed = @Passed, PassedTime = @PassedTime, Passer = @Passer WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@Passed", true);
                myCommand.Parameters.AddWithValue("@PassedTime", releaseTime);
                myCommand.Parameters.AddWithValue("@Passer", named);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var updateStatus = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "OMCCLE");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            Response.Redirect("WaiveKRA.aspx?status=ok&ID=" + theID);

            LabelResults.Visible = true;
            LabelResults.Text = "This order has been waived to OMC CLEARANCE";
            ParaResult.Visible = false;
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeclinedKRA.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeclinedKRA.aspx");
        }
    }
}