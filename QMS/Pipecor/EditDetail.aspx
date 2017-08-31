<%@ Page Language="C#" MasterPageFile="~/Master/Pipecor.master" AutoEventWireup="true" CodeFile="EditDetail.aspx.cs" Inherits="Pipecor.Pipecor_EditDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <link href="../Styles.css" rel="stylesheet" type="text/css"/>
    <link href="../prompts/default.css" rel="stylesheet" type="text/css"/>

    <link href="../Scripts/default.css" rel="stylesheet" type="text/css"/>
    <script src="../prompts/jquery.js" type="text/javascript"></script>
    <script src="../prompts/jquery-impromptu.2.6.min.js" type="text/javascript"></script>
    <script language="javascript">

        function CheckTruck() {
            DisplayCheckTruckDialog();
            return false;
        }

        function DisplayCheckTruckDialog() {
            $("#CheckTruck").show();
        }

        function CloseCheckTruckDialog() {
            $("#CheckTruck").hide();
        }

        window.onerror = function(e) { return true; };
    </script>


    <div style="margin: 0px; width: 1000px;">
        <h3>Pipecore - Details edit</h3>
    </div>

    <table style="margin-top: 0px; width: 1000px;">
        <tr>
            <td>
                <asp:FormView ID="FormEdit" DefaultMode="Edit" EnableViewState="False" runat="server" DataKeyNames="QueueID"
                              DataSourceID="SqlEditSource">
                    <EditItemTemplate>
                        <asp:Label ID="LabelType" CssClass="Visibility" runat="server" Text='<%#Eval("Type") %>'></asp:Label>

                        <table rules="all" style="border: 2px solid #000000; width: 600px;">
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">No:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="Queue_NoTxt" Text='<%# Bind("Queue_No") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReQueue_No" ControlToValidate="Queue_NoTxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    <asp:CompareValidator ID="CompareQueue_NoTxt" ValidationGroup="Local" runat="server" ControlToValidate="Queue_NoTxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeQueue_NoTxt" ValidationGroup="Local" ControlToValidate="Queue_NoTxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">REGISTRATION:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="RegistrationLocal" Text='<%# Bind("Registration") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqRegistrationLocal" ControlToValidate="RegistrationLocal" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">TRAILER:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="TextTRAILER_TEXT" Text='<%# Bind("TRAILER_TEXT") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">L.O NO:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="LONOLocal" Text='<%# Bind("LO_NO") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqLONOLocal" ControlToValidate="LONOLocal" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">MSP:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="MSPtxt" Text='<%# Bind("MSP") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqMSP" ControlToValidate="MSPtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    <asp:CompareValidator ID="CompareMSPtxt" ValidationGroup="Local" runat="server" ControlToValidate="MSPtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeMSPtxt" ValidationGroup="Local" ControlToValidate="MSPtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">AGO:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="AGOtxt" Text='<%# Bind("AGO") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqAGO" ControlToValidate="AGOtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    <asp:CompareValidator ID="CompareAGOtxt" ValidationGroup="Local" runat="server" ControlToValidate="AGOtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeAGOtxt" ValidationGroup="Local" ControlToValidate="AGOtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">KERO:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="KEROtxt" Text='<%# Bind("KERO") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqKERO" ControlToValidate="KEROtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    <asp:CompareValidator ID="CompareReqKERO" ValidationGroup="Local" runat="server" ControlToValidate="KEROtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeReqKERO" ValidationGroup="Local" ControlToValidate="KEROtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">JET:</td>
                                <td style="border: 1px solid #000000; font-weight: bold; height: 50px; width: 50%;">
                                    <asp:TextBox ID="JETtxt" Text='<%# Bind("JET") %>' ValidationGroup="Local" Width="200px" CssClass="Enter" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqJET" ControlToValidate="JETtxt" ValidationGroup="Local" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator><br/>
                                    <asp:CompareValidator ID="CompareReqJET" ValidationGroup="Local" runat="server" ControlToValidate="JETtxt" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                                    <asp:RangeValidator ID="RangeReqJET" ValidationGroup="Local" ControlToValidate="JETtxt" Type="Integer" MinimumValue="0" MaximumValue="100000000" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="LocalBtn" runat="server" ValidationGroup="Local" CssClass="btn"
                                                Text="SAVE" onclick="LocalBtn_Click"/>

                                </td>
                            </tr>
                        </table>

                        <asp:Label ID="Type" CssClass="Visibility" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                        <asp:Label ID="Shipper" CssClass="Visibility" runat="server" Text='<%# Eval("Shipper") %>'></asp:Label>
                        <asp:Label ID="QueueID" CssClass="Visibility" runat="server" Text='<%# Eval("QueueID") %>'></asp:Label>
                    </EditItemTemplate>
                </asp:FormView>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="SqlEditSource" runat="server"
                       ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT * FROM NewQueue WHERE Status != 'LODCLE' AND Status != 'OMCCLE' AND Status != 'DISPATCH' AND Status != 'SECVE' AND Status != 'CALLOD' AND Finished IS NULL AND SetDate = @TheDate AND Loaded IS NULL AND ID = @ID">
        <SelectParameters>
            <asp:QueryStringParameter Name="ID" QueryStringField="ID"/>
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

    <div id="CheckTruck" class="JqueryForm">
        <table style="width: 100%;" cellpadding="5" cellspacing="0">
            <tr class="headerRow">
                <td>
                    Message:
                </td>
                <td style="text-align: right;">
                    <a onclick="CloseCheckTruckDialog();" style="color: #ffffff; cursor: pointer; text-decoration: none;"></a>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>
                        <asp:Label ID="lblPopUp" runat="server"></asp:Label>
                    </p>
                    <asp:Button ID="btnBack" runat="server" CssClass="btn" onclick="btnBack_Click" Text="Ok"/>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>