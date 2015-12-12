Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_AdditionalImages
    Inherits System.Web.UI.UserControl


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not Page.IsPostBack Then
        '    Me.imgZoom.ImageUrl = PersonalizationServices.GetThemedButton("MorePictures")
        'End If

        Dim id As String = Request.QueryString("ProductID")
        Me.ZoomLink.Style.Add("CURSOR", "pointer")
        Me.ZoomLink.Attributes.Add("onclick", ViewUtilities.GetAdditionalImagesPopupJavascript(id, Me.Page))

        Dim baseProd As Catalog.Product = Catalog.InternalProduct.FindByBvin(id)
        If baseProd IsNot Nothing Then
            If baseProd.AdditionalImages.Count <= 0 Then
                Me.ZoomLink.Visible = False
            End If
        End If

    End Sub

End Class
