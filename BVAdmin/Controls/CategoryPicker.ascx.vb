Imports BVSoftware.Bvc5.Core


Partial Class BVAdmin_Controls_CategoryPicker
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack() Then
            BindCategoriesGridView()
        End If
    End Sub

    Protected Sub BindCategoriesGridView()
        CategoriesGridView.DataSource = Catalog.Category.ListFullTreeWithIndents(True)
        CategoriesGridView.DataKeyNames = New String() {"value"}
        CategoriesGridView.DataBind()
    End Sub

    Public ReadOnly Property SelectedCategories() As StringCollection
        Get
            Dim result As New StringCollection
            For Each row As GridViewRow In CategoriesGridView.Rows
                If DirectCast(row.Cells(0).FindControl("chkSelected"), CheckBox).Checked Then
                    result.Add(CategoriesGridView.DataKeys(row.RowIndex).Value)
                End If
            Next
            Return result
        End Get
    End Property
End Class
