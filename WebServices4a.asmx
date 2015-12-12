<%@ WebService Language="VB" Class="WebServices4a" %>

Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

<CLSCompliant(True), _
   Runtime.InteropServices.ComVisible(False), _
   Protocols.SoapDocumentService(), _
WebService(Name:="WebServices4a", Namespace:="http://www.bvsoftware.com/Schemas/Bvc5/20070529/WebServices4a")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
Public Class WebServices4a
    Inherits System.Web.Services.WebService
    
    <WebMethod()> _
         Public Function Login(ByVal username As String, ByVal password As String) As Membership.AuthenticationToken
        Dim result As New Membership.AuthenticationToken
        result.ExpirationDate = DateTime.Now
        result.TokenRejected = True
        Try
            Dim validationResult As BVOperationResult = Membership.UserAccount.ValidateUser(username, password)
            If validationResult.Success = True Then
                Dim tempUser As Membership.UserAccount
                tempUser = Membership.UserAccount.FindByUserName(username)
                If tempUser IsNot Nothing Then
                    result.ExpirationDate = DateTime.UtcNow.AddMinutes(WebAppSettings.DEFAULT_WEB_SERVICE_TIMEOUT)
                    result.UserBvin = tempUser.Bvin
                    If Membership.AuthenticationToken.Insert(result) = True Then
                        result.TokenRejected = False
                        
                        ' clean up expired tokens
                        Membership.AuthenticationToken.DeleteExpired()
                    End If
                End If
            End If
        Catch ex As Exception
            EventLog.LogEvent(ex)
        End Try
        Return result
    End Function

    <WebMethod()> _
    Public Function LoginAndRunRequest(ByVal username As String, ByVal password As String, ByVal command As String, ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
        Dim t As Membership.AuthenticationToken = Login(username, password)
        Return RunRequest(t, command, data)
    End Function

    <WebMethod()> _
    Public Function RunRequest(ByRef token As Membership.AuthenticationToken, ByVal command As String, ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
        If Membership.AuthenticationToken.ValidateToken(token) Then
            Return ProcessRequest(command, data)
        Else
            token.TokenRejected = True
            Dim res As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            res.Errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("1", "Authentication Token was Rejected"))
            Return res
        End If
    End Function

    Private Function ProcessRequest(ByVal command As String, ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
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

End Class

