<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Security.master" AutoEventWireup="true" CodeFile="Verification.aspx.cs" Inherits="Security.Security_Verification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("verify").className = "active";
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Timer ID="AutoRefreshTimer" runat="server" Interval="10000" ontick="AutoRefreshTimer_Tick"/>
            <div style="margin: 0px; width: 1200px;">
                <h3>Security - Driver Verification</h3>
            </div>
            <table style="margin-top: 0px; width: 1200px;">
                <tr>
                    <td style="text-align: left; vertical-align: top;">
                        <asp:Panel ID="PanelExp" Height="420px" Visible="false" runat="server">
                            <h4>EXPORT QUEUE</h4>
                            <div class="gridBorder" style="min-height: 335px"">
                                <asp:GridView ID="GridExp" runat="server" Width="1200px" AutoGenerateColumns="False" DataSourceID="SqlExportSource"
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
                                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Text="CHECK TRUCK" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Status"/>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
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
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="300px">
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
                                                <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# "Check.aspx?ID=" + Eval("ID") + "&order=" + Eval("LO_NO") %>' Text="CHECK TRUCK" ForeColor="Blue" Font-Bold="true" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Status" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Status"/>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
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
                                <asp:TemplateField HeaderText="No.">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
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

                        </div>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="SqlLocalSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT NewQueue.*, Operations.*, SafetySecurity_B.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_B ON NewQueue.QueueID = SafetySecurity_B.QueueID WHERE (NewQueue.Type = 'Local') AND (NewQueue.Status = 'SECVE') AND (Operations.Called = 'True') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlExportSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT NewQueue.*, Operations.*, SafetySecurity_B.* FROM NewQueue INNER JOIN Operations ON NewQueue.QueueID = Operations.QueueID INNER JOIN SafetySecurity_B ON NewQueue.QueueID = SafetySecurity_B.QueueID WHERE (NewQueue.Type = 'Export') AND (NewQueue.Status = 'SECVE') AND (Operations.Called = 'True') AND (NewQueue.Finished IS NULL) AND (NewQueue.Rejected IS NULL OR NewQueue.Rejected = 'False') AND (NewQueue.Withdrawal IS NULL OR NewQueue.Withdrawal = 'False') AND SetDate = @TheDate ORDER BY NewQueue.StatusTime">
        <SelectParameters>
            <asp:Parameter Name="TheDate" Type="DateTime"/>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>