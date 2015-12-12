Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Data


Public Class CategoryInfo

    Public Enum EMenuMode
        Normal = 0
        Expanded = 1
        Collapsed = 2
    End Enum

    Private _categoryId As String = String.Empty
    Private _menuMode As EMenuMode = EMenuMode.Normal
    Private _menuColor As String = String.Empty

    Public Property CategoryId As String
        Get
            Return _categoryId
        End Get
        Set(ByVal value As String)
            _categoryId = value
        End Set
    End Property
    Public Property MenuMode As EMenuMode
        Get
            Return _menuMode
        End Get
        Set(ByVal value As EMenuMode)
            _menuMode = value
        End Set
    End Property
    Public Property MenuColor As String
        Get
            Return _menuColor
        End Get
        Set(ByVal value As String)
            _menuColor = value
        End Set
    End Property

    Public Shared Function FindByCategory(ByVal CategoryId As String) As CategoryInfo
        Return Mapper.FindByCategory(CategoryId)
    End Function

    Public Function Update() As Boolean
        Return Mapper.Update(Me)
    End Function

    Protected Class Mapper

        Public Shared Function FindByCategory(ByVal CategoryId As String) As CategoryInfo
            Dim result As CategoryInfo = Nothing
            Dim request As New Datalayer.DataRequest
            request.Command = "avc_CategoryInfo_s"
            request.CommandType = CommandType.StoredProcedure
            request.AddParameter("@bvin", CategoryId)
            request.Transactional = False
            Dim ds As DataSet = Datalayer.SqlDataHelper.ExecuteDataSet(request)
            If ds IsNot Nothing Then
                If ds.Tables.Count > 0 Then
                    If ds.Tables(0).Rows.Count > 0 Then
                        result = New CategoryInfo
                        result._categoryId = CStr(ds.Tables(0).Rows(0)("bvin"))
                        result._menuMode = CInt(ds.Tables(0).Rows(0)("MenuMode"))
                        result._menuColor = CStr(ds.Tables(0).Rows(0)("MenuColor"))
                    End If
                End If
            End If
            Return result
        End Function

        Public Shared Function Update(ByVal info As CategoryInfo) As Boolean
            Dim request As New Datalayer.DataRequest
            request.Command = "avc_CategoryInfo_u"
            request.CommandType = CommandType.StoredProcedure
            request.AddParameter("@bvin", info._categoryId)
            request.AddParameter("@MenuMode", CInt(info._menuMode))
            request.AddParameter("@MenuColor", info._menuColor)
            request.Transactional = False
            Return Datalayer.SqlDataHelper.ExecuteNonQueryAsBoolean(request)
        End Function

    End Class

End Class

