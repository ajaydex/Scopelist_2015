<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SQLConnection.aspx.vb" Inherits="SQLConnection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sql Connection String Failed</title>
    <link href="~/BVAdmin/Styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Bvc.js" language="javascript"></script>
</head>
<body>
    <form id="myform" runat="server" class="sqlpatch">
    <div id="wrapper">
        <div class="topper">
        </div>
        <div class="content">
            <h1>
                Database Connection Failed!</h1>
            <p>
                The database connection for your site failed. Check your connection string in the
                web.config file to make sure the database name, server, username and password are
                all correct.</p>
            <div style="width: 600px; padding: 10px; margin: 20px auto; background-color: #F0FFF0;
                border: solid 1px #ccc;">
                <h3>
                    How to Fix This Error</h3>
                <p>
                    Check all the details of your database connection string. The username, password,
                    database and server names. We recommend using SQL logins instead of trusted windows
                    authentication unless you are an advanced user. Your database connection string
                    should look something like this example:</p>
                <p>
                    <em>server=sql001.MyHost.com;database=Bvc5;uid=MyUsername;pwd=MyPassword;</em></p>
                <p>
                    The database connection string is located in your web.config file which is in the
                    root folder of your web site. You can open and edit this file with any text editor
                    like Notepad, Wordpad or TextEdit on the Mac.</p>
                <p>
                    Look for the 'ConnectionStrings' section of the file. The line will look like this:</p>
                <p>
                    <em>&lt;add name=&quot;Bvc5Database&quot; connectionString=&quot;Data Source=sql001.MyHost.com;Initial
                        Catalog=Bvc5;User ID=MyUserName;Password=MyPassword&quot;/&gt;</em></p>
                <p>
                    Make changes and then save the file back to your web site. Refresh your web site
                    in your web browser and see if the error goes away.</p>
                <p>
                    If you are certain that your connection string is correct, check the permissions
                    for your SQL username on the database server. Your account needs to have db_owner
                    permissions or at least permissions to read the database and execute all stored
                    procedures.</p>
                <h3>
                    More Information</h3>
                <p>
                    If you are having trouble finding the exact right connection string a good resource
                    is <a href="http://connectionstrings.com/" target="_blank">ConnectionStrings.com</a></p>
            </div>
        </div>
        <div class="bottom">
        </div>
    </div>
    </form>
</body>
</html>
