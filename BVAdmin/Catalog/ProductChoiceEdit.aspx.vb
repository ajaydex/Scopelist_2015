Imports BVSoftware.BVC5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_ProductChoiceEdit
    Inherits BaseAdminPage

    Dim productChoiceEditControl As Content.ProductChoiceTemplate
    Private _isShared As Boolean = False

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Product Choice Edit"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SharedChoiceProductList.Visible = Me._isShared
        If ViewState("choiceId") IsNot Nothing Then
            SharedChoiceProductList.SharedChoiceType = Catalog.ChoiceInputTypeEnum.Choice
            SharedChoiceProductList.SharedChoiceId = ViewState("choiceId").ToString()
        End If
    End Sub

    Protected Sub FinishedEditing(ByVal sender As Object, ByVal e As Content.BVModuleEventArgs)
        Dim editor As Content.ProductChoiceTemplate = DirectCast(sender, Content.ProductChoiceTemplate)
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
                If (editor.Product IsNot Nothing) AndAlso (ViewState("choiceId") IsNot Nothing) Then
                    Dim choiceInputBase As Catalog.ProductChoiceInputBase = editor.Product.ChoicesAndInputs.FindBusinessObject(ViewState("choiceId"))
                    If choiceInputBase IsNot Nothing Then
                        choiceInputBase.IsShared = True
                        choiceInputBase.ParentProductId = ""
                        Dim request As New Datalayer.DataRequest()
                        Try
                            Datalayer.SqlDataHelper.BeginTransaction(request)
                            If Not Catalog.ProductChoice.RegenerateChoiceCombinationsForAffectedProducts(DirectCast(choiceInputBase, Catalog.ProductChoice), request) Then
                                Datalayer.SqlDataHelper.RollbackTransaction(request)
                            Else
                                If Not choiceInputBase.Commit(request) Then
                                    EventLog.LogEvent("ProductChoiceEdit.aspx", "Modified Shared Choice Failed To Save To The Database", Metrics.EventLogSeverity.Error)
                                    Datalayer.SqlDataHelper.RollbackTransaction(request)
                                Else
                                    Datalayer.SqlDataHelper.CommitTransaction(request)
                                End If
                            End If
                        Catch
                            Datalayer.SqlDataHelper.RollbackTransaction(request)
                        End Try
                    End If
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx?source=ChoiceEdit&choiceId=" & HttpUtility.UrlEncode(ViewState("choiceId")))
                Else
                    'we had some issues, take me away!
                    Response.Redirect("~/BVAdmin/Catalog/ProductSharedChoices.aspx")
                End If
            Else
                'we need to pass our original product id back to the previous page        
                Session(ViewState("pid")) = editor.Product
                Response.Redirect("~/BVAdmin/Catalog/ProductChoices.aspx?source=ProductChoiceEdit&id=" & ViewState("pid"))
            End If
        End If
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If (Request.QueryString("pid") IsNot Nothing) Then
            If Request.QueryString("pid") = "shared" Then
                _isShared = True
            End If
            If (Request.QueryString("id") Is Nothing) AndAlso (Request.QueryString("choiceType") Is Nothing) Then
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

            'if we have a choice type then we are adding a new choice
            Dim choice As Catalog.ProductChoice
            If Request.QueryString("choiceType") IsNot Nothing Then
                If Not loadedFromViewstate Then
                    'we are adding a new choice so pass it in
                    choice = New Catalog.ProductChoice()
                    ViewState("choiceId") = choice.Bvin
                    choice.Type = Request.QueryString("choiceType")
                    If product IsNot Nothing Then
                        product.ChoicesAndInputs.Add(choice)
                        ViewState("product") = product
                    End If
                Else
                    choice = product.ChoicesAndInputs.FindBusinessObject(CStr(ViewState("choiceId")))
                End If
            Else
                If _isShared Then
                    choice = Catalog.ProductChoice.FindByBvin(Request.QueryString("id"))
                    ViewState("choiceId") = choice.Bvin
                    product.ChoicesAndInputs.Add(choice)
                Else
                    choice = product.ChoicesAndInputs.FindBusinessObject(Request.QueryString("id"))
                    ViewState("choiceId") = choice.Bvin
                End If
            End If
            productChoiceEditControl = Content.ModuleController.LoadProductChoiceEdit(choice.Type, Me)
            productChoiceEditControl.ID = "ChoiceEditControl1"
            productChoiceEditControl.BlockId = choice.Bvin
            productChoiceEditControl.Product = product
            AddHandler productChoiceEditControl.EditingComplete, AddressOf FinishedEditing
            EditPanel.Controls.Add(productChoiceEditControl)
        Else
            Response.Redirect(DefaultCatalogPage)
        End If
    End Sub
End Class
