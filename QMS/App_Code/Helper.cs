using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Net;

/// <summary>
///     Summary description for Helper
/// </summary>
public class Helper
{
    public static string getShipper(string code)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
        var sentShipper = code;
        var shipperName = string.Empty;
        if (code != string.Empty)
        {
            try
            {
                //get name from code
                using (var conn = new SqlConnection(strConnection))
                {
                    var shipper = "SELECT Shipper_Name FROM [dbo].[SAP_Shippers] WHERE Shipper_Code = @Scode";
                    var compareShipper = code.Trim();

                    var showShipper = new SqlCommand(shipper, conn);
                    showShipper.Parameters.AddWithValue("Scode", compareShipper);

                    conn.Open();
                    var theShipper = showShipper.ExecuteScalar();
                    //string theShipper = showShipper.

                    if (theShipper != null && theShipper != string.Empty && theShipper != "")
                    {
                        shipperName = theShipper.ToString();
                    }
                    else
                    {
                        shipperName = sentShipper;
                    }

                    conn.Close();
                }
            }
            catch
            {
                //shipperName = "No Shipper";
                shipperName = sentShipper;
            }
        }
        return shipperName;
    }

    public static string getShipperCode(string name)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        var shipperCode = string.Empty;
        var sentShipper = name;
        if (name != string.Empty)
        {
            try
            {
                //get code from name
                using (var conn = new SqlConnection(strConnection))
                {
                    var shipper = "SELECT Shipper_Code FROM [dbo].[SAP_Shippers] WHERE Shipper_Name = @Sname";
                    var compareShipper = name.Trim().ToUpper();

                    var showShipperCode = new SqlCommand(shipper, conn);
                    showShipperCode.Parameters.AddWithValue("Sname".ToUpper(), compareShipper);

                    conn.Open();
                    var theShipper = showShipperCode.ExecuteScalar();
                    //string theShipper = showShipper.

                    if (theShipper == null && theShipper == string.Empty && theShipper == "")
                    {
                        shipperCode = sentShipper;
                    }
                    else
                    {
                        shipperCode = theShipper.ToString();
                    }

                    conn.Close();
                }
            }
            catch
            {
                //show name if error occured

                shipperCode = sentShipper;

                //using (SqlConnection conn = new SqlConnection(strConnection))
                //{
                //    string shipper = "SELECT Shipper_Code FROM [dbo].[SAP_Shippers] WHERE Shipper_Name LIKE @Sname";
                //    string compareShipper = name.ToString().Trim();

                //    SqlCommand showShipperCode = new SqlCommand(shipper, conn);
                //    showShipperCode.Parameters.AddWithValue("Sname", compareShipper);

                //    conn.Open();
                //    object theShipper = showShipperCode.ExecuteScalar();
                //    //string theShipper = showShipper.

                //    if (theShipper != null)
                //    {
                //        shipperCode = theShipper.ToString();
                //    }

                //    conn.Close();
                //}
            }
        }
        return shipperCode;
    }

    public static string getDriver(string driverNo)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        var driverName = string.Empty;
        if (driverNo != string.Empty)
        {
            try
            {
                //get name from driver table
                using (var conn = new SqlConnection(strConnection))
                {
                    var driver = "SELECT NAME FROM [dbo].[PS28drivers] WHERE DRIVER_NUMBER = @Dcode";
                    var compareDriver = driverNo.Trim();

                    var showDriver = new SqlCommand(driver, conn);
                    showDriver.Parameters.AddWithValue("Dcode", compareDriver);

                    conn.Open();
                    var theDriver = showDriver.ExecuteScalar();
                    //string theShipper = showShipper.

                    if (theDriver != null)
                    {
                        driverName = theDriver.ToString();
                    }

                    conn.Close();
                }
            }
            catch
            {
                driverName = "";
            }
        }
        return driverName;
    }

    public static bool IsServiceAvailable(string address)
    {
        try
        {
            var client = new WebClient();
            client.DownloadData(address);
            return true;
        }
        catch
        {
            return false;
        }
    }

    public static string GetTimeAgo(object postedOn)
    {
        var currentDate = DateTime.Now;
        var postDate = Convert.ToDateTime(postedOn);

        var timegap = currentDate.Subtract(postDate);

        if (timegap.Days >= 7)
            return string.Concat("on ", postDate.ToString("MMMM d"));
        if (timegap.Days > 1)
            return string.Concat("", timegap.Days, " days ago");
        if (timegap.Days == 1)
            return "yesterday";
        if (timegap.Hours > 1)
            return string.Concat("", timegap.Hours, "hrs ago");
        if (timegap.Hours == 1)
            return string.Concat("", timegap.Hours, "hr ago");
        if (timegap.Minutes >= 1)
            return string.Concat("", timegap.Minutes, "min ago");
        return "";
    }

    public static void iisRestart()
    {
        var iisreset = new Process();

        iisreset.StartInfo.FileName = "iisreset.exe";
        iisreset.StartInfo.Arguments = "KPCQUEUENKU";

        iisreset.Start();
    }

    public static string getForeColor(string code)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        var colorName = string.Empty;
        if (code != string.Empty)
        {
            try
            {
                //get name from code
                using (var conn = new SqlConnection(strConnection))
                {
                    var color = "SELECT ForeColour FROM [dbo].[SAP_Order_Status] WHERE Status_Code = @Scode";
                    colorName = StatusColor(code, colorName, conn, color);
                }
            }
            catch
            {
                colorName = "Black";
            }
        }
        return colorName;
    }

    public static string getBackColor(string code)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        var colorName = string.Empty;
        if (code != string.Empty)
        {
            try
            {
                //get name from code
                using (var conn = new SqlConnection(strConnection))
                {
                    var color = "SELECT BackColour FROM [dbo].[SAP_Order_Status] WHERE Status_Code = @Scode";
                    colorName = StatusColor(code, colorName, conn, color);
                }
            }
            catch
            {
                colorName = "White";
            }
        }
        return colorName;
    }

    private static string StatusColor(string code, string colorName, SqlConnection conn, string color)
    {
        var compareColor = code.Trim();

        var showColor = new SqlCommand(color, conn);
        showColor.Parameters.AddWithValue("Scode", compareColor);

        conn.Open();
        var theColor = showColor.ExecuteScalar();

        if (theColor != null)
        {
            colorName = theColor.ToString();
        }

        conn.Close();
        return colorName;
    }

    public static string getStatus(string status)
    {
        var strConnection = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;

        var statusName = string.Empty;
        if (status != string.Empty)
        {
            try
            {
                //get name from driver table
                using (var conn = new SqlConnection(strConnection))
                {
                    var driver = "SELECT Status_Text FROM [dbo].[SAP_Order_Status] WHERE Status_Code = @Status";
                    var compareStatus = status.Trim();

                    var showStatus = new SqlCommand(driver, conn);
                    showStatus.Parameters.AddWithValue("Status", compareStatus);

                    conn.Open();
                    var theStatus = showStatus.ExecuteScalar();
                    //string theShipper = showShipper.

                    if (theStatus != null)
                    {
                        statusName = theStatus.ToString();
                    }

                    conn.Close();
                }
            }
            catch
            {
                statusName = "";
            }
        }
        return statusName;
    }
}