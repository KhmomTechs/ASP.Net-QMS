<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Security.master" AutoEventWireup="true" CodeFile="List.aspx.cs" Inherits="Security.Security_List" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("list").className = "active";
</script>
<h3>Security Check</h3>
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" runat="server">
<ContentTemplate>
<asp:Timer ID="AutoRefreshTimer" runat="server" Interval="3000" ontick="AutoRefreshTimer_Tick"/>
<table>
<tr>
<td style="text-align: left; vertical-align: top;">
<asp:Panel ID="PanelExp" runat="server" Height="400px" Visible="false">
    <h4>EXPORT QUEUE</h4>
    <div class="gridBorder" style="height: 370px;">
        <asp:GridView ID="GridExp" runat="server" AutoGenerateColumns="False"
                      DataSourceID="SqlExp" BackColor="#CCCCCC" Width="1200px" DataKeyNames="QueueID"
                      BorderColor="#000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                      CellSpacing="2" ForeColor="Black"
                      onselectedindexchanged="GridExp_SelectedIndexChanged"
                      onrowdatabound="GridExp_RowDataBound" AllowPaging="True" GridLines="Both"
                      PageSize="8" RowStyle-VerticalAlign="Bottom">
            <Columns>
                <asp:TemplateField ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                                        CommandName="Edit" Text="Edit">
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>

                        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="true">Update</asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                              CommandName="Cancel" Text="Cancel">
                        </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AVAILABILITY">
                    <ItemTemplate>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" Font-Size="14px"
                                             onselectedindexchanged="RadioButtonExp_SelectedIndexChanged"
                                             RepeatDirection="Horizontal">
                            <asp:ListItem Value="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True"
                                             onselectedindexchanged="RadioButtonExp_SelectedIndexChanged"
                                             RepeatDirection="Horizontal">
                            <asp:ListItem Value="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                SortExpression="Queue_No"/>
                <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" ReadOnly="true"
                                SortExpression="Shipper"/>
                <asp:TemplateField HeaderText="REGISTRATION">
                    <ItemTemplate>
                        <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LO_NO" HeaderText="LO_NO" ReadOnly="true"
                                SortExpression="LO_NO"/>
                <asp:BoundField DataField="MSP" HeaderText="MSP" ReadOnly="true"
                                SortExpression="MSP"/>
                <asp:BoundField DataField="AGO" HeaderText="AGO" ReadOnly="true"
                                SortExpression="AGO"/>
                <asp:BoundField DataField="KERO" HeaderText="KERO" ReadOnly="true"
                                SortExpression="KERO"/>
                <asp:BoundField DataField="JET" HeaderText="JET" ReadOnly="true"
                                SortExpression="JET"/>
                <asp:TemplateField HeaderText="" Visible="false" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Enabled="false" Text="CHECK TRUCK" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:Label ID="LabelID" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ID" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                SortExpression="ID"/>
                <asp:BoundField DataField="Status" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                SortExpression="Status"/>
                <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                SortExpression="Suspended"/>

                <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="EntryStatus">
                    <ItemTemplate>
                        <asp:Button ID="CheckExpApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                    onclick="CheckExpApp_Click" Text="APPROVE"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC"/>
            <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
            <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
            <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
            <EmptyDataTemplate>
                <div style="width: 100%;">No trucks in the system to check</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
    <p style="vertical-align: bottom;">
        <asp:Button ID="LocSwitchBtn" runat="server" CssClass="btn"
                    onclick="LocSwitchBtn_Click" Text="Switch to Local Queue"/>
    </p>
</asp:Panel>
<asp:Panel ID="PanelLoc" runat="server" Height="400px">
    <h4>LOCAL QUEUE</h4>
    <div class="gridBorder" style="height: 370px;">
        <asp:GridView ID="GridLoc" runat="server" AutoGenerateColumns="False"
                      DataSourceID="SqlLoc" BackColor="#CCCCCC" Width="1200px" DataKeyNames="QueueID"
                      BorderColor="#000" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                      CellSpacing="2" ForeColor="Black"
                      onselectedindexchanged="GridLoc_SelectedIndexChanged"
                      onrowdatabound="GridLoc_RowDataBound"
                      AllowPaging="True" GridLines="Both" PageSize="8" RowStyle-VerticalAlign="Bottom">
            <Columns>
                <asp:TemplateField ControlStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False"
                                        CommandName="Edit" Text="Edit">
                        </asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>

                        <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="true">Update</asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False"
                                              CommandName="Cancel" Text="Cancel">
                        </asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AVAILABILITY">
                    <ItemTemplate>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" Font-Size="14px"
                                             onselectedindexchanged="RadioButtonLoc_SelectedIndexChanged"
                                             RepeatDirection="Horizontal">
                            <asp:ListItem Value="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True"
                                             onselectedindexchanged="RadioButtonLoc_SelectedIndexChanged"
                                             RepeatDirection="Horizontal">
                            <asp:ListItem Value="True">Yes</asp:ListItem>
                            <asp:ListItem Value="False">No</asp:ListItem>
                        </asp:RadioButtonList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                SortExpression="Queue_No"/>
                <asp:BoundField DataField="Shipper" HeaderText="SHIPPER" ReadOnly="true"
                                SortExpression="Shipper"/>
                <asp:TemplateField HeaderText="REGISTRATION">
                    <ItemTemplate>
                        <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="LO_NO" HeaderText="LO_NO" ReadOnly="true"
                                SortExpression="LO_NO"/>
                <asp:BoundField DataField="MSP" HeaderText="MSP" ReadOnly="true"
                                SortExpression="MSP"/>
                <asp:BoundField DataField="AGO" HeaderText="AGO" ReadOnly="true"
                                SortExpression="AGO"/>
                <asp:BoundField DataField="KERO" HeaderText="KERO" ReadOnly="true"
                                SortExpression="KERO"/>
                <asp:BoundField DataField="JET" HeaderText="JET" ReadOnly="true"
                                SortExpression="JET"/>
                <asp:TemplateField HeaderText="" Visible="false" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Enabled="false" Text="CHECK TRUCK" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="false" ControlStyle-CssClass="Visibility">
                    <ItemTemplate>
                        <asp:Label ID="LabelID" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ID" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                SortExpression="ID"/>
                <asp:BoundField DataField="Status" HeaderText="" ReadOnly="true" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility"
                                SortExpression="Status"/>
                <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                SortExpression="Suspended"/>

                <asp:TemplateField HeaderText="" HeaderStyle-Width="25px" ItemStyle-Width="25px" SortExpression="EntryStatus">
                    <ItemTemplate>
                        <asp:Button ID="CheckLocApp" runat="server" CssClass="butt2" OnClientClick="return confirm('Are you sure?');" CausesValidation="false"
                                    onclick="CheckLocApp_Click" Text="APPROVE"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#CCCCCC"/>
            <HeaderStyle BackColor="Black" Font-Bold="True" Height="25px" Font-Size="18px" ForeColor="White"/>
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" Height="25px"/>
            <RowStyle Font-Size="16px" BackColor="White" Height="18px" HorizontalAlign="Right"/>
            <AlternatingRowStyle Font-Size="16px" BackColor="LightGray" Height="18px" HorizontalAlign="Right"/>
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White"/>
            <EmptyDataTemplate>
                <div style="width: 100%;">No trucks in the system to check</div>
            </EmptyDataTemplate>
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

<asp:SqlDataSource ID="SqlExp" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE (NewQueue.Type = 'Export') AND (NewQueue.Status = 'SECTA' OR NewQueue.Status = 'SECTNA') AND (NewQueue.Finished IS NULL) AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND NewQueue.SetDate = @TheDate ORDER BY NewQueue.Queue_No"
                   UpdateCommand="UPDATE SafetySecurity_B SET TruckAvailability = @TruckAvailability FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (SafetySecurity_B.QueueID = @QueueID)">
    <UpdateParameters>
        <asp:Parameter Name="TruckAvailability" Type="Boolean"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlLoc" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE (NewQueue.Type = 'Local') AND (NewQueue.Status = 'SECTA' OR NewQueue.Status = 'SECTNA') AND (NewQueue.Finished IS NULL) AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND NewQueue.SetDate = @TheDate ORDER BY NewQueue.Queue_No"
                   UpdateCommand="UPDATE SafetySecurity_B SET TruckAvailability = @TruckAvailability FROM SafetySecurity_B INNER JOIN NewQueue ON SafetySecurity_B.QueueID = NewQueue.QueueID WHERE (SafetySecurity_B.QueueID = @QueueID)">
    <UpdateParameters>
        <asp:Parameter Name="TruckAvailability" Type="Boolean"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>