<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="BVAdmin_Login" %>
<%@ Register Src="Controls/MessageBox.ascx" TagName="MessageBox" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="foundation.css" rel="stylesheet" type="text/css" />
    <link href="styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Bvc.js" language="javascript"></script>
</head>
<body class="login">
    <form id="form1" runat="server">

        <div style="background: #eee; position: absolute; top: 0; left: 0; right: 0; bottom: 0;">

            <div id="Login">
                <img src="/bvadmin/images/bvc-logo.png" style="display: block; margin: 0 auto 20px;" alt="BV Commerce" />

                <asp:Panel runat="server" ID="PanelMain" DefaultButton="btnLogin">

                    <uc1:MessageBox ID="MessageBox1" runat="server" />

                    <table cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="UserNameLabel" runat="server" Text="Username:"></asp:Label>
                            </td>
                            <td class="formfield">
                                <asp:TextBox ID="UsernameField" class="input oversize" autocomplete="off" runat="server" ToolTip="Username"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="formlabel">
                                <asp:Label ID="PasswordLabel" runat="server" Text="Password:"></asp:Label>
                            </td>
                            <td class="formfield">
                                <asp:TextBox ID="PasswordField" class="input oversize" autocomplete="off" runat="server" TextMode="Password" ToolTip="Password"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td class="formfield" colspan="2">
                                <asp:ImageButton ID="btnLogin" runat="server" AlternateText="Login" ImageUrl="~/BVAdmin/Images/Buttons/Login.png" ToolTip="Login" />
                            </td>
                        </tr>
                    </table>

                </asp:Panel>
            </div>

        </div>

        <asp:HiddenField ID="RedirectToField" runat="server" />
    </form>
</body>
</html>