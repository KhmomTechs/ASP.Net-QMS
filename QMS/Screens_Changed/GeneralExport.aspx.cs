using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.SqlServer.Dts.Runtime;

namespace Screens_Changed
{
    public partial class GeneralExport : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();

            var lblTimer = (Label) View.FindControl("lblTimer");
            Timer1.Interval = Convert.ToInt32(lblTimer.Text);
        }

        private void LED()
        {
            var app = new Application();
            var package = app.LoadPackage(@"F:\KPC Q-MS\SSIS Packages\Export.dtsx", null);

            //Excute Package

            var results = package.Execute();
        }

        private void GetLocal()
        {
            var deleteCalled = "DELETE FROM ExportCalled";

            using (var myConn = new SqlConnection(strConnection))
            {
                myConn.Open();
                var myExpComm = new SqlCommand(deleteCalled, myConn);
                myExpComm.ExecuteNonQuery();
                myConn.Close();
            }

            //Fill dataset from called table
            var adapterDb =
                new SqlDataAdapter(
                    "SELECT NewQueue.LO_NO, NewQueue.Registration, NewQueue.Queue_No FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_B ON NewQueue.QueueID = SafetySecurity_B.QueueID WHERE (SafetySecurity_B.Failed IS NULL) AND (NewQueue.Finished IS NULL) AND (Operations.Called = 'True') AND (Operations.Cleared IS NULL) AND (NewQueue.Archived IS NULL) AND (NewQueue.Status = 'CALLOD') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND (NewQueue.Type = 'Export') AND (NewQueue.EnterTime = '" +
                    DateTime.Now.Date + "') ORDER BY NewQueue.Queue_No", strConnection);
            var datasetDb = new DataSet();

            adapterDb.Fill(datasetDb);

            //Check integer status returned
            var newstatus = SaveCalled(datasetDb);
            if (newstatus == 1)
            {
            }
        }

        private int SaveLocal(DataSet objdatasetdto)
        {
            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                //access db
                var conn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;data source= F:\\LED\\Export\\Pop.mdb");
                if (conn.State == ConnectionState.Open)
                    conn.Close();
                conn.Open();
                var comm = new OleDbCommand();
                comm.CommandType = CommandType.Text;
                comm.Connection = conn;
                comm.CommandText = "INSERT INTO Called ([No], Registration, [LO_NO]) values (" +
                                   objdatasetdto.Tables[0].Rows[i]["Queue_No"] + ", '" +
                                   objdatasetdto.Tables[0].Rows[i]["Registration"] + "', " +
                                   objdatasetdto.Tables[0].Rows[i]["LO_NO"] + ")";
                comm.ExecuteNonQuery();
                comm.Cancel();
                comm.Dispose();
            }
            return 1;
        }

        private int SaveCalled(DataSet objdatasetdto)
        {
            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var query0 = "INSERT INTO ExportCalled([LO_NO],[Registration],[No]) values('" +
                             objdatasetdto.Tables[0].Rows[i]["LO_NO"] + "','" +
                             objdatasetdto.Tables[0].Rows[i]["Registration"] + "','" +
                             objdatasetdto.Tables[0].Rows[i]["Queue_No"] + "');";
                var objda0 = new SqlDataAdapter(query0, objcon);
                objcon.Open();
                objda0.SelectCommand.ExecuteNonQuery();
                objcon.Close();
            }
            return 1;
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            GridLocal.DataBind();
        }

        protected void GridLocal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[3].Text.Trim().Equals("CALLOD"))
                {
                    //e.Row.Cells[2].BackColor = System.Drawing.Color.CadetBlue;
                    //e.Row.BackColor = System.Drawing.Color.LightPink;

                    //show code
                    var shipper = e.Row.Cells[1].Text.Trim();
                    e.Row.Cells[1].Text = Helper.getShipper(shipper);
                    try
                    {
                        e.Row.ForeColor = Color.Green;
                        using (var conn = new SqlConnection(strConnection))
                        {
                            //string result = "SELECT STATUS FROM [dbo].[PS27orders] WHERE ORDER_NO = @id AND Shipper_Code = @shipper";
                            var result = "SELECT STATUS FROM [dbo].[PS27orders] WHERE ORDER_NO = @id";
                            var compareId = e.Row.Cells[7].Text.Trim();
                            var showresult = new SqlCommand(result, conn);
                            showresult.Parameters.AddWithValue("id", compareId);
                            //int shipperNo;
                            //showresult.Parameters.AddWithValue("shipper", (int.TryParse(shipper, out shipperNo) ? shipperNo : 0));

                            conn.Open();
                            var showing = showresult.ExecuteScalar().ToString();
                            var status = Convert.ToInt32(showing);

                            if (status == 1)
                            {
                                e.Row.Cells[3].Text = "ENTERING";
                            }
                            else if (status == 2)
                            {
                                e.Row.Cells[3].Text = "DISPATCHED";
                            }
                            else if (status == 3)
                            {
                                e.Row.Cells[3].Text = "VALIDATING";
                            }
                            else if (status == 4)
                            {
                                e.Row.Cells[3].Text = "WAITING TO LOAD";
                            }
                            else if (status == 5)
                            {
                                e.Row.Cells[3].Text = "LOADED";
                            }
                            else if (status == 6)
                            {
                                e.Row.Cells[3].Text = "CANCELLED";
                            }
                            else if (status == 7)
                            {
                                e.Row.Cells[3].Text = "LOADING AT BAY";
                            }
                            else if (status == 8)
                            {
                                e.Row.Cells[3].Text = "AUTHORIZED";
                            }
                            else if (status == null)
                            {
                                e.Row.Cells[3].Text = "";
                            }
                            else
                            {
                                e.Row.Cells[3].Text = showing;
                            }
                            conn.Close();
                        }
                    }
                    catch
                    {
                        e.Row.ForeColor = Color.Red;
                        e.Row.Cells[3].Text = "ENTER TO LOAD";
                    }
                }
                else
                {
                    using (var conn = new SqlConnection(strConnection))
                    {
                        //string shipper = "SELECT Shipper_Name FROM [dbo].[SAP_Shippers] WHERE Shipper_Code = @Scode";
                        var newStatus = "SELECT Status_Text FROM [dbo].[SAP_Order_Status] WHERE Status_Code = @Status";

                        //string compareShipper = e.Row.Cells[1].Text.Trim();
                        var compareStatus = e.Row.Cells[3].Text.Trim();

                        //SqlCommand showShipper = new SqlCommand(shipper, conn);
                        var showStatus = new SqlCommand(newStatus, conn);

                        //showShipper.Parameters.AddWithValue("Scode", compareShipper);
                        showStatus.Parameters.AddWithValue("Status", compareStatus);

                        conn.Open();
                        //object theShipper = showShipper.ExecuteScalar();
                        var theStatus = showStatus.ExecuteScalar();


                        //show code
                        var shipper = e.Row.Cells[1].Text.Trim();
                        e.Row.Cells[1].Text = Helper.getShipper(shipper);

                        //colours
                        if (e.Row.Cells[3].Text.Trim().Equals("SECTA"))
                        {
                            //e.Row.ForeColor = System.Drawing.Color.LightSkyBlue;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("CUST"))
                        {
                            e.Row.BackColor = Color.AntiqueWhite;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("SAFCON"))
                        {
                            e.Row.ForeColor = Color.Blue;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("QCCON"))
                        {
                            e.Row.ForeColor = Color.Blue;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("SECVE"))
                        {
                            e.Row.ForeColor = Color.Peru;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("SECCO"))
                        {
                            e.Row.ForeColor = Color.Blue;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STK"))
                        {
                            e.Row.BackColor = Color.Orange;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("DISPATCH"))
                        {
                            e.Row.BackColor = Color.LightSeaGreen;
                            e.Row.ForeColor = Color.White;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("SAFTY"))
                        {
                            e.Row.ForeColor = Color.OrangeRed;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("OMCCLE"))
                        {
                            e.Row.BackColor = Color.Yellow;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("LODCLE"))
                        {
                            e.Row.BackColor = Color.YellowGreen;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKDEC"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKNEN"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKNO"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKNPR"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKCON"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKORIG"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKWV"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKKRA"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("STKNOSIG"))
                        {
                            e.Row.BackColor = Color.Wheat;
                        }
                        else if (e.Row.Cells[3].Text.Trim().Equals("QC"))
                        {
                            e.Row.ForeColor = Color.Chocolate;
                            e.Row.BackColor = Color.White;
                        }

                        //status
                        if (theStatus != null)
                        {
                            e.Row.Cells[3].Text = theStatus.ToString();
                        }

                        conn.Close();


                        //get unauthorised

                        var serial = "SELECT SERIAL_NUMBER FROM [dbo].[PS27orders] WHERE ORDER_NO = @id";
                        var result =
                            "SELECT STATUS FROM [dbo].[PS27orders] WHERE ORDER_NO = @id AND Shipper_Code = @shipper";
                        var compareId = e.Row.Cells[7].Text.Trim();
                        var showresult = new SqlCommand(result, conn);
                        var showserial = new SqlCommand(serial, conn);
                        showresult.Parameters.AddWithValue("id", compareId);
                        showserial.Parameters.AddWithValue("id", compareId);

                        int shipperNo;
                        showresult.Parameters.AddWithValue("shipper",
                            int.TryParse(shipper, out shipperNo) ? shipperNo : 0);

                        conn.Open();
                        try
                        {
                            var showing = showresult.ExecuteScalar();
                            var serialized = showserial.ExecuteScalar();

                            if (showing != null || serialized != null)
                            {
                                var status = Convert.ToInt32(showing.ToString());

                                if (status == 0 || status == 1 || status == 2 || status == 3 || status == 4 ||
                                    status == 5 || status == 6 || status == 7 || status == 8)
                                {
                                    if (serialized.ToString().ToUpper().Trim() == e.Row.Cells[2].Text.ToUpper().Trim())
                                    {
                                        e.Row.BackColor = Color.Red;
                                        e.Row.ForeColor = Color.White;

                                        e.Row.Cells[3].Text = "UNAUTHORIZED";
                                    }
                                }
                            }
                        }
                        catch
                        {
                        }
                        conn.Close();
                    }
                }

                //check suspension
                if (e.Row.Cells[8].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[3].Text = "SUSPENDED";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }

                //check withdrawal
                if (e.Row.Cells[10].Text.Trim().Equals("True"))
                {
                    e.Row.Cells[3].Text = "WITHDRAWN";
                    e.Row.ForeColor = Color.White;
                    e.Row.BackColor = Color.DimGray;
                }

                //get product MSP
                int MSP;
                int MSPB;
                int AGO;
                int AGOB;
                int KERO;
                int JET;

                if (e.Row.Cells[11].Text != null && int.TryParse(e.Row.Cells[11].Text, out MSP))
                {
                    if (MSP > 0)
                    {
                        e.Row.Cells[4].Text = "MSP";
                    }
                }
                if (e.Row.Cells[12].Text != null && int.TryParse(e.Row.Cells[12].Text, out MSPB))
                {
                    if (MSPB > 0)
                    {
                        e.Row.Cells[4].Text = "MSPB";
                    }
                }
                if (e.Row.Cells[13].Text != null && int.TryParse(e.Row.Cells[13].Text, out AGO))
                {
                    if (AGO > 0)
                    {
                        e.Row.Cells[4].Text = "AGO";
                    }
                }
                if (e.Row.Cells[14].Text != null && int.TryParse(e.Row.Cells[14].Text, out AGOB))
                {
                    if (AGOB > 0)
                    {
                        e.Row.Cells[4].Text = "AGOB";
                    }
                }
                if (e.Row.Cells[15].Text != null && int.TryParse(e.Row.Cells[15].Text, out KERO))
                {
                    if (KERO > 0)
                    {
                        e.Row.Cells[4].Text = "IK";
                    }
                }
                if (e.Row.Cells[16].Text != null && int.TryParse(e.Row.Cells[16].Text, out JET))
                {
                    if (JET > 0)
                    {
                        e.Row.Cells[4].Text = "JET";
                    }
                }

                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Left;
            }
        }

        protected void GridLocal_Sorted(object sender, EventArgs e)
        {
            ViewState["PageIndex"] = null;
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            GetLocal();
            //LED();
            GridViewMovePage();
        }

        protected void GridViewMovePage()
        {
            var PageCount = GridLocal.PageCount;
            var PageIndex = 0;
            if (ViewState["PageIndex"] != null)
            {
                PageIndex = (int) ViewState["PageIndex"];
            }
            PageIndex += 1;
            if (PageIndex == PageCount)
            {
                PageIndex = 0;
            }
            ViewState["PageIndex"] = PageIndex;
            GridLocal.PageIndex = PageIndex;
        }
    }
}