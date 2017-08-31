<%@ Page Language="C#" MasterPageFile="~/Master/Security.master" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="Security.Security_Check" %>

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

<asp:ScriptManager ID="asm" runat="server"/>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<h3 style="color: Red;">
    <asp:Label ID="LabelResults" Visible="false" runat="server" Text="Taken to Depot Manager"></asp:Label>
</h3>
<p id="ParaResult" runat="server">
    <h3>Security-Truck Inspection</h3>
    <table style="margin-top: 0px; width: 1100px;">
        <tr>
            <td style="text-align: left; vertical-align: top;">
                <asp:FormView ID="FormView1Ai" onitemupdating="FormView1Ai_ItemUpdating" onitemupdated="FormView1Ai_ItemUpdated" DataKeyNames="QueueID" DefaultMode="Edit" DataSourceID="SqlSecuritySource" runat="server">
                    <EditItemTemplate>
                        <h4>PART (B):GATE HOUSE INSPECTION</h4>
                        Truck Reg No. <asp:Label ID="LabelName" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Registration") %>'></asp:Label> ,Order No. <asp:Label ID="Queue_No" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Queue_No") %>'></asp:Label><br/><br/>
                        The truck is lifting product(s) for <asp:Label ID="LabelType" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Type") %>'></asp:Label>, Truck belongs to <asp:Label ID="TextOmc" runat="server" Font-Bold="true" Font-Underline="true" Text='<%#Eval("Shipper") %>'></asp:Label> OMC.
                        <br/><br/>
                        <table rules="all" border="solid" style="border: 2px solid #000000; width: 1000px;">
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
                                <td>30.</td>
                                <td>Does the registration No. tally with the one in the order?</td>
                                <td>
                                    <asp:CheckBox ID="RegTally" AutoPostBack="true" Checked='<%# Eval("RegTally") == DBNull.Value ? false : Eval("RegTally") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="ExtinguishersCheck_1Fail" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu1" Key="YesNo1" TargetControlID="RegTally" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu2" Key="YesNo1" TargetControlID="ExtinguishersCheck_1Fail" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>31.</td>
                                <td>Confirm Driving License number with the one in the system?</td>
                                <td>
                                    <asp:CheckBox ID="DrLicense" AutoPostBack="true" Checked='<%# Eval("DrLicense") == DBNull.Value ? false : Eval("DrLicense") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu3" Key="YesNo2" TargetControlID="DrLicense" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu4" Key="YesNo2" TargetControlID="CheckBox1" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>32.</td>
                                <td>Driver’s cabin is free of any dangerous weapons?</td>
                                <td>
                                    <asp:CheckBox ID="CheckDanger" AutoPostBack="true" Checked='<%# Eval("CheckDanger") == DBNull.Value ? false : Eval("CheckDanger") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox25" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender17" Key="YesNoCheckDanger" TargetControlID="CheckDanger" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender18" Key="YesNoCheckDanger" TargetControlID="CheckBox25" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>33.</td>
                                <td>All ignition sources, e.g lighters, mobile phones and matches have been left at the gate?</td>
                                <td>
                                    <asp:CheckBox ID="ignitionSources" AutoPostBack="true" Checked='<%# Eval("ignitionSources") == DBNull.Value ? false : Eval("ignitionSources") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox28" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender35" Key="YesNoignitionSources" TargetControlID="ignitionSources" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender36" Key="YesNoignitionSources" TargetControlID="CheckBox28" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>34.</td>
                                <td>The bottom valves have properly been sealed(local trucks only)?</td>
                                <td>
                                    <asp:CheckBox ID="CheckBtmValves" AutoPostBack="true" Checked='<%# Eval("CheckBtmValves") == DBNull.Value ? false : Eval("CheckBtmValves") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox27" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender37" Key="YesNoCheckBtmValves" TargetControlID="CheckBtmValves" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender38" Key="YesNoCheckBtmValves" TargetControlID="CheckBox27" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                        </table>

                        <p style="height: 1px; visibility: hidden; width: 600px;">
                            Entry status:<asp:DropDownList ID="DropDownStatus" DataTextField="EntryStatus" DataValueField="EntryStatus" SelectedValue='<%# Bind("EntryStatus") %>' runat="server">
                                <asp:ListItem Text="Select as appropriate" Value=""></asp:ListItem>
                                <asp:ListItem Text="Accepted" Value="True"></asp:ListItem>
                                <asp:ListItem Text="Denied" Value="False"></asp:ListItem>
                            </asp:DropDownList><br/><br/>
                            GATEHOUSE INPECTION OFFICIAL: NAME <asp:TextBox ID="TextGateHseOff" Text='<%# Bind("GateHseInspOfficial") %>' runat="server"></asp:TextBox>
                        </p>
                        <asp:Panel ID="CommentPanel" Visible="false" runat="server">
                            Comments<br/>
                            <asp:TextBox ID="ImmCorrectiveTxt" Text='<%# Bind("ImmCorrAction_B") %>' ValidationGroup="Comment" Width="500px" TextMode="MultiLine" runat="server"></asp:TextBox><br/>
                            <asp:RequiredFieldValidator ID="ReqReason" ControlToValidate="ImmCorrectiveTxt" ValidationGroup="Comment" runat="server" ErrorMessage="You must enter a comment"></asp:RequiredFieldValidator>
                        </asp:Panel>
                        <p>
                            <asp:Button ID="SaveBtn" CommandName="Update" ValidationGroup="Comment" CssClass="btn" runat="server" Visible="false" Text="SAVE"/><asp:Button ID="ApproveBtn" CssClass="btn" runat="server" Text="SECURITY APPROVED" Visible="false" onclick="ApproveBtn_Click"/>&nbsp;&nbsp;<asp:Button ID="GoBack" CssClass="btn" runat="server" Text="BACK"
                                                                                                                                                                                                                                                                                                                      onclick="GoBack_Click"/>
                        </p>
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
                    <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Get Driver ID"
                                ValidationGroup="Go" onclick="btnGo_Click"/>
                </asp:Panel>


                <p>
                    <asp:GridView ID="GridResult" Width="200px" BorderStyle="None" runat="server">
                        <EmptyDataTemplate>
                            NO ID FOUND
                        </EmptyDataTemplate>
                    </asp:GridView>
                </p>
            </td>
        </tr>
    </table>
</p>
<asp:SqlDataSource ID="FuelFacsSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM PS28orders WHERE (PS28orders.ORDER_ID = @ORDER_ID)">
    <SelectParameters>
        <asp:QueryStringParameter Name="ORDER_ID" QueryStringField="order"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlSecuritySource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (NewQueue.ID = @ID)"

                   UpdateCommand="UPDATE SafetySecurity_B SET InspectionDate_B = @InspectionDate_B, RegTally = @RegTally, DrLicense = @DrLicense, CheckDanger = @CheckDanger, ignitionSources = @ignitionSources, CheckBtmValves = @CheckBtmValves, EntryStatus = @EntryStatus, EntryStatusTime = @EntryStatusTime, GateHseInspOfficial = @GateHseInspOfficial, ImmCorrAction_B = @ImmCorrAction_B, SavedTime_B = @SavedTime_B, SavedBy_B = @SavedBy_B, Failed = @Failed FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (SafetySecurity_B.QueueID = @QueueID)">
    <SelectParameters>
        <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="InspectionDate_B"/>
        <asp:Parameter Name="RegTally"/>
        <asp:Parameter Name="DrLicense"/>
        <asp:Parameter Name="CheckDanger"/>
        <asp:Parameter Name="ignitionSources"/>
        <asp:Parameter Name="CheckBtmValves"/>
        <asp:Parameter Name="EntryStatus"/>
        <asp:Parameter Name="EntryStatusTime"/>
        <asp:Parameter Name="GateHseInspOfficial"/>
        <asp:Parameter Name="ImmCorrAction_B"/>
        <asp:Parameter Name="SavedTime_B"/>
        <asp:Parameter Name="SavedBy_B"/>
        <asp:Parameter Name="Failed"/>
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

</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>