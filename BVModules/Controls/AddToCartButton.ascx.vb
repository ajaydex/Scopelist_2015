Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Net
Imports System.IO
Imports System.Net.Mail
Imports System.Net.Configuration
Imports System.Web.Configuration


Partial Class BVModules_Controls_AddToCartButton
    Inherits System.Web.UI.UserControl

    Public Event AddToCartClicked(ByVal args As AddToCartClickedEventArgs)

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Me.btnAdd.ImageUrl = Page.ResolveUrl(PersonalizationServices.GetThemedButton("AddToCart"))
        'Me.btnSaveChanges.ImageUrl = Page.ResolveUrl(PersonalizationServices.GetThemedButton("SaveChanges"))
        Me.btnAdd.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/add-to-cart.jpg")
        Me.btnSaveChanges.ImageUrl = Page.ResolveUrl("~/BVModules/Themes/Scopelist/ScopelistImages/button-save-change.png")

        If Not Page.IsPostBack Then
            Me.btnAdd.EnableCallBack = (Not WebAppSettings.RedirectToCartAfterAddProduct)
            If Request.QueryString("LineItemId") Is Nothing Then
                btnAdd.Visible = True
                btnSaveChanges.Visible = False
            Else
                btnAdd.Visible = False
                btnSaveChanges.Visible = True
            End If
        End If
    End Sub

    Private Sub CheckForBackOrder()
        If Not WebAppSettings.DisableInventory Then
            If TypeOf Me.Page Is BaseStoreProductPage Then
                Dim p As BaseStoreProductPage = CType(Me.Page, BaseStoreProductPage)
                Select Case p.LocalProduct.InventoryStatus
                    Case Catalog.ProductInventoryStatus.NotAvailable
                        btnAdd.Visible = False
                        btnAdd.UpdateAfterCallBack = True
                    Case Else
                        If Request.QueryString("LineItemId") Is Nothing Then    ' keep btnAdd hidden when editing a cart item
                            btnAdd.Visible = True
                            btnAdd.UpdateAfterCallBack = True
                        End If
                End Select
            End If
        End If
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAdd.Click, btnSaveChanges.Click
        Dim args As New AddToCartClickedEventArgs()
        RaiseEvent AddToCartClicked(args)

        If args.IsValid Then
            If Page.IsValid Then
                Dim selectedProduct As Catalog.Product
                If args.VariantsDisplay IsNot Nothing Then
                    If Not args.VariantsDisplay.IsValid Then
                        Return
                    End If
                    selectedProduct = args.VariantsDisplay.GetSelectedProduct(Nothing)
                    If selectedProduct Is Nothing Then
                        EventLog.LogEvent("AddToCartButton.aspx.vb", "Product could not be found from Variants display. Current product: " & args.Page.LocalProduct.Bvin & " " & args.Page.LocalProduct.Sku, Metrics.EventLogSeverity.Error)
                        Return
                    Else
                        If args.VariantsDisplay.IsValidCombination Then
                            args.Page.LocalProduct = selectedProduct
                        Else
                            args.MessageBox.ShowError("Cannot Add To Cart. Current Selection Is Not Available.")
                        End If
                    End If
                ElseIf args.KitDisplay IsNot Nothing Then
                    If Not args.KitDisplay.IsValid Then
                        args.MessageBox.ShowError("Required selections are missing.")
                    End If
                    selectedProduct = args.Page.LocalProduct
                Else
                    selectedProduct = args.Page.LocalProduct
                End If

                args.Page.ModuleProductQuantity = args.Quantity

                Dim destination As String = String.Empty

                Dim Basket As Orders.Order = SessionManager.CurrentShoppingCart

                If Basket.UserID <> SessionManager.GetCurrentUserId Then
                    Basket.UserID = SessionManager.GetCurrentUserId
                End If

                Dim oldGiftWrapDetails As Collection(Of Orders.GiftWrapDetails) = Nothing
                If Request.QueryString("LineItemId") IsNot Nothing Then
                    Dim oldItem As Orders.LineItem = Orders.LineItem.FindByBvin(Request.QueryString("LineItemId"))
                    oldGiftWrapDetails = oldItem.GiftWrapDetails
                    Basket.RemoveItem(Request.QueryString("LineItemId"))
                End If

                Dim li As New Orders.LineItem()
                li.ProductId = selectedProduct.Bvin
                li.Quantity = args.Quantity

                'Retain gift wrap details from original line item
                If oldGiftWrapDetails IsNot Nothing Then
                    li.GiftWrapDetails = oldGiftWrapDetails
                End If

                If args.VariantsDisplay IsNot Nothing Then
                    args.VariantsDisplay.WriteValuesToLineItem(li)
                ElseIf args.KitDisplay IsNot Nothing Then
                    args.KitDisplay.WriteToLineItem(li)
                End If
                Basket.AddItem(li)

                If Basket.LastLineItemAdded IsNot Nothing Then
                    If args.ProductOverridePrice > 0 Then
                        Basket.LastLineItemAdded.BasePrice = args.ProductOverridePrice
                    End If

                    If sender.Equals(Me.btnSaveChanges) Then
                        destination = "~/Cart.aspx"
                    Else
                        destination = selectedProduct.GetCartDestinationUrl(Basket.LastLineItemAdded)
                    End If

                    Orders.LineItem.Update(Basket.LastLineItemAdded)
                    If destination.Trim() = String.Empty Then
                        args.ItemAddedToCartLabel.Text = WebAppSettings.ItemAddedToCartText
                        args.ItemAddedToCartLabel.Visible = True
                        args.ItemAddedToCartLabel.UpdateAfterCallBack = True
                    Else

                        If Not SessionManager.GetCurrentUserId Is Nothing And Not SessionManager.GetCurrentUserId Is String.Empty Then
                            Dim u As Membership.UserAccount = Membership.UserAccount.FindByBvin(SessionManager.GetCurrentUserId)
                            Dim firstName As String = u.FirstName
                            Dim lastName As String = u.LastName
                            Dim email As String = u.Email
                            Dim sku As String = args.Page.LocalProduct.Sku
                            Dim productName As String = args.Page.LocalProduct.ProductName

                            'Dim productUrl As String = args.Page.LocalProduct.ProductURL
                            Dim productUrl = WebAppSettings.SiteStandardRoot.TrimEnd("/"c) & args.Page.LocalProduct.ProductURL
                            Dim quantity As Integer = args.Quantity
                            Dim saleprice As String = Math.Round(args.Page.LocalProduct.SitePrice, 2).ToString()

                            SendSalesForceRequest(firstName, lastName, email, sku, productName, productUrl, quantity, saleprice)
                        End If


                        Response.Redirect(destination)
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        CheckForBackOrder()
    End Sub

    ''' <summary>
    ''' Sends an email in either HTML or Text format 
    ''' </summary>
    ''' <param name="sToAddr">String: The email recipient</param>
    ''' <param name="sFromAddr">String: The senders email address</param>
    ''' <param name="sFromName">String: The senders name</param>
    ''' <param name="sSubject">String: The email subject</param>
    ''' <param name="sBody">String: The message body</param>
    ''' <param name="bHtmlFormat">Boolean: True = HTML, False = Text</param>
    Public Sub SendEmail(ByVal sToAddr As String, ByVal sFromAddr As String, _
                         ByVal sFromName As String, ByVal sSubject As String, _
                         ByVal sBody As String, ByVal bHtmlFormat As Boolean)

        Dim strMail As New MailMessage()
        strMail.From = New MailAddress(sFromAddr, sFromName)
        strMail.To.Add(sToAddr)
        strMail.Subject = sSubject
        strMail.IsBodyHtml = bHtmlFormat
        strMail.Body = sBody

        Dim objSmptClient As New SmtpClient()
        Try

            Dim configurationFile As System.Configuration.Configuration = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath)
            Dim mailSettings As MailSettingsSectionGroup = TryCast(configurationFile.GetSectionGroup("system.net/mailSettings"), MailSettingsSectionGroup)
            Dim smtpSection As SmtpSection = mailSettings.Smtp

            Dim networkCredentials As New NetworkCredential(smtpSection.Network.UserName, smtpSection.Network.Password)
            objSmptClient.Credentials = networkCredentials


            objSmptClient.EnableSsl = True

            objSmptClient.Send(strMail)
        Catch exception1 As Exception

        End Try
    End Sub

    Protected Sub SendSalesForceRequest(ByVal firstName As String, ByVal lastName As String, ByVal email As String, ByVal sku As String, ByVal productName As String, ByVal productUrl As String, ByVal quantity As Integer, ByVal saleprice As String)
        Dim oid As String = "00Do0000000JvrX"
        Dim retURL As String = "http://"
        Dim ipaddress As String = Request.UserHostAddress.ToString()
        Dim lead_source As String = "Scopelist.com Add To Cart"
        Dim remoteUrl As String = "https://www.salesforce.com/servlet/servlet.WebToLead?encoding=UTF-8"


        Dim encoding As ASCIIEncoding = New ASCIIEncoding

        Dim data As String = String.Format("first_name={0}&last_name={1}&email={2}&oid={3}&retURL={4}&lead_source={5}&00No0000003opMp={6}&00No0000003pJ9f={7}&00No0000003pJ9k={8}&00No00000039vpM={9}&00No0000003AtbV={10}&00No0000003AtN4={11}", firstName, lastName, email, oid, retURL, lead_source, ipaddress, productUrl, productName, sku, quantity, saleprice)

        Dim bytes() As Byte = encoding.GetBytes(data)
        Dim httpRequest As HttpWebRequest = CType(WebRequest.Create(remoteUrl), HttpWebRequest)
        httpRequest.Method = "POST"
        httpRequest.ContentType = "application/x-www-form-urlencoded"
        httpRequest.ContentLength = bytes.Length()
        Dim stream As Stream = httpRequest.GetRequestStream
        stream.Write(bytes, 0, bytes.Length)
        stream.Close()

        'Build our email message        
        'Dim strToAddress As String = ConfigurationManager.AppSettings("Email.AskUs")
        'Dim strSubject As String = "AddToCart From the Scopelist.com Website"
        'Dim sbBody As StringBuilder = New StringBuilder
        'sbBody.Append("<p><b>First Name: </b>" & firstName & "</p>")
        'sbBody.Append("<p><b>Last Name: </b>" & lastName & "</p>")
        'sbBody.Append("<p><b>Email: </b>" & email & "</p>")
        'sbBody.Append("<p><b>Ip Address: </b>" & ipaddress)
        'Dim strOutput As String = sbBody.ToString()

        ' Send our email
        'Me.SendEmail(strToAddress, email, firstName, strSubject, strOutput, True)
    End Sub
End Class
