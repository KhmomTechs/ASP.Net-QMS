using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_SAP_New : Page
    {
        private readonly SqlConnection objcon =
            new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            QueueView();
            SqlExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            SqlLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();

            TotalExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            TotalLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
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
            GridLocal.DataBind();
            GridExp.DataBind();
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

        protected void Grid_LocalRowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowDataBound(e, "local");
        }

        protected void Grid_ExportRowDataBound(object sender, GridViewRowEventArgs e)
        {
            RowDataBound(e, "export");
        }

        protected void btnLocalQueue_Click(object sender, EventArgs e)
        {
            var total = GridTotalLocal.Rows.Count;
            QueueOrder(sender, "local", total);
        }

        protected void btnExportQueue_Click(object sender, EventArgs e)
        {
            var total = GridTotalExport.Rows.Count;
            QueueOrder(sender, "export", total);
        }

        private void QueueOrder(object sender, string type, int total)
        {
            if (IsPostBack)
            {
                var conSAP = new SqlConnection(strConnection);
                var cmd = new SqlCommand();

                var btnQueue = (Button) sender;
                var grdRow = (GridViewRow) btnQueue.NamingContainer;

                var lblSAPid = (Label) grdRow.FindControl("SAP_ID");
                var Shipper = (Label) grdRow.FindControl("SHIPPER");
                var Registration = (Label) grdRow.FindControl("REGISTRATION");
                var LO_NO = (Label) grdRow.FindControl("LONO");
                var MSP = (Label) grdRow.FindControl("MSP");
                var AGO = (Label) grdRow.FindControl("AGO");
                var KERO = (Label) grdRow.FindControl("KERO");
                var JET = (Label) grdRow.FindControl("JET");

                var DrNo = (Label) grdRow.FindControl("DRIVER_NUMBER");
                var TrailerNo = (Label) grdRow.FindControl("TRAILER_TEXT");
                //TextBox txtNo = (TextBox)grdRow.FindControl("txtNo");
                total = total + 1;

                var named = User.Identity.Name;

                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Now;
                var setDate = DateTime.Today;

                try
                {
                    var query =
                        "INSERT INTO NewQueue([SAP_Request_No],[Queue_No],[Shipper],[Registration],[Type],[LO_NO],[MSP],[AGO],[KERO],[JET],[Status],[QueueID],[EnterName],[SetDate],[StatusTime],[DRIVER_NUMBER],[TRAILER_TEXT]) values('" +
                        lblSAPid.Text + "','" + total + "','" + Shipper.Text + "','" + Registration.Text + "','" + type +
                        "','" + LO_NO.Text + "','" + MSP.Text + "','" + AGO.Text + "','" + KERO.Text + "','" + JET.Text +
                        "','SECTA','" + newQueueId + "','" + named + "','" + setDate + "','" + statusTime + "','" +
                        DrNo.Text + "','" + TrailerNo.Text + "');";
                    var objda = new SqlDataAdapter(query, objcon);
                    objcon.Open();
                    objda.SelectCommand.ExecuteNonQuery();
                    objcon.Close();

                    //add unique guid to all tables
                    AddGuidToTables(newQueueId);

                    //then sap status
                    UpdateSAP(conSAP, cmd, lblSAPid);
                }
                catch (SqlException ex)
                {
                    var errorMsg = "Error in Updation";
                    errorMsg += ex.Message;
                    throw new Exception(errorMsg);
                }
                finally
                {
                    conSAP.Close();

                    GridLocal.DataBind();
                    GridExp.DataBind();
                }
            }
        }

        private void AddGuidToTables(string newQueueId)
        {
            var query0 = "INSERT INTO CustomerCare([QueueID]) values('" + newQueueId + "');";
            var objda0 = new SqlDataAdapter(query0, objcon);
            objcon.Open();
            objda0.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query1 = "INSERT INTO SafetySecurity_A([QueueID]) values('" + newQueueId + "');";
            var objda1 = new SqlDataAdapter(query1, objcon);
            objcon.Open();
            objda1.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query2 = "INSERT INTO SafetySecurity_B([QueueID]) values('" + newQueueId + "');";
            var objda2 = new SqlDataAdapter(query2, objcon);
            objcon.Open();
            objda2.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query3 = "INSERT INTO SafetySecurity_C([QueueID]) values('" + newQueueId + "');";
            var objda3 = new SqlDataAdapter(query3, objcon);
            objcon.Open();
            objda3.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query4 = "INSERT INTO Operations([QueueID]) values('" + newQueueId + "');";
            var objda4 = new SqlDataAdapter(query4, objcon);
            objcon.Open();
            objda4.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query5 = "INSERT INTO KRA([QueueID]) values('" + newQueueId + "');";
            var objda5 = new SqlDataAdapter(query5, objcon);
            objcon.Open();
            objda5.SelectCommand.ExecuteNonQuery();
            objcon.Close();

            var query6 = "INSERT INTO StockControl([QueueID]) values('" + newQueueId + "');";
            var objda6 = new SqlDataAdapter(query6, objcon);
            objcon.Open();
            objda6.SelectCommand.ExecuteNonQuery();
            objcon.Close();
        }

        private static void UpdateSAP(SqlConnection conSAP, SqlCommand cmd, Label lblSAPid)
        {
            const string sapUpdate =
                "UPDATE SAP_Orders SET Status = @Status, Last_Change_Date = @Last_Change_Date WHERE SAP_Request_No = @SAP_Request_No";
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = sapUpdate;
            cmd.Parameters.Clear();
            cmd.Parameters.AddWithValue("@Status", "RQUED");
            cmd.Parameters.AddWithValue("@Last_Change_Date", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@SAP_Request_No", lblSAPid.Text);
            cmd.Connection = conSAP;
            conSAP.Open();
            cmd.ExecuteNonQuery();
        }

        private void RowDataBound(GridViewRowEventArgs e, string type)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //split kra string
                var kraNo = string.Empty;
                if (e.Row.Cells[8].Text != string.Empty)
                {
                    kraNo = e.Row.Cells[8].Text.Replace("~", "<br />");
                }

                e.Row.Cells[8].Text = kraNo;


                //disable rejected
                var rejected = e.Row.Cells[14].Text;

                if (rejected == true.ToString() || rejected == "True" || rejected == "1")
                {
                    e.Row.Cells[10].Enabled = false;
                }
                else
                {
                    e.Row.Cells[10].Enabled = true;
                }


                var theShipper = e.Row.Cells[1].Text;
                e.Row.Cells[1].Text = Helper.getShipper(theShipper);

                //align
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[9].HorizontalAlign = HorizontalAlign.Center;

                //top
                e.Row.VerticalAlign = VerticalAlign.Top;
            }
        }

        protected void ChkLocalReject_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ChkReject = (CheckBox) sender;
                var grdRow = (GridViewRow) ChkReject.NamingContainer;

                var lblID = (Label) grdRow.FindControl("SAP_ID");

                RejectTruck(con, conQueue, cmd, ChkReject, lblID);

                //update grid
                GridLocal.DataBind();
            }
        }

        protected void ChkExportReject_CheckedChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var strSql = new StringBuilder(string.Empty);
                var con = new SqlConnection(strConnection);
                var conQueue = new SqlConnection(strConnection);
                var cmd = new SqlCommand();


                var ChkReject = (CheckBox) sender;
                var grdRow = (GridViewRow) ChkReject.NamingContainer;

                var lblID = (Label) grdRow.FindControl("SAP_ID");

                RejectTruck(con, conQueue, cmd, ChkReject, lblID);

                //update grid
                GridExp.DataBind();
            }
        }

        private static void RejectTruck(SqlConnection con, SqlConnection conQueue, SqlCommand cmd, CheckBox ChkReject,
            Label lblID)
        {
            //save
            try
            {
                const string strUpdate =
                    "Update SAP_Orders set Rejected = @Rejected, Last_Change_Date = @Last_Change_Date WHERE SAP_Request_No = @SAP_Request_No";
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strUpdate;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Rejected", ChkReject.Checked);
                cmd.Parameters.AddWithValue("@Last_Change_Date", DateTime.Now.ToString());
                cmd.Parameters.AddWithValue("@SAP_Request_No", lblID.Text);
                cmd.Connection = con;
                con.Open();
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
            }
        }
    }
}