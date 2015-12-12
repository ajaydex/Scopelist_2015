Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_SharedChoiceProductList
    Inherits System.Web.UI.UserControl

    Private _SharedChoiceId As String = String.Empty
    Private _SharedChoiceType As Catalog.ChoiceInputTypeEnum = Catalog.ChoiceInputTypeEnum.None

    Public Property SharedChoiceId As String
        Get
            Return Me._SharedChoiceId
        End Get
        Set(value As String)
            Me._SharedChoiceId = value
        End Set
    End Property

    Public Property SharedChoiceType() As Catalog.ChoiceInputTypeEnum
        Get
            Return Me._SharedChoiceType
        End Get
        Set(ByVal value As Catalog.ChoiceInputTypeEnum)
            Me._SharedChoiceType = value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim products As New Collection(Of Catalog.Product)

        If Not String.IsNullOrEmpty(Me.SharedChoiceId) Then
            products = Catalog.InternalProduct.FindBySharedChoice(Me.SharedChoiceId, Me.SharedChoiceType)
        End If

        litProductsTotal.Text = products.Count.ToString()

        gvProducts.DataSource = products
        gvProducts.DataBind()
    End Sub

End Class