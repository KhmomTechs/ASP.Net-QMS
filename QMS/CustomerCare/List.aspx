<%@ Page Title="" Language="C#" MasterPageFile="~/Master/CustomerCare.master" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="CustomerCare.CustomerCare_List" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("list").className = "active";
</script>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:Timer ID="AutoRefreshTimer" runat="server" Interval="5000" ontick="AutoRefreshTimer_Tick"/>
<div style="margin: 0px; width: 1200px;">
    <h3>Customer care-Order approval</h3>
</div>
<table style="margin-top: 0px; width: 1200px;">
<tr>
<td style="text-align: left; vertical-align: top;">
    <asp:Panel ID="PanelExp" Height="420px" Visible="false" runat="server">
        <h4>EXPORT QUEUE</h4>
        <div class="gridBorder" style="min-height: 335px"">
            <asp:GridView ID="GridExp" runat="server" Width="1000px" AutoGenerateColumns="False" DataSourceID="SqlExportSource"
                          DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="true" PageSize="10"
                          BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                    SortExpression="Queue_No"/>
                    <asp:BoundField DataField="Shipper" ItemStyle-Width="150px" HeaderText="SHIPPER"
                                    SortExpression="Shipper"/>
                    <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="300px">
                        <ItemTemplate>
                            <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&view=export" + "&order=" + Eval("LO_NO") %>' Text="APPROVE" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Status"/>
                    <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Suspended"/>
                    <asp:TemplateField HeaderText="REQ">
                        <ItemTemplate>
                            <asp:CheckBox ID="ChkExpReq" runat="server" Checked='<%# Eval("Requeued") == DBNull.Value ? false : Eval("Requeued") %>' oncheckedchanged="ChkExpReq_CheckedChanged" AutoPostBack="true"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ControlStyle-CssClass="Visibility" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="Que_ID" runat="server" CssClass="Visibility" Text='<%# Eval("QueueID") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle CssClass="Visibility"/>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC"/>
                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                <EmptyDataTemplate>
                    <div style="width: 100%;">No orders in the system</div>
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
            <asp:GridView ID="GridLocal" runat="server" Width="1000px" AutoGenerateColumns="False"
                          DataKeyNames="QueueID" BackColor="#CCCCCC" AllowPaging="True" DataSourceID="SqlLocalSource"
                          BorderColor="#000000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                          CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                    SortExpression="Queue_No"/>
                    <asp:BoundField DataField="Shipper" ItemStyle-Width="150px" HeaderText="SHIPPER"
                                    SortExpression="Shipper"/>
                    <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="200px">
                        <ItemTemplate>
                            <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
                    <asp:TemplateField HeaderText="">
                        <ItemTemplate>
                            <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&view=local" + "&order=" + Eval("LO_NO") %>' Text="APPROVE" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Status"/>
                    <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                    SortExpression="Suspended"/>
                    <asp:TemplateField HeaderText="REQ">
                        <ItemTemplate>
                            <asp:CheckBox ID="ChkLocReq" runat="server" Checked='<%# Eval("Requeued") == DBNull.Value ? false : Eval("Requeued") %>' oncheckedchanged="ChkLocReq_CheckedChanged" AutoPostBack="true"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ControlStyle-CssClass="Visibility" Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="Que_ID" runat="server" CssClass="Visibility" Text='<%# Eval("QueueID") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle CssClass="Visibility"/>
                    </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#CCCCCC"/>
                <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" Height="25px"/>
                <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                <EmptyDataTemplate>
                    <div style="width: 100%;">No orders in the system</div>
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
            <asp:BoundField DataField="JET" HeaderText="JET"
                            SortExpression="JET"/>
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
            <div style="width: 100%;">No order found matching that order number</div>
        </EmptyDataTemplate>
        <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
        <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
    </asp:GridView>
</td>
<td style="text-align: left; vertical-align: top; width: 250px;">
    <div style="padding-left: 10px">
        <div class="Visibility">
            <h4>Search by OrderNo.</h4>
            <p>
                <asp:TextBox ID="TextSearch" CssClass="Enter" ValidationGroup="Go" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqSearch" runat="server" ValidationGroup="Go" ControlToValidate="TextSearch" ErrorMessage="*"></asp:RequiredFieldValidator>

                <asp:CompareValidator ID="CompareTextTrail" ValidationGroup="Go" runat="server" ControlToValidate="TextSearch" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                <asp:RangeValidator ID="RangeTextTrail" ValidationGroup="Go" ControlToValidate="TextSearch" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
            </p>
            <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Get Order"
                        ValidationGroup="Go" onclick="btnGo_Click"/>
            <p>
                <br/>
            </p>
        </div>
        <p class="Visibility">
            <asp:Button ID="btnDisable" CssClass="btn" runat="server" Text="REQUEUE SELECTED ORDERS" onclick="btnDisable_Click" OnClientClick="return confirm('Are you sure?');"/>
        </p>
    </div>
</td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
<asp:SqlDataSource ID="SqlLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, CustomerCare.*, SafetySecurity_A.* FROM NewQueue INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID INNER JOIN SafetySecurity_A ON NewQueue.QueueID = SafetySecurity_A.QueueID WHERE (NewQueue.Type = 'Local') AND (NewQueue.Status = 'CUST') AND (SafetySecurity_A.ReleaseStatus = 'True') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, CustomerCare.*, SafetySecurity_A.* FROM NewQueue INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID INNER JOIN SafetySecurity_A ON NewQueue.QueueID = SafetySecurity_A.QueueID WHERE (NewQueue.Type = 'Export') AND (NewQueue.Status = 'CUST') AND (SafetySecurity_A.ReleaseStatus = 'True') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>