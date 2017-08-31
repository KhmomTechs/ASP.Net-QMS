<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Operations.master" AutoEventWireup="true" CodeFile="Suspend.aspx.cs" Inherits="Operations.Operations_Suspend" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("suspend").className = "active";
</script>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:Timer ID="AutoRefreshTimer" runat="server" Interval="900000" ontick="AutoRefreshTimer_Tick"/>
<div style="margin: 0px; width: 1400px;">
    <h3>Dispatch - Truck suspension</h3>
</div>
<table style="margin-top: 0px; width: 1400px;">
<tr>
<td style="text-align: left; vertical-align: top;">
    <asp:Panel ID="PanelExp" Height="420px" Visible="false" runat="server">
        <h4>EXPORT QUEUE</h4>
        <div class="gridBorder" style="min-height: 335px">
            <asp:GridView ID="GridExp" runat="server" Width="1200px" AutoGenerateColumns="False" DataSourceID="SqlExportSource"
                          DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="true" PageSize="10"
                          BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                    SortExpression="Queue_No"/>
                    <asp:BoundField DataField="Shipper" ItemStyle-Width="150px" HeaderText="SHIPPER"
                                    SortExpression="Shipper"/>
                    <asp:BoundField DataField="Registration" ItemStyle-Width="200px" HeaderText="REGISTRATION"
                                    SortExpression="Registration"/>
                    <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                    SortExpression="LO_NO"/>
                    <asp:BoundField DataField="Quantity" HeaderText="QUANTITY"
                                    SortExpression="Quantity"/>
                    <asp:BoundField DataField="Product" HeaderText="PRODUCT"
                                    SortExpression="Product"/>
                    <asp:TemplateField HeaderText="SUSPEND">
                        <ItemTemplate>
                            <asp:CheckBox ID="ExpSuspension" runat="server" Checked='<%# Eval("Suspended") == DBNull.Value ? false : Eval("Suspended") %>' oncheckedchanged="ExpSuspension_CheckedChanged" OnClick="return confirm('Are you sure?');"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="WITHDRAW">
                        <ItemTemplate>
                            <asp:CheckBox ID="ExpWithdrawal" runat="server" Checked='<%# Eval("Withdrawal") == DBNull.Value ? false : Eval("Withdrawal") %>' oncheckedchanged="ExpWithdrawal_CheckedChanged" OnClick="return confirm('Are you sure?');"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Status"/>
                    <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                        <ItemTemplate>
                            <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="COMMENT">
                        <ItemTemplate>
                            <table style="margin-top: 0px; width: 200px;">
                                <tr>
                                    <td style="text-align: left; vertical-align: top; width: 150px;">
                                        <asp:TextBox ID="txtExpComment" runat="server" Text='<%# Eval("Reason") %>'></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; vertical-align: top; width: 50px;">
                                        <asp:Button ID="btnExpComment" CssClass="butt1" runat="server" Text="Save"
                                                    onclick="btnExpComment_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC"/>
                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                <EmptyDataTemplate>
                    <div style="width: 100%;">No trucks in the system</div>
                </EmptyDataTemplate>
                <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
            </asp:GridView>

        </div>
        <p style="margin-top: 40px; vertical-align: bottom;">
            <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn" Text="Switch to Local Queue"
                        onclick="LocSwitchBtn_Click"/>
        </p>
    </asp:Panel>

    <asp:Panel ID="PanelLoc" Height="420px" runat="server">
        <h4>LOCAL QUEUE</h4>
        <div class="gridBorder" style="min-height: 335px">
            <asp:GridView ID="GridLocal" runat="server" Width="1200px" AutoGenerateColumns="False"
                          DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="True" DataSourceID="SqlLocalSource"
                          BorderColor="#000000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                    SortExpression="Queue_No"/>
                    <asp:BoundField DataField="Shipper" ItemStyle-Width="150px" HeaderText="SHIPPER"
                                    SortExpression="Shipper"/>
                    <asp:BoundField DataField="Registration" ItemStyle-Width="300px" HeaderText="REGISTRATION"
                                    SortExpression="Registration"/>
                    <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO"
                                    SortExpression="LO_NO"/>
                    <asp:BoundField DataField="MSP" HeaderText="MSP"
                                    SortExpression="MSP"/>
                    <asp:BoundField DataField="AGO" HeaderText="AGO"
                                    SortExpression="AGO"/>
                    <asp:BoundField DataField="KERO" HeaderText="KERO"
                                    SortExpression="KERO"/>
                    <asp:TemplateField HeaderText="SUSPEND">
                        <ItemTemplate>
                            <asp:CheckBox ID="LocSuspension" runat="server" Checked='<%# Eval("Suspended") == DBNull.Value ? false : Eval("Suspended") %>' oncheckedchanged="LocSuspension_CheckedChanged" OnClick="return confirm('Are you sure?');"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="WITHDRAW">
                        <ItemTemplate>
                            <asp:CheckBox ID="LocWithdrawal" runat="server" Checked='<%# Eval("Withdrawal") == DBNull.Value ? false : Eval("Withdrawal") %>' oncheckedchanged="LocWithdrawal_CheckedChanged" OnClick="return confirm('Are you sure?');"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Status"/>
                    <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                        <ItemTemplate>
                            <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="COMMENT">
                        <ItemTemplate>
                            <table style="margin-top: 0px; width: 200px;">
                                <tr>
                                    <td style="text-align: left; vertical-align: top; width: 150px;">
                                        <asp:TextBox ID="txtLocComment" runat="server" Text='<%# Eval("Reason") %>'></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; vertical-align: top; width: 50px;">
                                        <asp:Button ID="btnLocComment" CssClass="butt1" runat="server" Text="Save" onclick="btnLocComment_Click"/>
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC"/>
                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                <EmptyDataTemplate>
                    <div style="width: 100%;">No trucks in the system</div>
                </EmptyDataTemplate>
                <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
                <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
            </asp:GridView>

        </div>
        <p style="margin-top: 40px; vertical-align: bottom;">
            <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn" Text="Switch to Export Queue"
                        onclick="ExpSwitchBtn_Click"/>
        </p>
    </asp:Panel>


    <asp:GridView ID="GridResult" runat="server" Width="1000px" AutoGenerateColumns="False"
                  DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="True"
                  BorderColor="#000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                  CellSpacing="2" ForeColor="Black" onrowdatabound="GridResult_RowDataBound">
        <Columns>
            <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
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
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") %>' Text="Approve" ForeColor="Blue" runat="server"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
        <FooterStyle BackColor="#CCCCCC"/>
        <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
        <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
        <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
        <EmptyDataTemplate>
            <div style="width: 100%;">No truck found matching that order number</div>
        </EmptyDataTemplate>
        <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
        <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
    </asp:GridView>
</td>
<td style="text-align: left; vertical-align: top; width: 250px;">
    <div style="padding-left: 10px">
        <p>
            <asp:TextBox ID="TextSearch" Visible="false" CssClass="Enter" ValidationGroup="Go" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="ReqSearch" Visible="false" runat="server" ValidationGroup="Go" ControlToValidate="TextSearch" ErrorMessage="*"></asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:CompareValidator ID="CompareTextTrail" ValidationGroup="Go" runat="server" ControlToValidate="TextSearch" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
            <asp:RangeValidator ID="RangeTextTrail" ValidationGroup="Go" ControlToValidate="TextSearch" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
        </p>
        <asp:Button ID="btnGo" CssClass="btn" runat="server" Visible="false" Text="Get Order"
                    ValidationGroup="Go" onclick="btnGo_Click"/>
    </div>
</td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
<asp:SqlDataSource ID="SqlLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, SafetySecurity_A.*, Operations.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_A ON NewQueue.QueueID = SafetySecurity_A.QueueID WHERE (SafetySecurity_A.ReleaseStatus = 'True') AND (NewQueue.Type = 'Local') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (Operations.Cleared IS NULL) AND (NewQueue.Status = 'DISPATCH') AND SetDate = @TheDate ORDER BY NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, SafetySecurity_A.*, Operations.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_A ON NewQueue.QueueID = SafetySecurity_A.QueueID WHERE (SafetySecurity_A.ReleaseStatus = 'True') AND (NewQueue.Type = 'Export') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (Operations.Cleared IS NULL) AND (NewQueue.Status = 'DISPATCH') AND SetDate = @TheDate ORDER BY NewQueue.Queue_No">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>