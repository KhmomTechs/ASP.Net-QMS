<%@ Page Language="C#" MasterPageFile="~/Master/Safety.master" AutoEventWireup="true" CodeFile="KRACheck.aspx.cs" Inherits="Safety.Safety_KRACheck" %>

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
                <h3>Safety-LOAD CLEARANCE</h3>
                <asp:FormView ID="FormView1Ai" onitemupdating="FormView1Ai_ItemUpdating" onitemupdated="FormView1Ai_ItemUpdated" DataKeyNames="QueueID" DefaultMode="Edit" DataSourceID="SqlSecuritySource" runat="server">
                    <EditItemTemplate>
                        <h4>PART (C):LOADING AREA</h4>
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
                                <td>Is product leaking after loading?</td>
                                <td>
                                    <asp:CheckBox ID="Leaking_Loading_36" AutoPostBack="true" Checked='<%# Eval("Leaking_Loading_36") == DBNull.Value ? false : Eval("Leaking_Loading_36") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="ExtinguishersCheck_1Fail" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu1" Key="YesNo1" TargetControlID="Leaking_Loading_36" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu2" Key="YesNo1" TargetControlID="ExtinguishersCheck_1Fail" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>31.</td>
                                <td>Has the truck been doped with bio-code?</td>
                                <td>
                                    <asp:CheckBox ID="BioCode" AutoPostBack="true" Checked='<%# Eval("BioCode") == DBNull.Value ? false : Eval("BioCode") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox1" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu3" Key="YesNo2" TargetControlID="BioCode" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="Mu4" Key="YesNo2" TargetControlID="CheckBox1" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>32.</td>
                                <td>Is the truck properly sealed?</td>
                                <td>
                                    <asp:CheckBox ID="ProperSealing_40" AutoPostBack="true" Checked='<%# Eval("ProperSealing_40") == DBNull.Value ? false : Eval("ProperSealing_40") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox4" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender3" Key="YesNo5" TargetControlID="ProperSealing_40" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender4" Key="YesNo5" TargetControlID="CheckBox4" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>33.</td>
                                <td>Product Destination?</td>
                                <td>
                                    <asp:CheckBox ID="ProductDestination" AutoPostBack="true" Checked='<%# Eval("ProductDestination") == DBNull.Value ? false : Eval("ProductDestination") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox3" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender1" Key="YesNoProductDestination" TargetControlID="ProductDestination" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender2" Key="YesNoProductDestination" TargetControlID="CheckBox3" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>34.</td>
                                <td>Has the truck cut out switch effectively engaged and wheel chokes placed by the wheels?</td>
                                <td>
                                    <asp:CheckBox ID="switchEngaged" AutoPostBack="true" Checked='<%# Eval("switchEngaged") == DBNull.Value ? false : Eval("switchEngaged") %>' runat="server"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="CheckBox5" AutoPostBack="true" runat="server"/>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender5" Key="YesNoswitchEngaged" TargetControlID="switchEngaged" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                    <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender6" Key="YesNoswitchEngaged" TargetControlID="CheckBox5" runat="server">
                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                </td>
                            </tr>
                        </table>

                        <p></p>
                        <asp:Panel ID="CommentPanel" Visible="false" runat="server">
                            Comments<br/>
                            <asp:TextBox ID="ImmCorrectiveTxt" Text='<%# Bind("CorrectiveAction") %>' ValidationGroup="Comment" Width="500px" TextMode="MultiLine" runat="server"></asp:TextBox><br/>
                            <asp:RequiredFieldValidator ID="ReqReason" ControlToValidate="ImmCorrectiveTxt" ValidationGroup="Comment" runat="server" ErrorMessage="You must enter a comment"></asp:RequiredFieldValidator>
                        </asp:Panel>
                        <p runat="server">
                            <asp:Button ID="SaveBtn" CssClass="btn" ValidationGroup="Comment" CommandName="Update" runat="server" Visible="false" Text="SAVE"/> <asp:Button ID="Button1" runat="server" CssClass="btn" Text="CLEAR TRUCK" Visible="false" onclick="Button1_Click"/>
                        </p>
                        <div style="visibility: hidden;">
                            <asp:Label ID="QueueLbl" runat="server" Text='<%# Bind("QueueID") %>'></asp:Label>
                        </div>
                    </EditItemTemplate>
                </asp:FormView>
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
                               SelectCommand="SELECT * FROM SafetySecurity_C INNER JOIN NewQueue ON SafetySecurity_C.QueueID = NewQueue.QueueID WHERE (NewQueue.ID = @ID)"

                               UpdateCommand="UPDATE SafetySecurity_C SET Leaking_Loading_36 = @Leaking_Loading_36, BioCode = @BioCode, ProperSealing_40 = @ProperSealing_40, ProductDestination = @ProductDestination, switchEngaged = @switchEngaged, CorrectiveAction = @CorrectiveAction, SavedTime_C = @SavedTime_C, SavedBy_C = @SavedBy_C, Passed = @Passed, Failed = @Failed FROM SafetySecurity_C INNER JOIN NewQueue ON SafetySecurity_C.QueueID = NewQueue.QueueID WHERE (SafetySecurity_C.QueueID = @QueueID)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Leaking_Loading_36"/>
                    <asp:Parameter Name="BioCode"/>
                    <asp:Parameter Name="ProperSealing_40"/>
                    <asp:Parameter Name="ProductDestination"/>
                    <asp:Parameter Name="switchEngaged"/>
                    <asp:Parameter Name="CorrectiveAction"/>
                    <asp:Parameter Name="SavedTime_C"/>
                    <asp:Parameter Name="SavedBy_C"/>
                    <asp:Parameter Name="Passed"/>
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