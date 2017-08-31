using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_Add : Page
    {
        private readonly string strConnection =
            ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ButtonExp_Click(object sender, EventArgs e)
        {
            var connectionString = "";
            try
            {
                if (FileUploadExp.HasFile)
                {
                    if (ValidExport(FileUploadExp))
                    {
                        var fileName = Path.GetFileName(FileUploadExp.PostedFile.FileName);
                        var fileExtension = Path.GetExtension(FileUploadExp.PostedFile.FileName);
                        var fileLocation = Server.MapPath("~/App_Data/" + fileName);
                        FileUploadExp.SaveAs(fileLocation);

                        //Check whether file extension is xls or xslx

                        if (fileExtension == ".xls")
                        {
                            connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileLocation +
                                               ";Extended Properties=\"Excel 8.0;HDR=NO;IMEX=2\"";
                        }
                        else if (fileExtension == ".xlsx")
                        {
                            connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation +
                                               ";Extended Properties=\"Excel 12.0;HDR=NO;IMEX=2\"";
                        }

                        //Create OleDB Connection and OleDb Command

                        var con = new OleDbConnection(connectionString);
                        var cmd = new OleDbCommand();
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        var dAdapter = new OleDbDataAdapter(cmd);
                        var dtExcelRecords = new DataTable();
                        con.Open();
                        var dtExcelSheetName = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                        var getExcelSheetName = dtExcelSheetName.Rows[0]["Table_Name"].ToString();
                        cmd.CommandText = "SELECT * FROM [EXPORT$A3:G] WHERE F1 IS NOT NULL";
                        dAdapter.SelectCommand = cmd;

                        var dsbd = new DataSet();
                        dAdapter.Fill(dsbd);

                        var status = SaveExport(dsbd);
                        if (status == 1)
                        {
                            GridExp.DataBind();

                            if (GridExp.Rows.Count >= 1)
                            {
                                //show grid results
                                lblmessageExp.Text = GridExp.Rows.Count + " Duplicates detected.";

                                var connectExp1 =
                                    ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
                                var deleteExport1 = "DELETE FROM ExportQueue";

                                using (var myExpConnection1 = new SqlConnection(connectExp1))
                                {
                                    myExpConnection1.Open();
                                    var myExpCommand1 = new SqlCommand(deleteExport1, myExpConnection1);
                                    myExpCommand1.ExecuteNonQuery();
                                    myExpConnection1.Close();
                                }
                            }
                            else
                            {
                                //Fill dataset from staging table
                                var adapterDb = new SqlDataAdapter("Select * FROM ExportQueue", strConnection);

                                var datasetDb = new DataSet();
                                adapterDb.Fill(datasetDb);

                                //Check integer status returned
                                var newstatus = SaveNewExport(datasetDb);
                                if (newstatus == 1)
                                {
                                    //Delete exportQueue

                                    var connectExp =
                                        ConfigurationManager.ConnectionStrings["SecureConnectionString"]
                                            .ConnectionString;
                                    var deleteExport = "DELETE FROM ExportQueue";

                                    using (var myExpConnection = new SqlConnection(connectExp))
                                    {
                                        myExpConnection.Open();
                                        var myExpCommand = new SqlCommand(deleteExport, myExpConnection);
                                        myExpCommand.ExecuteNonQuery();
                                        myExpConnection.Close();
                                    }

                                    lblmessageExp.Text = "Export Queue updated successfully.";
                                }
                            }
                        }
                        else
                        {
                            lblmessageExp.Text = "Upload Error.Please try again";
                        }
                        con.Close();
                    }
                }
                else
                {
                    lblmessageExp.Text = "Please select an Excel file to upload.";
                }
            }
            catch (Exception ex)
            {
                lblmessageExp.Text = "Invalid Excel document.";
            }
        }

        protected void ButtonLoc_Click(object sender, EventArgs e)
        {
            var connectionString = "";
            try
            {
                if (FileUploadLoc.HasFile)
                {
                    if (ValidExport(FileUploadLoc))
                    {
                        var fileName = Path.GetFileName(FileUploadLoc.PostedFile.FileName);
                        var fileExtension = Path.GetExtension(FileUploadLoc.PostedFile.FileName);
                        var fileLocation = Server.MapPath("~/App_Data/" + fileName);
                        FileUploadLoc.SaveAs(fileLocation);

                        //Check whether file extension is xls or xslx

                        if (fileExtension == ".xls")
                        {
                            connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + fileLocation +
                                               ";Extended Properties=\"Excel 8.0;HDR=NO;IMEX=2\"";
                        }
                        else if (fileExtension == ".xlsx")
                        {
                            connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + fileLocation +
                                               ";Extended Properties=\"Excel 12.0;HDR=NO;IMEX=2\"";
                        }

                        //Create OleDB Connection and OleDb Command

                        var con = new OleDbConnection(connectionString);
                        var cmd = new OleDbCommand();
                        cmd.CommandType = CommandType.Text;
                        cmd.Connection = con;
                        var dAdapter = new OleDbDataAdapter(cmd);
                        var dtExcelRecords = new DataTable();
                        con.Open();
                        var dtExcelSheetName = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                        var getExcelSheetName = dtExcelSheetName.Rows[0]["Table_Name"].ToString();
                        cmd.CommandText = "SELECT * FROM [LOCAL$A3:H] WHERE F1 IS NOT NULL";
                        dAdapter.SelectCommand = cmd;

                        var dsbd = new DataSet();
                        dAdapter.Fill(dsbd);

                        var status = SaveLocal(dsbd);
                        if (status == 1)
                        {
                            GridLocal.DataBind();

                            if (GridLocal.Rows.Count >= 1)
                            {
                                //show grid results
                                lblmessageLoc.Text = GridLocal.Rows.Count + " Duplicates detected.";

                                var connectLoc1 =
                                    ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
                                var deleteLocal1 = "DELETE FROM LocalQueue";

                                using (var myLocConnection1 = new SqlConnection(connectLoc1))
                                {
                                    myLocConnection1.Open();
                                    var myLocCommand1 = new SqlCommand(deleteLocal1, myLocConnection1);
                                    myLocCommand1.ExecuteNonQuery();
                                    myLocConnection1.Close();
                                }
                            }
                            else
                            {
                                //Fill dataset from staging table
                                var adapterDb = new SqlDataAdapter("Select * FROM LocalQueue", strConnection);

                                var datasetDb = new DataSet();
                                adapterDb.Fill(datasetDb);

                                //Check integer status returned
                                var newstatus = SaveNewLocal(datasetDb);
                                if (newstatus == 1)
                                {
                                    //Delete localQueue

                                    var connectLoc =
                                        ConfigurationManager.ConnectionStrings["SecureConnectionString"]
                                            .ConnectionString;
                                    var deleteLocal = "DELETE FROM LocalQueue";

                                    using (var myLocConnection = new SqlConnection(connectLoc))
                                    {
                                        myLocConnection.Open();
                                        var myLocCommand = new SqlCommand(deleteLocal, myLocConnection);
                                        myLocCommand.ExecuteNonQuery();
                                        myLocConnection.Close();
                                    }

                                    lblmessageLoc.Text = "Local Queue updated successfully.";
                                }
                            }
                        }
                        else
                        {
                            lblmessageLoc.Text = "Upload Error.Please try again";
                        }
                        con.Close();
                    }
                }
                else
                {
                    lblmessageLoc.Text = "Please select an Excel file to upload.";
                }
            }
            catch (Exception ex)
            {
                lblmessageLoc.Text = "Invalid Excel document.";
            }
        }

        private int SaveNewLocal(DataSet objdatasetdto)
        {
            //get userId and name who is uploading excel
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            var named = User.Identity.Name;


            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            //Insert unique ids to all tables to establish relationship 
            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Today;

                var query =
                    "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[MSP],[AGO],[KERO],[Comment],[Status],[UserId],[QueueID],[EnterName],[SetDate],[StatusTime]) values('" +
                    objdatasetdto.Tables[0].Rows[i]["Queue_No"] + "','" + objdatasetdto.Tables[0].Rows[i]["Shipper"] +
                    "','" + objdatasetdto.Tables[0].Rows[i]["Registration"] + "','Local','" +
                    objdatasetdto.Tables[0].Rows[i]["LO_NO"] + "','" + objdatasetdto.Tables[0].Rows[i]["MSP"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["AGO"] + "','" + objdatasetdto.Tables[0].Rows[i]["KERO"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["COMMENT"] + "','SECTA','" + currentUserId + "','" + newQueueId +
                    "','" + named + "','" + statusTime + "','" + statusTime + "');";
                var objda = new SqlDataAdapter(query, objcon);
                objcon.Open();
                objda.SelectCommand.ExecuteNonQuery();
                objcon.Close();

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
            return 1;
        }

        private int SaveNewExport(DataSet objdatasetdto)
        {
            //get userId and name who is uploading excel
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;
            var named = User.Identity.Name;


            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            //Insert unique ids to all tables to establish relationship 
            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Today;

                var query =
                    "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[Product],[Quantity],[Comment],[Status],[UserId],[QueueID],[EnterName],[SetDate],[StatusTime]) values('" +
                    objdatasetdto.Tables[0].Rows[i]["Queue_No"] + "','" + objdatasetdto.Tables[0].Rows[i]["Shipper"] +
                    "','" + objdatasetdto.Tables[0].Rows[i]["Registration"] + "','Export','" +
                    objdatasetdto.Tables[0].Rows[i]["LO_NO"] + "','" + objdatasetdto.Tables[0].Rows[i]["Product"] +
                    "','" + objdatasetdto.Tables[0].Rows[i]["Quantity"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["COMMENT"] + "','SECTA','" + currentUserId + "','" + newQueueId +
                    "','" + named + "','" + statusTime + "','" + statusTime + "');";
                var objda = new SqlDataAdapter(query, objcon);
                objcon.Open();
                objda.SelectCommand.ExecuteNonQuery();
                objcon.Close();

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
            return 1;
        }

        private int SaveExport(DataSet objdatasetdto)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;

            var named = User.Identity.Name;
            var masterId = Guid.NewGuid().ToString();


            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Now;

                var query =
                    "INSERT INTO ExportQueue([Queue_No],[Shipper],[Registration],[LO_NO],[Product],[Quantity],[Comment]) values('" +
                    objdatasetdto.Tables[0].Rows[i]["F1"] + "','" + objdatasetdto.Tables[0].Rows[i]["F2"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F3"] + "','" + objdatasetdto.Tables[0].Rows[i]["F4"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F5"] + "','" + objdatasetdto.Tables[0].Rows[i]["F6"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F7"] + "');";
                var objda = new SqlDataAdapter(query, objcon);
                objcon.Open();
                objda.SelectCommand.ExecuteNonQuery();
                objcon.Close();
            }
            return 1;
        }

        private int SaveLocal(DataSet objdatasetdto)
        {
            var currentUser = Membership.GetUser();
            var currentUserId = (Guid) currentUser.ProviderUserKey;

            var named = User.Identity.Name;
            var masterId = Guid.NewGuid().ToString();

            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Now;

                var query =
                    "INSERT INTO LocalQueue([Queue_No],[Shipper],[Registration],[LO_NO],[MSP],[AGO],[KERO],[Comment]) values('" +
                    objdatasetdto.Tables[0].Rows[i]["F1"] + "','" + objdatasetdto.Tables[0].Rows[i]["F2"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F3"] + "','" + objdatasetdto.Tables[0].Rows[i]["F4"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F5"] + "','" + objdatasetdto.Tables[0].Rows[i]["F6"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F7"] + "','" + objdatasetdto.Tables[0].Rows[i]["F8"] + "');";
                var objda = new SqlDataAdapter(query, objcon);
                objcon.Open();
                objda.SelectCommand.ExecuteNonQuery();
                objcon.Close();
            }
            return 1;
        }

        private bool ValidExport(FileUpload FileUploadExp)
        {
            if (string.Compare(Path.GetExtension(FileUploadExp.FileName), ".xlsx", true) != 0 &&
                string.Compare(Path.GetExtension(FileUploadExp.FileName), ".xls", true) != 0)
            {
                lblmessageLoc.Text = "You can only upload a valid Excel file(.xlsx, xls).";
                return false;
            }
            return true;
        }

        private bool ValidLocal(FileUpload FileUploadLoc)
        {
            if (string.Compare(Path.GetExtension(FileUploadLoc.FileName), ".xlsx", true) != 0 &&
                string.Compare(Path.GetExtension(FileUploadLoc.FileName), ".xls", true) != 0)
            {
                lblmessageLoc.Text = "You can only upload a valid Excel file(.xlsx, xls).";
                return false;
            }
            return true;
        }
    }
}