using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Web.Services.Protocols;
using System.Web.UI;
using System.Web.UI.WebControls;
using localhost;

namespace StockControl
{
    public partial class StockControl_Approval : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        private int totalItems;

        private decimal totalPrice;
        private decimal totalStock = 0M;

        protected void Page_Load(object sender, EventArgs e)
        {
            checkExpAll();
            checkLocAll();
            if (!Page.IsPostBack)
            {
                var con = new SqlConnection(strConnection);
                var com = "Select distinct NAME from QStock Order By NAME";
                var adpt = new SqlDataAdapter(com, con);
                var dt = new DataTable();
                adpt.Fill(dt);
                DropName.DataSource = dt;
                DropName.DataBind();
                DropName.DataTextField = "NAME";
                DropName.DataValueField = "NAME";
                DropName.DataBind();

                //check webservice
                var serviced =
                    Helper.IsServiceAvailable(
                        "http://172.16.5.94:50000/XMII/WSDLGen/KPC_UNGANISHA/QMS/Transactions/getStockEntitlementTrx");

                if (serviced == false)
                {
                    Analog.Visible = true;
                }
            }
            EntryLocSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
            EntryExpSource.SelectParameters["TheDate"].DefaultValue = DateTime.Today.ToString();
        }

        protected void AutoRefreshTimer_Tick(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                checkExpAll();
                checkLocAll();
            }
            if (!Page.IsPostBack)
            {
                checkExpAll();
                checkLocAll();
            }
            GridExpEntries.DataBind();
            GridLocEntries.DataBind();
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            var GridResult = (GridView) UpdatePanel1.FindControl("GridResult");
            var GridTotal = (GridView) UpdatePanel1.FindControl("GridTotal");
            if (Page.IsPostBack)
            {
                var con = new SqlConnection(strConnection);
                var cmd =
                    new SqlCommand(
                        "Select PRODUCT,VOLUME from QStock where NAME = '" + DropName.SelectedValue.Trim() + "'", con);
                var cmdT =
                    new SqlCommand(
                        "Select PRODUCT,VOLUME from QStock where NAME = '" + DropName.SelectedValue.Trim() + "'", con);
                //var result = cmd.ToString();
                var Adpt = new SqlDataAdapter(cmd);
                var AdpTotal = new SqlDataAdapter(cmdT);
                var dt = new DataTable();
                var dtotal = new DataTable();
                Adpt.Fill(dt);
                AdpTotal.Fill(dtotal);
                GridResult.DataSource = dt;
                GridResult.DataBind();
                GridTotal.DataSource = dtotal;
                GridTotal.DataBind();
                //LabelProduct.Text = "Volume:" + result;

                GridExpEntries.DataBind();
                GridLocEntries.DataBind();
            }
            checkExpAll();
            checkLocAll();
        }

        private void checkExpAll()
        {
            foreach (GridViewRow row in GridExpEntries.Rows)
            {
                var CheckExpApp = (Button) row.FindControl("CheckExpApp");
                CheckExpApp.Enabled = true;
                var DropEntExp = (DropDownList) row.FindControl("DropEntExp");

                DisableDropdown(CheckExpApp, DropEntExp);
            }
        }

        private void checkLocAll()
        {
            foreach (GridViewRow row in GridLocEntries.Rows)
            {
                var CheckLocApp = (Button) row.FindControl("CheckLocApp");
                CheckLocApp.Enabled = true;
                var DropEntLoc = (DropDownList) row.FindControl("DropEntLoc");

                DisableDropdown(CheckLocApp, DropEntLoc);
            }
        }

        private static void DisableDropdown(Button CheckBox, DropDownList DropDown)
        {
            if (DropDown.SelectedValue == "" || DropDown.SelectedValue == "STKNEN" || DropDown.SelectedValue == "STKDEC" ||
                DropDown.SelectedValue == "STKNPR" || DropDown.SelectedValue == "STKNO" ||
                DropDown.SelectedValue == "STKCON" || DropDown.SelectedValue == "STKORIG" ||
                DropDown.SelectedValue == "STKWV" || DropDown.SelectedValue == "STKKRA" ||
                DropDown.SelectedValue == "STKNOSIG")
            {
                CheckBox.Enabled = false;
            }
            else if (DropDown.SelectedValue == "STK")
            {
                CheckBox.Enabled = true;
            }
        }

        protected void DropEntExp_SelectedIndexChanged(object sender, EventArgs e)
        {
            var strSql = new StringBuilder(string.Empty);
            var con = new SqlConnection(strConnection);
            var conQueue = new SqlConnection(strConnection);
            var cmd = new SqlCommand();

            foreach (GridViewRow row in GridExpEntries.Rows)
            {
                for (var i = 0; i < GridExpEntries.Rows.Count; i++)
                {
                    var ChkEnt =
                        (GridExpEntries.Rows[i].Cells[10].FindControl("DropEntExp") as DropDownList).SelectedValue;
                    var strID = GridExpEntries.Rows[i].Cells[9].Text;

                    DropDownSave(con, conQueue, cmd, ChkEnt, strID);
                }
            }
            GridExpEntries.DataBind();
        }

        protected void DropEntLoc_SelectedIndexChanged(object sender, EventArgs e)
        {
            var strSql = new StringBuilder(string.Empty);
            var con = new SqlConnection(strConnection);
            var conQueue = new SqlConnection(strConnection);
            var cmd = new SqlCommand();

            foreach (GridViewRow row in GridLocEntries.Rows)
            {
                for (var i = 0; i < GridLocEntries.Rows.Count; i++)
                {
                    var ChkEnt =
                        (GridLocEntries.Rows[i].Cells[10].FindControl("DropEntLoc") as DropDownList).SelectedValue;
                    var strID = GridLocEntries.Rows[i].Cells[9].Text;

                    DropDownSave(con, conQueue, cmd, ChkEnt, strID);
                }
            }
            GridLocEntries.DataBind();
        }

        private static void DropDownSave(SqlConnection con, SqlConnection conQueue, SqlCommand cmd, string ChkEnt,
            string strID)
        {
            try
            {
                const string strQueueUpdate =
                    "Update NewQueue set Entitlement = @Entitlement, Status = @Status WHERE QueueID = @QueueID";
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strQueueUpdate;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Entitlement", ChkEnt);
                if (string.IsNullOrEmpty(ChkEnt))
                {
                    cmd.Parameters.AddWithValue("@Status", "STK");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Status", ChkEnt);
                }
                cmd.Parameters.AddWithValue("@QueueID", strID);
                cmd.Connection = conQueue;
                conQueue.Open();
                cmd.ExecuteNonQuery();
            }
            catch (SqlException)
            {
                var errorMsg = "Error in Updation";
                //errorMsg += ex.Message;
                throw new Exception(errorMsg);
            }
            finally
            {
                con.Close();
                conQueue.Close();
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
                var DropEntExp = (DropDownList) grdRow1.FindControl("DropLocExp");
                var lblID = (Label) grdRow1.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;

                ApproveOrder(con, conQueue, cmd, lblID, cusTime, named);

                GridLocEntries.DataBind();
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
                var DropEntExp = (DropDownList) grdRow.FindControl("DropEntExp");
                var lblID = (Label) grdRow.FindControl("Label1");

                var cusTime = DateTime.Now;
                var named = User.Identity.Name;

                ApproveOrder(con, conQueue, cmd, lblID, cusTime, named);

                GridExpEntries.DataBind();
            }
        }

        private static void ApproveOrder(SqlConnection con, SqlConnection conQueue, SqlCommand cmd, Label lblID,
            DateTime cusTime, string named)
        {
            try
            {
                const string strUpdate =
                    "Update StockControl set StControlApproval = @StControlApproval, StControlApprovalTime = @StControlApprovalTime, StControlApprover = @StControlApprover WHERE QueueID = @QueueID";
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strUpdate;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@StControlApproval", true);
                cmd.Parameters.AddWithValue("@StControlApprovalTime", cusTime);
                cmd.Parameters.AddWithValue("@StControlApprover", named);
                cmd.Parameters.AddWithValue("@QueueID", lblID.Text);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();

                const string strQueueUpdate =
                    "Update NewQueue set Status = @Status, StatusTime = @StatusTime WHERE QueueID = @QueueID";
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = strQueueUpdate;
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@Status", "DISPATCH");
                cmd.Parameters.AddWithValue("@StatusTime", cusTime);
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

        protected void GridExpEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridRowBound(e);
            }
        }

        protected void GridLocEntries_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridRowBound(e);
            }
        }

        private void GridRowBound(GridViewRowEventArgs e)
        {
            //show code
            var shipper = e.Row.Cells[2].Text;
            e.Row.Cells[2].Text = Helper.getShipper(shipper);

            //algn
            e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[10].HorizontalAlign = HorizontalAlign.Center;

            //disable approve button
            e.Row.Cells[0].Enabled = false;

            //enable button
            if (e.Row.Cells[13].Text == "STK")
            {
                e.Row.Cells[0].Enabled = true;
            }

            checkExpAll();
            checkLocAll();
        }

        protected void GridResult_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Right;
            }
        }

        protected void GridTotal_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var lblPrice = (Label) e.Row.FindControl("LabelVolume");
                var price = decimal.Parse(lblPrice.Text);

                totalPrice += price;
                totalItems += 1;
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                var lblTotalPrice = (Label) e.Row.FindControl("lblTotal");
                lblTotalPrice.Text = totalPrice.ToString();
            }
        }

        protected void CheckLocalStock_CheckedChanged(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    var CheckLocalStock = (CheckBox) sender;
                    var grdRow = (GridViewRow) CheckLocalStock.NamingContainer;
                    var ShipperCode = (Label) grdRow.FindControl("ShipperLbl");
                    var Sap_No = (Label) grdRow.FindControl("SAP_Request_No");
                    var Type = (Label) grdRow.FindControl("TypeLbl");

                    //stock values
                    var MSP = (Label) grdRow.FindControl("MSP");
                    var AGO = (Label) grdRow.FindControl("AGO");
                    var KERO = (Label) grdRow.FindControl("KERO");
                    var JET = (Label) grdRow.FindControl("JET");


                    if (CheckLocalStock.Checked)
                    {
                        WebService(grdRow, ShipperCode, Sap_No, MSP, AGO, KERO, JET, Type);
                    }
                    else
                    {
                        GridSAP.DataSource = null;
                        GridSAP.DataBind();
                    }
                }
                catch (SoapHeaderException ex)
                {
                    //Debug.WriteLine(ex.Message);
                    //LabelCatch.Text = ex.Message.ToString();
                }
            }
            //limit checks
            LimitCheck(sender, "CheckLocalStock", GridLocEntries);
        }

        protected void CheckExportStock_CheckedChanged(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    var CheckExportStock = (CheckBox) sender;
                    var grdRow = (GridViewRow) CheckExportStock.NamingContainer;
                    var ShipperCode = (Label) grdRow.FindControl("ShipperLbl");
                    var Sap_No = (Label) grdRow.FindControl("Duty_StatusLbl");
                    var Type = (Label) grdRow.FindControl("TypeLbl");

                    //stock values
                    var MSP = (Label) grdRow.FindControl("MSP");
                    var AGO = (Label) grdRow.FindControl("AGO");
                    var KERO = (Label) grdRow.FindControl("KERO");
                    var JET = (Label) grdRow.FindControl("JET");

                    if (CheckExportStock.Checked)
                    {
                        WebService(grdRow, ShipperCode, Sap_No, MSP, AGO, KERO, JET, Type);
                    }
                    else
                    {
                        GridSAP.DataSource = null;
                    }
                }
                catch (SoapHeaderException ex)
                {
                    //Debug.WriteLine(ex.Message);
                    //LabelCatch.Text = ex.Message.ToString();
                }
            }
            //limit checks
            LimitCheck(sender, "CheckExportStock", GridExpEntries);
        }

        private void WebService(GridViewRow grdRow, Label ShipperCode, Label Sap_No, Label MSP, Label AGO, Label KERO,
            Label JET, Label Type)
        {
            //get duty status using saqp request no
            var dtStatus = "";
            using (var conn = new SqlConnection(strConnection))
            {
                var result = "SELECT Duty_Status FROM [dbo].[SAP_Orders] WHERE SAP_Request_No = '" + Sap_No.Text.Trim() +
                             "' ";
                var showresult = new SqlCommand(result, conn);
                conn.Open();
                dtStatus = showresult.ExecuteScalar().ToString();
                conn.Close();
            }

            try
            {
                var service = new XacuteWS();

                //input parameters
                var parmeters = new InputParams();
                parmeters.DutyStatus = dtStatus.Trim();
                parmeters.MaterialType = Type.Text;
                parmeters.OMCCode = ShipperCode.Text.Trim();
                parmeters.Plant = "PS28";

                var stkInfo = service.Xacute("HTTPREMOTE", "MID2014$", parmeters);

                GridSAP.DataSource = stkInfo.Row.ToList();
                GridSAP.DataBind();

                //sap values                       
                var sapAGO =
                    stkInfo.Row.Where(x => x.Material == "N300301" && x.Plant == "PS28")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapMSP =
                    stkInfo.Row.Where(x => x.Material == "N300201" && x.Plant == "PS28")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapKERO =
                    stkInfo.Row.Where(x => x.Material == "N300501" && x.Plant == "PS28")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapJET =
                    stkInfo.Row.Where(x => x.Material == "N300701" && x.Plant == "PS28")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();

                var sapGlobalAGO =
                    stkInfo.Row.Where(x => x.Material == "N300301" && x.Plant == "Global")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapGlobalMSP =
                    stkInfo.Row.Where(x => x.Material == "N300201" && x.Plant == "Global")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapGlobalKERO =
                    stkInfo.Row.Where(x => x.Material == "N300501" && x.Plant == "Global")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();
                var sapGlobalJET =
                    stkInfo.Row.Where(x => x.Material == "N300701" && x.Plant == "Global")
                        .Select(x => x.Quantity)
                        .FirstOrDefault();

                //compare stock for eachproduct

                var GlobalAgo = true;
                var Ago = true;
                if (sapGlobalAGO != null && sapAGO != null)
                {
                    GlobalAgo = CompareStocks(AGO.Text, sapGlobalAGO);
                    Ago = CompareStocks(AGO.Text, sapAGO);
                    if (Ago)
                    {
                        grdRow.Cells[6].BackColor = Color.LightGreen;
                    }
                    else
                    {
                        if (GlobalAgo)
                        {
                            grdRow.Cells[6].BackColor = Color.Yellow;
                        }
                        else
                        {
                            grdRow.Cells[6].BackColor = Color.Red;
                        }
                    }
                }

                var GlobalMsp = true;
                var Msp = true;
                if (sapGlobalMSP != null && sapMSP != null)
                {
                    GlobalMsp = CompareStocks(MSP.Text, sapGlobalMSP);
                    Msp = CompareStocks(MSP.Text, sapMSP);
                    if (Msp)
                    {
                        grdRow.Cells[5].BackColor = Color.LightGreen;
                    }
                    else
                    {
                        if (GlobalMsp)
                        {
                            grdRow.Cells[5].BackColor = Color.Yellow;
                        }
                        else
                        {
                            grdRow.Cells[5].BackColor = Color.Red;
                        }
                    }
                }

                var GlobalKero = true;
                var Kero = true;
                if (sapGlobalKERO != null && sapKERO != null)
                {
                    GlobalKero = CompareStocks(KERO.Text, sapGlobalKERO);
                    Kero = CompareStocks(KERO.Text, sapKERO);
                    if (Kero)
                    {
                        grdRow.Cells[7].BackColor = Color.LightGreen;
                    }
                    else
                    {
                        if (GlobalKero)
                        {
                            grdRow.Cells[7].BackColor = Color.Yellow;
                        }
                        else
                        {
                            grdRow.Cells[7].BackColor = Color.Red;
                        }
                    }
                }

                var GlobalJet = true;
                var Jet = true;
                if (sapGlobalJET != null && sapJET != null)
                {
                    GlobalJet = CompareStocks(JET.Text, sapGlobalJET);
                    Jet = CompareStocks(JET.Text, sapJET);
                    if (Jet)
                    {
                        grdRow.Cells[8].BackColor = Color.LightGreen;
                    }
                    else
                    {
                        if (GlobalJet)
                        {
                            grdRow.Cells[8].BackColor = Color.Yellow;
                        }
                        else
                        {
                            grdRow.Cells[8].BackColor = Color.Red;
                        }
                    }
                }

                if (GlobalAgo == false || GlobalMsp == false || GlobalKero == false || GlobalJet == false)
                {
                    //disable approve button
                    grdRow.Cells[0].Enabled = false;

                    using (var conn = new SqlConnection(strConnection))
                    {
                        var queueQuery = "SELECT QueueID FROM [dbo].[NewQueue] WHERE SAP_Request_No = '" +
                                         Sap_No.Text.Trim() + "' ";
                        var showId = new SqlCommand(queueQuery, conn);
                        conn.Open();
                        var queueId = showId.ExecuteScalar().ToString();
                        conn.Close();

                        //update
                        var conQueue = new SqlConnection(strConnection);
                        var cmd = new SqlCommand();

                        const string strQueueUpdate =
                            "Update NewQueue set Entitlement = @Entitlement, Status = @Status WHERE QueueID = @QueueID";
                        cmd.CommandType = CommandType.Text;
                        cmd.CommandText = strQueueUpdate;
                        cmd.Parameters.Clear();
                        cmd.Parameters.AddWithValue("@Status", "STKNEN");
                        cmd.Parameters.AddWithValue("@Entitlement", "STKNEN");
                        cmd.Parameters.AddWithValue("@QueueID", queueId);
                        cmd.Connection = conQueue;
                        conQueue.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (SoapHeaderException exp)
            {
                GridSAP.EmptyDataText = exp.Message;
            }
        }

        private void LimitCheck(object sender, string chkBoxName, GridView Grid)
        {
            var chk = (CheckBox) sender;
            var gv = (GridViewRow) chk.NamingContainer;
            var rownumber = gv.RowIndex;

            if (chk.Checked)
            {
                int i;
                for (i = 0; i <= Grid.Rows.Count - 1; i++)
                {
                    if (i != rownumber)
                    {
                        var chkcheckbox = (CheckBox) Grid.Rows[i].FindControl(chkBoxName);
                        chkcheckbox.Checked = false;
                    }
                }
            }
        }

        protected void GridSAP_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //get name from code
                using (var conn = new SqlConnection(strConnection))
                {
                    var product = "SELECT Product_Name FROM [dbo].[SAP_Products] WHERE Product_Code = @Pcode";
                    var compareProduct = e.Row.Cells[0].Text.Trim();

                    var showProduct = new SqlCommand(product, conn);
                    showProduct.Parameters.AddWithValue("Pcode", compareProduct);

                    conn.Open();
                    var theProduct = showProduct.ExecuteScalar().ToString();

                    if (theProduct != string.Empty)
                    {
                        e.Row.Cells[0].Text = theProduct;
                    }

                    conn.Close();
                }

                ////display
                //int length = e.Row.Cells[1].Text.ToString().Length;
                //e.Row.Cells[1].Text = e.Row.Cells[1].Text.ToString().Remove(length - 4, 4);
            }
        }

        private static bool CompareStocks(string gridValue, string sapValue)
        {
            var GridStock = Convert.ToInt32(gridValue);
            var SapStock = Convert.ToInt32(sapValue);

            if (GridStock > SapStock)
            {
                //false meaning no enitlement
                return false;
            }
            //true for entitlement
            return true;
        }
    }
}