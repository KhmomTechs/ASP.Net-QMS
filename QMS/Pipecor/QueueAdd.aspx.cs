using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_QueueAdd : Page
    {
        private readonly SqlConnection objcon =
            new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            TotalExportSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            TotalLocalSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();

            var resulting = Request.QueryString["STATUS"];
            var qNo = Request.QueryString["NO"];
            var type = Request.QueryString["TYPE"];

            if (resulting == "ok")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                lblPopUp.Text = "<center>Order added successfully to " + type + " queue.</center>";
                lblHead.Visible = false;
                FormEdit.Visible = false;
            }
            else if (resulting == "err")
            {
                ClientScript.RegisterStartupScript(GetType(),
                    "startup", "<script type=\"text/javascript\">CheckTruck();</script>");

                lblPopUp.Text = "<center>Order not added.</center>Queue No:" + qNo + " already exists in " + type +
                                " queue.";
            }

            if (!Page.IsPostBack)
            {
                SetDropDown();
            }
        }

        private void SetDropDown()
        {
            var shipperList = (DropDownList) FormEdit.FindControl("ddlShipper");
            var driverList = (DropDownList) FormEdit.FindControl("ddlDriver");
            var con = new SqlConnection(strConnection);

            //shipper
            var comShipper = "Select Shipper_Name, Shipper_Code from SAP_Shippers Order By Shipper_Name";
            var adptShipper = new SqlDataAdapter(comShipper, con);
            var dtShipper = new DataTable();
            adptShipper.Fill(dtShipper);
            var rowShipper = dtShipper.NewRow();
            rowShipper["Shipper_Name"] = "";
            dtShipper.Rows.InsertAt(rowShipper, 0);
            shipperList.DataSource = dtShipper;
            shipperList.DataBind();
            shipperList.DataTextField = "Shipper_Name";
            shipperList.DataValueField = "Shipper_Code";
            shipperList.DataBind();

            //drivers
            var comDrivers = "Select DRIVER_NUMBER, NAME from PS28drivers Order By NAME";
            var adptDrivers = new SqlDataAdapter(comDrivers, con);
            var dtDrivers = new DataTable();
            adptDrivers.Fill(dtDrivers);
            var row = dtDrivers.NewRow();
            row["NAME"] = "";
            dtDrivers.Rows.InsertAt(row, 0);
            driverList.DataSource = dtDrivers;
            driverList.DataBind();
            driverList.DataTextField = "NAME";
            driverList.DataValueField = "DRIVER_NUMBER";
            driverList.DataBind();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                SetDropDown();
                FormEdit.DataBind();
            }
            if (!Page.IsPostBack)
            {
                SetDropDown();
                FormEdit.DataBind();
            }
        }

        protected void LocalBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                var localTotal = GridTotalLocal.Rows.Count;
                var exportTotal = GridTotalExport.Rows.Count;

                var typeList = (DropDownList) FormEdit.FindControl("ddlType");
                var shipperList = (DropDownList) FormEdit.FindControl("ddlShipper");
                var driverList = (DropDownList) FormEdit.FindControl("ddlDriver");
                var No = (TextBox) FormEdit.FindControl("Notxt");
                var EnterNo = Convert.ToInt32(No.Text);
                var totalNo = EnterNo;

                if (typeList.SelectedValue == "LOCAL")
                {
                    //if (totalNo > localTotal)
                    //{
                    QueueOrder(sender, "LOCAL", localTotal, shipperList.SelectedValue.Trim(),
                        driverList.SelectedValue.Trim());
                    //}
                    //else
                    //{
                    //    Response.Redirect("QueueAdd.aspx?status=err&no=" + EnterNo + "&type=local");
                    //}
                }
                else if (typeList.SelectedValue == "EXPORT")
                {
                    //if (totalNo > exportTotal)
                    //{
                    QueueOrder(sender, "EXPORT", exportTotal, shipperList.SelectedValue.Trim(),
                        driverList.SelectedValue.Trim());
                    //}
                    //else
                    //{
                    //    Response.Redirect("QueueAdd.aspx?status=err&no=" + EnterNo + "&type=export");
                    //}
                }

                Response.Redirect("QueueAdd.aspx?status=ok&type=" + typeList.SelectedValue.ToLower());
            }
        }

        private void QueueOrder(object sender, string type, int total, string shipperList, string driverList)
        {
            if (IsPostBack)
            {
                var conSAP = new SqlConnection(strConnection);
                var cmd = new SqlCommand();

                //Label lblSAPid = (Label)grdRow.FindControl("SAP_ID");

                var Registration = (TextBox) FormEdit.FindControl("RegistrationLocal");
                var LO_NO = (TextBox) FormEdit.FindControl("LONOLocal");
                var MSP = (TextBox) FormEdit.FindControl("MSPtxt");
                var AGO = (TextBox) FormEdit.FindControl("AGOtxt");
                var KERO = (TextBox) FormEdit.FindControl("KEROtxt");
                var JET = (TextBox) FormEdit.FindControl("JETtxt");
                var No = (TextBox) FormEdit.FindControl("Notxt");
                var TrailerNo = (TextBox) FormEdit.FindControl("TRAILER_TEXT");
                //TextBox txtNo = (TextBox)grdRow.FindControl("txtNo");
                total = total + 1;

                var named = User.Identity.Name;

                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Now;
                var setDate = DateTime.Today;

                try
                {
                    var query =
                        "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[MSP],[AGO],[KERO],[JET],[Status],[QueueID],[EnterName],[SetDate],[StatusTime],[DRIVER_NUMBER],[TRAILER_TEXT]) values('" +
                        No.Text + "','" + shipperList.Trim() + "','" + Registration.Text.ToUpper() + "','" + type +
                        "','" + LO_NO.Text.ToUpper() + "','" + MSP.Text + "','" + AGO.Text + "','" + KERO.Text + "','" +
                        JET.Text + "','SECTA','" + newQueueId + "','" + named + "','" + setDate + "','" + statusTime +
                        "','" + driverList + "','" + TrailerNo.Text.ToUpper() + "');";
                    var objda = new SqlDataAdapter(query, objcon);
                    objcon.Open();
                    objda.SelectCommand.ExecuteNonQuery();
                    objcon.Close();

                    //add unique guid to all tables
                    AddGuidToTables(newQueueId);

                    //then sap status
                    //UpdateSAP(conSAP, cmd, lblSAPid);
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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("QueueAdd.aspx");
        }
    }
}