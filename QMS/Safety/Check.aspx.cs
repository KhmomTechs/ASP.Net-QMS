using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Safety
{
    public partial class Safety_Check : Page
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
                lblPopUp.Text = "This order has been approved and sent to CUSTOMER CARE";
            }
            else if (resulting == "done")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                ParaResult.Visible = false;
                lblPopUp.Text = "This order has been sent to the Depot manager for further action.";
            }

            //Label LabelTime = (Label)FormView1Ai.FindControl("LabelTime");
            //LabelTime.Text = DateTime.Now.ToString();

            //get shipper
            var TextOmc = (Label) FormView1Ai.FindControl("TextOmc");
            TextOmc.Text = Helper.getShipper(TextOmc.Text);


            var chkPass = (CheckBox) FormView1Ai.FindControl("WheelChokesChaned_26");
            var chkFail = (CheckBox) FormView1Ai.FindControl("CheckBox23");

            var chk1 = (CheckBox) FormView1Ai.FindControl("ExtinguishersCheck_1");
            var chk2 = (CheckBox) FormView1Ai.FindControl("ExtingushersLabel_2");
            var chk3 = (CheckBox) FormView1Ai.FindControl("CompartmentsEmpty_3");
            var chk4 = (CheckBox) FormView1Ai.FindControl("TyreCondition_4");
            var chk5 = (CheckBox) FormView1Ai.FindControl("ExposedWires_5");
            var chk6 = (CheckBox) FormView1Ai.FindControl("FunctionalBattery_6");
            var chk7 = (CheckBox) FormView1Ai.FindControl("HandBrakeCondition_7");
            var chk8 = (CheckBox) FormView1Ai.FindControl("BottomExhaustPipe_8");
            var chk9 = (CheckBox) FormView1Ai.FindControl("ExhaustCondition_9");
            var chk10 = (CheckBox) FormView1Ai.FindControl("FlameArrestorFitted_10");
            var chk11 = (CheckBox) FormView1Ai.FindControl("SelfStart_11");
            var chk12 = (CheckBox) FormView1Ai.FindControl("BatteryInsulated_12");
            var chk13 = (CheckBox) FormView1Ai.FindControl("DashboardFree_13");
            var chk14 = (CheckBox) FormView1Ai.FindControl("Earthingplate_14");
            //CheckBox chk15 = (CheckBox)FormView1Ai.FindControl("ValidCalibrationChart_15");
            var chk16 = (CheckBox) FormView1Ai.FindControl("ContainersRemoved_16");
            //CheckBox chk17 = (CheckBox)FormView1Ai.FindControl("RegNo_Tally_OrderNo_17");
            var chk18 = (CheckBox) FormView1Ai.FindControl("ProperSealing_18");
            var chk19 = (CheckBox) FormView1Ai.FindControl("DangerPetroleumSign_20");
            var chk20 = (CheckBox) FormView1Ai.FindControl("OilLeaking_21");
            var chk21 = (CheckBox) FormView1Ai.FindControl("ValveCouplingComp_22");
            var chk22 = (CheckBox) FormView1Ai.FindControl("BrokenLights_23");
            var chk23 = (CheckBox) FormView1Ai.FindControl("KEN_Number_24");
            var chk24 = (CheckBox) FormView1Ai.FindControl("TruckLadderSpace_25");
            var chk25 = (CheckBox) FormView1Ai.FindControl("CheckomcCheclist");
            //CheckBox chk26 = (CheckBox)FormView1Ai.FindControl("ignitionSources");
            var chk27 = (CheckBox) FormView1Ai.FindControl("necessary_PPE");
            //CheckBox chk28 = (CheckBox)FormView1Ai.FindControl("CheckDanger");
            var chk29 = (CheckBox) FormView1Ai.FindControl("CheckERInst");
            //CheckBox chk30 = (CheckBox)FormView1Ai.FindControl("CheckBtmValves");


            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");
            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");


            if (chkPass.Checked && chk1.Checked && chk2.Checked && chk3.Checked && chk4.Checked && chk5.Checked &&
                chk6.Checked && chk7.Checked && chk8.Checked && chk9.Checked && chk10.Checked && chk11.Checked &&
                chk12.Checked && chk13.Checked && chk14.Checked && chk16.Checked && chk18.Checked && chk19.Checked &&
                chk20.Checked && chk21.Checked && chk22.Checked && chk23.Checked && chk24.Checked && chk25.Checked &&
                chk27.Checked && chk29.Checked)
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

        protected void FormView1Ai_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            var savedTime = DateTime.Now;
            e.NewValues["SavedTime"] = savedTime;

            e.NewValues["TruckAvailability"] = true;
            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;
            e.NewValues["SavedBy"] = User.Identity.Name;

            e.NewValues["ReleaseStatus"] = false;
            e.NewValues["Failed"] = true;


            var chk1 = (CheckBox) FormView1Ai.FindControl("ExtinguishersCheck_1");
            var chk1Fail = (CheckBox) FormView1Ai.FindControl("ExtinguishersCheck_1Fail");


            if (chk1.Checked)
            {
                chk1.Checked = true;
                e.NewValues["ExtinguishersCheck_1"] = chk1.Checked;
            }
            else
            {
                chk1.Checked = false;
                e.NewValues["ExtinguishersCheck_1"] = chk1.Checked;
            }

            var chk2 = (CheckBox) FormView1Ai.FindControl("ExtingushersLabel_2");
            if (chk2.Checked)
            {
                chk2.Checked = true;
                e.NewValues["ExtingushersLabel_2"] = chk2.Checked;
            }
            else
            {
                chk2.Checked = false;
                e.NewValues["ExtingushersLabel_2"] = chk2.Checked;
            }

            var chk3 = (CheckBox) FormView1Ai.FindControl("CompartmentsEmpty_3");
            if (chk3.Checked)
            {
                chk3.Checked = true;
                e.NewValues["CompartmentsEmpty_3"] = chk3.Checked;
            }
            else
            {
                chk3.Checked = false;
                e.NewValues["CompartmentsEmpty_3"] = chk3.Checked;
            }

            var chk4 = (CheckBox) FormView1Ai.FindControl("TyreCondition_4");
            if (chk4.Checked)
            {
                chk4.Checked = true;
                e.NewValues["TyreCondition_4"] = chk4.Checked;
            }
            else
            {
                chk4.Checked = false;
                e.NewValues["TyreCondition_4"] = chk4.Checked;
            }

            var chk5 = (CheckBox) FormView1Ai.FindControl("ExposedWires_5");
            if (chk5.Checked)
            {
                chk5.Checked = true;
                e.NewValues["ExposedWires_5"] = chk5.Checked;
            }
            else
            {
                chk5.Checked = false;
                e.NewValues["ExposedWires_5"] = chk5.Checked;
            }

            var chk6 = (CheckBox) FormView1Ai.FindControl("FunctionalBattery_6");
            if (chk6.Checked)
            {
                chk6.Checked = true;
                e.NewValues["FunctionalBattery_6"] = chk6.Checked;
            }
            else
            {
                chk6.Checked = false;
                e.NewValues["FunctionalBattery_6"] = chk6.Checked;
            }

            var chk7 = (CheckBox) FormView1Ai.FindControl("HandBrakeCondition_7");
            if (chk7.Checked)
            {
                chk7.Checked = true;
                e.NewValues["HandBrakeCondition_7"] = chk7.Checked;
            }
            else
            {
                chk7.Checked = false;
                e.NewValues["HandBrakeCondition_7"] = chk7.Checked;
            }

            var chk8 = (CheckBox) FormView1Ai.FindControl("BottomExhaustPipe_8");
            if (chk8.Checked)
            {
                chk8.Checked = true;
                e.NewValues["BottomExhaustPipe_8"] = chk8.Checked;
            }
            else
            {
                chk8.Checked = false;
                e.NewValues["BottomExhaustPipe_8"] = chk8.Checked;
            }

            var chk9 = (CheckBox) FormView1Ai.FindControl("ExhaustCondition_9");
            if (chk9.Checked)
            {
                chk9.Checked = true;
                e.NewValues["ExhaustCondition_9"] = chk9.Checked;
            }
            else
            {
                chk9.Checked = false;
                e.NewValues["ExhaustCondition_9"] = chk9.Checked;
            }

            var chk10 = (CheckBox) FormView1Ai.FindControl("FlameArrestorFitted_10");
            if (chk10.Checked)
            {
                chk10.Checked = true;
                e.NewValues["FlameArrestorFitted_10"] = chk10.Checked;
            }
            else
            {
                chk10.Checked = false;
                e.NewValues["FlameArrestorFitted_10"] = chk10.Checked;
            }

            var chk11 = (CheckBox) FormView1Ai.FindControl("SelfStart_11");
            if (chk11.Checked)
            {
                chk11.Checked = true;
                e.NewValues["SelfStart_11"] = chk11.Checked;
            }
            else
            {
                chk11.Checked = false;
                e.NewValues["SelfStart_11"] = chk11.Checked;
            }

            var chk12 = (CheckBox) FormView1Ai.FindControl("BatteryInsulated_12");
            if (chk12.Checked)
            {
                chk12.Checked = true;
                e.NewValues["BatteryInsulated_12"] = chk12.Checked;
            }
            else
            {
                chk12.Checked = false;
                e.NewValues["BatteryInsulated_12"] = chk12.Checked;
            }

            var chk13 = (CheckBox) FormView1Ai.FindControl("DashboardFree_13");
            if (chk13.Checked)
            {
                chk13.Checked = true;
                e.NewValues["DashboardFree_13"] = chk13.Checked;
            }
            else
            {
                chk13.Checked = false;
                e.NewValues["DashboardFree_13"] = chk13.Checked;
            }

            var chk14 = (CheckBox) FormView1Ai.FindControl("Earthingplate_14");
            if (chk14.Checked)
            {
                chk14.Checked = true;
                e.NewValues["Earthingplate_14"] = chk14.Checked;
            }
            else
            {
                chk14.Checked = false;
                e.NewValues["Earthingplate_14"] = chk14.Checked;
            }


            var chk16 = (CheckBox) FormView1Ai.FindControl("ContainersRemoved_16");
            if (chk16.Checked)
            {
                chk16.Checked = true;
                e.NewValues["ContainersRemoved_16"] = chk16.Checked;
            }
            else
            {
                chk16.Checked = false;
                e.NewValues["ContainersRemoved_16"] = chk16.Checked;
            }

            var chk18 = (CheckBox) FormView1Ai.FindControl("ProperSealing_18");
            if (chk18.Checked)
            {
                chk18.Checked = true;
                e.NewValues["ProperSealing_18"] = chk18.Checked;
            }
            else
            {
                chk18.Checked = false;
                e.NewValues["ProperSealing_18"] = chk18.Checked;
            }

            var chk19 = (CheckBox) FormView1Ai.FindControl("DangerPetroleumSign_20");
            if (chk19.Checked)
            {
                chk19.Checked = true;
                e.NewValues["DangerPetroleumSign_20"] = chk19.Checked;
            }
            else
            {
                chk19.Checked = false;
                e.NewValues["DangerPetroleumSign_20"] = chk19.Checked;
            }

            var chk20 = (CheckBox) FormView1Ai.FindControl("OilLeaking_21");
            if (chk20.Checked)
            {
                chk20.Checked = true;
                e.NewValues["OilLeaking_21"] = chk20.Checked;
            }
            else
            {
                chk20.Checked = false;
                e.NewValues["OilLeaking_21"] = chk20.Checked;
            }

            var chk21 = (CheckBox) FormView1Ai.FindControl("ValveCouplingComp_22");
            if (chk21.Checked)
            {
                chk21.Checked = true;
                e.NewValues["ValveCouplingComp_22"] = chk21.Checked;
            }
            else
            {
                chk21.Checked = false;
                e.NewValues["ValveCouplingComp_22"] = chk21.Checked;
            }

            var chk22 = (CheckBox) FormView1Ai.FindControl("BrokenLights_23");
            if (chk22.Checked)
            {
                chk22.Checked = true;
                e.NewValues["BrokenLights_23"] = chk22.Checked;
            }
            else
            {
                chk22.Checked = false;
                e.NewValues["BrokenLights_23"] = chk22.Checked;
            }

            var chk23 = (CheckBox) FormView1Ai.FindControl("KEN_Number_24");
            if (chk23.Checked)
            {
                chk23.Checked = true;
                e.NewValues["KEN_Number_24"] = chk23.Checked;
            }
            else
            {
                chk23.Checked = false;
                e.NewValues["KEN_Number_24"] = chk23.Checked;
            }

            var chk24 = (CheckBox) FormView1Ai.FindControl("TruckLadderSpace_25");
            if (chk24.Checked)
            {
                chk24.Checked = true;
                e.NewValues["TruckLadderSpace_25"] = chk24.Checked;
            }
            else
            {
                chk24.Checked = false;
                e.NewValues["TruckLadderSpace_25"] = chk24.Checked;
            }

            var chk25 = (CheckBox) FormView1Ai.FindControl("WheelChokesChaned_26");
            if (chk25.Checked)
            {
                chk25.Checked = true;
                e.NewValues["WheelChokesChaned_26"] = chk25.Checked;
            }
            else
            {
                chk25.Checked = false;
                e.NewValues["WheelChokesChaned_26"] = chk25.Checked;
            }

            var chk26 = (CheckBox) FormView1Ai.FindControl("CheckomcCheclist");
            if (chk26.Checked)
            {
                chk26.Checked = true;
                e.NewValues["CheckomcCheclist"] = chk26.Checked;
            }
            else
            {
                chk26.Checked = false;
                e.NewValues["CheckomcCheclist"] = chk26.Checked;
            }


            var chk28 = (CheckBox) FormView1Ai.FindControl("necessary_PPE");
            if (chk28.Checked)
            {
                chk28.Checked = true;
                e.NewValues["necessary_PPE"] = chk28.Checked;
            }
            else
            {
                chk28.Checked = false;
                e.NewValues["necessary_PPE"] = chk28.Checked;
            }


            var chk30 = (CheckBox) FormView1Ai.FindControl("CheckERInst");
            if (chk30.Checked)
            {
                chk30.Checked = true;
                e.NewValues["CheckERInst"] = chk30.Checked;
            }
            else
            {
                chk30.Checked = false;
                e.NewValues["CheckERInst"] = chk30.Checked;
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
                myCommand.Parameters.AddWithValue("@Status", "SAFCON");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            Response.Redirect("Check.aspx?status=done&ID=" + ID);
            //LabelResults.Visible = true;
        }

        protected void ApproveBtn_Click(object sender, EventArgs e)
        {
            var QueueLbl = (Label) FormView1Ai.FindControl("QueueLbl");

            var releaseTime = DateTime.Now;

            var type = Request.QueryString["VIEW"];
            //MembershipUser currentUser = Membership.GetUser();
            //Guid currentUserId = (Guid)currentUser.ProviderUserKey;

            var named = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
            var updateSql =
                "UPDATE SafetySecurity_A SET ReleaseStatus = @ReleaseStatus, ReleaseStatusTime = @ReleaseStatusTime, HSEInspOfficial = @HSEInspOfficial, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateSql, myConnection);
                myCommand.Parameters.AddWithValue("@ReleaseStatus", true);
                myCommand.Parameters.AddWithValue("@ReleaseStatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@HSEInspOfficial", named);
                myCommand.Parameters.AddWithValue("@TruckAvailability", true);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }


            var updateStatus =
                "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime, SafetyInspection = @SafetyInspection, SecurityInspection = @SecurityInspection WHERE QueueID = @QueueID";

            using (var myConnection = new SqlConnection(connectionString))
            {
                myConnection.Open();
                var myCommand = new SqlCommand(updateStatus, myConnection);
                myCommand.Parameters.AddWithValue("@Status", "CUST");
                myCommand.Parameters.AddWithValue("@StatusTime", releaseTime);
                myCommand.Parameters.AddWithValue("@SafetyInspection", false);
                myCommand.Parameters.AddWithValue("@SecurityInspection", true);
                myCommand.Parameters.AddWithValue("@QueueID", QueueLbl.Text);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }

            var ID = Request.QueryString["id"];
            Response.Redirect("Check.aspx?status=ok&ID=" + ID + "&view=" + type);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            //Response.Redirect("List.aspx");
            var type = Request.QueryString["VIEW"];
            //Label LabelType = (Label)FormView1Ai.FindControl("LabelType");
            Response.Redirect("List.aspx?view=" + type);
        }

        protected void ChkBtn_Click(object sender, EventArgs e)
        {
            //CheckBox CheckThemAll = (CheckBox)FormView1Ai.FindControl("CheckThemAll");
            //CheckBox CheckThemFaill = (CheckBox)FormView1Ai.FindControl("CheckThemFaill");

            var chkPass = (CheckBox) FormView1Ai.FindControl("WheelChokesChaned_26");
            var chk1 = (CheckBox) FormView1Ai.FindControl("ExtinguishersCheck_1");
            var chk2 = (CheckBox) FormView1Ai.FindControl("ExtingushersLabel_2");
            var chk3 = (CheckBox) FormView1Ai.FindControl("CompartmentsEmpty_3");
            var chk4 = (CheckBox) FormView1Ai.FindControl("TyreCondition_4");
            var chk5 = (CheckBox) FormView1Ai.FindControl("ExposedWires_5");
            var chk6 = (CheckBox) FormView1Ai.FindControl("FunctionalBattery_6");
            var chk7 = (CheckBox) FormView1Ai.FindControl("HandBrakeCondition_7");
            var chk8 = (CheckBox) FormView1Ai.FindControl("BottomExhaustPipe_8");
            var chk9 = (CheckBox) FormView1Ai.FindControl("ExhaustCondition_9");
            var chk10 = (CheckBox) FormView1Ai.FindControl("FlameArrestorFitted_10");
            var chk11 = (CheckBox) FormView1Ai.FindControl("SelfStart_11");
            var chk12 = (CheckBox) FormView1Ai.FindControl("BatteryInsulated_12");
            var chk13 = (CheckBox) FormView1Ai.FindControl("DashboardFree_13");
            var chk14 = (CheckBox) FormView1Ai.FindControl("Earthingplate_14");
            //CheckBox chk15 = (CheckBox)FormView1Ai.FindControl("ValidCalibrationChart_15");
            var chk16 = (CheckBox) FormView1Ai.FindControl("ContainersRemoved_16");
            //CheckBox chk17 = (CheckBox)FormView1Ai.FindControl("RegNo_Tally_OrderNo_17");
            var chk18 = (CheckBox) FormView1Ai.FindControl("ProperSealing_18");
            var chk19 = (CheckBox) FormView1Ai.FindControl("DangerPetroleumSign_20");
            var chk20 = (CheckBox) FormView1Ai.FindControl("OilLeaking_21");
            var chk21 = (CheckBox) FormView1Ai.FindControl("ValveCouplingComp_22");
            var chk22 = (CheckBox) FormView1Ai.FindControl("BrokenLights_23");
            var chk23 = (CheckBox) FormView1Ai.FindControl("KEN_Number_24");
            var chk24 = (CheckBox) FormView1Ai.FindControl("TruckLadderSpace_25");
            var chk25 = (CheckBox) FormView1Ai.FindControl("CheckomcCheclist");
            //CheckBox chk26 = (CheckBox)FormView1Ai.FindControl("ignitionSources");
            var chk27 = (CheckBox) FormView1Ai.FindControl("necessary_PPE");
            //CheckBox chk28 = (CheckBox)FormView1Ai.FindControl("CheckDanger");
            var chk29 = (CheckBox) FormView1Ai.FindControl("CheckERInst");
            //CheckBox chk30 = (CheckBox)FormView1Ai.FindControl("CheckBtmValves");

            //if (CheckThemAll.Checked)
            //{
            //CheckThemFaill.Checked = false;
            chkPass.Checked = true;
            chk1.Checked = true;
            chk2.Checked = true;
            chk3.Checked = true;
            chk4.Checked = true;
            chk5.Checked = true;
            chk6.Checked = true;
            chk7.Checked = true;
            chk8.Checked = true;
            chk9.Checked = true;
            chk10.Checked = true;
            chk11.Checked = true;
            chk12.Checked = true;
            chk13.Checked = true;
            chk14.Checked = true;
            //chk15.Checked = true;
            chk16.Checked = true;
            //chk17.Checked = true;
            chk18.Checked = true;
            chk19.Checked = true;
            chk20.Checked = true;
            chk21.Checked = true;
            chk22.Checked = true;
            chk23.Checked = true;
            chk24.Checked = true;
            chk25.Checked = true;
            //chk26.Checked = true;
            chk27.Checked = true;
            //chk28.Checked = true;
            chk29.Checked = true;
            //chk30.Checked = true;

            var CommentPanel = (Panel) FormView1Ai.FindControl("CommentPanel");

            var SaveBtn = (Button) FormView1Ai.FindControl("SaveBtn");
            var ApproveBtn = (Button) FormView1Ai.FindControl("ApproveBtn");

            if (chkPass.Checked && chk1.Checked && chk2.Checked && chk3.Checked && chk4.Checked && chk5.Checked &&
                chk6.Checked && chk7.Checked && chk8.Checked && chk9.Checked && chk10.Checked && chk11.Checked &&
                chk12.Checked && chk13.Checked && chk14.Checked && chk16.Checked && chk18.Checked && chk19.Checked &&
                chk20.Checked && chk21.Checked && chk22.Checked && chk23.Checked && chk24.Checked && chk25.Checked &&
                chk27.Checked && chk29.Checked)
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
            var type = Request.QueryString["VIEW"];
            Response.Redirect("List.aspx?view=" + type);
        }
    }
}