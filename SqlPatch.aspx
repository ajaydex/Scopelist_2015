<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SqlPatch.aspx.vb" Inherits="SqlPatch" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head id="Head1" runat="server">
        <title>Sql Patch</title>
        <link href="~/BVAdmin/Styles.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../Bvc.js" language="javascript"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js" language="javascript" type="text/javascript"></script>
    </head>
    <body>
        <script type="text/javascript">
              $(document).ready(function() {                
                $('input.startbutton').click(toggleBox);                
              });
          
              function toggleBox(){
                $('#Loading').show();
                $('.startbutton').hide();
              }
        </script>
        <form id="myform" runat="server" class="sqlpatch">

            <div style="background: #eee; position: absolute; top: 0; left: 0; right: 0; bottom: 0;">

            <div id="Login" style="width:300px; text-align:center;">
                <img src="/bvadmin/images/bvc-logo.png" style="display: block; margin: 0 auto 20px;" alt="BV Commerce" />

                <h2 style="color:#ADCF58;margin-bottom: .25em;">Database Update</h2>
                <p style="color:#fff;margin-top: 0;">The database for your site needs to be installed or updated. This process may take several minutes.</p> 

                <asp:ImageButton ID="StartButton" CssClass="startbutton" runat="server" AlternateText="Start" ImageUrl="~/BVAdmin/Images/Buttons/start.png" ToolTip="Begin Update" />

                
                <div id="Loading" style="display:none; background:#fff; padding: 20px 40px 20px; text-align:center; border-radius: 5px; margin-top: 20px;">
                    <p style="margin: .25em 0;">Please wait&hellip;</p>
                    <img  src="<%= Page.ResolveUrl("~/Images/System/ajax-loader.gif") %>" alt="Loading&hellip;" /> 
                    <asp:Literal ID="ProgressLiteral" runat="server"></asp:Literal>
                </div>
            </div>
        </form>    
    </body>
</html>
