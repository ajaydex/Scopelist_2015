Imports Microsoft.VisualBasic

' Included With Permission From Corneliu Tusnea

Public Class StringUtils    
    Public Shared Function SessionInfo() As String
        Try
            Dim sessionInfos As String

            Dim goingto As String = ToStr(HttpContext.Current.Request.Url)            
            sessionInfos = "<br>Session:" + SessionID() + "<br>To:" + goingto + vbCrLf + "<br>From:" + ToStr(HttpContext.Current.Request.UrlReferrer)
            sessionInfos = sessionInfos + "<br>User:" + HttpContext.Current.Request.UserHostName + "(" + HttpContext.Current.Request.UserHostAddress + ")"
            sessionInfos = sessionInfos + "<br>Agent:" + HttpContext.Current.Request.UserAgent
            Return sessionInfos

            Return String.Empty
        Catch ex As Exception
            Return ex.ToString
        End Try
    End Function

    Public Shared Function ToStr(ByVal value As Object) As String
        If value Is Nothing Then
            Return String.Empty
        Else
            Return value.ToString()
        End If
    End Function

    Public Shared Function SessionID() As String
        Return ToStr(BVSoftware.Bvc5.Core.SessionManager.CurrentCartID)
    End Function
End Class
