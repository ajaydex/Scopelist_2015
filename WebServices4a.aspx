<%@ Page Language="VB" %>
<%@ Import Namespace="BVSoftware.BVC5.Core" %>
<%@ Import Namespace="System.Collections.ObjectModel" %>
<%@ Import Namespace="System.Text" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Xml" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim username As String = Request.Params("username")
        Dim password As String = Request.Params("password")
        Dim command As String = Request.Params("command")
        Dim data As String = Request.Params("data")

        If Me.ValidateRequest(username, password, command) Then
            Dim result As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            result = ProcessMyRequest(command, data)
            If result.Success = False Then
                DumpErrors(result.Errors)
            Else
                Response.Clear()
                Response.ClearContent()
                Response.ClearHeaders()
                Response.ContentType = "text/xml"
                Dim output As String = result.ResponseData.Replace("encoding=""utf-16""", "encoding=""utf-8""")
                Response.Write(output)
                Response.End()
            End If
        End If
    End Sub
    
    Private Function ValidateRequest(ByVal username As String, ByVal password As String, ByVal command As String) As Boolean
        Dim errors As New Collection(Of BVSoftware.Bvc5.Core.Services.WS4.WS4Error)

        If username Is Nothing Then
            username = String.Empty
        End If
        If password Is Nothing Then
            password = String.Empty
        End If
        If command Is Nothing Then
            command = String.Empty
        End If

        If username.Length < 0 Then
            errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("1", "Username was empty"))
        End If
        If password.Length < 0 Then
            errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("2", "Password was empty"))
        End If
        If command.Length < 0 Then
            errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("3", "Command was empty"))
        End If
        If Login(username, password) = False Then
            errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("4", "Login Failed"))
        End If

        If errors.count > 0 Then
            DumpErrors(errors)
            Return False
        Else
            Return True
        End If
    End Function

    Private Function ProcessMyRequest(ByVal command As String, ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
        Dim result As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response

        Dim found As Boolean = False

        For Each c As BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor In WebServices4aLoader.AvailableProcessors()
            If c.CommandName = command Then
                found = True
                result = c.ProcessRequest(data)
                Exit For
            End If
        Next

        If found = False Then
            result.Errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("1", "Command " & command & " was not found."))
        End If

        Return result
    End Function

    Private Function Login(ByVal username As String, ByVal password As String) As Boolean
        Dim result As Boolean = False
        Try
            Dim validationResult As BVOperationResult = BVSoftware.Bvc5.Core.Membership.UserAccount.ValidateUser(username, password)
            If validationResult.Success = True Then
                Dim tempUser As BVSoftware.Bvc5.Core.Membership.UserAccount
                tempUser = BVSoftware.Bvc5.Core.Membership.UserAccount.FindByUserName(username)
                If tempUser IsNot Nothing Then
                    If BVSoftware.Bvc5.Core.Membership.UserAccount.DoesUserHavePermission(tempUser.Bvin, BVSoftware.Bvc5.Core.Membership.SystemPermissions.LoginToWebServices) Then
                        result = True
                    End If
                End If
            End If
        Catch ex As Exception
            result = False
        End Try

        Return result
    End Function

    Private Sub DumpErrors(ByVal errors As Collection(Of BVSoftware.Bvc5.Core.Services.WS4.WS4Error))
        Response.Clear()
        Response.ClearContent()
        Response.ClearHeaders()
        Response.ContentType = "text/xml"

        Dim output As String = String.Empty

        Try
            Dim sw As StringWriter = New StringWriter(System.Globalization.CultureInfo.InvariantCulture)
            Dim xw As XmlTextWriter = New XmlTextWriter(sw)

            xw.Formatting = Formatting.Indented
            xw.Indentation = 3
            xw.WriteStartDocument()


            xw.WriteStartElement("Errors")
            For Each e As BVSoftware.Bvc5.Core.Services.WS4.WS4Error In errors
                xw.WriteStartElement("Error")
                xw.WriteElementString("Code", e.Code)
                xw.WriteElementString("Message", e.Message)
                xw.WriteEndElement()
            Next
            xw.WriteEndElement()

            xw.WriteEndDocument()
            xw.Flush()
            xw.Close()
            output = sw.GetStringBuilder.ToString
            sw.Close()
        Catch ex As Exception
            output = "System Error: " & ex.Message
        End Try

        output = output.Replace("utf-16", "utf-8")
        Response.Write(output)
        Response.End()

    End Sub
    
   
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>WebServices4a Interface</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
