<%@ Page Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="SAP_New.aspx.cs" Inherits="Pipecor.Pipecor_SAP_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("sap").className = "active";
</script>
<link href="../Styles.css" rel="stylesheet" type="text/css"/>
<link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
<div style="margin: 0px; width: 1200px;">
    <h3>SAP - Orders</h3>
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

        <asp:GridView ID="GridExp" runat="server" Width="1200px" AllowPaging="True" DataKeyNames="SAP_Request_No"
                      AutoGenerateColumns="False" DataSourceID="SqlExportSource" BackColor="#CCCCCC" EnableViewState="False"
                      BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" EnableSortingAndPagingCallbacks="True"
                      CellSpacing="2" ForeColor="Black" OnRowDataBound="Grid_ExportRowDataBound">
            <Columns>
                <asp:BoundField DataField="Loading_Order_No" HeaderText="L.O.NO" SortExpression="Loading_Order_No"/>
                <asp:BoundField DataField="OMC_Code" HeaderText="SHIPPER" SortExpression="OMC_Code"/>
                <asp:TemplateField SortExpression="Prime_Mover" HeaderText="REGISTRATION">
                    <ItemTemplate>
                        <asp:Label ID="REGISTRATION" runat="server" Text='<%# Bind("Prime_Mover") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Material" HeaderText="PRODUCT" SortExpression="Material" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
                <asp:TemplateField HeaderText="MSP" SortExpression="MSP">
                    <ItemTemplate>
                        <asp:Label ID="MSP" runat="server" Text='<%# Bind("MSP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGO" SortExpression="AGO">
                    <ItemTemplate>
                        <asp:Label ID="AGO" runat="server" Text='<%# Bind("AGO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="KERO" SortExpression="KERO">
                    <ItemTemplate>
                        <asp:Label ID="KERO" runat="server" Text='<%# Bind("KERO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JET" SortExpression="JET">
                    <ItemTemplate>
                        <asp:Label ID="JET" runat="server" Text='<%# Bind("JET") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="KRA_NO" HeaderText="KRA NO" SortExpression="KRA_NO"/>
                <asp:TemplateField HeaderText="REJECT">
                    <ItemTemplate>
                        <asp:CheckBox ID="ChkReject" runat="server" Checked='<%# Eval("Rejected") == DBNull.Value ? false : Eval("Rejected") %>' oncheckedchanged="ChkExportReject_CheckedChanged" AutoPostBack="true"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="" ItemStyle-Width="70px">
                    <ItemTemplate>
                        <asp:Button ID="btnExportQueue" runat="server" CausesValidation="false" CssClass="butt2" onclick="btnExportQueue_Click" OnClientClick="return confirm('Are you sure?');" Text="QUEUE ORDER"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-CssClass="Visibility" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="SAP_ID" runat="server" CssClass="Visibility" Text='<%# Eval("SAP_Request_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Loading_Order_No">
                    <ItemTemplate>
                        <asp:Label ID="LONO" runat="server" Text='<%# Bind("Loading_Order_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="OMC_Code">
                    <ItemTemplate>
                        <asp:Label ID="SHIPPER" runat="server" Text='<%# Bind("OMC_Code") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:BoundField DataField="Rejected" HeaderText="" SortExpression="Rejected" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"/>
                <asp:TemplateField SortExpression="TRAILER_TEXT">
                    <ItemTemplate>
                        <asp:Label ID="TRAILER_TEXT" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="DRIVER_NUMBER">
                    <ItemTemplate>
                        <asp:Label ID="DRIVER_NUMBER" runat="server" Text='<%# Bind("DRIVER_NUMBER") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
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
        <asp:GridView ID="GridLocal" runat="server" Width="1200px" AllowPaging="True" DataKeyNames="SAP_Request_No"
                      AutoGenerateColumns="False" DataSourceID="SqlLocalSource" BackColor="#CCCCCC" EnableViewState="False"
                      BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" EnableSortingAndPagingCallbacks="True"
                      CellSpacing="2" ForeColor="Black" OnRowDataBound="Grid_LocalRowDataBound">
            <Columns>
                <asp:BoundField DataField="Loading_Order_No" HeaderText="L.O.NO" SortExpression="Loading_Order_No"/>
                <asp:BoundField DataField="OMC_Code" HeaderText="SHIPPER" SortExpression="OMC_Code"/>
                <asp:TemplateField SortExpression="Prime_Mover" HeaderText="REGISTRATION">
                    <ItemTemplate>
                        <asp:Label ID="REGISTRATION" runat="server" Text='<%# Bind("Prime_Mover") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Material" HeaderText="PRODUCT" SortExpression="Material" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
                <asp:TemplateField HeaderText="MSP" SortExpression="MSP">
                    <ItemTemplate>
                        <asp:Label ID="MSP" runat="server" Text='<%# Bind("MSP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGO" SortExpression="AGO">
                    <ItemTemplate>
                        <asp:Label ID="AGO" runat="server" Text='<%# Bind("AGO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="KERO" SortExpression="KERO">
                    <ItemTemplate>
                        <asp:Label ID="KERO" runat="server" Text='<%# Bind("KERO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="JET" SortExpression="JET">
                    <ItemTemplate>
                        <asp:Label ID="JET" runat="server" Text='<%# Bind("JET") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="KRA_NO" HeaderText="KRA NO" SortExpression="KRA_NO"/>
                <asp:TemplateField HeaderText="REJECT">
                    <ItemTemplate>
                        <asp:CheckBox ID="ChkReject" runat="server" Checked='<%# Eval("Rejected") == DBNull.Value ? false : Eval("Rejected") %>' oncheckedchanged="ChkLocalReject_CheckedChanged" AutoPostBack="true"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-Width="70px" HeaderText="" ItemStyle-Width="70px">
                    <ItemTemplate>
                        <asp:Button ID="btnLocalQueue" runat="server" CausesValidation="false" CssClass="butt2" onclick="btnLocalQueue_Click" OnClientClick="return confirm('Are you sure?');" Text="QUEUE ORDER"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-CssClass="Visibility" Visible="false">
                    <ItemTemplate>
                        <asp:Label ID="SAP_ID" runat="server" CssClass="Visibility" Text='<%# Eval("SAP_Request_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Loading_Order_No">
                    <ItemTemplate>
                        <asp:Label ID="LONO" runat="server" Text='<%# Bind("Loading_Order_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="OMC_Code">
                    <ItemTemplate>
                        <asp:Label ID="SHIPPER" runat="server" Text='<%# Bind("OMC_Code") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:BoundField DataField="Rejected" HeaderText="" SortExpression="Rejected" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"/>
                <asp:TemplateField SortExpression="TRAILER_TEXT">
                    <ItemTemplate>
                        <asp:Label ID="TRAILER_TEXT" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="DRIVER_NUMBER">
                    <ItemTemplate>
                        <asp:Label ID="DRIVER_NUMBER" runat="server" Text='<%# Bind("DRIVER_NUMBER") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
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
                   SelectCommand="SELECT * FROM [SAP_Orders] WHERE (([Status] = @Status) AND ([Material_Type] = @Material_Type)) AND ([Delivery_Date] = @TheDate) ORDER BY [Request_Creation_Date] DESC, [Request_Creation_Time] DESC">
    <SelectParameters>
        <asp:Parameter Name="Status" Type="String" DefaultValue="PIPCOR"/>
        <asp:Parameter DefaultValue="LOCAL" Name="Material_Type" Type="String"/>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM [SAP_Orders] WHERE (([Status] = @Status) AND ([Material_Type] = @Material_Type)) AND ([Delivery_Date] = @TheDate) ORDER BY [Request_Creation_Date] DESC, [Request_Creation_Time] DESC">
    <SelectParameters>
        <asp:Parameter Name="Status" Type="String" DefaultValue="PIPCOR"/>
        <asp:Parameter DefaultValue="EXPORT" Name="Material_Type" Type="String"/>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

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
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND Archived IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="TotalLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND Archived IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>