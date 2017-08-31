<%@ Page Title="" Language="C#" MasterPageFile="~/Master/CustomerCare.master" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="CustomerCare.CustomerCare_Check" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<link href="../Scripts/default.css" rel="stylesheet" type="text/css"/>
<script src="../prompts/jquery.js" type="text/javascript"></script>
<script src="../prompts/jquery-impromptu.2.6.min.js" type="text/javascript"></script>


<script type="text/javascript">
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

    window.onerror = function(e) { return true; };
</script>

<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<p id="ParaResult" runat="server">
    <h3>Approve Order No: <asp:Label ID="lblorder" runat="server"></asp:Label>
    </h3>
    <table style="margin-top: 0px; width: 1100px;">
        <tr>
            <td style="text-align: left; vertical-align: top;">
                <asp:FormView ID="FormView1Ai" onitemupdating="FormView1Ai_ItemUpdating" onitemupdated="FormView1Ai_ItemUpdated" DataKeyNames="QueueID" DefaultMode="Edit" DataSourceID="SqlSecuritySource" runat="server">
                    <EditItemTemplate>
                        <table rules="all" border="solid" style="border: 2px solid #000000; width: 800px;">
                            <tr>
                                <td style="border: 1px solid #000000; text-align: left; vertical-align: top; width: 400px;">
                                    <b>Order details</b>
                                    <ul>
                                        <li>Truck Registration No: <asp:Label ID="LabelName" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Registration") %>'></asp:Label></li>
                                        <li>The truck is lifting product(s) for :<asp:Label ID="LabelType" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Type") %>'></asp:Label></li>
                                        <li>Truck belongs to: <asp:Label ID="TextOmc" runat="server" Font-Bold="true" Font-Underline="true" Text='<%#Eval("Shipper") %>'></asp:Label> OMC.</li>
                                    </ul>
                                </td>
                                <td style="border: 1px solid #000000; text-align: left; vertical-align: top; width: 400px;">
                                    <asp:FormView ID="FormFuelFacs" DataSourceID="FuelFacsSource" runat="server" DefaultMode="ReadOnly">
                                        <ItemTemplate>
                                            <b>Driver details</b>
                                            <ul>
                                                <li>Driver number: <asp:Label ID="Label1" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("DRIVER_NUMBER") %>'></asp:Label></li>
                                                <li>Name: <asp:Label ID="LabelName" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("NAME") %>'></asp:Label></li>
                                                <li>License expiry date: <asp:Label ID="LabelTime" runat="server" Text='<%# Convert.ToDateTime(Eval("CERTIFICATION_DATE")).ToString("d") %>' Font-Bold="true" Font-Underline="true"></asp:Label></li>
                                            </ul>
                                            <asp:FormView ID="TrailerFacs" DataSourceID="TrailerSource" runat="server" DefaultMode="ReadOnly">
                                                <ItemTemplate>
                                                    <b>Trailer details</b>
                                                    <ul>
                                                        <li>Calibration date: <asp:Label ID="CalibrationTime" runat="server" Text='<%# Convert.ToDateTime(Eval("CERTIFICATION_DATE")).ToString("d") %>' Font-Bold="true" Font-Underline="true"></asp:Label></li>
                                                    </ul>
                                                </ItemTemplate>
                                                <EmptyDataTemplate>
                                                    Calibration date unavailable
                                                </EmptyDataTemplate>
                                            </asp:FormView>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <h3>Choose Driver and Registration to view details</h3>
                                        </EmptyDataTemplate>
                                    </asp:FormView>
                                </td>
                            </tr>
                        </table>
                        <br/>
                        <asp:Panel ID="b4Driver" Visible="false" runat="server">
                            <table rules="all" border="solid" style="border: 2px solid #000000; width: 800px;">
                                <tr>
                                    <td style="border: 1px solid #000000; font-weight: bold; width: 4%;">No.</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; width: 80%;">ITEM {Please check only if Pass}</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Pass</td>
                                    <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Fail</td>
                                    <td>
                                        <asp:Button ID="ChkBtn" CssClass="btn" runat="server" Text="Pass All"
                                                    onclick="ChkBtn_Click"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>1.</td>
                                    <td>KRA Stamped?</td>
                                    <td>
                                        <asp:CheckBox ID="KRA" AutoPostBack="true" Checked='<%# Eval("KRA") == DBNull.Value ? false : Eval("KRA") %>' runat="server"/>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="KraFail" AutoPostBack="true" runat="server"/>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu1" Key="YesNo1" TargetControlID="KRA" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu2" Key="YesNo1" TargetControlID="KraFail" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2.</td>
                                    <td>Pipecore Stamped?</td>
                                    <td>
                                        <asp:CheckBox ID="Pipecore" AutoPostBack="true" Checked='<%# Eval("Pipecore") == DBNull.Value ? false : Eval("Pipecore") %>' runat="server"/>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="PipecoreFail" AutoPostBack="true" runat="server"/>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu3" Key="YesNo2" TargetControlID="Pipecore" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu4" Key="YesNo2" TargetControlID="PipecoreFail" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3.</td>
                                    <td>Driver license expiry?</td>
                                    <td>
                                        <asp:CheckBox ID="Expiered" AutoPostBack="true" Checked='<%# Eval("Expiered") == DBNull.Value ? false : Eval("Expiered") %>' runat="server"/>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ExpieredFail" AutoPostBack="true" runat="server"/>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu5" Key="YesNo3" TargetControlID="Expiered" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu6" Key="YesNo3" TargetControlID="ExpieredFail" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>4.</td>
                                    <td>OMC Logo availability?</td>
                                    <td>
                                        <asp:CheckBox ID="OmcLogo" AutoPostBack="true" Checked='<%# Eval("OmcLogo") == DBNull.Value ? false : Eval("OmcLogo") %>' runat="server"/>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="ChkOMCFail" AutoPostBack="true" runat="server"/>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu7" Key="YesNo4" TargetControlID="OmcLogo" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu8" Key="YesNo4" TargetControlID="ChkOMCFail" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td>5.</td>
                                    <td>Signatories?</td>
                                    <td>
                                        <asp:CheckBox ID="Signatories" AutoPostBack="true" Checked='<%# Eval("Signatories") == DBNull.Value ? false : Eval("Signatories") %>' runat="server"/>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="SignatoriesFail" AutoPostBack="true" runat="server"/>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu9" Key="YesNo5" TargetControlID="Signatories" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu10" Key="YesNo5" TargetControlID="SignatoriesFail" runat="server">
                                        </asp:MutuallyExclusiveCheckBoxExtender>
                                    </td>
                                </tr>
                            </table>
                            <br/>
                            <asp:Panel ID="CommentPanel" Visible="false" runat="server">
                                Rejection comment<br/>
                                <asp:TextBox ID="RejectedReason" ValidationGroup="Comment" Text='<%# Bind("RejectedReason") %>' Width="500px" TextMode="MultiLine" runat="server"></asp:TextBox><br/>
                                <asp:RequiredFieldValidator ID="ReqReason" ControlToValidate="RejectedReason" ValidationGroup="Comment" runat="server" ErrorMessage="You must enter a comment"></asp:RequiredFieldValidator>
                            </asp:Panel>
                            <p>
                                <asp:Button ID="SaveBtn" CommandName="Update" ValidationGroup="Comment" CssClass="btn" runat="server" Visible="false" Text="REJECT"/><asp:Button ID="ApproveBtn" CssClass="btn" runat="server" Text="APPROVE TRUCK" Visible="false" onclick="ApproveBtn_Click"/>&nbsp;&nbsp;<asp:Button ID="GoBack" CssClass="btn" runat="server" Text="BACK"
                                                                                                                                                                                                                                                                                                                        onclick="GoBack_Click"/>
                            </p>
                        </asp:Panel>
                        <div style="visibility: hidden;">
                            <asp:Label ID="QueueLbl" runat="server" Text='<%# Bind("QueueID") %>'></asp:Label>
                            <asp:Label ID="DriverLbl" runat="server" Text='<%# Bind("DRIVER_NUMBER") %>'></asp:Label>
                        </div>
                    </EditItemTemplate>
                </asp:FormView>

            </td>
            <td style="text-align: left; vertical-align: top; width: 200px;">
                <asp:Panel ID="AfterDriver" runat="server">
                    <b>Driver name</b>
                    <p>
                        <asp:DropDownList ID="TextSearch" ValidationGroup="Go" runat="server" Width="150px">
                            <asp:ListItem Text="Choose Driver" Value=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="ReqSearch" runat="server" ValidationGroup="Go" ControlToValidate="TextSearch" InitialValue="" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </p>
                    <p>

                    </p>

                    <b>Trailer number</b>
                    <p></p>
                    <asp:FormView ID="FormTrailer" DataKeyNames="QueueID" DefaultMode="ReadOnly" DataSourceID="SqlSecuritySource" runat="server">
                        <ItemTemplate>
                            <asp:Label ID="trltxt" Text='<%# Eval("TRAILER_TEXT") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:FormView>
                    <p>
                        <asp:DropDownList ID="TextTrail" CssClass="Visibility" ValidationGroup="Go" runat="server" Width="150px">
                            <asp:ListItem Text="Choose Truck" Value=""></asp:ListItem>
                            <asp:ListItem Text="" Value="" Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="ReqTextTrail" Enabled="false" runat="server" ValidationGroup="Go" ControlToValidate="TextTrail" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </p>

                    <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Get Driver details"
                                ValidationGroup="Go" onclick="btnGo_Click"/>
                </asp:Panel>
                <asp:Label ID="lblCombination" runat="server" ForeColor="Red" Font-Bold="true" Text=""></asp:Label>
            </td>
        </tr>
    </table>
</p>

<asp:SqlDataSource ID="FuelFacsSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM [PS28drivers] WHERE ([NAME] LIKE '%' + @DRIVER_NAME + '%')">
    <SelectParameters>
        <asp:QueryStringParameter Name="DRIVER_NAME" QueryStringField="DRIVER_NAME"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="TrailerSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM [PS28trailers] WHERE ([SERIAL_NUMBER] LIKE '%' + @REG_NUMBER + '%') AND INDEXED = 1">
    <SelectParameters>
        <asp:QueryStringParameter Name="REG_NUMBER" QueryStringField="REG_NUMBER"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlSecuritySource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, CustomerCare.* FROM NewQueue INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID WHERE (NewQueue.ID = @ID)"
                   UpdateCommand="UPDATE CustomerCare SET KRA = @KRA, Pipecore = @Pipecore, Expiered = @Expiered, CheckUserTime = @CheckUserTime, CheckUser = @CheckUser, Approved = @Approved, Signatories = @Signatories, OmcLogo = @OmcLogo WHERE QueueID = @QueueID">
    <SelectParameters>
        <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="KRA"/>
        <asp:Parameter Name="Pipecore"/>
        <asp:Parameter Name="Expiered"/>
        <asp:Parameter Name="CheckUserTime"/>
        <asp:Parameter Name="CheckUser"/>
        <asp:Parameter Name="Approved"/>
        <asp:Parameter Name="Signatories"/>
        <asp:Parameter Name="OmcLogo"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
</asp:SqlDataSource>


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
                <!-- <input id="Button1" class="butt1" type="button" onclick="CloseLoginUserDialog();" value="Ok"/> -->
                <asp:Button ID="btnBack" runat="server" CssClass="btn" onclick="btnBack_Click" Text="Ok"/>
            </td>
        </tr>
    </table>
</div>
<asp:GridView ID="GridView1" AutoGenerateColumns="true" runat="server">
</asp:GridView>
</ContentTemplate>
</asp:UpdatePanel>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>