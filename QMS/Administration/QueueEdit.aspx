<%@ Page Language="C#" MasterPageFile="~/Master/Admin.master" AutoEventWireup="true" CodeFile="QueueEdit.aspx.cs" Inherits="Administration.Administration_QueueEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("edit").className = "active";
</script>
<link href="../Styles.css" rel="stylesheet" type="text/css"/>
<link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
<div style="margin: 0px; width: 1200px;">
    <h3>Admin - Queue edit</h3>
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:Timer ID="AutoRefreshTimer" runat="server" Interval="100000" ontick="AutoRefreshTimer_Tick"/>
<table style="margin-top: 0px; width: 1200px;">
    <tr>
        <td style="text-align: left; vertical-align: top;">
            <asp:Panel ID="PanelExp" Height="420px" Visible="false" runat="server">
                <h4>EXPORT QUEUE</h4>
                <div class="gridBorder" style="min-height: 335px">
                    <asp:GridView ID="GridExp" runat="server" Width="1200px"
                                  AutoGenerateColumns="False" DataSourceID="SqlExportSource"
                                  DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="false" AllowPaging="true"
                                  PageSize="10" AutoGenerateEditButton="true"
                                  BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px"
                                  CellPadding="4" EnableSortingAndPagingCallbacks="true"
                                  CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound"
                                  onrowupdated="GridExp_RowUpdated" onrowupdating="GridExp_RowUpdating">
                        <Columns>
                            <asp:BoundField DataField="Queue_No" HeaderText="No."
                                            SortExpression="Queue_No"/>
                            <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                            SortExpression="Shipper"/>
                            <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                            SortExpression="Registration"/>
                            <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                            SortExpression="LO_NO"/>
                            <asp:BoundField DataField="MSP" HeaderText="MSP"
                                            SortExpression="MSP"/>
                            <asp:BoundField DataField="AGO" HeaderText="AGO"
                                            SortExpression="AGO"/>
                            <asp:BoundField DataField="KERO" HeaderText="KERO"
                                            SortExpression="KERO"/>
                            <asp:BoundField DataField="JET" HeaderText="JET"
                                            SortExpression="JET"/>
                            <asp:TemplateField HeaderText="STATUS" SortExpression="Status">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="Drop_Status" runat="server" DataTextField="Status" Width="100px" DataValueField="Status" SelectedValue='<%# Bind("Status") %>'>
                                        <asp:ListItem Text="SECURITY" Value="SECTA"></asp:ListItem>
                                        <asp:ListItem Text="STOCK CONTROL" Value="STK"></asp:ListItem>
                                        <asp:ListItem Text="CUSTOMER CARE" Value="CUST"></asp:ListItem>
                                        <asp:ListItem Text="SAFETY" Value="SAFTY"></asp:ListItem>
                                        <asp:ListItem Text="SAFETY CONCERNS" Value="SAFCON"></asp:ListItem>
                                        <asp:ListItem Text="NO TRUCK-SAFETY" Value="SAFNT"></asp:ListItem>
                                        <asp:ListItem Text="DISPATCH" Value="DISPATCH"></asp:ListItem>
                                        <asp:ListItem Text="SECURITY VERIFICATION" Value="SECVE"></asp:ListItem>
                                        <asp:ListItem Text="SECURITY CONCERNS" Value="SECCO"></asp:ListItem>
                                        <asp:ListItem Text="NO TRUCK-SECURITY" Value="SECTNA"></asp:ListItem>
                                        <asp:ListItem Text="LOAD CLEARANCE" Value="LODCLE"></asp:ListItem>
                                        <asp:ListItem Text="OMC CLEARANCE" Value="OMCCLE"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabelStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px"/>
                            </asp:TemplateField>
                            <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="220px" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" ReadOnly="true"
                                            SortExpression="StatusTime"/>
                            <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                            SortExpression="Entitlement"/>
                            <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="Suspended"/>
                            <asp:BoundField DataField="Type" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="Type"/>
                            <asp:BoundField DataField="QueueID" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="QueueID"/>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC"/>
                        <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                        <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                        <AlternatingRowStyle Font-Size="16px" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                        <EmptyDataTemplate>
                            <div style="width: 100%;">No trucks in the system</div>
                        </EmptyDataTemplate>
                        <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                        <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                    </asp:GridView>

                </div>
                <p style="vertical-align: bottom;">
                    <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn" Text="Switch to Local Queue"
                                onclick="LocSwitchBtn_Click"/>
                </p>
            </asp:Panel>

            <asp:Panel ID="PanelLoc" Height="420px" runat="server">
                <h4>LOCAL QUEUE</h4>
                <div class="gridBorder" style="min-height: 335px;">
                    <asp:GridView ID="GridLocal" runat="server" Width="1200px" AutoGenerateColumns="False"
                                  DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="false" DataSourceID="SqlLocalSource"
                                  AllowPaging="true" PageSize="10" EnableSortingAndPagingCallbacks="true" AutoGenerateEditButton="true"
                                  BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                                  CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound"
                                  onrowupdated="GridLocal_RowUpdated" onrowupdating="GridLocal_RowUpdating">
                        <Columns>
                            <asp:BoundField DataField="Queue_No" HeaderText="No."
                                            SortExpression="Queue_No"/>
                            <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER"
                                            SortExpression="Shipper"/>
                            <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                            SortExpression="Registration"/>
                            <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                            SortExpression="LO_NO"/>
                            <asp:BoundField DataField="MSP" HeaderText="MSP"
                                            SortExpression="MSP"/>
                            <asp:BoundField DataField="AGO" HeaderText="AGO"
                                            SortExpression="AGO"/>
                            <asp:BoundField DataField="KERO" HeaderText="KERO"
                                            SortExpression="KERO"/>
                            <asp:BoundField DataField="JET" HeaderText="JET"
                                            SortExpression="JET"/>
                            <asp:TemplateField HeaderText="STATUS" SortExpression="Status">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="Drop_Status" runat="server" DataTextField="Status" Width="100px" DataValueField="Status" SelectedValue='<%# Bind("Status") %>'>
                                        <asp:ListItem Text="SECURITY" Value="SECTA"></asp:ListItem>
                                        <asp:ListItem Text="STOCK CONTROL" Value="STK"></asp:ListItem>
                                        <asp:ListItem Text="CUSTOMER CARE" Value="CUST"></asp:ListItem>
                                        <asp:ListItem Text="SAFETY" Value="SAFTY"></asp:ListItem>
                                        <asp:ListItem Text="SAFETY CONCERNS" Value="SAFCON"></asp:ListItem>
                                        <asp:ListItem Text="NO TRUCK-SAFETY" Value="SAFNT"></asp:ListItem>
                                        <asp:ListItem Text="DISPATCH" Value="DISPATCH"></asp:ListItem>
                                        <asp:ListItem Text="SECURITY VERIFICATION" Value="SECVE"></asp:ListItem>
                                        <asp:ListItem Text="SECURITY CONCERNS" Value="SECCO"></asp:ListItem>
                                        <asp:ListItem Text="NO TRUCK-SECURITY" Value="SECTNA"></asp:ListItem>
                                        <asp:ListItem Text="LOAD CLEARANCE" Value="LODCLE"></asp:ListItem>
                                        <asp:ListItem Text="OMC CLEARANCE" Value="OMCCLE"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LabelStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px"/>
                            </asp:TemplateField>
                            <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="220px" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" ReadOnly="true"
                                            SortExpression="StatusTime"/>
                            <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                            SortExpression="Entitlement"/>
                            <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="Suspended"/>
                            <asp:BoundField DataField="Type" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="Type"/>
                            <asp:BoundField DataField="QueueID" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                            SortExpression="QueueID"/>
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC"/>
                        <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                        <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                        <AlternatingRowStyle Font-Size="16px" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                        <EmptyDataTemplate>
                            <div style="width: 100%;">No trucks in the system</div>
                        </EmptyDataTemplate>
                        <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                        <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
                    </asp:GridView>

                </div>
                <p style="vertical-align: bottom;">
                    <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn" Text="Switch to Export Queue"
                                onclick="ExpSwitchBtn_Click"/>
                </p>
            </asp:Panel>

        </td>
    </tr>
</table>
<asp:SqlDataSource ID="SqlLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND Status != 'Finished' AND Archived IS NULL AND SetDate = @TheDate AND Finished IS NULL Order by NewQueue.Queue_No"
                   UpdateCommand="UPDATE NewQueue SET Queue_No = @Queue_No, Shipper = @Shipper, Registration = @Registration, LO_NO = @LO_NO, MSP = @MSP, AGO = @AGO, KERO = @KERO, JET = @JET, Status = @Status WHERE QueueID = @QueueID">
    <UpdateParameters>
        <asp:Parameter Name="Queue_No"/>
        <asp:Parameter Name="Shipper"/>
        <asp:Parameter Name="Registration"/>
        <asp:Parameter Name="LO_NO"/>
        <asp:Parameter Name="MSP"/>
        <asp:Parameter Name="AGO"/>
        <asp:Parameter Name="KERO"/>
        <asp:Parameter Name="JET"/>
        <asp:Parameter Name="Status"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND Status != 'Finished' AND Archived IS NULL AND SetDate = @TheDate AND Finished IS NULL Order by NewQueue.Queue_No"
                   UpdateCommand="UPDATE NewQueue SET Queue_No = @Queue_No, Shipper = @Shipper, Registration = @Registration, LO_NO = @LO_NO, MSP = @MSP, AGO = @AGO, KERO = @KERO, JET = @JET, Status = @Status WHERE QueueID = @QueueID">
    <UpdateParameters>
        <asp:Parameter Name="Queue_No"/>
        <asp:Parameter Name="Shipper"/>
        <asp:Parameter Name="Registration"/>
        <asp:Parameter Name="LO_NO"/>
        <asp:Parameter Name="MSP"/>
        <asp:Parameter Name="AGO"/>
        <asp:Parameter Name="KERO"/>
        <asp:Parameter Name="JET"/>
        <asp:Parameter Name="Status"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

<asp:FormView ID="View" DefaultMode="ReadOnly" CssClass="Visibility" EnableViewState="False" runat="server"
              DataSourceID="ViewDataSource">
    <ItemTemplate>
        <asp:Label ID="lblEditable_No" runat="server" Text='<%# Eval("Editable_No") %>'></asp:Label>
        <asp:Label ID="lblEditable_Shipper" runat="server" Text='<%# Eval("Editable_Shipper") %>'></asp:Label>
        <asp:Label ID="lblEditable_Reg" runat="server" Text='<%# Eval("Editable_Reg") %>'></asp:Label>
        <asp:Label ID="lblEditable_LONO" runat="server" Text='<%# Eval("Editable_LONO") %>'></asp:Label>
        <asp:Label ID="lblEditable_Quantity" runat="server" Text='<%# Eval("Editable_Quantity") %>'></asp:Label>
        <asp:Label ID="lblEditable_Product" runat="server" Text='<%# Eval("Editable_Product") %>'></asp:Label>
        <asp:Label ID="lblEditable_Status" runat="server" Text='<%# Eval("Editable_Status") %>'></asp:Label>
    </ItemTemplate>
</asp:FormView>

<asp:SqlDataSource ID="ViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT [Editable_No],[Editable_Shipper],[Editable_Reg],[Editable_LONO],[Editable_Quantity],[Editable_Product],[Editable_Status] FROM [Settings]">
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>