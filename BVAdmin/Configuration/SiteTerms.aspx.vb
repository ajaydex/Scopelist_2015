Imports System.Data
Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Content_SiteTerms
    Inherits BaseAdminPage

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Site Terms"
        Me.CurrentTab = AdminTabType.Configuration
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.SettingsView)
    End Sub

    Protected Sub TermsGridView_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles TermsGridView.RowCancelingEdit
        TermsGridView.EditIndex = -1
        BindTerms()
    End Sub

    Protected Sub TermsGridView_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles TermsGridView.RowDeleting
        Dim siteTerm As String = TermsGridView.DataKeys(e.RowIndex).Value
        If Content.SiteTerms.DeleteTerm(siteTerm) Then
            TermsGridView.EditIndex = -1
            BindTerms()
            MessageBox1.ShowOk(String.Format("The site term ""{0}"" has been deleted!", siteTerm))
            MessageBox2.ShowOk(String.Format("The site term ""{0}"" has been deleted!", siteTerm))
        End If
    End Sub

    Protected Sub TermsGridView_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles TermsGridView.RowEditing
        TermsGridView.EditIndex = e.NewEditIndex
        BindTerms()
    End Sub

    Protected Sub TermsGridView_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles TermsGridView.RowUpdating
        Dim siteTerm As String = TermsGridView.DataKeys(e.RowIndex).Value
        If Content.SiteTerms.UpdateTerm(siteTerm, DirectCast(TermsGridView.Rows(e.RowIndex).Controls(1).Controls(0), TextBox).Text) Then
            TermsGridView.EditIndex = -1
            BindTerms()
            MessageBox1.ShowOk(String.Format("The site term ""{0}"" has been updated!", siteTerm))
            MessageBox2.ShowOk(String.Format("The site term ""{0}"" has been updated!", siteTerm))
        Else
            MessageBox1.ShowError("An error occurred while trying to update the site term.")
            MessageBox2.ShowError("An error occurred while trying to update the site term.")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            BindTerms()
        End If
    End Sub

    Protected Sub BindTerms()
        TermsGridView.DataSource = Content.SiteTerms.AllTerms()
        TermsGridView.DataKeyNames = New String() {"SiteTerm"}
        TermsGridView.DataBind()
    End Sub

    Protected Sub NewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NewImageButton.Click
        Dim siteTerm As String = SiteTermTextBox.Text.Trim()
        If Content.SiteTerms.CreateNewTerm(siteTerm, SiteTermValueTextBox.Text) Then
            TermsGridView.EditIndex = -1
            BindTerms()
            SiteTermTextBox.Text = ""
            SiteTermValueTextBox.Text = ""
            MessageBox1.ShowOk(String.Format("The site term ""{0}"" has been created!", siteTerm))
            MessageBox2.ShowOk(String.Format("The site term ""{0}"" has been created!", siteTerm))
        Else
            MessageBox1.ShowError("An error occurred while trying to insert the site term.")
            MessageBox2.ShowError("An error occurred while trying to insert the site term.")
        End If
    End Sub

    Protected Sub btnDefault_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDefault.Click
        TermsGridView.UpdateRow(TermsGridView.EditIndex, False)
    End Sub

End Class