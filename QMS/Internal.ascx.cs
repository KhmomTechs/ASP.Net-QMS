using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Internal : UserControl
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
        RowDatabound(e);
    }

    protected void GridExp_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        RowDatabound(e);
    }

    private void RowDatabound(GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[8].Text.Trim().Equals("CALLOD"))
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
                        //string result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id AND Shipper_Code = @shipper";
                        var result = "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                        var compareId = e.Row.Cells[3].Text.Trim();
                        var showresult = new SqlCommand(result, conn);
                        showresult.Parameters.AddWithValue("id", compareId);
                        //int shipperNo;
                        //showresult.Parameters.AddWithValue("shipper", (int.TryParse(shipper, out shipperNo) ? shipperNo : 0));
                        conn.Open();
                        var showing = showresult.ExecuteScalar().ToString();
                        var status = Convert.ToInt32(showing);

                        if (status == 1)
                        {
                            e.Row.Cells[8].Text = "ENTERING";
                        }
                        else if (status == 2)
                        {
                            e.Row.Cells[8].Text = "DISPATCHED";
                        }
                        else if (status == 3)
                        {
                            e.Row.Cells[8].Text = "VALIDATING";
                        }
                        else if (status == 4)
                        {
                            e.Row.Cells[8].Text = "WAITING TO LOAD";
                        }
                        else if (status == 5)
                        {
                            e.Row.Cells[8].Text = "LOADED";

                            var updateSql = "UPDATE NewQueue SET Loaded = @Loaded WHERE QueueID = @QueueID";
                            using (var myConnection = new SqlConnection(strConnection))
                            {
                                myConnection.Open();
                                var myCommand = new SqlCommand(updateSql, myConnection);
                                myCommand.Parameters.AddWithValue("@Loaded", true);
                                myCommand.Parameters.AddWithValue("@QueueID", e.Row.Cells[13].Text);
                                myCommand.ExecuteNonQuery();
                                myConnection.Close();
                            }
                        }
                        else if (status == 6)
                        {
                            e.Row.Cells[8].Text = "CANCELLED";
                        }
                        else if (status == 7)
                        {
                            e.Row.Cells[8].Text = "LOADING AT BAY";
                        }
                        else if (status == 8)
                        {
                            e.Row.Cells[8].Text = "AUTHORIZED";
                        }
                        else if (status == null)
                        {
                            e.Row.Cells[8].Text = "";
                        }
                        else
                        {
                            e.Row.Cells[8].Text = showing;
                        }
                        conn.Close();
                    }
                }
                catch
                {
                    e.Row.ForeColor = Color.Red;
                    e.Row.Cells[8].Text = "ENTER TO LOAD";
                }
            }
            else
            {
                using (var conn = new SqlConnection(strConnection))
                {
                    var newStatus = "SELECT Status_Text FROM [dbo].[SAP_Order_Status] WHERE Status_Code = @Status";
                    var compareStatus = e.Row.Cells[8].Text.Trim();
                    var showStatus = new SqlCommand(newStatus, conn);
                    showStatus.Parameters.AddWithValue("Status", compareStatus);

                    conn.Open();
                    var theStatus = showStatus.ExecuteScalar();

                    //show code
                    var shipper = e.Row.Cells[1].Text.Trim();
                    e.Row.Cells[1].Text = Helper.getShipper(shipper);


                    //colours
                    if (e.Row.Cells[8].Text.Trim().Equals("SECTA"))
                    {
                        //e.Row.ForeColor = System.Drawing.Color.LightSkyBlue;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("CUST"))
                    {
                        e.Row.BackColor = Color.AntiqueWhite;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("SAFCON"))
                    {
                        e.Row.ForeColor = Color.Blue;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("SECVE"))
                    {
                        e.Row.ForeColor = Color.Peru;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("SECCO"))
                    {
                        e.Row.ForeColor = Color.Blue;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STK"))
                    {
                        e.Row.BackColor = Color.Orange;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("DISPATCH"))
                    {
                        e.Row.BackColor = Color.LightSeaGreen;
                        e.Row.ForeColor = Color.White;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("SAFTY"))
                    {
                        e.Row.ForeColor = Color.OrangeRed;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("OMCCLE"))
                    {
                        e.Row.BackColor = Color.Yellow;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("LODCLE"))
                    {
                        e.Row.BackColor = Color.YellowGreen;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKDEC"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKNEN"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKNO"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKNPR"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKCON"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKORIG"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKWV"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKKRA"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }
                    else if (e.Row.Cells[8].Text.Trim().Equals("STKNOSIG"))
                    {
                        e.Row.BackColor = Color.Wheat;
                    }


                    //status
                    if (theStatus != null)
                    {
                        e.Row.Cells[8].Text = theStatus.ToString();
                    }

                    conn.Close();


                    //get unauthorised

                    var serial = "SELECT SERIAL_NUMBER FROM [dbo].[PS28orders] WHERE ORDER_NO = @id";
                    var result =
                        "SELECT STATUS FROM [dbo].[PS28orders] WHERE ORDER_NO = @id AND Shipper_Code = @shipper";
                    var compareId = e.Row.Cells[3].Text.Trim();
                    var showresult = new SqlCommand(result, conn);
                    var showserial = new SqlCommand(serial, conn);
                    showresult.Parameters.AddWithValue("id", compareId);
                    int shipperNo;
                    showresult.Parameters.AddWithValue("shipper", int.TryParse(shipper, out shipperNo) ? shipperNo : 0);
                    showserial.Parameters.AddWithValue("id", compareId);

                    conn.Open();
                    try
                    {
                        var showing = showresult.ExecuteScalar();
                        var serialized = showserial.ExecuteScalar();

                        if (showing != null || serialized != null)
                        {
                            var status = Convert.ToInt32(showing.ToString());

                            if (status == 0 || status == 1 || status == 2 || status == 3 || status == 4 || status == 5 ||
                                status == 6 || status == 7 || status == 8)
                            {
                                if (serialized.ToString().ToUpper().Trim() == e.Row.Cells[2].Text.ToUpper().Trim())
                                {
                                    e.Row.BackColor = Color.Red;
                                    e.Row.ForeColor = Color.White;

                                    e.Row.Cells[8].Text = "UNAUTHORIZED";
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
            if (e.Row.Cells[11].Text.Trim().Equals("True"))
            {
                e.Row.Cells[8].Text = "SUSPENDED";
                e.Row.ForeColor = Color.White;
                e.Row.BackColor = Color.DimGray;
            }
            //check withdrawn
            if (e.Row.Cells[14].Text.Trim().Equals("True"))
            {
                e.Row.Cells[8].Text = "WITHDRAWN";
                e.Row.ForeColor = Color.White;
                e.Row.BackColor = Color.DimGray;
            }

            e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Left;
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
}