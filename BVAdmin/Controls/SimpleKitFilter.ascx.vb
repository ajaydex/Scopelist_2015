Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_SimpleKItFilter
    Inherits System.Web.UI.UserControl

    Public Event FilterChanged(ByVal criteria As Catalog.ProductSearchCriteria)
    Public Event GoPressed(ByVal criteria As Catalog.ProductSearchCriteria)

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Not Page.IsPostBack Then
            PopulateFilterFields()
        End If
        If WebAppSettings.DisableInventory Then
            InventoryStatusFilter.Enabled = False
        Else
            InventoryStatusFilter.Enabled = True
        End If
    End Sub

    Public Overrides Sub Focus()
        Me.FilterField.Focus()
    End Sub

    Public Function LoadProducts() As Catalog.ProductSearchCriteria

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
        If Me.StatusFilter.SelectedValue <> "" Then
            c.Status = Me.StatusFilter.SelectedValue
        End If
        If Me.InventoryStatusFilter.SelectedValue <> "" Then
            c.InventoryStatus = Me.InventoryStatusFilter.SelectedValue
        End If
        If Me.ProductTypeFilter.SelectedValue <> "" Then
            c.ProductTypeId = Me.ProductTypeFilter.SelectedValue
        End If
        c.SpecialProductTypeOne = Catalog.SpecialProductTypes.Kit


        'If products.Count = 1 Then
        '    Me.lblResults.Text = "1 product found"
        'Else
        '    Me.lblResults.Text = products.Count & " products found"
        'End If

        ' Save Setting to Session
        SessionManager.AdminKitCriteriaKeyword = Me.FilterField.Text.Trim
        SessionManager.AdminKitCriteriaCategory = Me.CategoryFilter.SelectedValue
        SessionManager.AdminKitCriteriaManufacturer = Me.ManufacturerFilter.SelectedValue
        SessionManager.AdminKitCriteriaVendor = Me.VendorFilter.SelectedValue
        SessionManager.AdminKitCriteriaStatus = Me.StatusFilter.SelectedValue
        SessionManager.AdminKitCriteriaInventoryStatus = Me.InventoryStatusFilter.SelectedValue
        SessionManager.AdminKitCriteriaProductType = Me.ProductTypeFilter.SelectedValue

        c.DisplayInactiveProducts = True

        Return c
    End Function

    Private Sub PopulateFilterFields()
        PopulateCategories()
        PopulateManufacturers()
        PopulateVendors()
        PopulateStatus()
        PopulateInventoryStatus()
        PopulateProductTypes()

        Me.FilterField.Text = SessionManager.AdminKitCriteriaKeyword.Trim
        SetListToValue(Me.CategoryFilter, SessionManager.AdminKitCriteriaCategory)
        SetListToValue(Me.ManufacturerFilter, SessionManager.AdminKitCriteriaManufacturer)
        SetListToValue(Me.VendorFilter, SessionManager.AdminKitCriteriaVendor)
        SetListToValue(Me.StatusFilter, SessionManager.AdminKitCriteriaStatus)
        SetListToValue(Me.InventoryStatusFilter, SessionManager.AdminKitCriteriaInventoryStatus)
        SetListToValue(Me.ProductTypeFilter, SessionManager.AdminKitCriteriaProductType)
    End Sub

    Private Sub SetListToValue(ByVal l As DropDownList, ByVal value As String)
        If l IsNot Nothing Then
            If l.Items.FindByValue(value) IsNot Nothing Then
                l.ClearSelection()
                l.Items.FindByValue(value).Selected = True
            End If
        End If
    End Sub

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

    Private Sub PopulateStatus()
        Me.StatusFilter.Items.Clear()
        Me.StatusFilter.Items.Add(New ListItem("- Any Status -", ""))
        Me.StatusFilter.Items.Add(New ListItem("Active", "1"))
        Me.StatusFilter.Items.Add(New ListItem("Disabled", "0"))
    End Sub

    Private Sub PopulateInventoryStatus()
        Me.InventoryStatusFilter.Items.Clear()
        If WebAppSettings.DisableInventory Then
            Me.InventoryStatusFilter.Items.Add(New ListItem("- Inventory Disabled -", ""))
        Else
            Me.InventoryStatusFilter.Items.Add(New ListItem("- Any Inventory Status -", ""))
            Me.InventoryStatusFilter.Items.Add(New ListItem("Not Available", "0"))
            Me.InventoryStatusFilter.Items.Add(New ListItem("Available", "1"))
        End If

    End Sub

    Private Sub PopulateProductTypes()
        Me.ProductTypeFilter.Items.Clear()
        Me.ProductTypeFilter.DataSource = Catalog.ProductType.FindAll()
        Me.ProductTypeFilter.DataTextField = "ProductTypeName"
        Me.ProductTypeFilter.DataValueField = "bvin"
        Me.ProductTypeFilter.DataBind()
        Me.ProductTypeFilter.Items.Insert(0, New ListItem("- Any Type -", ""))
    End Sub

    Protected Sub ProductTypeFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ProductTypeFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub CategoryFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CategoryFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub ManufacturerFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ManufacturerFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub VendorFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles VendorFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub StatusFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles StatusFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub InventoryStatusFilter_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles InventoryStatusFilter.SelectedIndexChanged
        RaiseEvent FilterChanged(Me.LoadProducts())
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        RaiseEvent GoPressed(Me.LoadProducts())
        Me.FilterField.Focus()
    End Sub
End Class
