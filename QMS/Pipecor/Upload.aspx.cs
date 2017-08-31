using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pipecor
{
    public partial class Pipecor_Upload : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ButtonExp_Click(object sender, EventArgs e)
        {
            var datestring = datepickerExport.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);

            if (dt < DateTime.Today)
            {
                lblmessageExp.Text = "You must choose a date in the future";
            }
            else
            {
                var connectionString = "";
                try
                {
                    if (FileUploadExp.HasFile)
                    {
                        if (ValidFile(FileUploadExp, "EXPORT"))
                        {
                            var fileName = Path.GetFileName(FileUploadExp.PostedFile.FileName);
                            var fileExtension = Path.GetExtension(FileUploadExp.PostedFile.FileName);
                            var fileLocation = Server.MapPath("~/App_Data/" + fileName);
                            FileUploadExp.SaveAs(fileLocation);

                            connectionString = UploadExcel(connectionString, fileExtension, fileLocation, "EXPORT");
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
        }

        protected void ButtonLoc_Click(object sender, EventArgs e)
        {
            var datestring = datepickerLocal.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);

            if (dt < DateTime.Today)
            {
                lblmessageLoc.Text = "You must choose a date in the future";
            }
            else
            {
                var connectionString = "";
                try
                {
                    if (FileUploadLoc.HasFile)
                    {
                        if (ValidFile(FileUploadLoc, "LOCAL"))
                        {
                            var fileName = Path.GetFileName(FileUploadLoc.PostedFile.FileName);
                            var fileExtension = Path.GetExtension(FileUploadLoc.PostedFile.FileName);
                            var fileLocation = Server.MapPath("~/App_Data/" + fileName);
                            FileUploadLoc.SaveAs(fileLocation);

                            connectionString = UploadExcel(connectionString, fileExtension, fileLocation, "LOCAL");
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
                    //lblmessageLoc.Text = ex.Message.ToString();
                }
            }
        }

        private string UploadExcel(string connectionString, string fileExtension, string fileLocation, string type)
        {
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
            cmd.CommandText = "SELECT * FROM [" + type + "$A3:J] WHERE F1 IS NOT NULL";
            dAdapter.SelectCommand = cmd;

            var dsbd = new DataSet();
            dAdapter.Fill(dsbd);

            var status = SaveIt(dsbd, type);
            if (status == 1)
            {
                if (type == "LOCAL")
                {
                    lblmessageLoc.Text = type + " Queue uploaded successfully.".ToUpper();
                }
                else if (type == "EXPORT")
                {
                    lblmessageExp.Text = type + " Queue uploaded successfully.".ToUpper();
                }
            }
            else
            {
                if (type == "LOCAL")
                {
                    lblmessageLoc.Text = "Upload Error.Please try again".ToUpper();
                }
                else if (type == "EXPORT")
                {
                    lblmessageExp.Text = "Upload Error.Please try again".ToUpper();
                }
            }
            con.Close();
            return connectionString;
        }

        private int SaveIt(DataSet objdatasetdto, string type)
        {
            //archive all the previous Local truck records
            var connection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

            var named = User.Identity.Name;
            var datestring = DateTime.Now.ToString();
            if (type == "EXPORT")
            {
                datestring = datepickerExport.Text;
            }
            else
            {
                datestring = datepickerLocal.Text;
            }

            var objcon = new SqlConnection(ConfigurationManager.ConnectionStrings["SecureConnectionString"].ToString());

            for (var i = 0; i < objdatasetdto.Tables[0].Rows.Count; i++)
            {
                var newQueueId = Guid.NewGuid().ToString();
                var statusTime = DateTime.Now;

                //reset shipper from name to code
                var shipperName =
                    objdatasetdto.Tables[0].Rows[i]["F2"].ToString().Replace(" ", ".").Replace(" ", ",").Trim();
                var shipperCode = Helper.getShipperCode(shipperName);

                //split registration and trailer
                var registrationField = objdatasetdto.Tables[0].Rows[i]["F3"].ToString().Trim();
                char[] delimiterChar = {'/'};
                var regSplit = registrationField.Split(delimiterChar, 2);
                var regSplitedCount = regSplit.Count();

                var registration = "";
                var trailer = "";

                if (regSplitedCount == 2)
                {
                    registration = regSplit[0];
                    trailer = regSplit[1];
                }
                else if (regSplitedCount == 1)
                {
                    registration = registrationField;
                    trailer = "";
                }

                var query =
                    "INSERT INTO NewQueue([Queue_No],[Shipper],[Registration],[Type],[LO_NO],[MSR],[MSP],[AGO],[KERO],[JET],[Status],[QueueID],[EnterName],[SetDate],[StatusTime],[DRIVER_NUMBER],[TRAILER_TEXT]) values('" +
                    objdatasetdto.Tables[0].Rows[i]["F1"].ToString().Trim() + "','" + shipperCode + "','" + registration +
                    "','" + type + "','" + objdatasetdto.Tables[0].Rows[i]["F4"] + "','0','" +
                    objdatasetdto.Tables[0].Rows[i]["F5"] + "','" + objdatasetdto.Tables[0].Rows[i]["F6"] + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F7"] + "','" + objdatasetdto.Tables[0].Rows[i]["F8"] +
                    "','SECTA','" + newQueueId + "','" + named + "','" + datestring + "','" + statusTime + "','" +
                    objdatasetdto.Tables[0].Rows[i]["F9"].ToString().Trim() + "','" + trailer + "');";
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

        private bool ValidFile(FileUpload FileUploadLoc, string type)
        {
            if (string.Compare(Path.GetExtension(FileUploadLoc.FileName), ".xlsx", true) != 0 &&
                string.Compare(Path.GetExtension(FileUploadLoc.FileName), ".xls", true) != 0)
            {
                if (type == "LOCAL")
                {
                    lblmessageLoc.Text = "You can only upload a valid Excel file(.xlsx, xls).".ToUpper();
                }
                else if (type == "EXPORT")
                {
                    lblmessageExp.Text = "You can only upload a valid Excel file(.xlsx, xls).".ToUpper();
                }
                return false;
            }
            return true;
        }
    }
}