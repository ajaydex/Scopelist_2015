Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVModules_Controls_RelatedItems
    Inherits System.Web.UI.UserControl

    Public Property ProductID() As String
        Get
            Return Me.bvinField.Value
        End Get
        Set(ByVal Value As String)
            Me.bvinField.Value = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.TitleLabel.Text = Content.SiteTerms.GetTerm("RelatedItems")
            Me.ProductID = Request.QueryString("ProductId")
        End If
        LoadRelatedItems()
    End Sub

    Sub LoadRelatedItems()
        ' Load Product Info
        Try
            Me.phItems.Controls.Clear()

            Dim localProduct As New Catalog.Product
            localProduct = Catalog.InternalProduct.FindByBvin(ProductID)

            Dim relatedItems As New Collection(Of Catalog.Product)

            'relatedItems = Catalog.Product.FindRelatedItems


            If relatedItems.Count > 0 Then
                Me.pnlMain.Visible = True

                For Each relatedItem As Catalog.Product In relatedItems
                    ' Show Related Item Here
                    'Dim prodDisplay As New BVSoftware.Aurora.Core.UIControls.SingleProductDisplay
                    'prodDisplay.UseTinyImages = True
                    'prodDisplay.LoadProduct(dtItems.Rows(iCount).Item("Bvin"))
                    'Me.phItems.Controls.Add(prodDisplay)
                Next
            Else
                Me.pnlMain.Visible = False
            End If

            localProduct = Nothing
        Catch Ex As Exception
            'EventLog.LogEvent(Ex)
            Me.pnlMain.Visible = False
        End Try
    End Sub

End Class
