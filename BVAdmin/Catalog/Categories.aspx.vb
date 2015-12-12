Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Text
Imports System.IO

Partial Class BVAdmin_Catalog_Categories
    Inherits BaseAdminPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load        
        If Not Page.IsPostBack Then
            If Request.QueryString("id") IsNot Nothing Then
                'validate 
                Dim c As Catalog.Category = Catalog.Category.FindByBvin(Request.QueryString("id"))
                If c.Bvin = Request.QueryString("id") Then
                    Me.bvinField.Value = c.Bvin
                Else
                    Me.bvinField.Value = "0"
                End If
            End If
            LoadCategoryTree()
        End If
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Categories"
        Me.CurrentTab = AdminTabType.Catalog
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.CatalogView)
    End Sub

    Public Sub LoadCategoryTree()
        If Me.bvinField.Value = String.Empty Then
            Me.bvinField.Value = "0"
        End If

        'Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildren(Me.bvinField.Value)

        'Me.GridView1.DataSource = children
        Me.GridView1.PageSize = WebAppSettings.RowsPerPage
        Me.GridView1.DataBind()

        If GridView1.Rows.Count = 0 Then
            Me.lblInstructions.Visible = True
        Else
            Me.lblInstructions.Visible = False
        End If

        BuildTrail()
    End Sub

    Private Sub BuildTrail()
        Dim sb As New StringBuilder

        Dim trail As New Collection(Of Catalog.Category)

        Dim currentCategory As Catalog.Category = Catalog.Category.FindByBvin(Me.bvinField.Value)
        If currentCategory IsNot Nothing Then
            'currentCategory.FindParentsToRoot(trail)
            trail = Catalog.Category.BuildParentTrail(currentCategory.Bvin)
        End If

        sb.Append("<a href=""categories.aspx?id=0"">Root</a>")
        If trail IsNot Nothing Then
            ' Walk list backwards
            For i As Integer = trail.Count - 1 To 0 Step -1
                sb.Append(" :: ")
                sb.Append("<a href=""categories.aspx?id=")
                sb.Append(trail(i).Bvin)
                sb.Append(""">")
                sb.Append(trail(i).Name)
                sb.Append("</a>")
            Next
        End If

        Me.lblTrail.Text = sb.ToString
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        Me.lblError.Visible = False
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Me.bvinField.Value = bvin
        LoadCategoryTree()
    End Sub

    Protected Sub btnNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnNew.Click
        Response.Redirect("Categories_Edit.aspx?ParentID=" & Me.bvinField.Value & "&type=" & HttpUtility.UrlEncode(CategoryTypeRadioButtonList.SelectedValue))
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand        
        Dim bvin As String = String.Empty
        Select Case e.CommandName
            Case "Up"
                Me.lblError.Visible = False
                bvin = CType(GridView1.DataKeys(CType(e.CommandArgument, Integer)).Value, String)
                Catalog.Category.MoveUp(bvin)                
            Case "Down"
                Me.lblError.Visible = False
                bvin = CType(GridView1.DataKeys(CType(e.CommandArgument, Integer)).Value, String)                
                Catalog.Category.MoveDown(bvin)
            Case Else
                ' Do Nothing
        End Select
        LoadCategoryTree()
    End Sub

    Protected Sub GridView1_RowCreated1(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowCreated        
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btnUp As ImageButton = CType(e.Row.FindControl("btnUp"), ImageButton)
            If btnUp IsNot Nothing Then
                btnUp.CommandArgument = e.Row.RowIndex.ToString()
            End If
            Dim btnDown As ImageButton = CType(e.Row.FindControl("btnDown"), ImageButton)
            If btnDown IsNot Nothing Then
                btnDown.CommandArgument = e.Row.RowIndex.ToString()
            End If
        End If
    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim bvin As String = CType(GridView1.DataKeys(e.RowIndex).Value, String)
        Dim children As Collection(Of Catalog.Category) = Catalog.Category.FindChildren(bvin)
        If children IsNot Nothing Then
            If children.Count > 0 Then
                Me.lblError.Visible = True
            Else
                If WebAppSettings.AutoPopulateRedirectOnCategoryDelete Then
                    Dim c As Catalog.Category = Catalog.Category.FindByBvin(bvin)
                    If Not String.IsNullOrEmpty(c.Bvin) Then
                        Dim categoryUrl As String = Utilities.UrlRewriter.BuildUrlForCategory(c, Me, Catalog.Category.FindAllLight())
                        If Catalog.Category.Delete(bvin) Then
                            If c.SourceType <> Catalog.CategorySourceType.CustomLink AndAlso c.SourceType <> Catalog.CategorySourceType.CustomPage Then
                                Response.Redirect(String.Format("~/BVAdmin/Content/UrlRedirect_Edit.aspx?RequestedUrl={0}&RedirectType={1}&SystemData={2}&ReturnUrl={3}", HttpUtility.UrlEncode(categoryUrl), Convert.ToInt32(Utilities.UrlRedirectType.Category).ToString(), c.Bvin, HttpUtility.UrlEncode(Me.Request.Url.AbsolutePath)))
                            End If
                        End If
                    End If
                Else
                    Catalog.Category.Delete(bvin)
                End If
            End If
        End If
        LoadCategoryTree()
        e.Cancel = True
    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        Dim bvin As String = CType(GridView1.DataKeys(e.NewEditIndex).Value, String)
        Response.Redirect("Categories_Edit.aspx?id=" & bvin)
    End Sub

    Protected Sub RegenerateDynamicCategoriesLinkButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles RegenerateDynamicCategoriesLinkButton.Click
        Catalog.Category.RegenerateDynamicCategories()
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim key As String = GridView1.DataKeys(e.Row.RowIndex).Value
            Dim ChildCountLabel As Label = DirectCast(e.Row.FindControl("ChildCountLabel"), Label)
            ChildCountLabel.Text = Catalog.Category.FindChildren(key).Count.ToString()

            Dim CategoryTypeLabel As Label = DirectCast(e.Row.FindControl("CategoryTypeLabel"), Label)
            Dim category As Catalog.Category = DirectCast(e.Row.DataItem, Catalog.Category)
            Select Case category.SourceType
                Case Catalog.CategorySourceType.ByRules
                    CategoryTypeLabel.Text = "Dynamic"
                Case Catalog.CategorySourceType.CustomLink
                    CategoryTypeLabel.Text = "Custom Link"
                Case Catalog.CategorySourceType.CustomPage
                    CategoryTypeLabel.Text = "Custom Page"
                Case Catalog.CategorySourceType.Manual
                    CategoryTypeLabel.Text = "Static"
            End Select



        End If
    End Sub

    Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        SessionManager.AdminCategoriesGridPage = GridView1.PageIndex
    End Sub
End Class
