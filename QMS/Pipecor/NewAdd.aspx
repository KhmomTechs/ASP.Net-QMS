<%@ Page Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="NewAdd.aspx.cs" Inherits="Pipecor.Pipecor_NewAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script language="javascript">
    document.getElementById("newadd").className = "active";
    window.location.href = "#myanchor";
</script>
<link href="../Styles.css" rel="stylesheet" type="text/css"/>
<link href="../prompts/default.css" rel="stylesheet" type="text/css"/>
<div style="margin: 0px; width: 1200px;">
    <h3>Pipecor - Add Orders</h3>
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
                      AutoGenerateColumns="False" DataSourceID="SqlExportSource" ShowFooter="True"
                      DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="False"
                      BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4" EnableSortingAndPagingCallbacks="True"
                      CellSpacing="2" ForeColor="Black" onrowdatabound="GridExp_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <asp:Label ID="LabelQuExp" runat="server" Text='<%# Bind("Queue_No") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="No" MaxLength="3" Width="140px" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqNo" ValidationGroup="EnterExport" runat="server" ControlToValidate="No" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareNO" ValidationGroup="EnterExport" runat="server" ControlToValidate="No" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeNO" ValidationGroup="EnterExport" ControlToValidate="No" Type="Integer" MinimumValue="0" MaximumValue="999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="OMC" SortExpression="Shipper">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Shipper") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Shipper") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="120px"/>
                    <FooterTemplate>
                        <asp:TextBox ID="Shipper" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqShipper" ValidationGroup="EnterExport" runat="server" ControlToValidate="Shipper" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="REGISTRATION" SortExpression="Registration">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Registration") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="200px"/>
                    <FooterTemplate>
                        <asp:TextBox ID="Registration" Width="95%" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqRegistration" ValidationGroup="EnterExport" runat="server" ControlToValidate="Registration" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="L.O.NO" SortExpression="LO_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LO_NO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("LO_NO") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="LO_NO" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqLO_NO" ValidationGroup="EnterExport" runat="server" ControlToValidate="LO_NO" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareLO_NO" ValidationGroup="EnterExport" runat="server" ControlToValidate="LO_NO" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeLO_NO" ValidationGroup="EnterExport" ControlToValidate="LO_NO" Type="Integer" MinimumValue="0" MaximumValue="9999999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="QUANTITY" SortExpression="Quantity">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Quantity") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="Quantity" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqQuantity" ValidationGroup="EnterExport" runat="server" ControlToValidate="Quantity" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareQuantity" ValidationGroup="EnterExport" runat="server" ControlToValidate="Quantity" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeQuantity" ValidationGroup="EnterExport" ControlToValidate="Quantity" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="PRODUCT" SortExpression="Product">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Product") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("Product") %>'></asp:Label>
                    </ItemTemplate>
                    <ControlStyle Width="70px"/>
                    <ItemStyle Width="70px"/>
                    <FooterTemplate>
                        <asp:DropDownList ID="Product" runat="server">
                            <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                            <asp:ListItem Text="MSP" Value="MSP"></asp:ListItem>
                            <asp:ListItem Text="AGO" Value="AGO"></asp:ListItem>
                            <asp:ListItem Text="KERO" Value="KERO"></asp:ListItem>
                            <asp:ListItem Text="JET" Value="JET"></asp:ListItem>
                        </asp:DropDownList><br/>
                        <asp:RequiredFieldValidator ID="ReqProduct" ValidationGroup="EnterExport" runat="server" ControlToValidate="Product" InitialValue="" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="STATUS" SortExpression="Status">
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text="SECURITY"></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemStyle Width="300px"/>
                    <FooterTemplate>
                        <asp:Label ID="LabelSec" runat="server" Text="SECURITY"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TIME" SortExpression="StatusTime">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server"
                                   Text='<%# Bind("StatusTime", "{0:MMM-dd-yyyy hh:mm tt}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server"
                                   Text='<%# Eval("StatusTime", "{0:MMM-dd-yyyy hh:mm tt}") %>'>
                        </asp:Label>
                    </EditItemTemplate>
                    <ItemStyle Width="250px"/>
                    <FooterTemplate>
                        <asp:Button ID="BtnAddExport" runat="server" Text="Add" CssClass="butt1" ValidationGroup="EnterExport"
                                    CommandName="Add" onclick="BtnAddExport_Click"/>

                    </FooterTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Entitlement"
                                SortExpression="Entitlement" ControlStyle-CssClass="Visibility"
                                FooterStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <FooterStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
                <asp:BoundField DataField="Suspended" HeaderText=""
                                SortExpression="Suspended" ControlStyle-CssClass="Visibility"
                                FooterStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <FooterStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
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
        <asp:GridView ID="GridLocal" runat="server" Width="1200px"
                      AutoGenerateColumns="False" ShowFooter="True"
                      DataKeyNames="QueueID" BackColor="#CCCCCC" EnableViewState="False"
                      DataSourceID="SqlLocalSource" EnableSortingAndPagingCallbacks="True"
                      BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CellPadding="4"
                      CellSpacing="2" ForeColor="Black" onrowdatabound="GridLocal_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <asp:Label ID="LabelQuLoc" runat="server" Text='<%# Bind("Queue_No") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="No" MaxLength="3" Width="140px" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqNo" ValidationGroup="EnterLocal" runat="server" ControlToValidate="No" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareNO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="No" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeNO" ValidationGroup="EnterLocal" ControlToValidate="No" Type="Integer" MinimumValue="0" MaximumValue="999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="SHIPPER" SortExpression="Shipper">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Shipper") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Shipper") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="120px"/>
                    <FooterTemplate>
                        <asp:TextBox ID="Shipper" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqShipper" ValidationGroup="EnterLocal" runat="server" ControlToValidate="Shipper" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="REGISTRATION" SortExpression="Registration">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Registration") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Registration") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="200px"/>
                    <FooterTemplate>
                        <asp:TextBox ID="Registration" Width="95%" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqRegistration" ValidationGroup="EnterLocal" runat="server" ControlToValidate="Registration" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="L.O.NO" SortExpression="LO_NO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LO_NO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("LO_NO") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="LO_NO" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqLO_NO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="LO_NO" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareLO_NO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="LO_NO" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeLO_NO" ValidationGroup="EnterLocal" ControlToValidate="LO_NO" Type="Integer" MinimumValue="0" MaximumValue="9999999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="MSP" SortExpression="MSP">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("MSP") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("MSP") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="MSP" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqMSP" ValidationGroup="EnterLocal" runat="server" ControlToValidate="MSP" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareMSP" ValidationGroup="EnterLocal" runat="server" ControlToValidate="MSP" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeMSP" ValidationGroup="EnterLocal" ControlToValidate="MSP" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="AGO" SortExpression="AGO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("AGO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("AGO") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="AGO" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqAGO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="AGO" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareAGO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="AGO" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeAGO" ValidationGroup="EnterLocal" ControlToValidate="AGO" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="KERO" SortExpression="KERO">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("KERO") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("KERO") %>'></asp:Label>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:TextBox ID="KERO" runat="server"></asp:TextBox><br/>
                        <asp:RequiredFieldValidator ID="ReqKERO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="KERO" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareKERO" ValidationGroup="EnterLocal" runat="server" ControlToValidate="KERO" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                        <asp:RangeValidator ID="RangeKERO" ValidationGroup="EnterLocal" ControlToValidate="KERO" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="STATUS" SortExpression="Status">
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemStyle Width="300px"/>
                    <FooterTemplate>
                        <asp:Label ID="LabelSec" runat="server" Text="SECURITY"></asp:Label>
                    </FooterTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TIME " SortExpression="StatusTime">
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server"
                                   Text='<%# Bind("StatusTime", "{0:MMM-dd-yyyy hh:mm tt}") %>'>
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server"
                                   Text='<%# Eval("StatusTime", "{0:MMM-dd-yyyy hh:mm tt}") %>'>
                        </asp:Label>
                    </EditItemTemplate>
                    <ItemStyle Width="250px"/>
                    <FooterTemplate>
                        <asp:Button ID="BtnAddLocal" runat="server" Text="Add" CssClass="butt1" ValidationGroup="EnterLocal"
                                    CommandName="Add" onclick="BtnAddLocal_Click"/>

                    </FooterTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Entitlement"
                                SortExpression="Entitlement" ControlStyle-CssClass="Visibility"
                                FooterStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <FooterStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
                <asp:BoundField DataField="Suspended" HeaderText=""
                                SortExpression="Suspended" ControlStyle-CssClass="Visibility"
                                FooterStyle-CssClass="Visibility" HeaderStyle-CssClass="Visibility"
                                ItemStyle-CssClass="Visibility">
                    <ControlStyle CssClass="Visibility"/>
                    <FooterStyle CssClass="Visibility"/>
                    <HeaderStyle CssClass="Visibility"/>
                    <ItemStyle CssClass="Visibility"/>
                </asp:BoundField>
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
<a id="myanchor"></a>
<asp:SqlDataSource ID="SqlLocalSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Local' AND Archived IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No"
                   UpdateCommand="UPDATE NewQueue SET Shipper = @Shipper, Registration = @Registration, LO_NO = @LO_NO, MSP = @MSP, AGO = @AGO, KERO = @KERO WHERE QueueID = @QueueID">
    <UpdateParameters>
        <asp:Parameter Name="Shipper"/>
        <asp:Parameter Name="Registration"/>
        <asp:Parameter Name="LO_NO"/>
        <asp:Parameter Name="MSP"/>
        <asp:Parameter Name="AGO"/>
        <asp:Parameter Name="KERO"/>
        <asp:Parameter Name="QueueID"/>
    </UpdateParameters>
    <SelectParameters>
        <asp:Parameter Name="TheDate" Type="DateTime"/>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlExportSource" runat="server"
                   ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                   SelectCommand="SELECT * FROM NewQueue WHERE Type = 'Export' AND Archived IS NULL AND SetDate = @TheDate Order by NewQueue.Queue_No"
                   UpdateCommand="UPDATE NewQueue SET Shipper = @Shipper, Registration = @Registration, LO_NO = @LO_NO, Quantity = @Quantity, Product = @Product WHERE QueueID = @QueueID">
    <UpdateParameters>
        <asp:Parameter Name="Shipper"/>
        <asp:Parameter Name="Registration"/>
        <asp:Parameter Name="LO_NO"/>
        <asp:Parameter Name="Quantity"/>
        <asp:Parameter Name="Product"/>
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