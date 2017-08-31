<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Reports.master" AutoEventWireup="true" CodeFile="Withdrawn.aspx.cs" Inherits="Reports.Reports_Suspended" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script src="../Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.core.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.ui.widget.js" type="text/javascript"></script>
    <link href="../Styles/jquery.ui.all.css" rel="stylesheet" type="text/css"/>
    <link href="../Scripts/jquery.ui.datepicker.css" rel="stylesheet" type="text/css"/>
    <script src="../Scripts/jquery.ui.datepicker.js" type="text/javascript"></script>
    <script language="javascript">
        document.getElementById("withdrawn").className = "active";

        $(function() {
            $("#datepicker").datepicker();
        });
    </script>
    <h3>Withdrawn</h3>(Trucks that are withdrawn)
    <table style="width: 1120px;">
        <tr>
            <td style="text-align: left; vertical-align: text-top; width: 920px;">
                <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                                        AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px"
                                        ReportSourceID="CrystalReportSource1" ToolbarImagesFolderUrl=""
                                        ToolPanelWidth="100px" Width="350px" ToolPanelView="None"/>
                <CR:CrystalReportSource ID="CrystalReportSource1" runat="server">
                    <Report FileName="Withdrawn.rpt">
                    </Report>
                </CR:CrystalReportSource>
            </td>
            <td style="text-align: left; vertical-align: text-top; width: 200px;">
                Date: <asp:TextBox ID="datepicker" runat="server" ClientIDMode="Static">
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqDate" runat="server" ValidationGroup="theDate" ControlToValidate="datepicker" ErrorMessage="*"></asp:RequiredFieldValidator>
                <br/><br/>
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click" ValidationGroup="theDate" CssClass="btn" Text="Go"/>
                <asp:Label ID="Label1" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>