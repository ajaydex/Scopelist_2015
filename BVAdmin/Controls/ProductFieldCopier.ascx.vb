Imports BVSoftware.Bvc5.Core

Partial Class BVAdmin_Controls_ProductFieldCopier
    Inherits Content.NotifyClickControl

    Private _fieldToCopyName As String = String.Empty
    Private _fieldToCopy As Control = Nothing

    Private _fieldToCopyTo As Catalog.CopyableProductProperties = Catalog.CopyableProductProperties.NotSet

    Private _productId As String = String.Empty
    Private _basePage As BaseAdminPage = Nothing

    Public Property FieldToCopy() As String
        Get
            Return _fieldToCopyName
        End Get
        Set(ByVal value As String)
            _fieldToCopyName = value
        End Set
    End Property

    Public Property FieldToCopyTo() As Catalog.CopyableProductProperties
        Get
            Return _fieldToCopyTo
        End Get
        Set(ByVal value As Catalog.CopyableProductProperties)
            _fieldToCopyTo = value
        End Set
    End Property

    Public Property BasePage() As BaseAdminPage
        Get
            Return _basePage
        End Get
        Set(ByVal value As BaseAdminPage)
            _basePage = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim val As String = CStr(Request.QueryString("id"))
        If val IsNot Nothing Then
            If val = String.Empty Then
                Throw New ArgumentException("Product Id Must Be Set.")
            Else
                _productId = val
            End If
        End If

        If Catalog.ProductChoice.GetChoiceCountForProduct(val) > 0 Then
            Me.Visible = True
        Else
            Me.Visible = False
        End If

        If FieldToCopy <> String.Empty Then
            _fieldToCopy = RecursiveFindControl(Me.Page.Controls, FieldToCopy)
            If _fieldToCopy Is Nothing Then
                Throw New ArgumentException("FieldToCopy does not contain a valid control name.")
            End If
        Else
            Throw New ArgumentException("FieldToCopy must be assigned.")
        End If

        If TypeOf Me.Page Is BaseAdminPage Then
            Me.BasePage = DirectCast(Me.Page, BaseAdminPage)
        End If
    End Sub

    Public Function RecursiveFindControl(ByVal controls As ControlCollection, ByVal controlName As String) As Control
        For Each ctrl As Control In controls
            If ctrl.ID = controlName Then
                Return ctrl
            ElseIf ctrl.Controls.Count > 0 Then
                Dim result As Control = RecursiveFindControl(ctrl.Controls, controlName)
                If result IsNot Nothing Then
                    Return result
                End If
            End If
        Next
        Return Nothing
    End Function


    Protected Sub CopyToChildImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles CopyToChildImageButton.Click
        If Me.NotifyClicked() Then
            Dim value As Object = Nothing
            Dim value2 As Object = Nothing
            If _fieldToCopy IsNot Nothing Then
                If TypeOf _fieldToCopy Is TextBox Then
                    Dim tb As TextBox = DirectCast(_fieldToCopy, TextBox)
                    value = tb.Text
                ElseIf TypeOf _fieldToCopy Is CheckBox Then
                    Dim cb As CheckBox = DirectCast(_fieldToCopy, CheckBox)
                    value = cb.Checked
                ElseIf TypeOf _fieldToCopy Is ASP.bvadmin_controls_htmleditor_ascx Then
                    Dim he As ASP.bvadmin_controls_htmleditor_ascx = DirectCast(_fieldToCopy, ASP.bvadmin_controls_htmleditor_ascx)
                    value = he.Text
                    If he.SupportsTransform Then
                        value2 = he.PreTransformText
                    End If
                End If
            End If

            Dim product As Catalog.Product = Catalog.InternalProduct.FindByBvin(_productId)
            If product Is Nothing Then
                Throw New ArgumentException("Product Id was not valid.")
            Else
                Select Case _fieldToCopyTo
                    Case Catalog.CopyableProductProperties.ProductName
                        'don't do anything, value is correct
                    Case Catalog.CopyableProductProperties.MSRP
                        value = Decimal.Parse(value, System.Globalization.NumberStyles.Currency)
                    Case Catalog.CopyableProductProperties.SitePrice
                        value = Decimal.Parse(value, System.Globalization.NumberStyles.Currency)
                    Case Catalog.CopyableProductProperties.SiteCost
                        value = Decimal.Parse(value, System.Globalization.NumberStyles.Currency)
                    Case Catalog.CopyableProductProperties.SmallImage
                        'don't do anything, value is correct
                    Case Catalog.CopyableProductProperties.MediumImage
                        'don't do anything, value is correct
                    Case Catalog.CopyableProductProperties.NonShipping
                        'don't do anything, value is correct
                    Case Catalog.CopyableProductProperties.Weight
                        value = Decimal.Parse(value, System.Globalization.NumberStyles.Number)
                    Case Catalog.CopyableProductProperties.ShortDescription
                        'don't do anything, value is correct
                    Case Catalog.CopyableProductProperties.LongDescription
                        'we have to save off the pre-transform long description
                        If value2 IsNot Nothing Then
                            If Not product.CopyValueToChildren(value2, Catalog.CopyableProductProperties.PreTransformLongDescription) Then
                                ShowMessage("An error occurred while copying value to product variations, please check event log.", ErrorTypes.Error)
                                Exit Sub
                            End If
                        End If
                    Case Catalog.CopyableProductProperties.ExtraShipFee
                        value = Decimal.Parse(value, System.Globalization.NumberStyles.Currency)
                    Case Catalog.CopyableProductProperties.SitePriceOverrideText
                        'don't do anything, value is correct
                    Case Else
                        Throw New ArgumentException("Field To Copy To Was Not Properly Addressed.")
                End Select

                If product.CopyValueToChildren(value, _fieldToCopyTo) Then
                    ShowMessage("Value successfully copied to product variations.", ErrorTypes.Ok)
                Else
                    ShowMessage("An error occurred while copying value to product variations, please check event log.", ErrorTypes.Error)
                End If
            End If
        End If
    End Sub

    Public Sub ShowMessage(ByVal message As String, ByVal type As ErrorTypes)
        If Me.BasePage IsNot Nothing Then
            Me.BasePage.ShowMessage(message, type)
        End If
    End Sub
End Class
