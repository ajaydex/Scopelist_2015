Imports System.Collections.ObjectModel
Imports BVSoftware.Bvc5.Core

Namespace FeedEngine.Products

    Public Class CommissionJunction
        Inherits BaseProductFeed

        Private Const COMPONENTID As String = "8D2C31EB-619F-458f-ACC5-A65733E4CFE6"

        Private _CID As String
        Private _SUBID As String
        Private _AID As String
        Private _PromotionalText As String

#Region " Default Properties "

        Protected Overrides ReadOnly Property DEFAULT_FIELDWRAPCHARACTER() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FEEDNAME() As String
            Get
                Return "Commission Junction"
            End Get
        End Property

        Protected Overrides ReadOnly Property DEFAULT_FILENAME() As String
            Get
                Return "cj.txt"
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_CID() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_SUBID() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_AID() As String
            Get
                Return String.Empty
            End Get
        End Property

        Protected Overridable ReadOnly Property DEFAULT_PROMOTIONALTEXT() As String
            Get
                Return String.Empty
            End Get
        End Property

#End Region

#Region " Properties "

        Public Overridable Property CID() As String
            Get
                Return Me._CID
            End Get
            Set(ByVal value As String)
                Me._CID = value
            End Set
        End Property

        Public Overridable Property SUBID() As String
            Get
                Return Me._SUBID
            End Get
            Set(ByVal value As String)
                Me._SUBID = value
            End Set
        End Property

        Public Overridable Property AID() As String
            Get
                Return Me._AID
            End Get
            Set(ByVal value As String)
                Me._AID = value
            End Set
        End Property

        Public Overridable Property PromotionalText() As String
            Get
                Return Me._PromotionalText
            End Get
            Set(ByVal value As String)
                Me._PromotionalText = value
            End Set
        End Property

#End Region

        Sub New()
            MyBase.New(COMPONENTID)

            Me.SettingsManager = New Datalayer.ComponentSettingsManager("8D2C31EB-619F-458f-ACC5-A65733E4CFE6")

            Dim setting As String = String.Empty

            setting = Me.SettingsManager.GetSetting("CID")
            Me._CID = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_CID)

            setting = Me.SettingsManager.GetSetting("SUBID")
            Me._SUBID = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_SUBID)

            setting = Me.SettingsManager.GetSetting("AID")
            Me._AID = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_AID)

            setting = Me.SettingsManager.GetSetting("PromotionalText")
            Me._PromotionalText = If(Not String.IsNullOrEmpty(setting), setting, Me.DEFAULT_PROMOTIONALTEXT)
        End Sub

        Public Overrides Sub SaveSettings()
            MyBase.SaveSettings()

            Me.SettingsManager.SaveSetting("CID", Me.CID, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("SUBID", Me.SUBID, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("AID", Me.AID, "Develisys", "Product Feed", Me.FeedName)
            Me.SettingsManager.SaveSetting("PromotionalText", Me.PromotionalText, "Develisys", "Product Feed", Me.FeedName)
        End Sub

        Protected Overrides Sub AddHeaderRow()
            AddRow(String.Format("&CID={0}", Me.CID))
            AddRow(String.Format("&SUBID={0}", Me.SUBID))
            AddRow("&DATEFMT=MM/DD/YYYY HH12:MI PM")
            AddRow("&PROCESSTYPE=OVERWRITE")
            AddRow(String.Format("&AID={0}", Me.AID))
            AddRow("&PARAMETERS=NAME|KEYWORDS|DESCRIPTION|SKU|MANUFACTURERID|BUYURL|AVAILABLE|IMAGEURL|PRICE|RETAILPRICE|SALEPRICE|PROMOTIONALTEXT|ADVERTISERCATEGORY|MANUFACTURER|INSTOCK|CONDITION")
        End Sub

        Protected Overrides Sub AddProductRow(ByRef p As BVSoftware.BVC5.Core.Catalog.Product)
            ' Name
            Dim productName As String = Me.CleanText(p.ProductName).Replace(ControlChars.Quote, "&quot;")
            AddColumn(productName, 160)

            ' Keywords
            AddColumn(Me.GetProductKeywords(p, ",", 300).Replace(ControlChars.Quote, String.Empty))

            ' Description
            If Not String.IsNullOrEmpty(p.LongDescription) Then
                AddColumn(p.LongDescription, 3000)
            ElseIf Not String.IsNullOrEmpty(p.MetaDescription) Then
                AddColumn(p.MetaDescription)
            Else
                AddColumn(p.ProductName)
            End If

            ' Sku
            AddColumn(p.Sku)

            ' ManufacturerID
            AddColumn(p.Sku)

            ' BuyUrl
            AddColumn(Me.CreateProductUrl(p))

            ' Available
            AddColumn(ConvertBooleanToYesOrNo(p.IsInStock))

            ' ImageUrl
            AddColumn(Me.CreateProductImageUrl(p))

            ' Price
            AddColumn(p.SitePrice.ToString("0.00"))

            ' RetailPrice
            AddColumn(p.ListPrice.ToString("0.00"))

            ' Sale Price
            AddColumn(Me.GetProductPrice(p))

            ' Promotional Text
            AddColumn(Me.PromotionalText, 300)

            ' Advertiser Category
            'AddColumn(Me.GetProductCategoryBreadcrumb(p))
            AddColumn(Me.GetProductType(p))

            ' Manufacturer
            AddColumn(Me.GetProductManufacturer(p))

            ' In Stock
            AddColumn(ConvertBooleanToYesOrNo(p.IsInStock))

            ' Condition
            AddColumn("New")
        End Sub

    End Class

End Namespace