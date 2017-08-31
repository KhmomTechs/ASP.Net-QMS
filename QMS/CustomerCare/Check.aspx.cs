using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CustomerCare
{
    public partial class CustomerCare_Check : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            var resulting = Request.QueryString["STATUS"];
            var theID = Request.QueryString["ID"];
            var order = Request.QueryString["ORDER"];
            var carrier = Request.QueryString["CARRIER_NUMBER"];
            var driver = Request.QueryString["DRIVER_NUMBER"];
            var type = Request.QueryString["VIEW"];
            lblorder.Text = order;

            //SHIPPER
            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            var shipper = TextOmc.Text;
            TextOmc.Text = Helper.getShipper(shipper);

            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");

            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");

            var chk1 = (CheckBox) FormView1Ai.FindControl("KRA");
            var chk2 = (CheckBox) FormView1Ai.FindControl("Pipecore");
            var chk3 = (CheckBox) FormView1Ai.FindControl("Expiered");
            var chk4 = (CheckBox) FormView1Ai.FindControl("OmcLogo");
            var chk5 = (CheckBox) FormView1Ai.FindControl("Signatories");

            var Expired = (CheckBox) FormView1Ai.FindControl("Expiered");
            var chkExpiry = (CheckBox) FormView1Ai.FindControl("ExpieredFail");
            var FormFuelFacs = (FormView) FormView1Ai.FindControl("FormFuelFacs");
            var LabelTime = (Label) FormFuelFacs.FindControl("LabelTime");

            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been Approved to STOCK CONTROL";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been sent to the REJECTED QUEUE.";
            }
            else if (resulting == "active")
            {
                var b4Driver = (Panel) FormView1Ai.FindControl("b4Driver");
                var AfterDriver = (Panel) FormView1Ai.FindControl("AfterDriver");

                try
                {
                    b4Driver.Visible = true;
                    lblCombination.Text = "";

                    var timimg = LabelTime.Text;

                    var CheckDate = Convert.ToDateTime(timimg);

                    if (CheckDate < DateTime.Now)
                    {
                        CommentPanel.Visible = true;
                        SaveBtn.Visible = true;
                        ApproveBtn.Visible = false;
                        chkExpiry.Checked = true;
                        chkExpiry.Enabled = false;
                        Expired.Enabled = false;
                    }
                    else
                    {
                        chkExpiry.Enabled = false;
                        Expired.Checked = true;
                        Expired.Enabled = false;

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
                    }
                }
                catch
                {
                    b4Driver.Visible = false;
                    lblCombination.Text = "Wrong combination";
                }
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

                TextTrail.DataSource = rg;
                TextTrail.DataBind();
                TextTrail.DataTextField = "SERIAL_NUMBER";
                TextTrail.DataValueField = "SERIAL_NUMBER";
                TextTrail.DataBind();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            var type = Request.QueryString["VIEW"];
            Response.Redirect("List.aspx?view=" + type);
        }

        protected void FormView1Ai_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            var ID = Request.QueryString["id"];
            var type = Request.QueryString["VIEW"];
            Response.Redirect("Check.aspx?status=done&ID=" + ID + "&view=" + type);
        }

        protected void ChkBtn_Click(object sender, EventArgs e)
        {
            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");
            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");

            var chk1 = (CheckBox) FormView1Ai.FindControl("KRA");
            var chk2 = (CheckBox) FormView1Ai.FindControl("Pipecore");
            var chk3 = (CheckBox) FormView1Ai.FindControl("Expiered");
            var chk4 = (CheckBox) FormView1Ai.FindControl("OmcLogo");
            var chk5 = (CheckBox) FormView1Ai.FindControl("Signatories");

            var Expired = (CheckBox) FormView1Ai.FindControl("Expiered");
            var chkExpiry = (CheckBox) FormView1Ai.FindControl("ExpieredFail");
            var FormFuelFacs = (FormView) FormView1Ai.FindControl("FormFuelFacs");
            var LabelTime = (Label) FormFuelFacs.FindControl("LabelTime");

            var timimg = LabelTime.Text;

            var CheckDate = Convert.ToDateTime(timimg);
            if (CheckDate < DateTime.Now)
            {
                chkExpiry.Checked = true;
                chkExpiry.Enabled = false;
                CommentPanel.Visible = true;
                SaveBtn.Visible = true;
                ApproveBtn.Visible = false;
                Expired.Enabled = false;
            }
            else
            {
                chk1.Checked = true;
                chk2.Checked = true;
                chk3.Checked = true;
                chk4.Checked = true;
                chk5.Checked = true;
                chkExpiry.Checked = false;

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
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var releaseTime = DateTime.Now;

            var named = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE CustomerCare SET CustCareApproval = @CustCareApproval, CustCareApprovalTime = @CustCareApprovalTime, CustCareApprover = @CustCareApprover WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@CustCareApproval", true);
                myCommand.Parameters.AddWithValue("@CustCareApprovalTime", releaseTime);
                myCommand.Parameters.AddWithValue("@CustCareApprover", named);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var updateStatus = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "STK");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            var type = Request.QueryString["VIEW"];
            Response.Redirect("Check.aspx?status=ok&ID=" + ID + "&view=" + type);
        }

        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateStatus =
                "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime, Rejected = @Rejected, RejectedTime = @RejectedTime, RejectedBy = @RejectedBy, RejectedReason = @RejectedReason WHERE QueueID = @QueueID";

            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");
            var RejectedReason = (TextBox) FormView1Ai.FindControl("RejectedReason");
            var releaseTime = DateTime.Now;
            var named = User.Identity.Name;

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "CUSTR");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@Rejected", true);
                myCommand.Parameters.AddWithValue("@RejectedTime", releaseTime);
                myCommand.Parameters.AddWithValue("@RejectedBy", named);
                myCommand.Parameters.AddWithValue("@RejectedReason", RejectedReason.Text.Trim());
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var savedTime = DateTime.Now;
            e.NewValues["CheckUserTime"] = savedTime;

            e.NewValues["CheckUser"] = User.Identity.Name;
            e.NewValues["Approved"] = "False";
            //e.NewValues["Failed"] = "True";


            var chk1 = (CheckBox) FormView1Ai.FindControl("KRA");
            var chk2 = (CheckBox) FormView1Ai.FindControl("Pipecore");
            var chk3 = (CheckBox) FormView1Ai.FindControl("Expiered");
            var chk4 = (CheckBox) FormView1Ai.FindControl("OmcLogo");
            var chk5 = (CheckBox) FormView1Ai.FindControl("Signatories");

            if (chk1.Checked)
            {
                chk1.Checked = true;
                e.NewValues["KRA"] = chk1.Checked;
            }
            else
            {
                chk1.Checked = false;
                e.NewValues["KRA"] = chk1.Checked;
            }

            if (chk2.Checked)
            {
                chk2.Checked = true;
                e.NewValues["Pipecore"] = chk2.Checked;
            }
            else
            {
                chk2.Checked = false;
                e.NewValues["Pipecore"] = chk2.Checked;
            }

            if (chk3.Checked)
            {
                chk3.Checked = true;
                e.NewValues["Expiered"] = chk3.Checked;
            }
            else
            {
                chk3.Checked = false;
                e.NewValues["Expiered"] = chk3.Checked;
            }
            if (chk4.Checked)
            {
                chk4.Checked = true;
                e.NewValues["OmcLogo"] = chk4.Checked;
            }
            else
            {
                chk4.Checked = false;
                e.NewValues["OmcLogo"] = chk4.Checked;
            }
            if (chk5.Checked)
            {
                chk5.Checked = true;
                e.NewValues["Signatories"] = chk5.Checked;
            }
            else
            {
                chk5.Checked = false;
                e.NewValues["Signatories"] = chk5.Checked;
            }
        }

        protected void GoBack_Click(object sender, EventArgs e)
        {
            //Label LabelType = (Label)FormView1Ai.FindControl("LabelType");
            var type = Request.QueryString["VIEW"];
            Response.Redirect("List.aspx?view=" + type);
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var theID = Request.QueryString["ID"];
                var order = Request.QueryString["ORDER"];
                var type = Request.QueryString["VIEW"];

                var trailerNo = (Label) FormTrailer.FindControl("trltxt");

                Response.Redirect("Check.aspx?ID=" + theID + "&order=" + order + "&DRIVER_NAME=" +
                                  TextSearch.SelectedValue.Trim() + "&REG_NUMBER=" + trailerNo.Text.Trim() +
                                  "&status=active" + "&view=" + type);
            }
        }
    }
}