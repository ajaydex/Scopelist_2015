Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Controls_ProductModifications
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Me.Page.ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "flipRow") Then            
            Dim script As String = _
            "function flipRow(checkBoxId, rowId){ " & _
            "   if (document.getElementById(checkBoxId).checked){" & _
            "       document.getElementById(rowId).style.backgroundColor = '#ffc';" & _
            "   }else{" & _
            "       document.getElementById(rowId).style.backgroundColor = 'white';" & _
            "   }" & _
            "} "
            Me.Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "flipRow", script, True)
        End If

        If Not Me.Page.ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "checkBoxForOption") Then
            Dim script As String = _
            "function checkBoxForOption(textbox, checkBoxId, rowId){" & _
            "   if (textbox.value != ''){" & _
            "       document.getElementById(checkBoxId).checked = true;" & _
            "   }else{" & _
            "       document.getElementById(checkBoxId).checked = false;" & _
            "   }" & _
            "   flipRow(checkBoxId, rowId);" & _
            "}"
            Me.Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "checkBoxForOption", script, True)
        End If


        Dim currCheckBox As CheckBox = Nothing
        Dim currTextBoxBasedControl As Controls.ITextBoxBasedControl = Nothing
        For Each rowControl As System.Web.UI.Control In Me.ProductModificationPanel.Controls
            If TypeOf rowControl Is HtmlTableRow Then
                For Each cellControl As System.Web.UI.Control In rowControl.Controls
                    If TypeOf cellControl Is HtmlTableCell Then
                        For Each control As System.Web.UI.Control In cellControl.Controls
                            If TypeOf control Is Controls.ITextBoxBasedControl Then
                                currTextBoxBasedControl = DirectCast(control, Controls.ITextBoxBasedControl)
                                If (currTextBoxBasedControl IsNot Nothing) Then
                                    currTextBoxBasedControl.AddTextBoxAttribute("onkeyup", "checkBoxForOption(this, '" & currCheckBox.ClientID & "', '" & rowControl.ClientID & "')")
                                End If
                            End If
                            If TypeOf control Is CheckBox Then
                                currCheckBox = DirectCast(control, CheckBox)
                                If currCheckBox.CssClass = "modificationSelected" Then
                                    If currCheckBox.Checked Then
                                        DirectCast(rowControl, HtmlTableRow).Attributes.Add("style", "background-color: #ffc")
                                    Else
                                        DirectCast(rowControl, HtmlTableRow).Attributes.Add("style", "background-color: white")
                                    End If
                                    currCheckBox.Attributes.Add("onclick", "flipRow(this.id, '" & rowControl.ClientID & "');")
                                End If
                            End If
                        Next
                    End If
                Next
            End If
        Next

        If Not Page.IsPostBack Then
            BindEnumeratedFields()
        End If
    End Sub

    Protected Sub BindEnumeratedFields()

        ProductTypeEnumeratedValueModifierField.Datasource = Catalog.ProductType.FindAll()
        ProductTypeEnumeratedValueModifierField.DataTextField = "ProductTypeName"
        ProductTypeEnumeratedValueModifierField.DataValueField = "bvin"
        ProductTypeEnumeratedValueModifierField.DataBind()

        ' load ShippingMode enum into bindable object
        Dim shippingModeNames As String() = [Enum].GetNames(GetType(Shipping.ShippingMode))
        Dim shippingModeValues As Array = [Enum].GetValues(GetType(Shipping.ShippingMode))
        Dim shippingModeBindable As New Hashtable()
        For i As Integer = 0 To shippingModeNames.Length - 1
            shippingModeBindable.Add(shippingModeNames(i), shippingModeValues(i))
        Next

        ShippingModeEnumeratedValueModifierField.Datasource = shippingModeBindable
        ShippingModeEnumeratedValueModifierField.DataTextField = "value"
        ShippingModeEnumeratedValueModifierField.DataValueField = "key"
        ShippingModeEnumeratedValueModifierField.DataBind()

        ' load VariantsDisplayMode enum into bindable object
        'Dim variantsDisplayModeNames As String() = [Enum].GetNames(GetType(Catalog.VariantDisplayMode))
        'Dim variantsDisplayModeValues As Array = [Enum].GetValues(GetType(Catalog.VariantDisplayMode))
        'Dim variantsDisplayModeBindable As New Hashtable()
        'For i As Integer = 0 To variantsDisplayModeNames.Length - 1
        '    variantsDisplayModeBindable.Add(variantsDisplayModeNames(i), variantsDisplayModeValues(i))
        'Next

        'VariantsDisplayModeEnumeratedValueModifierField.Datasource = variantsDisplayModeBindable
        'VariantsDisplayModeEnumeratedValueModifierField.DataTextField = "value"
        'VariantsDisplayModeEnumeratedValueModifierField.DataValueField = "key"
        'VariantsDisplayModeEnumeratedValueModifierField.DataBind()

        ManufacturerEnumeratedValueModifierField.Datasource = Contacts.Manufacturer.FindAll()
        ManufacturerEnumeratedValueModifierField.DataTextField = "DisplayName"
        ManufacturerEnumeratedValueModifierField.DataValueField = "bvin"
        ManufacturerEnumeratedValueModifierField.DataBind()

        ProductTemplateEnumeratedValueModifierField.Datasource = Content.ModuleController.FindProductTemplates()
        ProductTemplateEnumeratedValueModifierField.DataBind()

        PreContentColumnEnumeratedValueModifierField.Datasource = Content.ContentColumn.FindAll()
        PreContentColumnEnumeratedValueModifierField.DataTextField = "DisplayName"
        PreContentColumnEnumeratedValueModifierField.DataValueField = "bvin"
        PreContentColumnEnumeratedValueModifierField.DataBind()

        PostContentColumnEnumeratedValueModifierField.Datasource = Content.ContentColumn.FindAll()
        PostContentColumnEnumeratedValueModifierField.DataTextField = "DisplayName"
        PostContentColumnEnumeratedValueModifierField.DataValueField = "bvin"
        PostContentColumnEnumeratedValueModifierField.DataBind()

        TaxClassEnumeratedValueModifierField.Datasource = Taxes.TaxClass.FindAll()
        TaxClassEnumeratedValueModifierField.DataTextField = "DisplayName"
        TaxClassEnumeratedValueModifierField.DataValueField = "bvin"
        TaxClassEnumeratedValueModifierField.DataBind()

        VendorEnumeratedValueModifierField.Datasource = Contacts.Vendor.FindAll()
        VendorEnumeratedValueModifierField.DataTextField = "DisplayName"
        VendorEnumeratedValueModifierField.DataValueField = "bvin"
        VendorEnumeratedValueModifierField.DataBind()
    End Sub

    Public Sub PostChangesToProduct(ByVal item As Catalog.Product)
        Dim process As Boolean = False
        Dim controls As New Collection(Of Controls.ModificationControlBase)
        For Each rowControl As System.Web.UI.Control In Me.ProductModificationPanel.Controls
            If TypeOf rowControl Is HtmlTableRow Then
                For Each cellControl As System.Web.UI.Control In rowControl.Controls
                    If TypeOf cellControl Is HtmlTableCell Then
                        For Each control As System.Web.UI.Control In cellControl.Controls
                            If TypeOf control Is CheckBox Then
                                process = DirectCast(control, CheckBox).Checked
                            End If
                            If process Then
                                If TypeOf control Is Controls.ModificationControlBase Then
                                    controls.Add(control)
                                End If
                            End If
                        Next
                    End If
                Next
            End If
        Next

        For Each control As Controls.ModificationControlBase In controls
            If TypeOf control Is Controls.ModificationControl(Of String) Then
                Dim stringControl As Controls.ModificationControl(Of String) = DirectCast(control, Controls.ModificationControl(Of String))
                MakeChanges(stringControl, item)
            ElseIf TypeOf control Is Controls.ModificationControl(Of Boolean) Then
                Dim booleanControl As Controls.ModificationControl(Of Boolean) = DirectCast(control, Controls.ModificationControl(Of Boolean))
                MakeChanges(booleanControl, item)
            ElseIf TypeOf control Is Controls.ModificationControl(Of Integer) Then
                Dim integerControl As Controls.ModificationControl(Of Integer) = DirectCast(control, Controls.ModificationControl(Of Integer))
                MakeChanges(integerControl, item)
            ElseIf TypeOf control Is Controls.ModificationControl(Of Double) Then
                Dim floatControl As Controls.ModificationControl(Of Double) = DirectCast(control, Controls.ModificationControl(Of Double))
                MakeChanges(floatControl, item)
            ElseIf TypeOf control Is Controls.ModificationControl(Of Decimal) Then
                Dim monetaryControl As Controls.ModificationControl(Of Decimal) = DirectCast(control, Controls.ModificationControl(Of Decimal))
                MakeChanges(monetaryControl, item)
            End If
        Next

    End Sub

    Public Overloads Sub MakeChanges(ByVal control As Controls.ModificationControl(Of String), ByVal item As Catalog.Product)
        If control.ID = "ProductNameStringModifierField" Then
            item.ProductName = control.ApplyChanges(item.ProductName)
        ElseIf control.ID = "ProductSkuStringModifierField" Then
            item.Sku = control.ApplyChanges(item.Sku)
        ElseIf control.ID = "MetaKeywordsStringModifierField" Then
            item.MetaKeywords = control.ApplyChanges(item.MetaKeywords)
        ElseIf control.ID = "MetaDescriptionStringModifierField" Then
            item.MetaDescription = control.ApplyChanges(item.MetaDescription)
        ElseIf control.ID = "MetaTitleStringModifierField" Then
            item.MetaTitle = control.ApplyChanges(item.MetaTitle)
        ElseIf control.ID = "ImageFileSmallStringModifierField" Then
            item.ImageFileSmall = control.ApplyChanges(item.ImageFileSmall)
        ElseIf control.ID = "ImageFileMediumStringModifierField" Then
            item.ImageFileMedium = control.ApplyChanges(item.ImageFileMedium)
        ElseIf control.ID = "ShortDescriptionStringModifierField" Then
            item.ShortDescription = control.ApplyChanges(item.ShortDescription)
        ElseIf control.ID = "LongDescriptionHtmlModifierField" Then
            item.LongDescription = control.ApplyChanges(item.LongDescription)
        ElseIf control.ID = "KeyWordsStringModifierField" Then
            item.Keywords = control.ApplyChanges(item.Keywords)
        ElseIf control.ID = "UrlToRewriteStringModifierField" Then
            item.RewriteUrl = control.ApplyChanges(item.RewriteUrl)
        ElseIf control.ID = "SitePriceOverrideStringModifierField" Then
            item.GlobalProduct.SitePriceOverrideText = control.ApplyChanges(item.SitePriceOverrideText)
        ElseIf control.ID = "ManufacturerEnumeratedValueModifierField" Then
            item.ManufacturerId = control.ApplyChanges(item.ManufacturerId)
        ElseIf control.ID = "ProductTemplateEnumeratedValueModifierField" Then
            item.TemplateName = control.ApplyChanges(item.TemplateName)
        ElseIf control.ID = "PreContentColumnEnumeratedValueModifierField" Then
            item.PreContentColumnId = control.ApplyChanges(item.PreContentColumnId)
        ElseIf control.ID = "PostContentColumnEnumeratedValueModifierField" Then
            item.PostContentColumnId = control.ApplyChanges(item.PostContentColumnId)
        ElseIf control.ID = "TaxClassEnumeratedValueModifierField" Then
            item.TaxClass = control.ApplyChanges(item.TaxClass)
        ElseIf control.ID = "VendorEnumeratedValueModifierField" Then
            item.VendorId = control.ApplyChanges(item.VendorId)
        ElseIf control.ID = "ShippingModeEnumeratedValueModifierField" Then
            item.ShippingMode = [Enum].Parse(GetType(Shipping.ShippingMode), control.ApplyChanges(item.ShippingMode))
            'ElseIf control.ID = "VariantsDisplayModeEnumeratedValueModifierField" Then
            '    item.VariantDisplay = [Enum].Parse(GetType(Catalog.VariantDisplayMode), control.ApplyChanges(item.VariantDisplay))
        ElseIf control.ID = "ProductTypeEnumeratedValueModifierField" Then
            item.ProductTypeId = control.ApplyChanges(item.ProductTypeId)
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Sub

    Public Overloads Sub MakeChanges(ByVal control As Controls.ModificationControl(Of Boolean), ByVal item As Catalog.Product)
        If control.ID = "TaxExemptBooleanModifierField" Then
            item.TaxExempt = control.ApplyChanges(item.TaxExempt)
        ElseIf control.ID = "NonShippingBooleanModifierField" Then
            item.NonShipping = control.ApplyChanges(item.NonShipping)
        ElseIf control.ID = "ShipSeperatelyBooleanModifierField" Then
            item.ShipSeparately = control.ApplyChanges(item.ShipSeparately)
        ElseIf control.ID = "ProductStateBooleanModifierField" Then
            If control.ApplyChanges(item.Status) Then
                item.Status = Catalog.ProductStatus.Active
            Else
                item.Status = Catalog.ProductStatus.Disabled
            End If
        ElseIf control.ID = "GiftWrapAllowedBooleanModifierField" Then
            item.GiftWrapAllowed = control.ApplyChanges(item.GiftWrapAllowed)
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Sub

    Public Overloads Sub MakeChanges(ByVal control As Controls.ModificationControl(Of Integer), ByVal item As Catalog.Product)
        If control.ID = "MinimumQuantityIntegerModifierField" Then
            item.MinimumQty = control.ApplyChanges(item.MinimumQty)
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Sub

    Public Overloads Sub MakeChanges(ByVal control As Controls.ModificationControl(Of Double), ByVal item As Catalog.Product)
        If control.ID = "ShippingWeightFloatModifierField" Then
            item.ShippingWeight = control.ApplyChanges(item.ShippingWeight)
        ElseIf control.ID = "ShippingLengthFloatModifierField" Then
            item.ShippingLength = control.ApplyChanges(item.ShippingLength)
        ElseIf control.ID = "ShippingWidthFloatModifierField" Then
            item.ShippingWidth = control.ApplyChanges(item.ShippingWidth)
        ElseIf control.ID = "ShippingHeightFloatModifierField" Then
            item.ShippingHeight = control.ApplyChanges(item.ShippingHeight)
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Sub

    Public Overloads Sub MakeChanges(ByVal control As Controls.ModificationControl(Of Decimal), ByVal item As Catalog.Product)
        If control.ID = "ListPriceMonetaryModifierField" Then
            item.ListPrice = control.ApplyChanges(item.ListPrice)
        ElseIf control.ID = "SitePriceMonetaryModifierField" Then
            item.SitePrice = control.ApplyChanges(item.SitePrice)
        ElseIf control.ID = "SiteCostMonetaryModifierField" Then
            item.SiteCost = control.ApplyChanges(item.SiteCost)
        ElseIf control.ID = "ExtraShipFeeMonetaryModifierField" Then
            item.ExtraShipFee = control.ApplyChanges(item.ExtraShipFee)
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Sub
End Class
