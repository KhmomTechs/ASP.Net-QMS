<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Operations.master" AutoEventWireup="true" CodeFile="CallTrucks.aspx.cs" Inherits="Operations.Operations_CallTrucks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <link href="../prompts/impromptu.css" rel="stylesheet" type="text/css"/>
    <script src="../prompts/jquery.js" type="text/javascript"></script>
    <script src="../prompts/jquery-impromptu.2.6.min.js" type="text/javascript"></script>
    <link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
    <link href="../prompts/New.css" rel="stylesheet" type="text/css"/>
    <script language="javascript">
        document.getElementById("call").className = "active";

        function ReplyTruck() {
            DisplayReplyTruckDialog();
            return false;
        }

        function DisplayReplyTruckDialog() {
            $("#ReplyForm").show();
        }

        function CloseReplyTruckDialog() {
            $("#ReplyForm").hide();
        }
    </script>
    <h3>Call orders to loading bay and Security check</h3>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="500" ontick="AutoRefreshTimer_Tick"/>
            <table>
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <asp:Panel ID="PanelExp" runat="server" Height="420px" Visible="false">
                            <h4>EXPORT QUEUE</h4>
                            <div class="gridBorder" style="height: 345px;">
                                <asp:GridView ID="GridExpEntries" runat="server" AutoGenerateColumns="False" Width="1200px"
                                              CellPadding="4" ForeColor="Black" RowStyle-VerticalAlign="Bottom" HeaderStyle-Height="20px"
                                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                                              DataKeyNames="QueueID" DataSourceID="EntryExpSource"
                                              CellSpacing="2" AllowPaging="True" GridLines="Both"
                                              PageSize="10" onrowdatabound="GridExpEntries_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="Called">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server"
                                                              Checked='<%# Eval("Called") == DBNull.Value ? false : Eval("Called") %>'/>
                                            </EditItemTemplate>
                                            
                                            <ItemTemplate>
                                                <asp:LoginView ID="lvUserRecord" runat="server">
                                               <RoleGroups>
                                                      <asp:RoleGroup Roles="Administrators, ICT Supervisor, Operations">
                                                             <ContentTemplate>
                                                                 <asp:Button ID="CheckExpApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                                            onclick="CheckExpApp_Click" Text="CALL TRUCK"/>
                                                         </ContentTemplate>
                                                       </asp:RoleGroup>
                                                </RoleGroups>
                                               </asp:LoginView>
                                                
                                            </ItemTemplate> 

                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." HeaderStyle-Width="40px" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="150px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O_NO" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="MSP" HeaderText="MSP" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="MSP"/>
                                        <asp:BoundField DataField="AGO" HeaderText="AGO" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="AGO"/>
                                        <asp:BoundField DataField="KERO" HeaderText="KERO" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="KERO"/>
                                        <asp:BoundField DataField="JET" HeaderText="JET" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="JET"/>
                                        <asp:BoundField DataField="StatusTime" HeaderText="TIME" HeaderStyle-Width="200px" ItemStyle-Width="200px" ReadOnly="true" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" SortExpression="StatusTime"/>
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
                                        <div style="width: 100%;">No trucks in the system to call</div>
                                    </EmptyDataTemplate>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" Font-Bold="true" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
                                </asp:GridView>
                            </div>
                            <p style="vertical-align: bottom;">
                                <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn"
                                            onclick="LocSwitchBtn_Click" Text="Switch to Local Queue"/>
                            </p>
                        </asp:Panel>
                        <asp:Panel ID="PanelLoc" runat="server" Height="420px">
                            <h4>LOCAL QUEUE</h4>
                            <div class="gridBorder" style="height: 345px;">
                                <asp:GridView ID="GridLocEntries" runat="server" AutoGenerateColumns="False" Width="1200px"
                                              CellPadding="4" ForeColor="Black" RowStyle-VerticalAlign="Bottom" HeaderStyle-Height="20px"
                                              BackColor="#CCCCCC" BorderColor="#000" BorderStyle="Solid" BorderWidth="1px"
                                              DataKeyNames="QueueID" DataSourceID="EntryLocSource"
                                              CellSpacing="2"
                                              AllowPaging="True" GridLines="Both" PageSize="10"
                                              onrowdatabound="GridLocEntries_RowDataBound">
                                    <Columns>

                                        <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="Called">
                                            <EditItemTemplate>
                                                <asp:CheckBox ID="CheckBox1" runat="server"
                                                              Checked='<%# Eval("Called") == DBNull.Value ? false : Eval("Called") %>'/>
                                            </EditItemTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="CheckLocApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                                            onclick="CheckLocApp_Click" Text="CALL TRUCK"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." HeaderStyle-Width="40px" ItemStyle-Width="40px" ReadOnly="true" SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" HeaderStyle-Width="100px" ItemStyle-Width="100px" ReadOnly="true" SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="150px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O_NO" HeaderStyle-Width="70px" ItemStyle-Width="70px" ReadOnly="true" SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="MSP" HeaderText="MSP" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="MSP"/>
                                        <asp:BoundField DataField="AGO" HeaderText="AGO" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="AGO"/>
                                        <asp:BoundField DataField="KERO" HeaderText="KERO" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="KERO"/>
                                        <asp:BoundField DataField="JET" HeaderText="JET" HeaderStyle-Width="60px" ItemStyle-Width="60px"
                                                        SortExpression="JET"/>
                                        <asp:BoundField DataField="StatusTime" HeaderText="TIME" HeaderStyle-Width="200px" ItemStyle-Width="200px" ReadOnly="true" DataFormatString="{0:MMM-dd-yyyy hh:mm tt}" SortExpression="StatusTime"/>
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
                                        <div style="width: 100%;">No trucks in the system to call</div>
                                    </EmptyDataTemplate>
                                    <FooterStyle BackColor="#CCCCCC"/>
                                    <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
                                    <RowStyle Font-Size="16px" BackColor="White" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
                                    <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Font-Bold="true" Height="18px" HorizontalAlign="Right"/>
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
                       SelectCommand="SELECT NewQueue.*, StockControl.*, Operations.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN StockControl ON NewQueue.QueueID = StockControl.QueueID WHERE (StockControl.StControlApproval = 'True') AND (NewQueue.Type = 'Export') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (Operations.Cleared IS NULL) AND (NewQueue.Status = 'DISPATCH') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="EntryLocSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT NewQueue.*, StockControl.*, Operations.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN StockControl ON NewQueue.QueueID = StockControl.QueueID WHERE (StockControl.StControlApproval = 'True') AND (NewQueue.Type = 'Local') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (Operations.Cleared IS NULL) AND (NewQueue.Status = 'DISPATCH') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <div id="ReplyForm" class="JqueryRegisterForm">
        <table style="width: 100%;" cellpadding="5" cellspacing="0">
            <tr class="headerRow">
                <td>
                    Message
                </td>
                <td style="text-align: right;">
                    <a onclick="CloseReplyTruckDialog();" style="color: #ffffff; cursor: pointer; text-decoration: none;">X</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>