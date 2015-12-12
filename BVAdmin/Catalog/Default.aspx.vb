Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Catalog_Default
    Inherits BaseAdminPage

    Private criteriaSessionKey As String = "ProductCriteria"
    Private maxProducts As Boolean = False

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Products"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        If Not Page.IsPostBack Then


            'If WebAppSettings.PerformanceAutoLoadProductsList = False Then
            Me.GridView1.PageSize = WebAppSettings.RowsPerPage
            Me.GridView1.PageIndex = SessionManager.AdminProductGridPage
            GoPressed(SimpleProductFilter.LoadProducts())
            'End If

            Me.SimpleProductFilter.Focus()
        End If

        ' Make sure page index never goes above/below PageCount
        Dim countMinusOne As Integer = Me.GridView1.PageCount - 1
        If Me.GridView1.PageIndex > (countMinusOne) Then
            If countMinusOne >= 0 Then
                Me.GridView1.PageIndex = (countMinusOne)
            Else
                Me.GridView1.PageIndex = 0
            End If
            SessionManager.AdminProductGridPage = Me.GridView1.PageIndex
        End If


        If Not SessionManager.IsLicenseValid() Then
            MessageBox1.ShowInformation("No License Installed. Store is running in Lite mode and is limited to 10 products.")
            MessageBox1.ShowInformation("<a href=""" & TaskLoader.Brand.CompanyWebSite & """>Purchase a License</a>&nbsp;|&nbsp;<a href=""../Configuration/License.aspx"">Install a Purchased License</a>.")
            If Catalog.InternalProduct.CountOfAll() > 9 Then
                Me.btnNew.Visible = False
            End If
        End If

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim p As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                If p.Bvin = Me.LastProductViewed.Bvin Then
                    e.Row.RowState = DataControlRowState.Selected
                End If

                Dim chkActive As CheckBox = CType(e.Row.FindControl("chkActive"), CheckBox)
                If p.Status = Catalog.ProductStatus.Active Then
                    chkActive.Checked = True
                Else
                    chkActive.Checked = False
                End If
            End If

            Dim cloneButton As Anthem.ImageButton = DirectCast(e.Row.FindControl("CloneImageButton"), Anthem.ImageButton)
            If (cloneButton IsNot Nothing) Then
                If Catalog.InternalProduct.CountOfAll() > 9 Then
                    If SessionManager.IsLicenseValid() Then
                        cloneButton.Visible = True
                        cloneButton.CommandArgument = e.Row.RowIndex
                    Else
                        cloneButton.Visible = False
                    End If
                Else
                    cloneButton.Visible = True
                    cloneButton.CommandArgument = e.Row.RowIndex
                End If
            End If

        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        If Membership.UserAccount.DoesUserHavePermission(SessionManager.GetCurrentUserId, Membership.SystemPermissions.CatalogEdit) = True Then
            Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
            If WebAppSettings.AutoPopulateRedirectOnProductDelete Then
                Dim p As Catalog.Product = Catalog.InternalProduct.FindByBvinLight(bvin)
                If p IsNot Nothing AndAlso Not String.IsNullOrEmpty(p.Bvin) Then
                    Dim productUrl As String = p.ProductURL
                    If Catalog.InternalProduct.Delete(bvin) Then
                        Response.Redirect(String.Format("~/BVAdmin/Content/UrlRedirect_Edit.aspx?RequestedUrl={0}&RedirectType={1}&SystemData={2}&ReturnUrl={3}", HttpUtility.UrlEncode(productUrl), Convert.ToInt32(Utilities.UrlRedirectType.Product).ToString(), p.Bvin, HttpUtility.UrlEncode(Me.Request.Url.AbsolutePath)))
                    End If
                End If
            Else
                Catalog.InternalProduct.Delete(bvin)
            End If
        End If
        Me.Session(criteriaSessionKey) = SimpleProductFilter.LoadProducts()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Products_Edit.aspx?id=" & bvin)
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Clone" Then
            Dim key As String = GridView1.DataKeys(Integer.Parse(e.CommandArgument)).Value
            Response.Redirect("~/BVAdmin/Catalog/ProductClone.aspx?id=" & HttpUtility.UrlEncode(key))
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            Dim count As Integer = CInt(HttpContext.Current.Items("RowCount"))
            If count = 1 Then
                Me.lblResults.Text = count & " product found"
            Else
                Me.lblResults.Text = count & " products found"
            End If
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub FilterChanged(ByVal criteria As Catalog.ProductSearchCriteria) Handles SimpleProductFilter.FilterChanged
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataBind()
        Me.GridView1.UpdateAfterCallBack = True

    End Sub

    Protected Sub GoPressed(ByVal criteria As Catalog.ProductSearchCriteria) Handles SimpleProductFilter.GoPressed
        Me.Session(criteriaSessionKey) = criteria
        Me.GridView1.DataBind()
        Me.GridView1.UpdateAfterCallBack = True
    End Sub

    Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        SessionManager.AdminProductGridPage = GridView1.PageIndex
    End Sub
End Class
