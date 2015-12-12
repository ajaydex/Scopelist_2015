Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Themes_Foundation4_Responsive_Controls_CategorySortOrder
    Inherits System.Web.UI.UserControl

    Event SelectionChanged(ByVal sortOrder As Catalog.CategorySortOrder)

    Public Property SelectedSortOrder() As Catalog.CategorySortOrder
        Get
            Return SortOrderDropDownList.SelectedValue
        End Get
        Set(ByVal value As Catalog.CategorySortOrder)
            SortOrderDropDownList.SelectedValue = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Page.IsPostBack Then
            Dim val As String = Me.Request.Params(Me.SortOrderDropDownList.UniqueID)
            If Not String.IsNullOrEmpty(val) Then
                SetCategorySortOrder(val)
            End If
        Else
            Dim val As String = Me.Request.QueryString("sortorder")
            If Not String.IsNullOrEmpty(val) Then
                SetCategorySortOrder(val)
            End If
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sortOrder As String = Content.SiteTerms.GetTerm("SortOrder")
        If Not String.IsNullOrEmpty(sortOrder) Then
            SortOrderLabel.Text = sortOrder
        Else
            SortOrderLabel.Text = "Sort Order"
        End If

        If TypeOf Me.Page Is BaseStoreCategoryPage Then
            Dim basePage As BaseStoreCategoryPage = DirectCast(Me.Page, BaseStoreCategoryPage)
            If basePage.LocalCategory IsNot Nothing Then
                If Not Page.IsPostBack Then
                    If basePage.LocalCategory.DisplaySortOrder = Catalog.CategorySortOrder.ManualOrder Then
                        SortOrderDropDownList.Items.Add(New ListItem("Default", "1"))
                    End If
                    SortOrderDropDownList.Items.Add(New ListItem("Name", "2"))
                    SortOrderDropDownList.Items.Add(New ListItem("Manufacturer", "5"))
                    SortOrderDropDownList.Items.Add(New ListItem("Lowest Price", "3"))
                    SortOrderDropDownList.Items.Add(New ListItem("Highest Price", "4"))
                    SortOrderDropDownList.Items.Add(New ListItem("Newest", "6"))

                    If basePage.SortOrder <> Catalog.CategorySortOrder.None Then
                        SortOrderDropDownList.SelectedValue = basePage.SortOrder
                    Else
                        SortOrderDropDownList.SelectedValue = basePage.LocalCategory.DisplaySortOrder
                    End If

                End If

                If basePage.LocalCategory.CustomerChangeableSortOrder Then
                    Me.Visible = True
                Else
                    Me.Visible = False
                End If
            End If
            'SetCategorySortOrder()
        End If
    End Sub

    Protected Sub SortOrderDropDownList_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles SortOrderDropDownList.SelectedIndexChanged
        RaiseEvent SelectionChanged(CType(SortOrderDropDownList.SelectedValue, Catalog.CategorySortOrder))
    End Sub

    Private Sub SetCategorySortOrder(Optional ByVal value As String = "")
        If TypeOf Me.Page Is BaseStoreCategoryPage Then
            Dim basePage As BaseStoreCategoryPage = DirectCast(Me.Page, BaseStoreCategoryPage)
            If value <> String.Empty Then
                Dim parsedInt As Integer = 0
                If Integer.TryParse(value, parsedInt) Then
                    If [Enum].IsDefined(GetType(Catalog.CategorySortOrder), parsedInt) Then
                        basePage.SortOrder = parsedInt
                    End If
                End If

            Else
                Dim parsedInt As Integer = 0
                If Integer.TryParse(Me.SelectedSortOrder, parsedInt) Then
                    If [Enum].IsDefined(GetType(Catalog.CategorySortOrder), parsedInt) Then
                        basePage.SortOrder = parsedInt
                    End If
                End If
            End If
        End If
    End Sub

End Class