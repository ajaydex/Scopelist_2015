Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_ProductInputEdit
    Inherits BaseAdminPage

    Dim productInputEditControl As Content.ProductInputTemplate
    Private _isShared As Boolean = False

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Input Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SharedChoiceProductList.Visible = Me._isShared
        If ViewState("inputId") IsNot Nothing Then
            SharedChoiceProductList.SharedChoiceType = Catalog.ChoiceInputTypeEnum.Input
            SharedChoiceProductList.SharedChoiceId = ViewState("inputId").ToString()
        End If
    End Sub

    Protected Sub FinishedEditing(ByVal sender As Object, ByVal e As Content.BVModuleEventArgs)
        Dim editor As Content.ProductInputTemplate = DirectCast(sender, Content.ProductInputTemplate)
        If e.Info = "Canceled" Then
            If ViewState("pid") = "shared" Then
                Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx")
            Else
                'we need to pass our original product id back to the previous page
                Session(ViewState("pid")) = DirectCast(ViewState("originalProduct"), Catalog.Product)
                Response.Redirect("~/BVAdmin/Catalog/ProductChoices.aspx?source=ProductChoiceEdit&id=" & ViewState("pid"))
            End If
        Else
            If ViewState("pid") = "shared" Then
                If ViewState("inputId") IsNot Nothing Then
                    If editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("inputId")) IsNot Nothing Then
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("inputId")).IsShared = True
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("inputId")).ParentProductId = ""
                        editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("inputId")).Commit()
                    End If
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx?source=InputEdit&inputId=" & HttpUtility.UrlEncode(ViewState("inputId")))
                Else
                    'we had some issues, take me away!
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx")
                End If
            Else
                'we need to pass our original product id back to the previous page        
                Session(editor.Product.Bvin) = editor.Product
                Response.Redirect("~/BVAdmin/Catalog/ProductChoices.aspx?source=ProductChoiceEdit&id=" & ViewState("pid"))
            End If
        End If
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If (Request.QueryString("pid") IsNot Nothing) Then
            If Request.QueryString("pid") = "shared" Then
                _IsShared = True
            End If
            If (Request.QueryString("id") Is Nothing) AndAlso (Request.QueryString("inputType") Is Nothing) Then
                Response.Redirect(DefaultCatalogPage)
            End If
            ViewState("pid") = Request.QueryString("pid")
            Dim product As Catalog.Product = Nothing
            Dim loadedFromViewstate As Boolean = False
            'if we have a input type then we are adding a new input
            'Dim input As Catalog.ProductInput = Nothing
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

            'if we have a input type then we are adding a new input
            Dim input As Catalog.ProductInput
            If Request.QueryString("inputType") IsNot Nothing Then
                If Not loadedFromViewstate Then
                    'we are adding a new input so pass it in
                    input = New Catalog.ProductInput()
                    ViewState("inputId") = input.Bvin
                    input.Type = Request.QueryString("inputType")
                    If product IsNot Nothing Then
                        product.ChoicesAndInputs.Add(input)
                        ViewState("product") = product
                    End If
                Else
                    input = product.ChoicesAndInputs.FindBusinessObject(CStr(ViewState("inputId")))
                End If
            Else
                If _isShared Then
                    input = Catalog.ProductInput.FindByBvin(Request.QueryString("id"))
                    ViewState("inputId") = input.Bvin
                    product.ChoicesAndInputs.Add(input)
                Else
                    input = product.ChoicesAndInputs.FindBusinessObject(Request.QueryString("id"))
                End If

            End If

            productInputEditControl = Content.ModuleController.LoadProductInputEdit(input.Type, Me)
            productInputEditControl.ID = "inputEditControl1"
            productInputEditControl.BlockId = input.Bvin
            productInputEditControl.Product = product
            AddHandler productInputEditControl.EditingComplete, AddressOf FinishedEditing
            EditPanel.Controls.Add(productInputEditControl)
        Else
            Response.Redirect(DefaultCatalogPage)
        End If
    End Sub
End Class
