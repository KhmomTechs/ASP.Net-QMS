<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Operations.master" AutoEventWireup="true" CodeFile="RemoveTrucks.aspx.cs" Inherits="Operations.Operations_RemoveTrucks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("remove").className = "active";
    </script>
    <h3>Clear loaded orders to OMC clearance</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="500" ontick="AutoRefreshTimer_Tick"/>
            <table>
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <asp:Panel ID="PanelExp" runat="server" Height="400px" Visible="false">
                            <h4>EXPORT QUEUE</h4>
                            <div class="gridBorder" style="height: 345px;">
                                <asp:GridView ID="GridExpEntries" runat="server" AutoGenerateColumns="False" Width="1000px"
                                              CellPadding="4" ForeColor="Black" RowStyle-VerticalAlign="Bottom"
                                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                                              DataKeyNames="QueueID" DataSourceID="EntryExpSource"
                                              HeaderStyle-Height="20px"
                                              CellSpacing="2" AllowPaging="True" GridLines="Both"
                                              PageSize="10" onrowdatabound="GridExpEntries_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="Cleared">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server"
                                                              Checked='<%# Eval("Cleared") == DBNull.Value ? false : Eval("Cleared") %>'/>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="CheckExpApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                                            onclick="CheckExpApp_Click" Text="CLEAR TRUCK"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." HeaderStyle-Width="40px" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="150px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O NO" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="CallTime" HeaderText="TIME CALLED" HeaderStyle-Width="150px" ItemStyle-Width="150px" ReadOnly="true" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" SortExpression="CallTime"/>
                                        <asp:BoundField DataField="QueueID" HeaderText="" HeaderStyle-CssClass="Visibility" ReadOnly="true" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" SortExpression="QueueID"/>
                                        <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div style="width: 100%;">No orders in the system to remove</div>
                                    </EmptyDataTemplate>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                </asp:GridView>
                            </div>
                            <p style="vertical-align: bottom;">
                                <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn"
                                            onclick="LocSwitchBtn_Click" Text="Switch to Local Queue"/>
                            </p>
                        </asp:Panel>
                        <asp:Panel ID="PanelLoc" runat="server" Height="400px">
                            <h4>LOCAL QUEUE</h4>
                            <div class="gridBorder" style="height: 345px;">
                                <asp:GridView ID="GridLocEntries" runat="server" AutoGenerateColumns="False" Width="1000px"
                                              CellPadding="4" ForeColor="Black" RowStyle-VerticalAlign="Bottom"
                                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                                              DataKeyNames="QueueID" DataSourceID="EntryLocSource"
                                              HeaderStyle-Height="20px"
                                              CellSpacing="2" AllowPaging="True" GridLines="Both"
                                              PageSize="10" onrowdatabound="GridLocEntries_RowDataBound">
                                    <Columns>

                                        <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="Cleared">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server"
                                                              Checked='<%# Eval("Cleared") == DBNull.Value ? false : Eval("Cleared") %>'/>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="CheckLocApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                                            onclick="CheckLocApp_Click" Text="CLEAR TRUCK"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." HeaderStyle-Width="40px" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="150px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O NO" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="CallTime" HeaderText="TIME CALLED" HeaderStyle-Width="150px" ItemStyle-Width="150px" ReadOnly="true" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" SortExpression="CallTime"/>
                                        <asp:BoundField DataField="QueueID" HeaderText="" HeaderStyle-CssClass="Visibility" ReadOnly="true" ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" SortExpression="QueueID"/>
                                        <asp:TemplateField HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div style="width: 100%;">No orders in the system to remove</div>
                                    </EmptyDataTemplate>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                </asp:GridView>
                            </div>
                            <p style="vertical-align: bottom;">
                                <asp:Button ID="ExpSwitchBtn" runat="server" CssClass="btn"
                                            onclick="ExpSwitchBtn_Click" Text="Switch to Export Queue"/>
                            </p>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="EntryExpSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT NewQueue.*, Operations.*, SafetySecurity_B.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_B ON NewQueue.QueueID = SafetySecurity_B.QueueID WHERE (SafetySecurity_B.EntryStatus = 'True') AND (NewQueue.Type = 'Export') AND (NewQueue.Finished IS NULL) AND (Operations.Called = 'True') AND (NewQueue.Loaded = 'True') AND (Operations.Cleared IS NULL) AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EntryLocSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT NewQueue.*, Operations.*, SafetySecurity_B.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_B ON NewQueue.QueueID = SafetySecurity_B.QueueID WHERE (SafetySecurity_B.EntryStatus = 'True') AND (NewQueue.Type = 'Local') AND (NewQueue.Finished IS NULL) AND (Operations.Called = 'True') AND (NewQueue.Loaded = 'True') AND (Operations.Cleared IS NULL) AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>