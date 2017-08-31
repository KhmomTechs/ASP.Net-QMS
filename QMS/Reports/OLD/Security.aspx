<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Reports.master" AutoEventWireup="true" CodeFile="Security.aspx.cs" Inherits="Reports.OLD.Reports_Security" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("").className = "active";
    </script>
    <h3>Security inspection failure report</h3>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                            AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px"
                            ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl=""
                            ToolPanelWidth="200px" Width="350px"/>
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="SecurityReport.rpt">
        </Report>
    </CR:CrystalReportSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>