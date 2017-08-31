using System;
using System.Globalization;
using System.Web.UI;
using CrystalDecisions.CrystalReports.Engine;

namespace Reports
{
    public partial class Reports_History : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var theDate = Request.QueryString["DATE"];
            var theType = Request.QueryString["TYPE"];
            var theQ_No = Request.QueryString["NO"];
            var theNo = Convert.ToInt32(theQ_No);

            try
            {
                if (Request.QueryString.Count > 0)
                {
                    //DateTime Mydate = Convert.ToDateTime(datepicker.Text.ToString());
                    //String.Format("{0:yyyy-MM-dd}", Mydate);

                    DateTime _date;

                    var Mydate = Convert.ToDateTime(theDate);
                    var day = Mydate.ToString("yyyy-MM-dd HH:mm:ss");
                    _date = DateTime.Parse(day);

                    day = _date.Year + "," + _date.Month + "," + _date.Day + "," + _date.Hour + "," + _date.Minute + "," +
                          _date.Second;

                    //string selectRejected = "{SafetySecurity_B.EntryStatus} = True AND {NewQueue.EnterTime} = '" + day + "' AND {NewQueue.Type} = '" + theType + "' AND {NewQueue.Queue_No} = " + theNo + "";

                    var selectRejected = "{SafetySecurity_B.EntryStatus} = True AND {NewQueue.SetDate} =  [CDATETIME(" +
                                         day + ")] AND {NewQueue.Type} = '" + theType + "' AND {NewQueue.Queue_No} = " +
                                         theNo + "";

                    var reportdocument = new ReportDocument();
                    reportdocument.Load(Server.MapPath("../Rpts-Crystal/History.rpt"));
                    reportdocument.SetDatabaseLogon("", "", "", "Secure");
                    CrystalReportViewer1.ReportSource = reportdocument;
                    CrystalReportViewer1.SelectionFormula = selectRejected;

                    lblReportResult.Text = "Result for Queue No:" + theNo + ", Date: " + day + ", Type: " + theType;
                }
                else
                {
                    GetReport();
                }
            }
            catch
            {
                Helper.iisRestart();

                Response.Redirect("History.aspx");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //DateTime dt = Convert.ToDateTime(datepicker.Text.ToString());
            //String.Format("{0:yyyy/MM/dd}", dt);


            var datestring = datepicker.Text;
            var dt = DateTime.ParseExact(datestring, @"MM/dd/yyyy", CultureInfo.InvariantCulture);
            Response.Redirect("History.aspx?type=" + DropType.SelectedValue + "&no=" + txtNo.Text + "&date=" + dt);
        }

        private void GetReport()
        {
            var theDate = DateTime.Today.ToString("yyyy-MM-dd");

            DateTime _date;
            var day = "";

            _date = DateTime.Parse(theDate);
            day = _date.ToString("yyyy-MM-dd");

            var selectRejected = "{SafetySecurity_B.EntryStatus} = True AND {NewQueue.EnterTime} = '" + day + "'";

            var reportdocument = new ReportDocument();
            reportdocument.Load(Server.MapPath("../Rpts-Crystal/History.rpt"));
            reportdocument.SetDatabaseLogon("", "", "", "Secure");
            CrystalReportViewer1.ReportSource = reportdocument;
            CrystalReportViewer1.SelectionFormula = selectRejected;
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            var reportdocument = new ReportDocument();
            CrystalReportViewer1.Dispose();
            reportdocument.Close();
            reportdocument.Dispose();
        }
    }
}