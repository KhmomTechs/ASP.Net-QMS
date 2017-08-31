<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Reports.master" AutoEventWireup="true" CodeFile="QueueReport.aspx.cs" Inherits="Reports.Reports_QueueReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("queue").className = "active";
    </script>
    <h3>QMS</h3>(Trucks currently queued at each stage)
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                            AutoDataBind="True" EnableDatabaseLogonPrompt="False"
                            GroupTreeImagesFolderUrl="" Height="50px" ReportSourceID="CrystalReportSource1"
                            ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px"/>
    <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
        <Report FileName="QueueReport.rpt">
        </Report>
    </CR:CrystalReportSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>