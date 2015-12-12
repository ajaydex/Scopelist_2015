Imports Microsoft.VisualBasic
Imports System.Data
Imports BVSoftware.Bvc5.Core

Public Class ProductInfo
    Private _productId As String = String.Empty
    Private _shortDescription2 As String = String.Empty
    Private _shortDescription3 As String = String.Empty
    Private _mpn As String = String.Empty
    Private _subtitle As String = String.Empty
    'Goverment Restrictions
    Private _itarRestriction As Boolean = False
    Private _fflRestriction As Boolean = False
    Private _exportRestriction As Boolean = False

    Private _upc As String = ""

    Public Property ProductId As String
        Get
            Return _productId
        End Get
        Set(ByVal value As String)
            _productId = value
        End Set
    End Property
    Public Property ShortDescription2 As String
        Get
            Return _shortDescription2
        End Get
        Set(ByVal value As String)
            _shortDescription2 = value
        End Set
    End Property
    Public Property ShortDescription3 As String
        Get
            Return _shortDescription3
        End Get
        Set(ByVal value As String)
            _shortDescription3 = value
        End Set
    End Property
    Public Property MPN As String
        Get
            Return _mpn
        End Get
        Set(ByVal value As String)
            _mpn = value
        End Set
    End Property
    Public Property Subtitle As String
        Get
            Return _subtitle
        End Get
        Set(ByVal value As String)
            _subtitle = value
        End Set
    End Property

    'Goverment Restrictions
    Public Property ItarRestriction As Boolean
        Get
            Return _itarRestriction
        End Get
        Set(ByVal value As Boolean)
            _itarRestriction = value
        End Set
    End Property
    Public Property FflRestriction As Boolean
        Get
            Return _fflRestriction
        End Get
        Set(ByVal value As Boolean)
            _fflRestriction = value
        End Set
    End Property
    Public Property ExportRestriction As Boolean
        Get
            Return _exportRestriction
        End Get
        Set(ByVal value As Boolean)
            _exportRestriction = value
        End Set
    End Property
    Public Property UPC() As String
        Get
            Return _upc
        End Get
        Set(ByVal value As String)
            _upc = value
        End Set
    End Property
    Public Shared Function FindByProduct(ByVal bvin As String) As ProductInfo
        Return Mapper.FindByProduct(bvin)
    End Function

    Public Function Save() As Boolean
        Return Mapper.Save(Me)
    End Function

    Private Class Mapper

        Public Shared Function FindByProduct(ByVal bvin As String) As ProductInfo
            Dim p As Catalog.Product = Nothing
            Dim result As ProductInfo = Nothing
            Dim request As New Datalayer.DataRequest
            request.Command = "select bvin, ShortDescription2, ShortDescription3, MPN, Subtitle, ItarRestriction, FflRestriction, ExportRestriction,UPC from bvc_Product where bvin=@Bvin"
            request.CommandType = CommandType.Text
            request.Transactional = False
            request.AddParameter("@Bvin", bvin)
            Dim ds As DataSet = Datalayer.SqlDataHelper.ExecuteDataSet(request)
            If ds IsNot Nothing Then
                If ds.Tables.Count > 0 Then
                    If ds.Tables(0).Rows.Count > 0 Then
                        result = ConvertDataRow(ds.Tables(0).Rows(0))
                    End If
                End If
            End If
            Return result
        End Function

        Public Shared Function Save(ByVal i As ProductInfo) As Boolean
            If i Is Nothing OrElse i.ProductId = String.Empty Then
                Return False
            Else
                Dim request As New Datalayer.DataRequest
                request.Command = "update bvc_Product set ShortDescription2=@ShortDescription2, ShortDescription3=@ShortDescription3, MPN=@MPN, Subtitle=@Subtitle, ItarRestriction=@ItarRestriction, FflRestriction=@FflRestriction, ExportRestriction=@ExportRestriction, UPC=@UPC where bvin=@Bvin"
                request.CommandType = CommandType.Text
                request.Transactional = False
                request.AddParameter("@Bvin", i._productId)
                request.AddParameter("@ShortDescription2", i._shortDescription2)
                request.AddParameter("@ShortDescription3", i._shortDescription3)
                request.AddParameter("@MPN", i._mpn)
                request.AddParameter("@Subtitle", i._subtitle)
                request.AddParameter("@ItarRestriction", i._itarRestriction)
                request.AddParameter("@FflRestriction", i._fflRestriction)
                request.AddParameter("@ExportRestriction", i._exportRestriction)
                request.AddParameter("@UPC", i._upc)
                Return Datalayer.SqlDataHelper.ExecuteNonQueryAsBoolean(request)
            End If
        End Function

        Private Shared Function ConvertDataRow(ByVal dr As DataRow) As ProductInfo
            Dim result As New ProductInfo
            If dr IsNot Nothing Then
                result._productId = CType(dr.Item("Bvin"), String)
                If Not IsDBNull(dr.Item("ShortDescription2")) Then
                    result._shortDescription2 = CType(dr.Item("ShortDescription2"), String)
                End If
                If Not IsDBNull(dr.Item("ShortDescription3")) Then
                    result._shortDescription3 = CType(dr.Item("ShortDescription3"), String)
                End If
                If Not IsDBNull(dr.Item("MPN")) Then
                    result._mpn = CType(dr.Item("MPN"), String)
                End If
                If Not IsDBNull(dr.Item("Subtitle")) Then
                    result._subtitle = CType(dr.Item("Subtitle"), String)
                End If
                If Not IsDBNull(dr.Item("ItarRestriction")) Then
                    result._itarRestriction = CType(dr.Item("ItarRestriction"), Boolean)
                End If
                If Not IsDBNull(dr.Item("FflRestriction")) Then
                    result._fflRestriction = CType(dr.Item("FflRestriction"), Boolean)
                End If
                If Not IsDBNull(dr.Item("ExportRestriction")) Then
                    result._exportRestriction = CType(dr.Item("ExportRestriction"), Boolean)
                End If
                If Not dr.IsNull("UPC") Then
                    result._upc = CType(dr("UPC"), String)
                End If
            End If
            Return result
        End Function

    End Class

End Class

