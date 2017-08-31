<%@ Page Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="QueueEdit.aspx.cs" Inherits="Pipecor.Pipecor_QueueEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("edit").className = "active";
    </script>
    <link href="../Styles.css" rel="stylesheet" type="text/css"/>
    <link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
    <div style="margin: 0px; width: 1200px;">
        <h3>Pipecore - Edit queue</h3>
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
                                              PageSize="10" AutoGenerateEditButton="false"
                                              BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px"
                                              CellPadding="4" EnableSortingAndPagingCallbacks="true"
                                              CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound"
                                              onrowupdated="GridExp_RowUpdated">
                                    <Columns>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperGo" NavigateUrl='<%# "EditDetail.aspx?ID=" + Eval("ID") %>' ForeColor="Blue" Text="Edit" Font-Bold="true" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                                        SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER" ReadOnly="true"
                                                        SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="200px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>/<asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO" ReadOnly="true"
                                                        SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                        SortExpression="MSP"/>
                                        <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                        SortExpression="AGO"/>
                                        <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                        SortExpression="KERO"/>
                                        <asp:BoundField DataField="JET" HeaderText="JET"
                                                        SortExpression="JET"/>
                                        <asp:BoundField DataField="Status" ItemStyle-Width="200px" HeaderText="STATUS" ReadOnly="true"
                                                        SortExpression="Status"/>
                                        <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="200px" DataFormatString="{0:MMM-dd hh:mm tt}" ReadOnly="true"
                                                        SortExpression="StatusTime"/>
                                        <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                        SortExpression="Entitlement"/>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
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
                                              AllowPaging="true" PageSize="10" EnableSortingAndPagingCallbacks="true" AutoGenerateEditButton="false"
                                              BorderColor="#000" BorderStyle="Solid" GridLines="Both" BorderWidth="1px" CellPadding="4"
                                              CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound"
                                              onrowupdated="GridLocal_RowUpdated">
                                    <Columns>
                                        <asp:TemplateField HeaderText="">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperGo" NavigateUrl='<%# "EditDetail.aspx?ID=" + Eval("ID") %>' ForeColor="Blue" Text="Edit" Font-Bold="true" runat="server"></asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Queue_No" HeaderText="No." ReadOnly="true"
                                                        SortExpression="Queue_No"/>
                                        <asp:BoundField DataField="Shipper" ItemStyle-Width="120px" HeaderText="SHIPPER" ReadOnly="true"
                                                        SortExpression="Shipper"/>
                                        <asp:TemplateField HeaderText="REGISTRATION" ItemStyle-Width="200px">
                                            <ItemTemplate>
                                                <asp:Label ID="Registration" runat="server" Text='<%# Bind("Registration") %>'></asp:Label> <asp:Label ID="Trailer" runat="server" Text='<%# Bind("TRAILER_TEXT") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LO_NO" HeaderText="L.O.NO" ReadOnly="true"
                                                        SortExpression="LO_NO"/>
                                        <asp:BoundField DataField="MSP" HeaderText="MSP"
                                                        SortExpression="MSP"/>
                                        <asp:BoundField DataField="AGO" HeaderText="AGO"
                                                        SortExpression="AGO"/>
                                        <asp:BoundField DataField="KERO" HeaderText="KERO"
                                                        SortExpression="KERO"/>
                                        <asp:BoundField DataField="JET" HeaderText="JET"
                                                        SortExpression="JET"/>
                                        <asp:BoundField DataField="Status" ItemStyle-Width="200px" HeaderText="STATUS" ReadOnly="true"
                                                        SortExpression="Status"/>
                                        <asp:BoundField DataField="StatusTime" HeaderText="TIME IN" ItemStyle-Width="200px" DataFormatString="{0:MMM-dd hh:mm tt}" ReadOnly="true"
                                                        SortExpression="StatusTime"/>
                                        <asp:BoundField DataField="Entitlement" ItemStyle-CssClass="Visibility" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                                        SortExpression="Entitlement"/>
                                        <asp:BoundField DataField="Suspended" ControlStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility" ItemStyle-CssClass="Visibility" HeaderText=""
                                                        SortExpression="Suspended"/>
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
                               SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND SetDate = @TheDate AND Loaded IS NULL Order by NewQueue.Queue_No"
                               UpdateCommand="UPDATE NewQueue SET Registration = @Registration, LO_NO = @LO_NO, MSP = @MSP, AGO = @AGO, KERO = @KERO WHERE QueueID = @QueueID">
                <UpdateParameters>
                    <asp:Parameter Name="Registration"/>
                    <asp:Parameter Name="MSP"/>
                    <asp:Parameter Name="AGO"/>
                    <asp:Parameter Name="KERO"/>
                    <asp:Parameter Name="LO_NO"/>
                    <asp:Parameter Name="QueueID"/>
                </UpdateParameters>
                <SelectParameters>
                    <asp:Parameter Name="TheDate" Type="DateTime"/>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlExportSource" runat="server"
                               ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                               SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND SetDate = @TheDate AND Loaded IS NULL Order by NewQueue.Queue_No"
                               UpdateCommand="UPDATE NewQueue SET Registration = @Registration, LO_NO = @LO_NO, Quantity = @Quantity, Product = @Product WHERE QueueID = @QueueID">
                <UpdateParameters>
                    <asp:Parameter Name="Registration"/>
                    <asp:Parameter Name="Quantity"/>
                    <asp:Parameter Name="Product"/>
                    <asp:Parameter Name="LO_NO"/>
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

                    <asp:Label ID="lblEditable_Reg" runat="server" Text='<%# Eval("Editable_Reg") %>'></asp:Label>
                    <asp:Label ID="Editable_LONO" runat="server" Text='<%# Eval("Editable_LONO") %>'></asp:Label>
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