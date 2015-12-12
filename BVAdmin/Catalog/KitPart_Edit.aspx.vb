Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_KitPart_Edit
    Inherits BaseAdminPage

    Private _kitPart As Catalog.KitPart = Nothing

    Private Property KitPart() As Catalog.KitPart
        Get
            If _kitPart Is Nothing Then
                If Request.QueryString("ID") IsNot Nothing Then
                    _kitPart = Services.KitService.FindKitPart(Request.QueryString("ID"))
                End If
            End If
            Return _kitPart
        End Get
        Set(ByVal value As Catalog.KitPart)

        End Set
    End Property

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Edit Kit Part"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Not Page.IsPostBack Then
            Me.CurrentTab = AdminTabType.Catalog

            If Not Request.QueryString("ID") Is Nothing Then
                Dim id As String = String.Empty
                id = Request.QueryString("ID")
                LoadPart(id)
            End If
        End If
    End Sub

    Private Sub LoadPart(ByVal id As String)
        Dim kp As Catalog.KitPart = Me.KitPart
        If kp IsNot Nothing Then
            Me.ProductBvinField.Value = kp.ProductBvin
            Me.DisplaynameField.Text = kp.Description
            Me.PriceField.Text = kp.Price.ToString("c")
            Me.PriceTypeDropDownList.SelectedValue = kp.PriceType
            Me.WeightField.Text = Math.Round(kp.Weight, 3)
            Me.WeightTypeDropDownList.SelectedValue = kp.WeightType
            Me.QuantityField.Text = kp.Quantity
            SelectedCheckBox.Checked = kp.IsSelected


            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductBvinField.Value)
            If p IsNot Nothing Then
                Me.lblProduct.Text = p.Sku & " - " & p.ProductName
            Else
                Me.lblProduct.Text = "No Product Selected"
            End If

        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnCancel.Click
        Dim parentProductBvin As String = Services.KitService.GetPartParentKitBvin(Me.KitPart)
        If Request.QueryString("DOC") = "1" Then
            Services.KitService.DeleteKitPart(Request.QueryString("id"))            
        End If
        Response.Redirect("Kit_Edit.aspx?id=" & parentProductBvin)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If Page.IsValid Then
            Dim kp As Catalog.KitPart = Me.KitPart
            If kp IsNot Nothing Then
                kp.Description = Me.DisplaynameField.Text.Trim
                kp.ProductBvin = Me.ProductBvinField.Value
                Decimal.TryParse(Me.PriceField.Text, System.Globalization.NumberStyles.Currency, System.Threading.Thread.CurrentThread.CurrentUICulture, kp.Price)
                Decimal.TryParse(Me.WeightField.Text, System.Globalization.NumberStyles.Float, System.Threading.Thread.CurrentThread.CurrentUICulture, kp.Weight)
                Integer.TryParse(Me.QuantityField.Text, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture, kp.Quantity)
                Integer.TryParse(Me.PriceTypeDropDownList.SelectedValue, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture, kp.PriceType)
                Integer.TryParse(Me.WeightTypeDropDownList.SelectedValue, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture, kp.WeightType)
                kp.IsSelected = SelectedCheckBox.Checked
                Services.KitService.UpdateKitPart(kp)
                Response.Redirect("Kit_Edit.aspx?id=" & Services.KitService.GetPartParentKitBvin(kp))
            Else
                Response.Redirect("Kit_Edit.aspx")
            End If            
        End If
    End Sub

    Protected Sub btnSelect_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSelect.Click
        If Me.ProductPicker1.SelectedProducts.Count > 0 Then
            Me.ProductBvinField.Value = Me.ProductPicker1.SelectedProducts(0)
            Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvin(Me.ProductBvinField.Value)
            If p IsNot Nothing Then
                If p.HasVariants Then
                    lblError.Text = "Products that have variants cannot be included in a kit."
                Else
                    lblError.Text = String.Empty
                    Dim qty As Integer = 1
                    Integer.TryParse(Me.QuantityField.Text, System.Globalization.NumberStyles.Integer, System.Threading.Thread.CurrentThread.CurrentUICulture, qty)
                    Me.lblProduct.Text = p.Sku & " - " & p.ProductName
                    Me.DisplaynameField.Text = p.ProductName
                    Me.PriceField.Text = (p.SitePrice * qty).ToString("c")
                    Me.WeightField.Text = Math.Round((p.ShippingWeight * qty), 3)
                End If
            Else
                Me.lblProduct.Text = "No Product Selected"
            End If
            End If
    End Sub

    Protected Sub PriceAndWeightTypeBVCustomValidator_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles PriceTypeBVCustomValidator.ServerValidate, WeightTypeBVCustomValidator.ServerValidate        
        If String.IsNullOrEmpty(Me.ProductBvinField.Value) Then            
            If args.Value = "2" Then
                args.IsValid = False
            End If
        End If
    End Sub
End Class
