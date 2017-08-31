using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Security
{
    public partial class Security_Check : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            var resulting = Request.QueryString["STATUS"];
            var theID = Request.QueryString["ID"];
            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been Approved and CALLED TO LOADING BAY";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been sent to the Depot manager for further action";
            }

            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            TextOmc.Text = Helper.getShipper(TextOmc.Text);

            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");

            //CheckBox chkPass = (CheckBox)FormView1Ai.FindControl("EmergencyInstGiven_35");
            var chkFail = (CheckBox) FormView1Ai.FindControl("CheckBox7");

            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");

            var chk27 = (CheckBox) FormView1Ai.FindControl("RegTally");
            var chk28 = (CheckBox) FormView1Ai.FindControl("DrLicense");

            var chk26 = (CheckBox) FormView1Ai.FindControl("ignitionSources");
            var chk29 = (CheckBox) FormView1Ai.FindControl("CheckDanger");
            var chk30 = (CheckBox) FormView1Ai.FindControl("CheckBtmValves");

            if (chk27.Checked && chk28.Checked && chk26.Checked && chk29.Checked && chk30.Checked)
            {
                CommentPanel.Visible = false;
                SaveBtn.Visible = false;
                ApproveBtn.Visible = true;
            }
            else
            {
                CommentPanel.Visible = true;
                SaveBtn.Visible = true;
                ApproveBtn.Visible = false;
            }

            //set to dropdown
            var DriverLbl = (Label) FormView1Ai.FindControl("DriverLbl");

            if (!Page.IsPostBack)
            {
                //get drivers
                var con = new SqlConnection(strConnection);
                var com = "Select distinct NAME from PS28drivers Order By NAME";
                var reg = "Select distinct SERIAL_NUMBER from PS28Trailers Order By SERIAL_NUMBER";
                var adpt = new SqlDataAdapter(com, con);
                var regpt = new SqlDataAdapter(reg, con);
                var dt = new DataTable();
                var rg = new DataTable();
                adpt.Fill(dt);
                regpt.Fill(rg);
                TextSearch.DataSource = dt;
                TextSearch.DataBind();
                TextSearch.DataTextField = "NAME";
                TextSearch.DataValueField = "NAME";

                var selectDriver = DriverLbl.Text;
                if (selectDriver != string.Empty)
                {
                    if (Helper.getDriver(selectDriver) != "")
                    {
                        TextSearch.SelectedValue = Helper.getDriver(selectDriver);
                    }
                }

                TextSearch.DataBind();
            }
        }


        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var savedTime = DateTime.Now;
            e.NewValues["SavedTime_B"] = savedTime;
            e.NewValues["StatusTime"] = savedTime;

            e.NewValues["TruckAvailability"] = true;
            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.NewValues["SavedBy_B"] = User.Identity.Name;

            e.NewValues["EntryStatus"] = false;

            e.NewValues["Failed"] = true;


            var chk27 = (CheckBox) FormView1Ai.FindControl("RegTally");
            if (chk27.Checked)
            {
                chk27.Checked = true;
                e.NewValues["RegTally"] = chk27.Checked;
            }
            else
            {
                chk27.Checked = false;
                e.NewValues["RegTally"] = chk27.Checked;
            }

            var chk28 = (CheckBox) FormView1Ai.FindControl("DrLicense");
            if (chk28.Checked)
            {
                chk28.Checked = true;
                e.NewValues["DrLicense"] = chk28.Checked;
            }
            else
            {
                chk28.Checked = false;
                e.NewValues["DrLicense"] = chk28.Checked;
            }

            var chk29 = (CheckBox) FormView1Ai.FindControl("ignitionSources");
            if (chk29.Checked)
            {
                chk29.Checked = true;
                e.NewValues["ignitionSources"] = chk29.Checked;
            }
            else
            {
                chk29.Checked = false;
                e.NewValues["ignitionSources"] = chk29.Checked;
            }

            var chk30 = (CheckBox) FormView1Ai.FindControl("CheckDanger");
            if (chk30.Checked)
            {
                chk30.Checked = true;
                e.NewValues["CheckDanger"] = chk30.Checked;
            }
            else
            {
                chk30.Checked = false;
                e.NewValues["CheckDanger"] = chk30.Checked;
            }

            var chk31 = (CheckBox) FormView1Ai.FindControl("CheckBtmValves");
            if (chk31.Checked)
            {
                chk31.Checked = true;
                e.NewValues["CheckBtmValves"] = chk31.Checked;
            }
            else
            {
                chk31.Checked = false;
                e.NewValues["CheckBtmValves"] = chk31.Checked;
            }
        }

        protected void FormView1Ai_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var releaseTime = DateTime.Now;
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

            var updateStatus = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "SECCO");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            Response.Redirect("Check.aspx?status=done&ID=" + ID);
            LabelResults.Visible = true;
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var releaseTime = DateTime.Now;

            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            var named = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE SafetySecurity_B SET EntryStatus = @EntryStatus, VerifyTime = @VerifyTime, Verifier = @Verifier, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@EntryStatus", true);
                myCommand.Parameters.AddWithValue("@VerifyTime", releaseTime);
                myCommand.Parameters.AddWithValue("@Verifier", named);
                myCommand.Parameters.AddWithValue("@TruckAvailability", true);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var updateStatus =
                "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime, SecurityInspection = @SecurityInspection WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "CALLOD");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@SecurityInspection", false);
                //myCommand.Parameters.AddWithValue("@OperationsIn", releaseTime);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            Response.Redirect("Check.aspx?status=ok&ID=" + ID);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            var LabelType = (Label) FormView1Ai.FindControl("LabelType");
            Response.Redirect("Verification.aspx?view=" + LabelType.Text);
        }

        protected void ChkBtn_Click(object sender, EventArgs e)
        {
            //CheckBox CheckThemAll = (CheckBox)FormView1Ai.FindControl("CheckThemAll");

            var chk1 = (CheckBox) FormView1Ai.FindControl("RegTally");
            var chk2 = (CheckBox) FormView1Ai.FindControl("DrLicense");
            var chk3 = (CheckBox) FormView1Ai.FindControl("ignitionSources");
            var chk4 = (CheckBox) FormView1Ai.FindControl("CheckDanger");
            var chk5 = (CheckBox) FormView1Ai.FindControl("CheckBtmValves");

            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");
            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");


            chk1.Checked = true;
            chk2.Checked = true;
            chk3.Checked = true;
            chk4.Checked = true;
            chk5.Checked = true;


            if (chk1.Checked && chk2.Checked && chk3.Checked && chk4.Checked && chk5.Checked)
            {
                CommentPanel.Visible = false;
                SaveBtn.Visible = false;
                ApproveBtn.Visible = true;
            }
            else
            {
                CommentPanel.Visible = true;
                SaveBtn.Visible = true;
                ApproveBtn.Visible = false;
            }
            var ChkBtn = (Button) FormView1Ai.FindControl("ChkBtn");
            ChkBtn.Enabled = false;
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            var LabelType = (Label) FormView1Ai.FindControl("LabelType");
            Response.Redirect("Verification.aspx?view=" + LabelType.Text);
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            //code to bind driver id to grid below databound here
            var GridResult = (GridView) UpdatePanel1.FindControl("GridResult");

            if (Page.IsPostBack)
            {
                //WHERE ([SERIAL_NUMBER] LIKE '%' + @REG_NUMBER + '%')
                var con = new SqlConnection(strConnection);
                var cmd =
                    new SqlCommand("SELECT TOP 1 ID FROM [PS28drivers] WHERE ([NAME] LIKE '%' + @DRIVER_NAME + '%')",
                        con);
                cmd.Parameters.Add("@DRIVER_NAME", TextSearch.SelectedValue.Trim());

                //var result = cmd.ToString();
                var Adpt = new SqlDataAdapter(cmd);
                var dt = new DataTable();
                Adpt.Fill(dt);
                GridResult.DataSource = dt;
                GridResult.DataBind();
                //LabelProduct.Text = "Volume:" + result;
            }
        }
    }
}