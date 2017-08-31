using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Operations
{
    public partial class Operations_CallTrucks : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            QueueView();
            EntryExpSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            EntryLocSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        private void QueueView()
        {
            if (Request.QueryString["VIEW"] != null || Request.QueryString["VIEW"] != "")
            {
                var show = Request.QueryString["VIEW"];

                if (show == "local" || show == "Local")
                {
                    PanelLoc.Visible = true;
                    PanelExp.Visible = false;
                }
                else if (show == "export" || show == "Export")
                {
                    PanelLoc.Visible = false;
                    PanelExp.Visible = true;
                }
            }
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridLocEntries.DataBind();
            GridExpEntries.DataBind();

            if (IsPostBack)
            {
                QueueView();
            }
        }

        protected void CheckExpApp_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var CheckExpApp = (Button) sender;
                var grdRow = (GridViewRow) CheckExpApp.NamingContainer;
                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";


                try
                {
                    const string strUpdate =
                        "Update Operations set Called = @Called, CallTime = @CallTime, Caller = @Caller WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Called", true);
                    cmd.Parameters.AddWithValue("@CallTime", cusTime);
                    cmd.Parameters.AddWithValue("@Caller", named);
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    const string strQueueUpdate =
                        "Update NewQueue set StatusTime = @StatusTime, Status = @Status WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQueueUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@StatusTime", cusTime);
                    cmd.Parameters.AddWithValue("@Status", "SECVE");
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = conQueue;
                    conQueue.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    var errorMsg = "Error in Updation";
                    errorMsg += ex.Message;
                    throw new Exception(errorMsg);
                }
                finally
                {
                    con.Close();
                    conQueue.Close();

                    ClientScript.RegisterStartupScript(GetType(),
                        "startup", "<script type=\"text/javascript\">ReplyTruck();</script>");
                }
            }
        }

        protected void CheckLocApp_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();

                var ChecklocApp = (Button) sender;
                var grdRow1 = (GridViewRow) ChecklocApp.NamingContainer;
                var lblID = (Label) grdRow1.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;
                //string nothing = "";


                try
                {
                    const string strUpdate =
                        "Update Operations set Called = @Called, CallTime = @CallTime, Caller = @Caller WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@Called", true);
                    cmd.Parameters.AddWithValue("@CallTime", cusTime);
                    cmd.Parameters.AddWithValue("@Caller", named);
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = con;
                    con.Open();
                    cmd.ExecuteNonQuery();

                    const string strQueueUpdate =
                        "Update NewQueue set StatusTime = @StatusTime, Status = @Status WHERE QueueID = @QueueID";
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = strQueueUpdate;
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddWithValue("@StatusTime", cusTime);
                    cmd.Parameters.AddWithValue("@Status", "SECVE");
                    cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                    cmd.Connection = conQueue;
                    conQueue.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    var errorMsg = "Error in Updation";
                    errorMsg += ex.Message;
                    throw new Exception(errorMsg);
                }
                finally
                {
                    con.Close();
                    conQueue.Close();

                    var prompt = "<script>$(document).ready(function(){{$.prompt('{0}');}});</script>";
                    var message = string.Format(prompt, "Truck has been called to loading bay");
                    ClientScript.RegisterStartupScript(typeof(Page), "alert", message);
                }
            }
        }

        protected void LocSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("CallTrucks.aspx?view=local");
                PanelExp.Visible = false;
                PanelLoc.Visible = true;
            }
        }

        protected void ExpSwitchBtn_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Response.Redirect("CallTrucks.aspx?view=export");
                PanelExp.Visible = true;
                PanelLoc.Visible = false;
            }
        }

        protected void GridExpEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;

                //show code
                var shipper = e.Row.Cells[2].Text;
                e.Row.Cells[2].Text = Helper.getShipper(shipper);

                //check suspension
                if (e.Row.Cells[12].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[0].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
            }
        }

        protected void GridLocEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center;

                //show code
                var shipper = e.Row.Cells[2].Text;
                e.Row.Cells[2].Text = Helper.getShipper(shipper);

                //check suspension
                if (e.Row.Cells[12].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[0].Enabled = false;
                    //e.Row.Cells[7].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }
            }
        }
    }
}