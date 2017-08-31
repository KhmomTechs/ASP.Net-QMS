using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Safety
{
    public partial class Safety_KRACheck : Page
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
                lblPopUp.Text = "This order has been approved and sent to OMC CLEARANCE";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been sent to the Depot manager for further action.";
            }

            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            TextOmc.Text = Helper.getShipper(TextOmc.Text);
            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");


            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            //Button ApproveBtn = (Button)FormView1Ai.FindControl("ApproveBtn");
            var btn = (Button) FormView1Ai.FindControl("Button1");

            var chk27 = (CheckBox) FormView1Ai.FindControl("Leaking_Loading_36");
            var chk28 = (CheckBox) FormView1Ai.FindControl("BioCode");
            var chk29 = (CheckBox) FormView1Ai.FindControl("ProperSealing_40");
            var chk30 = (CheckBox) FormView1Ai.FindControl("ProductDestination");
            var chk31 = (CheckBox) FormView1Ai.FindControl("switchEngaged");


            if (chk27.Checked && chk28.Checked && chk29.Checked && chk30.Checked && chk31.Checked)
            {
                CommentPanel.Visible = false;
                SaveBtn.Visible = false;
                //ApproveBtn.Visible = true;
                btn.Visible = true;
            }
            else
            {
                CommentPanel.Visible = true;
                SaveBtn.Visible = true;
                //ApproveBtn.Visible = false;
                btn.Visible = false;
            }
        }


        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var savedTime = DateTime.Now;
            e.NewValues["SavedTime_C"] = savedTime;
            e.NewValues["StatusTime"] = savedTime;

            e.NewValues["Passed"] = false;

            e.NewValues["TruckAvailability"] = true;

            e.NewValues["Failed"] = true;

            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.NewValues["SavedBy_C"] = User.Identity.Name;

            var chk27 = (CheckBox) FormView1Ai.FindControl("Leaking_Loading_36");
            if (chk27.Checked)
            {
                chk27.Checked = true;
                e.NewValues["Leaking_Loading_36"] = chk27.Checked;
            }
            else
            {
                chk27.Checked = false;
                e.NewValues["Leaking_Loading_36"] = chk27.Checked;
            }

            var chk28 = (CheckBox) FormView1Ai.FindControl("BioCode");
            if (chk28.Checked)
            {
                chk28.Checked = true;
                e.NewValues["BioCode"] = chk28.Checked;
            }
            else
            {
                chk28.Checked = false;
                e.NewValues["BioCode"] = chk28.Checked;
            }

            var chk29 = (CheckBox) FormView1Ai.FindControl("ProperSealing_40");
            if (chk29.Checked)
            {
                chk29.Checked = true;
                e.NewValues["ProperSealing_40"] = chk29.Checked;
            }
            else
            {
                chk29.Checked = false;
                e.NewValues["ProperSealing_40"] = chk29.Checked;
            }

            var chk30 = (CheckBox) FormView1Ai.FindControl("ProductDestination");
            if (chk30.Checked)
            {
                chk30.Checked = true;
                e.NewValues["ProductDestination"] = chk30.Checked;
            }
            else
            {
                chk30.Checked = false;
                e.NewValues["ProductDestination"] = chk30.Checked;
            }

            var chk31 = (CheckBox) FormView1Ai.FindControl("switchEngaged");
            if (chk31.Checked)
            {
                chk31.Checked = true;
                e.NewValues["switchEngaged"] = chk31.Checked;
            }
            else
            {
                chk31.Checked = false;
                e.NewValues["switchEngaged"] = chk31.Checked;
            }
        }

        protected void FormView1Ai_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            //LabelResults.Visible = true;
            var ID = Request.QueryString["id"];
            Response.Redirect("KRACheck.aspx?status=done&ID=" + ID);
            LabelResults.Visible = true;
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            //Label QueueLbl = (Label)FormView1Ai.FindControl("QueueLbl");
            //DateTime releaseTime = DateTime.Now;

            ////MembershipUser currentUser = Membership.GetUser();
            ////Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            //string named = this.User.Identity.Name.ToString();

            //string connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            //string updateSql = "UPDATE SafetySecurity_C SET Passed = @Passed, PassedTime = @PassedTime, Passer = @Passer, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";

            //using (SqlConnection myConnection = new SqlConnection(connectionString))
            //{
            //    myConnection.Open();
            //    SqlCommand myCommand = new SqlCommand(updateSql, myConnection);
            //    myCommand.Parameters.AddWithValue("@Passed", "True");
            //    myCommand.Parameters.AddWithValue("@PassedTime", releaseTime);
            //    myCommand.Parameters.AddWithValue("@Passer", named);
            //    myCommand.Parameters.AddWithValue("@TruckAvailability", "True");
            //    myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text.ToString());
            //    myCommand.ExecuteNonQuery();
            //    myConnection.Close();
            //}

            //string updateStatus = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime, KraIn = @KraIn WHERE QueueID = @QueueID";

            //using (SqlConnection myConnection = new SqlConnection(connectionString))
            //{
            //    myConnection.Open();
            //    SqlCommand myCommand = new SqlCommand(updateStatus, myConnection);
            //    myCommand.Parameters.AddWithValue("@Status", "OMC CLEARANCE");
            //    myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
            //    myCommand.Parameters.AddWithValue("@KraIn", releaseTime);
            //    myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text.ToString());
            //    myCommand.ExecuteNonQuery();
            //    myConnection.Close();
            //}

            //string ID = Request.QueryString["id"].ToString();
            //Response.Redirect("KRACheck.aspx?status=ok&ID=" + ID);

            //LabelResults.Visible = true;
            //LabelResults.Text = "This truck has passed and should leave KPC";
            //ParaResult.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("KRA.aspx");
        }

        protected void ChkBtn_Click(object sender, EventArgs e)
        {
            //CheckBox CheckThemAll = (CheckBox)FormView1Ai.FindControl("CheckThemAll");
            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");


            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            //Button ApproveBtn = (Button)FormView1Ai.FindControl("ApproveBtn");
            var btn = (Button) FormView1Ai.FindControl("Button1");

            var chk27 = (CheckBox) FormView1Ai.FindControl("Leaking_Loading_36");
            var chk28 = (CheckBox) FormView1Ai.FindControl("BioCode");
            var chk29 = (CheckBox) FormView1Ai.FindControl("ProperSealing_40");
            var chk30 = (CheckBox) FormView1Ai.FindControl("ProductDestination");
            var chk31 = (CheckBox) FormView1Ai.FindControl("switchEngaged");

            chk27.Checked = true;
            chk28.Checked = true;
            chk29.Checked = true;
            chk30.Checked = true;
            chk31.Checked = true;

            if (chk27.Checked && chk28.Checked && chk29.Checked && chk30.Checked && chk31.Checked)
            {
                CommentPanel.Visible = false;
                SaveBtn.Visible = false;
                //ApproveBtn.Visible = true;
                btn.Visible = true;
            }
            else
            {
                CommentPanel.Visible = true;
                SaveBtn.Visible = true;
                //ApproveBtn.Visible = false;
                btn.Visible = false;
            }
            var ChkBtn = (Button) FormView1Ai.FindControl("ChkBtn");
            ChkBtn.Enabled = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var releaseTime = DateTime.Now;

            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            var named = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE SafetySecurity_C SET Passed = @Passed, PassedTime = @PassedTime, Passer = @Passer, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@Passed", true);
                myCommand.Parameters.AddWithValue("@PassedTime", releaseTime);
                myCommand.Parameters.AddWithValue("@Passer", named);
                myCommand.Parameters.AddWithValue("@TruckAvailability", true);
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

            var ID = Request.QueryString["id"];
            Response.Redirect("KRACheck.aspx?status=ok&ID=" + ID);
        }
    }
}