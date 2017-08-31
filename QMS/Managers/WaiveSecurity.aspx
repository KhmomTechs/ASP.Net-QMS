<%@ Page Language="C#" MasterPageFile="~/Master/Managers.master" AutoEventWireup="true" CodeFile="WaiveSecurity.aspx.cs" Inherits="Managers.Managers_WaiveSecurity" %>

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
                <asp:Label ID="LabelResults" Visible="false" runat="server" Text="Truck Security form updated"></asp:Label>
            </h3>
            <p id="ParaResult" runat="server">
                <h3>Security Waiver form</h3>
                <asp:FormView ID="FormView1Ai" onitemupdating="FormView1Ai_ItemUpdating" onitemupdated="FormView1Ai_ItemUpdated" DataKeyNames="QueueID" DefaultMode="ReadOnly" DataSourceID="SqlSecuritySource" runat="server">
                    <ItemTemplate>
                        Truck Reg No. <asp:Label ID="LabelName" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Registration") %>'></asp:Label> ,Order No. <asp:Label ID="Queue_No" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Queue_No") %>'></asp:Label><br/><br/>
                        The truck is lifting product(s) for <asp:Label ID="LabelType" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Type") %>'></asp:Label>, Truck belongs to <asp:Label ID="TextOmc" runat="server" Font-Bold="true" Font-Underline="true" Text='<%#Eval("Shipper") %>'></asp:Label> OMC.
                        <p style="font-size: medium;">
                            Inspected on: <asp:Label ID="Label2" ForeColor="Red" Text='<%#Eval("SavedTime_B") %>' runat="server" Font-Underline="true"></asp:Label> by:<asp:Label ID="Label1" ForeColor="Red" Text='<%#Eval("SavedBy_B") %>' runat="server" Font-Underline="true"></asp:Label>
                        </p>
                        <h4>PART (B):GATE HOUSE INSPECTION</h4>
                        <table rules="all" border="solid" style="border: 2px solid #000000; width: 1000px;">
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; width: 4%;">No.</td>
                                <td style="border: 1px solid #000000; font-weight: bold; width: 80%;">ITEM</td>
                                <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Pass</td>
                                <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Fail</td>
                            </tr>
                            <tr>
                                <td>30.</td>
                                <td>Does the registration No. tally with the one in the order?</td>
                                <td>
                                    <asp:CheckBox ID="RegTally" AutoPostBack="true" Enabled="false" Checked='<%# Eval("RegTally") == DBNull.Value ? false : Eval("RegTally") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="ExtinguishersCheck_1Fail" AutoPostBack="true" Enabled="false" runat="server"/>
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
                                    <asp:CheckBox ID="DrLicense" AutoPostBack="true" Enabled="false" Checked='<%# Eval("DrLicense") == DBNull.Value ? false : Eval("DrLicense") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" AutoPostBack="true" Enabled="false" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu3" Key="YesNo2" TargetControlID="DrLicense" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu4" Key="YesNo2" TargetControlID="CheckBox1" runat="server">
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
                        <asp:Panel ID="CommentPanel" runat="server">
                            Comments<br/>
                            <asp:TextBox ID="ImmCorrectiveTxt" Text='<%# Bind("ImmCorrAction_B") %>' Enabled="false" Width="500px" TextMode="MultiLine" runat="server"></asp:TextBox>
                        </asp:Panel>
                        <br/>
                        Waiver Comment:<br/>
                        <asp:TextBox ID="txtWaiveComment" Width="500px" TextMode="MultiLine" ValidationGroup="Comment" runat="server"></asp:TextBox>
                        <br/>
                        <asp:RequiredFieldValidator ID="ReqReason" ControlToValidate="txtWaiveComment" ValidationGroup="Comment" runat="server" ErrorMessage="You must enter a comment"></asp:RequiredFieldValidator>
                        <p>
                            <asp:Button ID="SaveBtn" ValidationGroup="Comment" CssClass="btn" CommandName="Update" runat="server" Visible="false" Text="SAVE"/><asp:Button ID="ApproveBtn" CssClass="btn" runat="server" Text="WAIVE TRUCK" ValidationGroup="Comment" onclick="ApproveBtn_Click"/>&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="RejectBtn" CssClass="btn" ValidationGroup="Comment" runat="server" Text="REJECT" onclick="RejectBtn_Click"/>&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="GoBack" CssClass="btn" runat="server" Text="BACK" onclick="GoBack_Click"/>
                        </p>
                        <div style="visibility: hidden;">
                            <asp:Label ID="QueueLbl" runat="server" Text='<%# Bind("QueueID") %>'></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
            </p>
            <asp:SqlDataSource ID="SqlSecuritySource" runat="server"
                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                               SelectCommand="SELECT * FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (NewQueue.ID = @ID)"
                               UpdateCommand="UPDATE SafetySecurity_B SET InspectionDate_B = @InspectionDate_B, NecessaryPPE_28 = @NecessaryPPE_28, CabinFree_29 = @CabinFree_29, ContainersRemoved_30 = @ContainersRemoved_30, IgnitionSources_31 = @IgnitionSources_31, BottomValvesSealed_32 = @BottomValvesSealed_32, ValidDL_33 = @ValidDL_33, DriverIDTallies_34 = @DriverIDTallies_34, EmergencyInstGiven_35 = @EmergencyInstGiven_35, EntryStatus = @EntryStatus, EntryStatusTime = @EntryStatusTime, GateHseInspOfficial = @GateHseInspOfficial FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (SafetySecurity_B.QueueID = @QueueID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="InspectionDate_B"/>
                    <asp:Parameter Name="NecessaryPPE_28"/>
                    <asp:Parameter Name="CabinFree_29"/>
                    <asp:Parameter Name="ContainersRemoved_30"/>
                    <asp:Parameter Name="IgnitionSources_31"/>
                    <asp:Parameter Name="BottomValvesSealed_32"/>
                    <asp:Parameter Name="ValidDL_33"/>
                    <asp:Parameter Name="DriverIDTallies_34"/>
                    <asp:Parameter Name="EmergencyInstGiven_35"/>
                    <asp:Parameter Name="EntryStatus"/>
                    <asp:Parameter Name="EntryStatusTime"/>
                    <asp:Parameter Name="GateHseInspOfficial"/>
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