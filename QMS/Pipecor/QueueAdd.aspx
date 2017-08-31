<%@ Page Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="QueueAdd.aspx.cs" Inherits="Pipecor.Pipecor_QueueAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<link href="../Styles.css" rel="stylesheet" type="text/css"/>
<link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
<link href="../Scripts/default.css" rel="stylesheet" type="text/css"/>
<script src="../prompts/jquery.js" type="text/javascript"></script>
<script src="../prompts/jquery-impromptu.2.6.min.js" type="text/javascript"></script>
<script language="javascript">

    function CheckTruck() {
        DisplayCheckTruckDialog();
        return false;
    }

    function DisplayCheckTruckDialog() {
        $("#CheckTruck").show();
    }

    function CloseCheckTruckDialog() {
        $("#CheckTruck").hide();
    }

    document.getElementById("queueAdd").className = "active";
    window.onerror = function(e) { return true; };
</script>


<div style="margin: 0px; width: 800px;">
    <h3>
        <asp:Label ID="lblHead" runat="server" Text="Pipecore - Add to queue."></asp:Label>
    </h3>
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
    <ContentTemplate>
        <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="999999" ontick="AutoRefreshTimer_Tick"/>
        <table style="margin-top: 0px; width: 800px;">
            <tr>
                <td>
                    <asp:FormView ID="FormEdit" DefaultMode="Insert" runat="server">
                        <InsertItemTemplate>
                            <asp:Label ID="LabelType" CssClass="Visibility" runat="server" Text='<%#Eval("Type") %>'></asp:Label>

                            <table rules="all" style="border: 2px solid #000000; width: 600px;">
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">TYPE:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:DropDownList ID="ddlType" runat="server" ValidationGroup="Local" Width="250px" CssClass="Enter">
                                            <asp:ListItem Text=" CHOOSE" Value=""></asp:ListItem>
                                            <asp:ListItem Text="LOCAL" Value="LOCAL"></asp:ListItem>
                                            <asp:ListItem Text="EXPORT" Value="EXPORT"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="ReQueue_Type" ControlToValidate="ddlType" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">SHIPPER:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:DropDownList ID="ddlShipper" runat="server" ValidationGroup="Local" Width="250px" CssClass="Enter" EnableViewState="true" AutoPostBack="false">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="ReQueue_Shipper" ControlToValidate="ddlShipper" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">QUEUE NO:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="Notxt" ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequNo" ControlToValidate="Notxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="CompareRequNo" ValidationGroup="Local" runat="server" ControlToValidate="Notxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number " Font-Size="Small"></asp:CompareValidator>
                                        <asp:RangeValidator ID="RangeRequNo" ValidationGroup="Local" ControlToValidate="Notxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">REGISTRATION:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="RegistrationLocal" Text='<%# Bind("Registration") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqRegistrationLocal" ControlToValidate="RegistrationLocal" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">TRAILER:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="TRAILER_TEXT" Text='<%# Bind("TRAILER_TEXT") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">L.O NO:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="LONOLocal" Text='<%# Bind("LO_NO") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqLONOLocal" ControlToValidate="LONOLocal" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">MSP:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="MSPtxt" Text='<%# Bind("MSP") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqMSP" ControlToValidate="MSPtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                        <asp:CompareValidator ID="CompareMSPtxt" ValidationGroup="Local" runat="server" ControlToValidate="MSPtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number " Font-Size="Small"></asp:CompareValidator>
                                        <asp:RangeValidator ID="RangeMSPtxt" ValidationGroup="Local" ControlToValidate="MSPtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">AGO:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="AGOtxt" Text='<%# Bind("AGO") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqAGO" ControlToValidate="AGOtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                        <asp:CompareValidator ID="CompareAGOtxt" ValidationGroup="Local" runat="server" ControlToValidate="AGOtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number " Font-Size="Small"></asp:CompareValidator>
                                        <asp:RangeValidator ID="RangeAGOtxt" ValidationGroup="Local" ControlToValidate="AGOtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">KERO:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="KEROtxt" Text='<%# Bind("KERO") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqKERO" ControlToValidate="KEROtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                        <asp:CompareValidator ID="CompareReqKERO" ValidationGroup="Local" runat="server" ControlToValidate="KEROtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number " Font-Size="Small"></asp:CompareValidator>
                                        <asp:RangeValidator ID="RangeReqKERO" ValidationGroup="Local" ControlToValidate="KEROtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">JET:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:TextBox ID="JETtxt" Text='<%# Bind("JET") %>' ValidationGroup="Local" Width="250px" CssClass="Enter" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ReqJET" ControlToValidate="JETtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                        <asp:CompareValidator ID="CompareReqJET" ValidationGroup="Local" runat="server" ControlToValidate="JETtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number " Font-Size="Small"></asp:CompareValidator>
                                        <asp:RangeValidator ID="RangeReqJET" ValidationGroup="Local" ControlToValidate="JETtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server" Font-Size="Small"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">DRIVER:</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; height: 30px; width: 50%;">
                                        <asp:DropDownList ID="ddlDriver" runat="server" ValidationGroup="Local" Width="250px" CssClass="Enter" EnableViewState="true" AutoPostBack="false">
                                        </asp:DropDownList>

                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Button ID="LocalBtn" runat="server" ValidationGroup="Local" CssClass="btn"
                                                    Text="ADD ORDER" onclick="LocalBtn_Click"/>

                                    </td>
                                </tr>
                            </table>

                            <asp:Label ID="Type" CssClass="Visibility" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                            <asp:Label ID="Shipper" CssClass="Visibility" runat="server" Text='<%# Eval("Shipper") %>'></asp:Label>
                            <asp:Label ID="QueueID" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                        </InsertItemTemplate>
                    </asp:FormView>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>

<div id="CheckTruck" class="JqueryForm">
    <table style="width: 100%;" cellpadding="5" cellspacing="0">
        <tr class="headerRow">
            <td>
                Message:
            </td>
            <td style="text-align: right;">
                <a onclick="CloseCheckTruckDialog();" style="color: #ffffff; cursor: pointer; text-decoration: none;"></a>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <p>
                    <asp:Label ID="lblPopUp" runat="server"></asp:Label>
                </p>
                <asp:Button ID="btnBack" runat="server" CssClass="btn" onclick="btnBack_Click" Text="Ok"/>
            </td>
        </tr>
    </table>
</div>
<div class="Visibility">
    <asp:GridView ID="GridTotalExport" runat="server" Width="1px" AutoGenerateColumns="False" CssClass="Visibility"
                  DataKeyNames="QueueID" EnableViewState="false" DataSourceID="TotalExportSource" EnableSortingAndPagingCallbacks="true">
        <Columns>
            <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                            SortExpression="LO_NO"/>
        </Columns>
    </asp:GridView>
    <asp:GridView ID="GridTotalLocal" runat="server" Width="1px" AutoGenerateColumns="False" CssClass="Visibility"
                  DataKeyNames="QueueID" EnableViewState="false" DataSourceID="TotalLocalSource" EnableSortingAndPagingCallbacks="true">
        <Columns>
            <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                            SortExpression="LO_NO"/>
        </Columns>
    </asp:GridView>
</div>
<asp:SqlDataSource ID="TotalExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND SetDate = @TheDate Order by NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="TotalLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND SetDate = @TheDate Order by NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>