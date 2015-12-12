Imports BVSoftware.Bvc5.Core
Imports System.Text
Imports System.Xml
Imports System.IO
Imports System.Collections.ObjectModel

Partial Class WebServices4
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim username As String = Request.Params("username")
        Dim password As String = Request.Params("password")
        Dim command As String = Request.Params("command")
        Dim data As String = Request.Params("data")

        If Me.ValidateRequest(username, password, command) Then
            Dim result As New Services.WS4.WS4Response
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
        Dim errors As New Collection(Of Services.WS4.WS4Error)

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
            errors.Add(New Services.WS4.WS4Error("1", "Username was empty"))
        End If
        If password.Length < 0 Then
            errors.Add(New Services.WS4.WS4Error("2", "Password was empty"))
        End If
        If command.Length < 0 Then
            errors.Add(New Services.WS4.WS4Error("3", "Command was empty"))
        End If
        If Login(username, password) = False Then
            errors.Add(New Services.WS4.WS4Error("4", "Login Failed"))
        End If

        If errors.count > 0 Then
            DumpErrors(errors)
            Return False
        Else
            Return True
        End If
    End Function

    Private Function ProcessMyRequest(ByVal command As String, ByVal data As String) As Services.WS4.WS4Response
        Dim result As New Services.WS4.WS4Response

        Dim found As Boolean = False

        For Each c As Services.WS4.CommandProcessor In Services.WS4.CommandProcessor.Processors
            If c.CommandName = command Then
                found = True
                result = c.ProcessRequest(data)
                Exit For
            End If
        Next

        If found = False Then
            result.Errors.Add(New Services.WS4.WS4Error("1", "Command " & command & " was not found."))
        End If

        Return result
    End Function

    Private Function Login(ByVal username As String, ByVal password As String) As Boolean
        Dim result As Boolean = False
        Try
            Dim validationResult As BVOperationResult = Membership.UserAccount.ValidateUser(username, password)
            If validationResult.Success = True Then
                Dim tempUser As Membership.UserAccount
                tempUser = Membership.UserAccount.FindByUserName(username)
                If tempUser IsNot Nothing Then
                    If Membership.UserAccount.DoesUserHavePermission(tempUser.Bvin, Membership.SystemPermissions.LoginToWebServices) Then
                        result = True
                    End If
                End If
            End If
        Catch ex As Exception
            result = False
        End Try

        Return result
    End Function

    Private Sub DumpErrors(ByVal errors As Collection(Of Services.WS4.WS4Error))
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
            For Each e As Services.WS4.WS4Error In errors
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

End Class
