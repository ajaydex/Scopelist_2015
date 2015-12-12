Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_ProductPicker
    Inherits System.Web.UI.UserControl

    Public Property Keyword() As String
        Get
            Return Me.FilterField.Text.Trim
        End Get
        Set(ByVal value As String)
            Me.FilterField.Text = value
        End Set
    End Property
    Protected Property IsInitialized() As Boolean
        Get
            Dim obj As Object = ViewState("IsInitialized")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("IsInitialized") = value
        End Set
    End Property
    Public Property IsMultiSelect() As Boolean
        Get
            Dim obj As Object = ViewState("IsMultiSelect")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("IsMultiSelect") = value
        End Set
    End Property
    Public Property DisplayPrice() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayPrice")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayPrice") = value
        End Set
    End Property
    Public Property DisplayInventory() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayInventory")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return False
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayInventory") = value
        End Set
    End Property
    Public Property DisplayKits() As Boolean
        Get
            Dim obj As Object = ViewState("DisplayKits")
            If obj IsNot Nothing Then
                Return CBool(obj)
            Else
                Return True
            End If
        End Get
        Set(ByVal value As Boolean)
            ViewState("DisplayKits") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GridView1.PageSize = CInt(DropDownList1.SelectedValue)
        If Not Me.IsInitialized Then
            PopulateCategories()
            PopulateManufacturers()
            PopulateVendors()
            Me.IsInitialized = True
            If Not Page.IsPostBack Then
                PopulateFilterFields()
            End If
        End If
    End Sub

    Public Sub PopulateFilterFields()
        Me.FilterField.Text = SessionManager.AdminProductCriteriaKeyword.Trim
        SetListToValue(Me.CategoryFilter, SessionManager.AdminProductCriteriaCategory)
        SetListToValue(Me.ManufacturerFilter, SessionManager.AdminProductCriteriaManufacturer)
        SetListToValue(Me.VendorFilter, SessionManager.AdminProductCriteriaVendor)
    End Sub

    Private Sub SetListToValue(ByVal l As DropDownList, ByVal value As String)
        If l IsNot Nothing Then
            If l.Items.FindByValue(value) IsNot Nothing Then
                l.ClearSelection()
                l.Items.FindByValue(value).Selected = True
            End If
        End If
    End Sub

    Public Property ExcludeCategoryBvin() As String
        Get
            Return Me.ExcludeCategoryBvinField.Value
        End Get
        Set(ByVal value As String)
            Me.ExcludeCategoryBvinField.Value = value
        End Set
    End Property

    Private Sub PopulateCategories()
        Dim tree As Collection(Of ListItem) = Catalog.Category.ListFullTreeWithIndents(True)
        Me.CategoryFilter.Items.Clear()
        For Each li As ListItem In tree
            Me.CategoryFilter.Items.Add(li)
        Next
        Me.CategoryFilter.Items.Insert(0, New ListItem("- Any Category -", ""))
    End Sub

    Private Sub PopulateManufacturers()
        Me.ManufacturerFilter.DataSource = Contacts.Manufacturer.FindAll
        Me.ManufacturerFilter.DataTextField = "DisplayName"
        Me.ManufacturerFilter.DataValueField = "Bvin"
        Me.ManufacturerFilter.DataBind()
        Me.ManufacturerFilter.Items.Insert(0, New ListItem("- Any Manufacturer -", ""))
    End Sub

    Private Sub PopulateVendors()
        Me.VendorFilter.DataSource = Contacts.Vendor.FindAll
        Me.VendorFilter.DataTextField = "DisplayName"
        Me.VendorFilter.DataValueField = "Bvin"
        Me.VendorFilter.DataBind()
        Me.VendorFilter.Items.Insert(0, New ListItem("- Any Vendor -", ""))
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        LoadSearch()
    End Sub

    Public Sub LoadSearch()
        'Me.GridView1.DataSource = Catalog.InternalProduct.FindByCriteria(c)
        Me.GridView1.DataBind()
        SessionManager.AdminProductCriteriaKeyword = Me.FilterField.Text.Trim
        SessionManager.AdminProductCriteriaCategory = Me.CategoryFilter.SelectedValue
        SessionManager.AdminProductCriteriaManufacturer = Me.ManufacturerFilter.SelectedValue
        SessionManager.AdminProductCriteriaVendor = Me.VendorFilter.SelectedValue
    End Sub

    Public ReadOnly Property SelectedProducts() As StringCollection
        Get
            Dim result As New StringCollection

            If Me.IsMultiSelect Then
                For i As Integer = 0 To Me.GridView1.Rows.Count - 1
                    If GridView1.Rows(i).RowType = DataControlRowType.DataRow Then
                        Dim chkSelected As CheckBox = Me.GridView1.Rows(i).Cells(0).FindControl("chkSelected")
                        If chkSelected IsNot Nothing Then
                            If chkSelected.Checked = True Then
                                result.Add(CType(GridView1.DataKeys(GridView1.Rows(i).RowIndex).Value, String))
                            End If
                        End If
                    End If
                Next
            Else
                Dim val As String = CStr(Request.Form(Me.GridView1.ClientID & "CheckBoxSelected"))
                If val IsNot Nothing Then
                    If val <> String.Empty Then
                        result.Add(val)
                    End If
                End If
            End If
            Return result
        End Get
    End Property

 
    Protected Sub ManufacturerFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ManufacturerFilter.SelectedIndexChanged
        LoadSearch()
    End Sub

    Protected Sub VendorFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VendorFilter.SelectedIndexChanged
        LoadSearch()
    End Sub

    Protected Sub CategoryFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CategoryFilter.SelectedIndexChanged
        LoadSearch()
    End Sub

    Protected Sub ObjectDataSource1_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If e.ExecutingSelectCount Then
            e.InputParameters("rowCount") = HttpContext.Current.Items("RowCount")
            HttpContext.Current.Items("RowCount") = Nothing
        Else
            Dim c As New Catalog.ProductSearchCriteria

            If Me.FilterField.Text.Trim.Length > 0 Then
                c.Keyword = Me.FilterField.Text.Trim
            End If
            If Me.ManufacturerFilter.SelectedValue <> "" Then
                c.ManufacturerId = Me.ManufacturerFilter.SelectedValue
            End If
            If Me.VendorFilter.SelectedValue <> "" Then
                c.VendorId = Me.VendorFilter.SelectedValue
            End If
            If Me.CategoryFilter.SelectedValue <> "" Then
                c.CategoryId = Me.CategoryFilter.SelectedValue
            End If
            If Me.ExcludeCategoryBvin.Trim.Length > 0 Then
                c.NotCategoryId = Me.ExcludeCategoryBvin.Trim
            End If
            c.DisplayInactiveProducts = True

            c.SpecialProductTypeOne = Catalog.SpecialProductTypes.NotSet
            c.SpecialProductTypeTwo = Catalog.SpecialProductTypes.NotSet

            If Not Me.DisplayKits Then
                c.ExcludedSpecialProductTypeOne = Catalog.SpecialProductTypes.Kit
            End If

            'c.SpecialProductTypeOne = Catalog.SpecialProductTypes.Normal
            'c.SpecialProductTypeTwo = Catalog.SpecialProductTypes.GiftCertificate
            'If DisplayKits Then
            'c.SpecialProductTypeTwo = Catalog.SpecialProductTypes.Kit
            'End If

            e.InputParameters("criteria") = c
        End If
    End Sub

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If e.OutputParameters("RowCount") IsNot Nothing Then
            HttpContext.Current.Items("RowCount") = e.OutputParameters("RowCount")
        End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        GridView1.PageSize = CInt(DropDownList1.SelectedValue)
        Me.GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If Not Me.IsMultiSelect Then
                DirectCast(e.Row.FindControl("chkSelected"), CheckBox).Visible = False
                DirectCast(e.Row.FindControl("radioButtonLiteral"), Literal).Text = "<input name='" & Me.GridView1.ClientID & "CheckBoxSelected' type='radio' value='" & GridView1.DataKeys(e.Row.RowIndex).Value & "' />"
            End If

            Dim PriceLabel As Label = DirectCast(e.Row.FindControl("PriceLabel"), Label)
            Dim InventoryLabel As Label = DirectCast(e.Row.FindControl("InventoryLabel"), Label)
            If Me.DisplayPrice Then
                PriceLabel.Text = DirectCast(e.Row.DataItem, Catalog.Product).SitePrice.ToString("c")
            End If

            If Me.DisplayInventory Then
                Dim prod As Catalog.Product = DirectCast(e.Row.DataItem, Catalog.Product)
                If prod.IsTrackingInventory() Then
                    InventoryLabel.Text = prod.QuantityAvailableForSale.ToString("N")
                Else
                    InventoryLabel.Text = "Not Tracking"
                End If
            End If
        ElseIf e.Row.RowType = DataControlRowType.Header Then
            If Me.DisplayPrice Then
                e.Row.Cells(3).Text = "Site Price"
            End If

            If Me.DisplayInventory Then
                e.Row.Cells(4).Text = "Available Qty"
            End If

            If Not Me.IsMultiSelect Then
                Dim chkSelectAll As CheckBox = DirectCast(e.Row.FindControl("chkSelectAll"), CheckBox)
                chkSelectAll.Visible = False
            End If
        End If
    End Sub
End Class
