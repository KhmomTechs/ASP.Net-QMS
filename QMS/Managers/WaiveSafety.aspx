<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Managers.master" AutoEventWireup="true" CodeFile="WaiveSafety.aspx.cs" Inherits="Managers.Managers_WaiveSafety" %>

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
    <asp:Label ID="LabelResults" Visible="false" runat="server" Text="Truck Safety form updated"></asp:Label>
</h3>
<p id="ParaResult" runat="server">
<h3>Safety Waiver form</h3>
<asp:FormView ID="FormView1Ai" onitemupdating="FormView1Ai_ItemUpdating" onitemupdated="FormView1Ai_ItemUpdated" DataKeyNames="QueueID" DefaultMode="ReadOnly" DataSourceID="SqlSecuritySource" runat="server">
<ItemTemplate>
<h4>PART (A):TRUCK INSPECTION BAY AREA</h4>
Truck Reg No. <asp:Label ID="LabelName" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Registration") %>'></asp:Label> ,Order No. <asp:Label ID="Queue_No" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Queue_No") %>'></asp:Label><br/><br/>
The truck is lifting product(s) for <asp:Label ID="LabelType" Font-Underline="true" Font-Bold="true" runat="server" Text='<%#Bind("Type") %>'></asp:Label>, Truck belongs to <asp:Label ID="TextOmc" Font-Bold="true" runat="server" Font-Underline="true" Text='<%#Eval("Shipper") %>'></asp:Label> OMC.
<p style="font-size: medium;">
    Inspected on: <asp:Label ID="Label1" ForeColor="Red" runat="server" Text='<%#Eval("SavedTime") %>' Font-Underline="true"></asp:Label> by: <asp:Label ID="Label2" ForeColor="Red" runat="server" Text='<%#Eval("SavedBy") %>' Font-Underline="true"></asp:Label>
</p>
<table rules="all" border="solid" style="border: 2px solid #000000; width: 1000px;">
<tr>
    <td style="border: 1px solid #000000; font-weight: bold; width: 4%;">No.</td>
    <td style="border: 1px solid #000000; font-weight: bold; width: 80%;">ITEM </td>
    <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Pass</td>
    <td style="border: 1px solid #000000; font-weight: bold; width: 8%;">Fail</td>
</tr>
<tr>
    <td>1.</td>
    <td>Does the truck has two 9kg dry powder or 9 litre foam serviceable fire extinguishers and unlocked for immediate use with one extinguisher in the cabin?</td>
    <td>
        <asp:CheckBox ID="ExtinguishersCheck_1" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ExtinguishersCheck_1") == DBNull.Value ? false : Eval("ExtinguishersCheck_1") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="ExtinguishersCheck_1Fail" AutoPostBack="true" Enabled="false" runat="server"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu1" Key="YesNo1" TargetControlID="ExtinguishersCheck_1" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu2" Key="YesNo1" TargetControlID="ExtinguishersCheck_1Fail" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>2.</td>
    <td>Does the truck possess a duly filled truck inspection check list from omc?</td>
    <td>
        <asp:CheckBox ID="CheckomcCheclist" AutoPostBack="true" Enabled="false" Checked='<%# Eval("omcCheclist") == DBNull.Value ? false : Eval("omcCheclist") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox26" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MuomcCheclist" Key="YesNoomcCheclist" TargetControlID="CheckomcCheclist" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MuomcCheclist2" Key="YesNoomcCheclist" TargetControlID="CheckBox26" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>3.</td>
    <td>Are the 2 serviceable fire extinguishers labeled with the truck’s registration number and valid inspection certificate?</td>
    <td>
        <asp:CheckBox ID="ExtingushersLabel_2" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ExtingushersLabel_2") == DBNull.Value ? false : Eval("ExtingushersLabel_2") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox1" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu3" Key="YesNo2" TargetControlID="ExtingushersLabel_2" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu4" Key="YesNo2" TargetControlID="CheckBox1" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>4.</td>
    <td>Are all compartments empty of product or water?</td>
    <td>
        <asp:CheckBox ID="CompartmentsEmpty_3" AutoPostBack="true" Enabled="false" Checked='<%# Eval("CompartmentsEmpty_3") == DBNull.Value ? false : Eval("CompartmentsEmpty_3") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox2" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu5" Key="YesNo3" TargetControlID="CompartmentsEmpty_3" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu6" Key="YesNo3" TargetControlID="CheckBox2" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>5.</td>
    <td>Are the tyres in good condition?</td>
    <td>
        <asp:CheckBox ID="TyreCondition_4" AutoPostBack="true" Enabled="false" Checked='<%# Eval("TyreCondition_4") == DBNull.Value ? false : Eval("TyreCondition_4") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox3" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu7" Key="YesNo4" TargetControlID="TyreCondition_4" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu8" Key="YesNo4" TargetControlID="CheckBox3" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>6.</td>
    <td>Does the truck have any exposed wire?</td>
    <td>
        <asp:CheckBox ID="ExposedWires_5" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ExposedWires_5") == DBNull.Value ? false : Eval("ExposedWires_5") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox4" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu9" Key="YesNo5" TargetControlID="ExposedWires_5" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu10" Key="YesNo5" TargetControlID="CheckBox4" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>7.</td>
    <td>Does the truck have a functional battery cut out switch and tested in your presence?</td>
    <td>
        <asp:CheckBox ID="FunctionalBattery_6" AutoPostBack="true" Enabled="false" Checked='<%# Eval("FunctionalBattery_6") == DBNull.Value ? false : Eval("FunctionalBattery_6") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox5" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu11" Key="YesNo6" TargetControlID="FunctionalBattery_6" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu12" Key="YesNo6" TargetControlID="CheckBox5" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>8.</td>
    <td>Is the hand break in good working condition?</td>
    <td>
        <asp:CheckBox ID="HandBrakeCondition_7" Enabled="false" AutoPostBack="true" Checked='<%# Eval("HandBrakeCondition_7") == DBNull.Value ? false : Eval("HandBrakeCondition_7") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox6" runat="server" Enabled="false" AutoPostBack="true"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu13" Key="YesNo7" TargetControlID="HandBrakeCondition_7" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu14" Key="YesNo7" TargetControlID="CheckBox6" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>9.</td>
    <td>Is the exhaust pipe at the bottom of the truck?</td>
    <td>
        <asp:CheckBox ID="BottomExhaustPipe_8" AutoPostBack="true" Enabled="false" Checked='<%# Eval("BottomExhaustPipe_8") == DBNull.Value ? false : Eval("BottomExhaustPipe_8") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox7" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu15" Key="YesNo8" TargetControlID="BottomExhaustPipe_8" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="Mu16" Key="YesNo8" TargetControlID="CheckBox7" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>10.</td>
    <td>Is the exhaust pipe in good working condition?</td>
    <td>
        <asp:CheckBox ID="ExhaustCondition_9" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ExhaustCondition_9") == DBNull.Value ? false : Eval("ExhaustCondition_9") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox8" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender1" Key="YesNo9" TargetControlID="ExhaustCondition_9" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender2" Key="YesNo9" TargetControlID="CheckBox8" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>11.</td>
    <td>Is the correct flame arrestor properly fitted?</td>
    <td>
        <asp:CheckBox ID="FlameArrestorFitted_10" AutoPostBack="true" Enabled="false" Checked='<%# Eval("FlameArrestorFitted_10") == DBNull.Value ? false : Eval("FlameArrestorFitted_10") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox9" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender3" Key="YesNo10" TargetControlID="FlameArrestorFitted_10" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender4" Key="YesNo10" TargetControlID="CheckBox9" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>12.</td>
    <td>Does the truck self start?</td>
    <td>
        <asp:CheckBox ID="SelfStart_11" AutoPostBack="true" Enabled="false" Checked='<%# Eval("SelfStart_11") == DBNull.Value ? false : Eval("SelfStart_11") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox10" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender5" Key="YesNo11" TargetControlID="SelfStart_11" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender6" Key="YesNo11" TargetControlID="CheckBox10" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>13.</td>
    <td>Are battery terminals properly insulated?</td>
    <td>
        <asp:CheckBox ID="BatteryInsulated_12" AutoPostBack="true" Enabled="false" Checked='<%# Eval("BatteryInsulated_12") == DBNull.Value ? false : Eval("BatteryInsulated_12") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox11" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender7" Key="YesNo12" TargetControlID="BatteryInsulated_12" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender8" Key="YesNo12" TargetControlID="CheckBox11" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>14.</td>
    <td>Is the dashboard free of any exposed wires and properly covered?</td>
    <td>
        <asp:CheckBox ID="DashboardFree_13" AutoPostBack="true" Enabled="false" Checked='<%# Eval("DashboardFree_13") == DBNull.Value ? false : Eval("DashboardFree_13") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox12" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender9" Key="YesNo13" TargetControlID="DashboardFree_13" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender10" Key="YesNo13" TargetControlID="CheckBox12" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>15.</td>
    <td>Is the earthing/bonding plate appropriate and properly fixed?</td>
    <td>
        <asp:CheckBox ID="Earthingplate_14" AutoPostBack="true" Enabled="false" Checked='<%# Eval("Earthingplate_14") == DBNull.Value ? false : Eval("Earthingplate_14") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox13" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender11" Key="YesNo14" TargetControlID="Earthingplate_14" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender12" Key="YesNo14" TargetControlID="CheckBox13" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>16.</td>
    <td>Have all the containers,stoves,charcoal,sacks and tins been removed from the truck?</td>
    <td>
        <asp:CheckBox ID="ContainersRemoved_16" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ContainersRemoved_16") == DBNull.Value ? false : Eval("ContainersRemoved_16") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox14" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender15" Key="YesNo16" TargetControlID="ContainersRemoved_16" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender16" Key="YesNo16" TargetControlID="CheckBox14" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>17.</td>
    <td>Does the truck have proper sealing facilities?</td>
    <td>
        <asp:CheckBox ID="ProperSealing_18" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ProperSealing_18") == DBNull.Value ? false : Eval("ProperSealing_18") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox16" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender19" Key="YesNo18" TargetControlID="ProperSealing_18" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender20" Key="YesNo18" TargetControlID="CheckBox16" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>18.</td>
    <td>Does the truck have a 'DANGER PETROLEUM' sign at the left,right or rear of the truck?</td>
    <td>
        <asp:CheckBox ID="DangerPetroleumSign_20" AutoPostBack="true" Enabled="false" Checked='<%# Eval("DangerPetroleumSign_20") == DBNull.Value ? false : Eval("DangerPetroleumSign_20") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox17" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender21" Key="YesNo19" TargetControlID="DangerPetroleumSign_20" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender22" Key="YesNo19" TargetControlID="CheckBox17" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>19.</td>
    <td>Is the engine oil leaking?</td>
    <td>
        <asp:CheckBox ID="OilLeaking_21" AutoPostBack="true" Enabled="false" Checked='<%# Eval("OilLeaking_21") == DBNull.Value ? false : Eval("OilLeaking_21") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox18" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender23" Key="YesNo20" TargetControlID="OilLeaking_21" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender24" Key="YesNo20" TargetControlID="CheckBox18" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>20.</td>
    <td>Is the truck valve coupling compatible (for bottom loading)?</td>
    <td>
        <asp:CheckBox ID="ValveCouplingComp_22" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ValveCouplingComp_22") == DBNull.Value ? false : Eval("ValveCouplingComp_22") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox19" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender25" Key="YesNo21" TargetControlID="ValveCouplingComp_22" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender26" Key="YesNo21" TargetControlID="CheckBox19" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>21.</td>
    <td>Are there any broken lights/covers etc?</td>
    <td>
        <asp:CheckBox ID="BrokenLights_23" AutoPostBack="true" Enabled="false" Checked='<%# Eval("BrokenLights_23") == DBNull.Value ? false : Eval("BrokenLights_23") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox20" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender27" Key="YesNo22" TargetControlID="BrokenLights_23" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender28" Key="YesNo22" TargetControlID="CheckBox20" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>22.</td>
    <td>K/E/N Number</td>
    <td>
        <asp:CheckBox ID="KEN_Number_24" AutoPostBack="true" Enabled="false" Checked='<%# Eval("KEN_Number_24") == DBNull.Value ? false : Eval("KEN_Number_24") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox21" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender29" Key="YesNo23" TargetControlID="KEN_Number_24" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender30" Key="YesNo23" TargetControlID="CheckBox21" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>23.</td>
    <td>Does the truck's ladder allow enough foot space and made of chequered surface?</td>
    <td>
        <asp:CheckBox ID="TruckLadderSpace_25" AutoPostBack="true" Enabled="false" Checked='<%# Eval("TruckLadderSpace_25") == DBNull.Value ? false : Eval("TruckLadderSpace_25") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox22" runat="server" AutoPostBack="true" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender31" Key="YesNo24" TargetControlID="TruckLadderSpace_25" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender32" Key="YesNo24" TargetControlID="CheckBox22" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>24.</td>
    <td>Does the truck have 2 No.Wheel chokes chained on the truck?</td>
    <td>
        <asp:CheckBox ID="WheelChokesChaned_26" AutoPostBack="true" Enabled="false" Checked='<%# Eval("WheelChokesChaned_26") == DBNull.Value ? false : Eval("WheelChokesChaned_26") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox23" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender33" Key="YesNo25" TargetControlID="WheelChokesChaned_26" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender34" Key="YesNo25" TargetControlID="CheckBox23" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>25.</td>
    <td>The driver has necessary PPE(i.e safety Helmet, Hand gloves, overall, Safety Boots etc)?</td>
    <td>
        <asp:CheckBox ID="necessary_PPE" AutoPostBack="true" Enabled="false" Checked='<%# Eval("necessary_PPE") == DBNull.Value ? false : Eval("necessary_PPE") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox24" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender13" Key="YesNonecessary_PPE" TargetControlID="necessary_PPE" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender14" Key="YesNonecessary_PPE" TargetControlID="CheckBox24" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>26.</td>
    <td>Driver’s cabin is free of any dangerous weapons?</td>
    <td>
        <asp:CheckBox ID="CheckDanger" AutoPostBack="true" Enabled="false" Checked='<%# Eval("CheckDanger") == DBNull.Value ? false : Eval("CheckDanger") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox25" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender17" Key="YesNoCheckDanger" TargetControlID="CheckDanger" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender18" Key="YesNoCheckDanger" TargetControlID="CheckBox25" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>27.</td>
    <td>All ignition sources, e.g lighters, mobile phones and matches have been left at the gate?</td>
    <td>
        <asp:CheckBox ID="ignitionSources" AutoPostBack="true" Enabled="false" Checked='<%# Eval("ignitionSources") == DBNull.Value ? false : Eval("ignitionSources") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox28" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender35" Key="YesNoignitionSources" TargetControlID="ignitionSources" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender36" Key="YesNoignitionSources" TargetControlID="CheckBox28" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>28.</td>
    <td>The bottom valves have properly been sealed(local trucks only)?</td>
    <td>
        <asp:CheckBox ID="CheckBtmValves" AutoPostBack="true" Enabled="false" Checked='<%# Eval("CheckBtmValves") == DBNull.Value ? false : Eval("CheckBtmValves") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox27" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender37" Key="YesNoCheckBtmValves" TargetControlID="CheckBtmValves" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender38" Key="YesNoCheckBtmValves" TargetControlID="CheckBox27" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
<tr>
    <td>29.</td>
    <td>KPC Emergency instruction given to Driver before entry?</td>
    <td>
        <asp:CheckBox ID="CheckERInst" AutoPostBack="true" Enabled="false" Checked='<%# Eval("CheckERInst") == DBNull.Value ? false : Eval("CheckERInst") %>' runat="server"/>
    </td>
    <td>
        <asp:CheckBox ID="CheckBox29" AutoPostBack="true" runat="server" Enabled="false"/>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender39" Key="YesNoCheckERInst" TargetControlID="CheckERInst" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
        <asp:MutuallyExclusiveCheckBoxExtender ID="MutuallyExclusiveCheckBoxExtender40" Key="YesNoCheckERInst" TargetControlID="CheckBox29" runat="server">
        </asp:MutuallyExclusiveCheckBoxExtender>
    </td>
</tr>
</table>

<p style="height: 1px; visibility: hidden; width: 600px;">
    26. Insurance/PTA cover <asp:TextBox ID="InsuranceptaTxt" Text='<%# Bind("Insurance_PTAcover_27") %>' runat="server"></asp:TextBox> Expiry date <asp:TextBox ID="InsurancetxtPtaExp" Text='<%# Bind("Ins_PTAcoverExpDate") %>' runat="server"></asp:TextBox><br/><br/>
    <br/><br/>
    Release status:<asp:DropDownList ID="DropDownRelease" DataTextField="ReleaseStatus" DataValueField="ReleaseStatus" SelectedValue='<%# Bind("ReleaseStatus") %>' runat="server">
        <asp:ListItem Text="Select as appropriate" Value=""></asp:ListItem>
        <asp:ListItem Text="Accepted" Value="True"></asp:ListItem>
        <asp:ListItem Text="Denied" Value="False"></asp:ListItem>
    </asp:DropDownList><br/><br/>
    HSE INSPECTION OFFICIAL: NAME <asp:TextBox ID="HSETextOfficial" ReadOnly="true" Text='<%# Bind("HSEInspOfficial") %>' runat="server"></asp:TextBox>
</p>
<asp:Panel ID="CommentPanel" runat="server">
    Immediate corrective action<br/>
    <asp:TextBox ID="ImmCorrectiveTxt" Text='<%# Bind("ImmCorrAction") %>' Width="500px" Enabled="false" TextMode="MultiLine" runat="server"></asp:TextBox>

</asp:Panel>
<br/>
Waiver Comment:<br/>
<asp:TextBox ID="txtWaiveComment" ValidationGroup="Comment" Width="500px" TextMode="MultiLine" runat="server"></asp:TextBox><br/>
<asp:RequiredFieldValidator ID="ReqReason" ControlToValidate="txtWaiveComment" ValidationGroup="Comment" runat="server" ErrorMessage="You must enter a comment"></asp:RequiredFieldValidator>
<p>
    <asp:Button ID="SaveBtn" CommandName="Update" ValidationGroup="Comment" CssClass="btn" runat="server" Visible="false" Text="SAVE"/><asp:Button ID="ApproveBtn" runat="server" CssClass="btn" Text="WAIVE TRUCK" ValidationGroup="Comment" onclick="ApproveBtn_Click"/>&nbsp;&nbsp;&nbsp;
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
                   SelectCommand="SELECT * FROM SafetySecurity_A INNER JOIN NewQueue ON SafetySecurity_A.QueueID = NewQueue.QueueID WHERE (NewQueue.ID = @ID)"

                   UpdateCommand="UPDATE SafetySecurity_A SET InspectionDate_A = @InspectionDate_A, ExtinguishersCheck_1 = @ExtinguishersCheck_1, ExtingushersLabel_2 = @ExtingushersLabel_2, CompartmentsEmpty_3 = @CompartmentsEmpty_3, TyreCondition_4 = @TyreCondition_4, ExposedWires_5 = @ExposedWires_5, FunctionalBattery_6 = @FunctionalBattery_6, HandBrakeCondition_7 = @HandBrakeCondition_7, BottomExhaustPipe_8 = @BottomExhaustPipe_8, ExhaustCondition_9 = @ExhaustCondition_9, FlameArrestorFitted_10 = @FlameArrestorFitted_10, SelfStart_11 = @SelfStart_11, BatteryInsulated_12 = @BatteryInsulated_12, DashboardFree_13 = @DashboardFree_13, Earthingplate_14 = @Earthingplate_14, ValidCalibrationChart_15 = @ValidCalibrationChart_15, ContainersRemoved_16 = @ContainersRemoved_16, RegNo_Tally_OrderNo_17 = @RegNo_Tally_OrderNo_17, ProperSealing_18 = @ProperSealing_18, DangerPetroleumSign_20 = @DangerPetroleumSign_20, OilLeaking_21 = @OilLeaking_21, ValveCouplingComp_22 = @ValveCouplingComp_22, BrokenLights_23 = @BrokenLights_23, KEN_Number_24 = @KEN_Number_24, TruckLadderSpace_25 = @TruckLadderSpace_25, WheelChokesChaned_26 = @WheelChokesChaned_26, Insurance_PTAcover_27 = @Insurance_PTAcover_27, Ins_PTAcoverExpDate = @Ins_PTAcoverExpDate, ImmCorrAction = @ImmCorrAction, ReleaseStatus = @ReleaseStatus, ReleaseStatusTime = @ReleaseStatusTime, HSEInspOfficial = @HSEInspOfficial, SavedTime = @SavedTime, SavedBy = @SavedBy FROM SafetySecurity_A INNER JOIN NewQueue ON SafetySecurity_A.QueueID = NewQueue.QueueID WHERE (SafetySecurity_A.QueueID = @QueueID)">
    <SelectParameters>
        <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="InspectionDate_A"/>
        <asp:Parameter Name="ExtinguishersCheck_1"/>
        <asp:Parameter Name="ExtingushersLabel_2"/>
        <asp:Parameter Name="CompartmentsEmpty_3"/>
        <asp:Parameter Name="TyreCondition_4"/>
        <asp:Parameter Name="ExposedWires_5"/>
        <asp:Parameter Name="FunctionalBattery_6"/>
        <asp:Parameter Name="HandBrakeCondition_7"/>
        <asp:Parameter Name="BottomExhaustPipe_8"/>
        <asp:Parameter Name="ExhaustCondition_9"/>
        <asp:Parameter Name="FlameArrestorFitted_10"/>
        <asp:Parameter Name="SelfStart_11"/>
        <asp:Parameter Name="BatteryInsulated_12"/>
        <asp:Parameter Name="DashboardFree_13"/>
        <asp:Parameter Name="Earthingplate_14"/>
        <asp:Parameter Name="ValidCalibrationChart_15"/>
        <asp:Parameter Name="ContainersRemoved_16"/>
        <asp:Parameter Name="RegNo_Tally_OrderNo_17"/>
        <asp:Parameter Name="ProperSealing_18"/>
        <asp:Parameter Name="DangerPetroleumSign_20"/>
        <asp:Parameter Name="OilLeaking_21"/>
        <asp:Parameter Name="ValveCouplingComp_22"/>
        <asp:Parameter Name="BrokenLights_23"/>
        <asp:Parameter Name="KEN_Number_24"/>
        <asp:Parameter Name="TruckLadderSpace_25"/>
        <asp:Parameter Name="WheelChokesChaned_26"/>
        <asp:Parameter Name="Insurance_PTAcover_27"/>
        <asp:Parameter Name="Ins_PTAcoverExpDate"/>
        <asp:Parameter Name="ImmCorrAction"/>
        <asp:Parameter Name="ReleaseStatus"/>
        <asp:Parameter Name="ReleaseStatusTime"/>
        <asp:Parameter Name="HSEInspOfficial"/>
        <asp:Parameter Name="SavedTime"/>
        <asp:Parameter Name="SavedBy"/>
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
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>