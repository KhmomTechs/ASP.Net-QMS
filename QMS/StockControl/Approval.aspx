<%@ Page Title="" Language="C#" MasterPageFile="~/Master/StocKControl.master" AutoEventWireup="true" CodeFile="Approval.aspx.cs" Inherits="StockControl.StockControl_Approval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("approve").className = "active";
</script>
<div style="width: 100%;">
    <h3>Stock control-Entitlement approval</h3>
</div>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
<ContentTemplate>
<asp:Timer ID="AutoRefreshTimer" runat="server" Interval="40000" ontick="AutoRefreshTimer_Tick"/>
<table>
<tr>
<td style="text-align: left; vertical-align: top;">
<asp:Panel ID="PanelExp" runat="server" Height="420px" Visible="false">
    <h4>EXPORT QUEUE</h4>
    <div class="gridBorder" style="min-height: 335px">
        <asp:GridView ID="GridExpEntries" runat="server" AutoGenerateColumns="False"
                      Width="1050px" GridLines="Both" EnableViewState="false"
                      BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                      CellPadding="4" DataKeyNames="QueueID" DataSourceID="EntryExpSource"
                      AllowPaging="True" CellSpacing="2" PageSize="10"
                      ForeColor="Black" RowStyle-VerticalAlign="Bottom"
                      onrowdatabound="GridExpEntries_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="20px" HeaderText=""
                                   ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px"
                                   SortExpression="CustCareApproval">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server"
                                      Checked='<%# Eval("StControlApproval") == DBNull.Value ? false : Eval("StControlApproval") %>'/>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="CheckExpApp" runat="server" OnClientClick="return confirm('Are you sure?');" CausesValidation="false" Text="APPROVE" CssClass="butt2" onclick="CheckExpApp_Click"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Queue_No" HeaderStyle-Width="40px" HeaderText="No."
                                ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                <asp:BoundField DataField="Shipper" HeaderStyle-Width="140px"
                                HeaderText="SHIPPER" ItemStyle-Width="140px" ReadOnly="true"
                                SortExpression="Shipper"/>
                <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="250px">
                    <ItemTemplate>
                        <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LO_NO" HeaderStyle-Width="100px" HeaderText="L.O NO"
                                ItemStyle-Width="80px" ReadOnly="true" SortExpression="LO_NO"/>
                <asp:TemplateField SortExpression="MSP" HeaderText="MSP">
                    <ItemTemplate>
                        <asp:Label ID="MSP" runat="server" Text='<%# Bind("MSP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="AGO" HeaderText="AGO">
                    <ItemTemplate>
                        <asp:Label ID="AGO" runat="server" Text='<%# Bind("AGO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="KERO" HeaderText="KERO">
                    <ItemTemplate>
                        <asp:Label ID="KERO" runat="server" Text='<%# Bind("KERO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="JET" HeaderText="JET">
                    <ItemTemplate>
                        <asp:Label ID="JET" runat="server" Text='<%# Bind("JET") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ControlStyle-CssClass="Visibility" DataField="QueueID"
                                HeaderStyle-CssClass="Visibility" HeaderText="" ItemStyle-CssClass="Visibility"
                                ReadOnly="true" SortExpression="QueueID"/>
                <asp:TemplateField HeaderText="ENTITELEMENT" ControlStyle-Width="120px" SortExpression="Entitlement">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropEntExp" runat="server" AutoPostBack="true"
                                          DataTextField="Entitlement" DataValueField="Entitlement"
                                          OnSelectedIndexChanged="DropEntExp_SelectedIndexChanged"
                                          SelectedValue='<%# Bind("Entitlement") %>' Width="120px">
                            <asp:ListItem Text="CHOOSE" Value=""></asp:ListItem>
                            <asp:ListItem Text="ENTITLEMENT" Value="STK"></asp:ListItem>
                            <asp:ListItem Text="NO ENTITLEMENT" Value="STKNEN"></asp:ListItem>
                            <asp:ListItem Text="DECLARATION" Value="STKDEC"></asp:ListItem>
                            <asp:ListItem Text="NO PRODUCT" Value="STKNPR"></asp:ListItem>
                            <asp:ListItem Text="NO ORDER" Value="STKNO"></asp:ListItem>
                            <asp:ListItem Text="SIGNATURE NOT CONFIRMED" Value="STKCON"></asp:ListItem>
                            <asp:ListItem Text="NOT ORIGINAL DOCUMENT" Value="STKORIG"></asp:ListItem>
                            <asp:ListItem Text="WRONG VOLUMES" Value="STKWV"></asp:ListItem>
                            <asp:ListItem Text="KRA ENTRY" Value="STKKRA"></asp:ListItem>
                            <asp:ListItem Text="NO SIGNATURES" Value="STKNOSIG"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText="" HeaderStyle-CssClass="Visibility"
                                SortExpression="Status"/>
                <asp:BoundField DataField="Entitlement" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText="" HeaderStyle-CssClass="Visibility"
                                SortExpression="Entitlement"/>
                <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                SortExpression="Suspended"/>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckExportStock" AutoPostBack="true" runat="server" OnCheckedChanged="CheckExportStock_CheckedChanged"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Shipper">
                    <ItemTemplate>
                        <asp:Label ID="ShipperLbl" runat="server" Text='<%# Bind("Shipper") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="SAP_Request_No">
                    <ItemTemplate>
                        <asp:Label ID="SAP_Request_No" runat="server" Text='<%# Bind("SAP_Request_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Type">
                    <ItemTemplate>
                        <asp:Label ID="TypeLbl" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div style="width: 100%;">
                    No orders in the system to approve
                </div>
            </EmptyDataTemplate>
            <FooterStyle BackColor="#CCCCCC"/>
            <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
            <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
            <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
            <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
            <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
        </asp:GridView>
    </div>

    <p style="margin-top: 30px; vertical-align: bottom;">
        <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn"
                    onclick="LocSwitchBtn_Click" Text="Switch to Local Queue"/>
    </p>
</asp:Panel>
<asp:Panel ID="PanelLoc" runat="server" Height="420px">
    <h4>LOCAL QUEUE</h4>
    <div class="gridBorder" style="min-height: 335px">
        <asp:GridView ID="GridLocEntries" runat="server" AutoGenerateColumns="False" Width="1050px"
                      DataKeyNames="QueueID" DataSourceID="EntryLocSource"
                      ForeColor="Black" RowStyle-VerticalAlign="Bottom" GridLines="Both"
                      BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                      CellPadding="4" AllowPaging="true" PageSize="10" CellSpacing="2"
                      onrowdatabound="GridLocEntries_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderStyle-Width="20px" HeaderText=""
                                   ItemStyle-HorizontalAlign="Center" ItemStyle-Width="20px"
                                   SortExpression="CustCareApproval">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server"
                                      Checked='<%# Eval("StControlApproval") == DBNull.Value ? false : Eval("StControlApproval") %>'/>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Button ID="CheckLocApp" runat="server" OnClientClick="return confirm('Are you sure?');" CausesValidation="false" Text="APPROVE" CssClass="butt2" onclick="CheckLocApp_Click"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Queue_No" HeaderStyle-Width="40px" HeaderText="No."
                                ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                <asp:BoundField DataField="Shipper" HeaderStyle-Width="140px"
                                HeaderText="SHIPPER" ItemStyle-Width="140px" ReadOnly="true"
                                SortExpression="Shipper"/>
                <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="250px">
                    <ItemTemplate>
                        <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LO_NO" HeaderStyle-Width="100px" HeaderText="L.O NO"
                                ItemStyle-Width="80px" ReadOnly="true" SortExpression="LO_NO"/>
                <asp:TemplateField SortExpression="MSP" HeaderText="MSP">
                    <ItemTemplate>
                        <asp:Label ID="MSP" runat="server" Text='<%# Bind("MSP") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="AGO" HeaderText="AGO">
                    <ItemTemplate>
                        <asp:Label ID="AGO" runat="server" Text='<%# Bind("AGO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="KERO" HeaderText="KERO">
                    <ItemTemplate>
                        <asp:Label ID="KERO" runat="server" Text='<%# Bind("KERO") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="JET" HeaderText="JET">
                    <ItemTemplate>
                        <asp:Label ID="JET" runat="server" Text='<%# Bind("JET") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField ControlStyle-CssClass="Visibility" DataField="QueueID"
                                HeaderStyle-CssClass="Visibility" HeaderText="" ItemStyle-CssClass="Visibility"
                                ReadOnly="true" SortExpression="QueueID"/>
                <asp:TemplateField HeaderText="ENTITELEMENT" ControlStyle-Width="120px" SortExpression="Entitlement">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropEntLoc" runat="server" AutoPostBack="true"
                                          DataTextField="Entitlement" DataValueField="Entitlement"
                                          OnSelectedIndexChanged="DropEntLoc_SelectedIndexChanged"
                                          SelectedValue='<%# Bind("Entitlement") %>' Width="120px">
                            <asp:ListItem Text="CHOOSE" Value=""></asp:ListItem>
                            <asp:ListItem Text="ENTITLEMENT" Value="STK"></asp:ListItem>
                            <asp:ListItem Text="NO ENTITLEMENT" Value="STKNEN"></asp:ListItem>
                            <asp:ListItem Text="DECLARATION" Value="STKDEC"></asp:ListItem>
                            <asp:ListItem Text="NO PRODUCT" Value="STKNPR"></asp:ListItem>
                            <asp:ListItem Text="NO ORDER" Value="STKNO"></asp:ListItem>
                            <asp:ListItem Text="SIGNATURE NOT CONFIRMED" Value="STKCON"></asp:ListItem>
                            <asp:ListItem Text="NOT ORIGINAL DOCUMENT" Value="STKORIG"></asp:ListItem>
                            <asp:ListItem Text="WRONG VOLUMES" Value="STKWV"></asp:ListItem>
                            <asp:ListItem Text="KRA ENTRY" Value="STKKRA"></asp:ListItem>
                            <asp:ListItem Text="NO SIGNATURES" Value="STKNOSIG"></asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText="" HeaderStyle-CssClass="Visibility"
                                SortExpression="Status"/>
                <asp:BoundField DataField="Entitlement" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText="" HeaderStyle-CssClass="Visibility"
                                SortExpression="Entitlement"/>
                <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                SortExpression="Suspended"/>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckLocalStock" AutoPostBack="true" runat="server" OnCheckedChanged="CheckLocalStock_CheckedChanged"/>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Shipper">
                    <ItemTemplate>
                        <asp:Label ID="ShipperLbl" runat="server" Text='<%# Bind("Shipper") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="SAP_Request_No">
                    <ItemTemplate>
                        <asp:Label ID="SAP_Request_No" runat="server" Text='<%# Bind("SAP_Request_No") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="Type">
                    <ItemTemplate>
                        <asp:Label ID="TypeLbl" runat="server" Text='<%# Bind("Type") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div style="width: 100%;">
                    No orders in the system to approve
                </div>
            </EmptyDataTemplate>
            <FooterStyle BackColor="#CCCCCC"/>
            <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
            <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
            <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
            <PagerStyle HorizontalAlign="Right" BackColor="White" VerticalAlign="Bottom"/>
            <PagerSettings Mode="NumericFirstLast" NextPageText="Next" PreviousPageText="Prev"/>
        </asp:GridView>
    </div>

    <p style="margin-top: 30px; vertical-align: bottom;">
        <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn"
                    onclick="ExpSwitchBtn_Click" Text="Switch to Export Queue"/>
    </p>
</asp:Panel>
</td>
<td style="text-align: right; vertical-align: top; width: 200px;">
    <div runat="server" id="Analog" visible="true">
        <h4>Check Entitlement</h4>
        <p>
            Shipper name<br/>
            <asp:DropDownList ID="DropName" ValidationGroup="Go" runat="server" Width="150px">
                <asp:ListItem Text="Choose Shipper" Value=""></asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="ReqSearch" runat="server" ValidationGroup="Go" ControlToValidate="DropName" InitialValue="" ErrorMessage="*"></asp:RequiredFieldValidator>
        </p>
        <p></p>
        <p>
            <asp:DropDownList ID="DropProduct" runat="server" CssClass="Visibility" Width="150px">
                <asp:ListItem Text="Choose product" Value=""></asp:ListItem>
                <asp:ListItem Text="AGO" Value="AGO"></asp:ListItem>
                <asp:ListItem Text="DPK" Value="DPK"></asp:ListItem>
                <asp:ListItem Text="IK" Value="IK"></asp:ListItem>
                <asp:ListItem Text="JET" Value="JET"></asp:ListItem>
                <asp:ListItem Text="MSP" Value="MSP"></asp:ListItem>
                <asp:ListItem Text="MSR" Value="MSR"></asp:ListItem>
            </asp:DropDownList>

        </p>
        <p>
            <asp:Button ID="btnGo" CssClass="btn" runat="server" Text="Check"
                        ValidationGroup="Go" onclick="btnGo_Click"/>
        </p>
    </div>
    <br/><br/>
    <asp:Label ID="LabelCatch" runat="server"></asp:Label>
    <p>
        <asp:GridView ID="GridSAP" Width="200px" BorderStyle="None" HeaderStyle-BackColor="Black" HeaderStyle-ForeColor="white" runat="server"
                      RowStyle-VerticalAlign="Bottom" GridLines="Both" BorderColor="#000" BorderWidth="1px"
                      CellPadding="4" CellSpacing="2" HeaderStyle-Font-Size="Medium" RowStyle-Font-Size="Small" OnRowDataBound="GridSAP_RowDataBound">
        </asp:GridView>
    </p>

    <p>
        <asp:GridView ID="GridResult" Width="200px" CssClass="Visibility" BorderStyle="None" runat="server"
                      onrowdatabound="GridResult_RowDataBound">
            <EmptyDataTemplate>
                No volume
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:Label ID="LabelProduct" runat="server"></asp:Label>
        <br/>
        <asp:GridView ID="GridTotal" Width="200px" BorderStyle="None" AutoGenerateColumns="false" runat="server" ShowFooter="true"
                      onrowdatabound="GridTotal_RowDataBound">
            <Columns>
                <asp:TemplateField SortExpression="PRODUCT" HeaderText="PRODUCT">
                    <ItemTemplate>
                        <asp:Label ID="LabelProduct" runat="server" Text='<%# Eval("PRODUCT") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <b>Global Total</b>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField SortExpression="VOLUME" HeaderText="VOLUME">
                    <ItemTemplate>
                        <asp:Label ID="LabelVolume" runat="server" Text='<%# Eval("VOLUME") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="lblTotal" runat="server" Font-Bold="true"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                No volume
            </EmptyDataTemplate>
        </asp:GridView>
    </p>

</td>
</tr>
</table>
</ContentTemplate>
</asp:UpdatePanel>
<asp:SqlDataSource ID="EntryExpSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, StockControl.*, CustomerCare.* FROM NewQueue INNER JOIN StockControl ON NewQueue.QueueID = StockControl.QueueID INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID WHERE (NewQueue.Type = 'Export') AND (NewQueue.Finished IS NULL) AND (NewQueue.Status = 'STK' OR NewQueue.Status = 'STKNEN' OR NewQueue.Status = 'STKDEC' OR NewQueue.Status = 'STKNPR' OR NewQueue.Status = 'STKNO' OR  NewQueue.Status = 'STKCON' OR  NewQueue.Status = 'STKORIG' OR  NewQueue.Status = 'STKWV' OR  NewQueue.Status = 'STKNOSIG' OR  NewQueue.Status = 'STKKRA') AND (CustomerCare.CustCareApproval = 'True') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="EntryLocSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT NewQueue.*, StockControl.*, CustomerCare.* FROM NewQueue INNER JOIN StockControl ON NewQueue.QueueID = StockControl.QueueID INNER JOIN CustomerCare ON NewQueue.QueueID = CustomerCare.QueueID WHERE (NewQueue.Type = 'Local') AND (NewQueue.Finished IS NULL) AND (NewQueue.Status = 'STK' OR NewQueue.Status = 'STKNEN' OR NewQueue.Status = 'STKDEC' OR NewQueue.Status = 'STKNPR' OR NewQueue.Status = 'STKNO' OR  NewQueue.Status = 'STKCON' OR  NewQueue.Status = 'STKORIG' OR  NewQueue.Status = 'STKWV' OR  NewQueue.Status = 'STKNOSIG' OR  NewQueue.Status = 'STKKRA') AND (CustomerCare.CustCareApproval = 'True') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>