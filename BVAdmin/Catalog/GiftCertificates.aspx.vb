Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Catalog_GiftCertificates
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindGiftCertificateGridView()
            BindIssuedGiftCertificateGridView()
            IssuedGiftCertificatesGridView.PageSize = WebAppSettings.RowsPerPage
        End If
    End Sub

    Protected Sub BindGiftCertificateGridView()
        Dim criteria As New Catalog.ProductSearchCriteria()
        criteria.SpecialProductTypeOne = Catalog.SpecialProductTypes.GiftCertificate
        criteria.SpecialProductTypeTwo = Catalog.SpecialProductTypes.ArbitrarilyPricedGiftCertificate
        criteria.DisplayInactiveProducts = True
        GiftCertificatesGridView.DataSource = Catalog.InternalProduct.FindByCriteria(criteria)
        GiftCertificatesGridView.DataKeyNames = New String() {"bvin"}
        GiftCertificatesGridView.DataBind()
    End Sub

    Protected Sub BindIssuedGiftCertificateGridView()        
        IssuedGiftCertificatesGridView.DataBind()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Gift Certificates"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Response.Redirect("~/BVAdmin/Catalog/GiftCertificateEdit.aspx")
    End Sub

    Protected Sub GiftCertificatesGridView_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GiftCertificatesGridView.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim p As Catalog.Product = CType(e.Row.DataItem, Catalog.Product)
            If p IsNot Nothing Then
                Dim chkActive As CheckBox = CType(e.Row.FindControl("chkActive"), CheckBox)
                If p.Status = Catalog.ProductStatus.Active Then
                    chkActive.Checked = True
                Else
                    chkActive.Checked = False
                End If
            End If
        End If
    End Sub

    Protected Sub GiftCertificatesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GiftCertificatesGridView.RowEditing
        Dim key As String = GiftCertificatesGridView.DataKeys(e.NewEditIndex).Value
        If key <> String.Empty Then
            Response.Redirect("~\BVAdmin\Catalog\GiftCertificateEdit.aspx?id=" & HttpUtility.UrlEncode(key))
        End If
    End Sub

    Protected Sub GiftCertificatesGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GiftCertificatesGridView.RowDeleting
        Dim key As String = GiftCertificatesGridView.DataKeys(e.RowIndex).Value
        If key <> String.Empty Then
            If Catalog.InternalProduct.Delete(key) Then
                MessageBox1.ShowOk("Gift certificate was deleted successfully")
                MessageBox2.ShowOk("Gift certificate was deleted successfully")
            Else
                MessageBox1.ShowError("An error occurred while trying to delete the gift certificate")
                MessageBox2.ShowError("An error occurred while trying to delete the gift certificate")
            End If
        End If
        BindGiftCertificateGridView()
        e.Cancel = True
    End Sub

    Protected Sub IssuedGiftCertificatesGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles IssuedGiftCertificatesGridView.RowEditing
        Dim key As String = IssuedGiftCertificatesGridView.DataKeys(e.NewEditIndex).Value
        Response.Redirect("~\BVAdmin\Catalog\GiftCertificateInstanceEdit.aspx?id=" & HttpUtility.UrlEncode(key))
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub
End Class
