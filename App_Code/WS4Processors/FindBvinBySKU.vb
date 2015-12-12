Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Namespace WS4Processors

    Public Class FindBvinBySKU
        Inherits Services.WS4.CommandProcessor

        Public Overrides ReadOnly Property CommandName() As String
            Get
                Return "FindBvinBySKU"
            End Get
        End Property

        Public Overrides Function Help(ByVal summary As Boolean) As String
            Return "Returns the BVIN of a product or child product where the given SKU exactly matches. If no match is found an empty string is returned."
        End Function

        Public Overrides Function ProcessRequest(ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            Dim result As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response

            Try
                Dim productBvin As String = String.Empty

                Dim p As Catalog.Product = Catalog.InternalProduct.FindBySkuAll(data)
                If p IsNot Nothing Then
                    If p.Sku.ToLower.Trim = data.ToLower.Trim Then
                        productBvin = p.Bvin
                    End If
                End If

                result.ResponseData = productBvin

            Catch ex As Exception
                result.Errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("Exception", ex.Message))
            End Try

            Return result
        End Function
    End Class

End Namespace