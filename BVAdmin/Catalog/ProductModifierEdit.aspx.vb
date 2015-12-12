Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductModifierEdit
    Inherits BaseAdminPage

    Private _isShared As Boolean = False
    Private productModifierEditControl As Content.ProductModifierTemplate

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Modifier Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SharedChoiceProductList.Visible = Me._isShared
        If ViewState("modifierId") IsNot Nothing Then
            SharedChoiceProductList.SharedChoiceType = Catalog.ChoiceInputTypeEnum.Modifier
            SharedChoiceProductList.SharedChoiceId = ViewState("modifierId").ToString()
        End If
    End Sub

    Protected Sub FinishedEditing(ByVal sender As Object, ByVal e As Content.BVModuleEventArgs)
        Dim editor As Content.ProductModifierTemplate = DirectCast(sender, Content.ProductModifierTemplate)
        If e.Info = "Canceled" Then
            If ViewState("pid") = "shared" Then
                Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx")
            Else
                'we need to pass our original product id back to the previous page
                Session(ViewState("pid")) = DirectCast(ViewState("originalProduct"), Catalog.Product)
                Response.Redirect("~/BVAdmin/Catalog/ProductChoices.aspx?source=ProductModifierEdit&id=" & ViewState("pid"))
            End If
        Else
            If ViewState("pid") = "shared" Then
                If (editor.Product IsNot Nothing) AndAlso (ViewState("modifierId") IsNot Nothing) Then
                    If editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("modifierId")) IsNot Nothing Then
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("modifierId")).IsShared = True
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("modifierId")).ParentProductId = ""
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("modifierId")).Commit()                                            
                    End If
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx?source=ModifierEdit&modifierId=" & HttpUtility.UrlEncode(ViewState("modifierId")))
                Else
                    'we had some issues, take me away!
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx")
                End If
            Else
                'we need to pass our original product id back to the previous page        
                Session(ViewState("pid")) = editor.Product
                Response.Redirect("~/BVAdmin/Catalog/ProductChoices.aspx?source=ProductModifierEdit&id=" & ViewState("pid"))
        End If
        End If
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If (Request.QueryString("pid") IsNot Nothing) Then
            If Request.QueryString("pid") = "shared" Then
                _isShared = True
            End If
            If (Request.QueryString("id") Is Nothing) AndAlso (Request.QueryString("modifierType") Is Nothing) Then
                Response.Redirect(DefaultCatalogPage)
            End If

            ViewState("pid") = Request.QueryString("pid")
            Dim product As Catalog.Product = Nothing
            Dim loadedFromViewstate As Boolean = False
            'If Not _isShared Then
            product = CType(Session(ViewState("pid")), Catalog.Product)
            If product IsNot Nothing Then
                ViewState("product") = product
                If Not Page.IsPostBack Then
                    ViewState("originalProduct") = product
                End If
                Session.Remove(ViewState("pid"))
            Else
                product = ViewState("product")
                If product Is Nothing Then
                    If Not _isShared Then
                        Response.Redirect(DefaultCatalogPage)
                    Else
                        product = New Catalog.Product()
                    End If
                Else
                    loadedFromViewstate = True
                End If
            End If
            If Not String.IsNullOrEmpty(product.ParentId) Then
                Response.Redirect(String.Format("{0}?id={1}&pid={2}", HttpContext.Current.Request.Url.AbsolutePath, Request.QueryString("id"), product.ParentId))
            End If

            'if we have a modifier type then we are adding a new modifier
            Dim modifier As Catalog.ProductModifier
            If Request.QueryString("modifierType") IsNot Nothing Then
                If Not loadedFromViewstate Then
                    'we are adding a new modifier so pass it in
                    modifier = New Catalog.ProductModifier()
                    ViewState("modifierId") = modifier.Bvin
                    modifier.Type = Request.QueryString("modifierType")
                    If product IsNot Nothing Then
                        product.ChoicesAndInputs.Add(modifier)
                        ViewState("product") = product
                    End If
                Else
                    modifier = product.ChoicesAndInputs.FindBusinessObject(CStr(ViewState("modifierId")))
                End If
            Else
                If _isShared Then
                    modifier = Catalog.ProductModifier.FindByBvin(Request.QueryString("id"))
                    ViewState("modifierId") = modifier.Bvin
                    product.ChoicesAndInputs.Add(modifier)
                Else
                    modifier = product.ChoicesAndInputs.FindBusinessObject(Request.QueryString("id"))
                    ViewState("modifierId") = modifier.Bvin
                End If
            End If
            productModifierEditControl = Content.ModuleController.LoadProductModifierEdit(modifier.Type, Me)
            productModifierEditControl.ID = "ModifierEditControl1"
            productModifierEditControl.BlockId = modifier.Bvin
            productModifierEditControl.Product = product
            AddHandler productModifierEditControl.EditingComplete, AddressOf FinishedEditing
            EditPanel.Controls.Add(productModifierEditControl)
        Else
            Response.Redirect(DefaultCatalogPage)
        End If
    End Sub
End Class
