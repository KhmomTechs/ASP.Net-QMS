using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Administration
{
    public partial class Administration_QueueEdit : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridLocal.DataBind();
            GridExp.DataBind();
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowBound(e);
        }

        protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowBound(e);
        }

        private static void RowBound(GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[9].HorizontalAlign = HorizontalAlign.Left;

                var shipper = e.Row.Cells[2].Text;
                e.Row.Cells[2].Text = Helper.getShipper(shipper);
            }
        }


        protected void LocSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                PanelExp.Visible = false;
                PanelLoc.Visible = true;
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                PanelExp.Visible = true;
                PanelLoc.Visible = false;
            }
        }

        protected void GridExp_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                if (e.AffectedRows == 1)
                {
                    RowUpdated(e);
                }
            }
        }

        private void RowUpdated(GridViewUpdatedEventArgs e)
        {
            var changeTime = DateTime.Now;
            var companyNo = User.Identity.Name;

            var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

            var updateRecord =
                "INSERT INTO Admin_Edit(CompNumber, TimeOfEdit, Type, StatusTo, QueueID) VALUES (@CompNumber, @TimeOfEdit, @Type, @StatusTo, @QueueID)";

            using (var myConnection = new SqlConnection(connectionString))
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;

                myConnection.Open();
                var myCommand = new SqlCommand(updateRecord, myConnection);
                myCommand.Parameters.AddWithValue("@CompNumber", companyNo);
                myCommand.Parameters.AddWithValue("@TimeOfEdit", changeTime);
                myCommand.Parameters.AddWithValue("@Type", e.NewValues["Type"]);
                myCommand.Parameters.AddWithValue("@StatusTo", e.NewValues["Status"]);


                if (e.NewValues["Status"].ToString() == "STK")
                {
                    const string strUpdate =
                        "UPDATE SafetySecurity_B SET EntryStatus = @EntryStatus, EntryStatusTime = @EntryStatusTime, GateHseInspOfficial = @GateHseInspOfficial, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@EntryStatus", true);
                    cmd.Parameters.AddWithValue("@EntryStatusTime", cusTime);
                    cmd.Parameters.AddWithValue("@GateHseInspOfficial", named);
                    cmd.Parameters.AddWithValue("@TruckAvailability", true);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    const string strQueueUpdate =
                        "Update NewQueue set SecurityInspection = @SecurityInspection WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQueueUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@SecurityInspection", false);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = conQueue;
                    conQueue.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    conQueue.Close();
                }
                else if (e.NewValues["Status"].ToString() == "CUST")
                {
                    const string strUpdate =
                        "Update StockControl set StControlApproval = @StControlApproval, StControlApprovalTime = @StControlApprovalTime, StControlApprover = @StControlApprover WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@StControlApproval", true);
                    cmd.Parameters.AddWithValue("@StControlApprovalTime", cusTime);
                    cmd.Parameters.AddWithValue("@StControlApprover", named);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                else if (e.NewValues["Status"].ToString() == "SAFTY")
                {
                    const string strUpdate =
                        "UPDATE CustomerCare SET CustCareApproval = @CustCareApproval, CustCareApprovalTime = @CustCareApprovalTime, CustCareApprover = @CustCareApprover WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@CustCareApproval", true);
                    cmd.Parameters.AddWithValue("@CustCareApprovalTime", cusTime);
                    cmd.Parameters.AddWithValue("@CustCareApprover", named);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                else if (e.NewValues["Status"].ToString() == "DISPATCH")
                {
                    const string strUpdate =
                        "UPDATE SafetySecurity_A SET ReleaseStatus = @ReleaseStatus, ReleaseStatusTime = @ReleaseStatusTime, HSEInspOfficial = @HSEInspOfficial, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@ReleaseStatus", true);
                    cmd.Parameters.AddWithValue("@ReleaseStatusTime", cusTime);
                    cmd.Parameters.AddWithValue("@HSEInspOfficial", named);
                    cmd.Parameters.AddWithValue("@TruckAvailability", true);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                else if (e.NewValues["Status"].ToString() == "SECVE")
                {
                    const string strUpdate =
                        "Update Operations set Called = @Called, CallTime = @CallTime, Caller = @Caller WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Called", true);
                    cmd.Parameters.AddWithValue("@CallTime", cusTime);
                    cmd.Parameters.AddWithValue("@Caller", named);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                else if (e.NewValues["Status"].ToString() == "LODCLE")
                {
                    const string strUpdate =
                        "Update Operations set Cleared = @Cleared, ClearTime = @ClearTime, Clearer = @Clearer WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Cleared", true);
                    cmd.Parameters.AddWithValue("@ClearTime", cusTime);
                    cmd.Parameters.AddWithValue("@Clearer", named);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    const string strUpdate1 =
                        "Update SafetySecurity_C set Failed = @Failed, Passed = @Passed WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate1;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Failed", DBNull.Value);
                    cmd.Parameters.AddWithValue("@Passed", DBNull.Value);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                }
                else if (e.NewValues["Status"].ToString() == "OMCCLE")
                {
                    const string strUpdate =
                        "UPDATE SafetySecurity_C SET Passed = @Passed, PassedTime = @PassedTime, Passer = @Passer, TruckAvailability = @TruckAvailability WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Passed", true);
                    cmd.Parameters.AddWithValue("@PassedTime", cusTime);
                    cmd.Parameters.AddWithValue("@Passer", named);
                    cmd.Parameters.AddWithValue("@TruckAvailability", true);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    const string strUpdate1 = "Update SafetySecurity_C set Passed = @Passed WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate1;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Passed", true);
                    cmd.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                    cmd.Connection = con;
                    cmd.ExecuteNonQuery();
                }


                myCommand.Parameters.AddWithValue("@QueueID", e.NewValues["QueueID"]);
                myCommand.ExecuteNonQuery();
                myConnection.Close();
            }
        }

        protected void GridLocal_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                if (e.AffectedRows == 1)
                {
                    RowUpdated(e);
                }
            }
        }

        protected void GridExp_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.NewValues["StatusTime"] = DateTime.Now;
        }

        protected void GridLocal_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.NewValues["StatusTime"] = DateTime.Now;
        }
    }
}