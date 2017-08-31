using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

public partial class Update : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var connectionString = ConfigurationManager.ConnectionStrings["SecureConnectionString"].ConnectionString;
        var SetDate = DateTime.Today;
        //update NewQueue
        var updateSql = "UPDATE NewQueue SET Status = @Status, StatusTime = @StatusTime WHERE SetDate = '" + SetDate +
                        "' AND Loaded IS NULL AND Rejected IS NULL";
        using (var myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            var myCommand = new SqlCommand(updateSql, myConnection);
            myCommand.Parameters.AddWithValue("@Status", "DISABLED");
            myCommand.Parameters.AddWithValue("@StatusTime", DateTime.Now);
            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }


        //update SAP
        var updateSap =
            "UPDATE SAP_Orders SET Status = @Status, Delivery_Date = @Delivery_Date, Last_Change_Date = @Last_Change_Date WHERE Delivery_Date = '" +
            SetDate + "' AND SAP_Request_No IN (SELECT SAP_Request_No FROM [dbo].[NewQueue] WHERE SetDate = '" + SetDate +
            "' AND Loaded IS NULL)";
        using (var myConnection = new SqlConnection(connectionString))
        {
            myConnection.Open();
            var myCommand = new SqlCommand(updateSap, myConnection);
            myCommand.Parameters.AddWithValue("@Status", "PIPCOR");
            myCommand.Parameters.AddWithValue("@Delivery_Date", DateTime.Today.AddDays(1));
            myCommand.Parameters.AddWithValue("@Last_Change_Date", DateTime.Now);
            myCommand.ExecuteNonQuery();
            myConnection.Close();
        }

        LabelH2.Text = "Unprocessed orders requeued.";
        LabelB.Text = "Only refresh this page if you want to requeue orders again";
    }
}