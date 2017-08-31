<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Users.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Users.Users_Default" %>
<%@ Register Src="~/Internal.ascx" TagName="Menu" TagPrefix="My" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <script language="javascript">
        document.getElementById("users").className = "active";
    </script>
    <div style="margin: 0px; width: 1200px;">
        <h3>Internal queue</h3>
    </div>
    <My:Menu ID="Menu" runat="server"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="LoginContent" Runat="Server">
</asp:Content>