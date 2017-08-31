<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Admin.master" AutoEventWireup="true" CodeFile="Configuration.aspx.cs" Inherits="Administration.Administration_Configuration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("config").className = "active";
    </script>

    <div style="margin: 0px; width: 1200px;">
        <h3>QMS Configurations</h3>
    </div>

    <b>Pipecor Queue Editing</b>

    <asp:FormView ID="View" DefaultMode="Edit" EnableViewState="False" runat="server"
                  DataSourceID="ViewDataSource">
        <EditItemTemplate>

            <p>
                <asp:Label ID="LabelNo" runat="server" Font-Bold="true" Width="100px" Text="Queue No:"></asp:Label>

                <asp:DropDownList ID="Drop_No" runat="server" DataTextField="Editable_No" Width="100px" DataValueField="Editable_No" SelectedValue='<%# Bind("Editable_No") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="Req_no" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="No" ControlToValidate="Drop_No"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnNo" runat="server" Text="Save" CssClass="butt1" ValidationGroup="No" onclick="btnNo_Click"/>
            </p>
            <p>
                <asp:Label ID="LabelShipper" runat="server" Font-Bold="true" Width="100px" Text="Shipper:"></asp:Label>

                <asp:DropDownList ID="Drop_Shipper" runat="server" DataTextField="Editable_Shipper" Width="100px" DataValueField="Editable_Shipper" SelectedValue='<%# Bind("Editable_Shipper") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqEditable_Shipper" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="Shipper" ControlToValidate="Drop_Shipper"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnShipper" runat="server" Text="Save" CssClass="butt1" ValidationGroup="Shipper" onclick="btnShipper_Click"/>
            </p>
            <p>
                <asp:Label ID="LabelRegistration" runat="server" Font-Bold="true" Width="100px" Text="Registration:"></asp:Label>

                <asp:DropDownList ID="Drop_Registration" runat="server" DataTextField="Editable_Reg" Width="100px" DataValueField="Editable_Reg" SelectedValue='<%# Bind("Editable_Reg") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqRegistration" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="Registration" ControlToValidate="Drop_Registration"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnRegistration" runat="server" Text="Save" CssClass="butt1" ValidationGroup="Registration" onclick="btnRegistration_Click"/>
            </p>
            <p>
                <asp:Label ID="LabelLONO" runat="server" Font-Bold="true" Width="100px" Text="L.O.NO:"></asp:Label>

                <asp:DropDownList ID="Drop_LONO" runat="server" DataTextField="Editable_LONO" Width="100px" DataValueField="Editable_LONO" SelectedValue='<%# Bind("Editable_LONO") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqEditable_LONO" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="LONO" ControlToValidate="Drop_LONO"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnLONO" runat="server" Text="Save" CssClass="butt1" ValidationGroup="LONO" onclick="btnLONO_Click"/>
            </p>
            <p>
                <asp:Label ID="LabelQuantity" runat="server" Font-Bold="true" Width="100px" Text="Quantity:"></asp:Label>

                <asp:DropDownList ID="Drop_Quantity" runat="server" DataTextField="Editable_Quantity" Width="100px" DataValueField="Editable_Quantity" SelectedValue='<%# Bind("Editable_Quantity") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqQuantity" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="Quantity" ControlToValidate="Drop_Quantity"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnQuantity" runat="server" Text="Save" CssClass="butt1" ValidationGroup="Quantity" onclick="btnQuantity_Click"/>
            </p>
            <p>
                <asp:Label ID="LabelProduct" runat="server" Font-Bold="true" Width="100px" Text="Product:"></asp:Label>

                <asp:DropDownList ID="Drop_Product" runat="server" DataTextField="Editable_Product" Width="100px" DataValueField="Editable_Product" SelectedValue='<%# Bind("Editable_Product") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqProduct" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="Product" ControlToValidate="Drop_Product"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnProduct" runat="server" Text="Save" CssClass="butt1" ValidationGroup="Product" onclick="btnProduct_Click"/>
            </p>
            <p class="Visibility">
                <asp:Label ID="LabelStatus" runat="server" Font-Bold="true" Width="100px" Text="Status:"></asp:Label>

                <asp:DropDownList ID="Drop_Status" runat="server" DataTextField="Editable_Status" Width="100px" DataValueField="Editable_Status" SelectedValue='<%# Bind("Editable_Status") %>'>
                    <asp:ListItem Text="Choose" Value=""></asp:ListItem>
                    <asp:ListItem Text="True" Value="True"></asp:ListItem>
                    <asp:ListItem Text="False" Value="False"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="ReqStatus" runat="server" ErrorMessage="*" InitialValue="" ValidationGroup="Status" ControlToValidate="Drop_Status"></asp:RequiredFieldValidator>

                &nbsp;&nbsp;<asp:Button ID="btnStatus" runat="server" Text="Save" ValidationGroup="Status" onclick="btnStatus_Click"/>
            </p>
            <hr/>
            <b>Time between screen page displays (In seconds)</b><br/>

            <p>
            Currently:&nbsp;<asp:Label ID="LabelTime" runat="server" Text='<%# Eval("ScreenTime") %>'></asp:Label>&nbsp seconds.
            <p>
                <asp:TextBox ID="txtTime" Width="50px" MaxLength="4" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReqTime" runat="server" ErrorMessage="*" ValidationGroup="Time" ControlToValidate="txtTime"></asp:RequiredFieldValidator>
                &nbsp;&nbsp;<asp:Button ID="btnTime" runat="server" Text="Save" ValidationGroup="Time" CssClass="btn" onclick="btnTime_Click"/><br/>
                <asp:CompareValidator ID="CompareNO" ValidationGroup="Time" runat="server" ControlToValidate="txtTime" Type="Integer" Operator="DataTypeCheck" ErrorMessage="Enter a number "></asp:CompareValidator>
                <asp:RangeValidator ID="RangeNO" ValidationGroup="Time" ControlToValidate="txtTime" Type="Integer" MinimumValue="0" MaximumValue="9999" ErrorMessage="no letters,decimals or characters." Display="Dynamic" runat="server"/>
            </p>

            </p>
        </EditItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="ViewDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecureConnectionString %>"
                       SelectCommand="SELECT * FROM [Settings]">
    </asp:SqlDataSource>
</asp:Content>