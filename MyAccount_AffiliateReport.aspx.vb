Imports BVSoftware.Bvc5.Core.PersonalizationServices
Imports BVSoftware.Bvc5.Core
Imports System.Collections.Generic
Imports System.Collections.ObjectModel

Partial Class MyAccount_AffiliateReport
    Inherits BaseStorePage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Utilities.WebForms.MakePageNonCacheable(Me)
        If Not Page.IsPostBack Then
            NextImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Next")
            PreviousImageButton.ImageUrl = PersonalizationServices.GetThemedButton("Previous")
            ViewImageButton.ImageUrl = PersonalizationServices.GetThemedButton("View")


            MonthDropDownList.SelectedValue = Date.Now.Month
            YearDropDownList.SelectedValue = Date.Now.Year
            ViewState("UserId") = SessionManager.GetCurrentUserId
            Page.Title = "Affiliate Report"
            BindAffiliates()
        End If
    End Sub

    Private Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.MasterPageFile = PersonalizationServices.GetSafeMasterPage("MyAccount.master")

        If SessionManager.IsUserAuthenticated = False Then
            Response.Redirect("login.aspx?ReturnURL=" & Server.UrlEncode("MyAccount_AffiliateReport.aspx"))
        End If

        If Contacts.Affiliate.FindEnabledByUserId(SessionManager.GetCurrentUserId).Count <= 0 Then
            Response.Redirect("MyAccount_AddressBook.aspx")
        End If

    End Sub

    Protected Sub BindAffiliates()
        AffiliatesDropDownList.DataSource = Contacts.Affiliate.FindByUserId(ViewState("UserId"))
        AffiliatesDropDownList.DataTextField = "DisplayName"
        AffiliatesDropDownList.DataValueField = "bvin"
        AffiliatesDropDownList.DataBind()
        AffiliatesDropDownList.Items.Insert(0, "-All Affiliates-")
    End Sub

    Protected Sub ViewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ViewImageButton.Click
        Dim affiliates As Collection(Of Contacts.Affiliate)
        If AffiliatesDropDownList.SelectedValue = "-All Affiliates-" Then
            affiliates = Contacts.Affiliate.FindByUserId(ViewState("UserId"))
        Else
            affiliates = New Collection(Of Contacts.Affiliate)()
            affiliates.Add(Contacts.Affiliate.FindByBvin(AffiliatesDropDownList.SelectedValue))
        End If

        AffiliatesDataList.DataSource = affiliates
        AffiliatesDataList.DataKeyField = "bvin"
        AffiliatesDataList.DataBind()
    End Sub

    Protected Sub AffiliatesDataList_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles AffiliatesDataList.ItemDataBound
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            If e.Item.DataItem IsNot Nothing Then
                Dim orderCriteria As New Orders.OrderSearchCriteria()
                Dim referralCriteria As New Contacts.AffiliateReferralSearchCriteria()

                Dim affiliate As Contacts.Affiliate = DirectCast(e.Item.DataItem, Contacts.Affiliate)

                orderCriteria.AffiliateId = affiliate.ReferralId
                orderCriteria.StartDate = New DateTime(CInt(YearDropDownList.SelectedValue), CInt(MonthDropDownList.SelectedValue), 1, 0, 0, 0, 0)
                orderCriteria.EndDate = orderCriteria.StartDate.AddMonths(1)
                orderCriteria.EndDate = orderCriteria.EndDate.AddMilliseconds(-1)

                referralCriteria.AffiliateId = affiliate.Bvin
                referralCriteria.StartDate = orderCriteria.StartDate
                referralCriteria.EndDate = orderCriteria.EndDate

                Dim affiliateOrders As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(orderCriteria)

                Dim currLabel As Label = DirectCast(e.Item.FindControl("ReferralsLabel"), Label)
                Dim referrals As Collection(Of Contacts.AffiliateReferral) = Contacts.AffiliateReferral.FindByCriteria(referralCriteria)
                currLabel.Text = referrals.Count

                currLabel = DirectCast(e.Item.FindControl("SalesLabel"), Label)
                currLabel.Text = affiliateOrders.Count

                currLabel = DirectCast(e.Item.FindControl("ConversionLabel"), Label)
                Dim conversion As Double = CType(affiliateOrders.Count, Double) / CType(referrals.Count, Double)
                currLabel.Text = String.Format("{0:p}", conversion)

                Dim total As Double = 0D

                For Each order As Orders.Order In affiliateOrders
                    total += order.SubTotal
                Next

                currLabel = DirectCast(e.Item.FindControl("CommissionLabel"), Label)
                Dim commission As Double = 0D
                Dim commissionText As String = String.Empty
                If Not affiliate Is Nothing Then
                    If affiliate.CommissionType = Contacts.AffiliateCommissionType.FlatRateCommission Then
                        commission = Math.Round(affiliate.CommissionAmount * CType(affiliateOrders.Count, Double), 2)
                        commissionText = String.Format("{0:c}", affiliate.CommissionAmount) & " per"
                    Else
                        commission = Math.Round((affiliate.CommissionAmount / CType(100, Double)) * total, 2)
                        commissionText = String.Format("{0:p}", (affiliate.CommissionAmount / CType(100, Double)))
                    End If

                    currLabel.Text = commissionText & " = " & String.Format("{0:c}", commission)
                End If

                Dim gv As GridView = CType(e.Item.FindControl("OrdersGridView"), GridView)
                If gv IsNot Nothing Then
                    gv.DataSource = affiliateOrders
                    gv.DataKeyNames = New String() {"bvin"}
                    gv.DataBind()
                End If

                Dim openDiv As Literal = e.Item.FindControl("openDiv")
                Dim closeDiv As Literal = e.Item.FindControl("closeDiv")

                If (openDiv IsNot Nothing) AndAlso (closeDiv IsNot Nothing) Then
                    openDiv.Text = "<a href="""
                    Dim agentName As String = Request.Browser.Browser
                    If agentName.StartsWith("IE") = True Then
                        openDiv.Text += "javascript:toggle('aff" & affiliate.Bvin & "');"
                    ElseIf agentName.StartsWith("Netscape") = True Then
                        openDiv.Text += "javascript:toggle('aff" & affiliate.Bvin & "');"
                    Else
                        openDiv.Text += "javascript:void(0);"
                    End If
                    openDiv.Text += """><img id=""aff" & affiliate.Bvin & "Carrot"" name=""aff" & affiliate.Bvin & "Carrot"" src=""images/system/RightArrow.png"" border=""0"" alt=""Toggle""></a><div style=""display:none"" id=""aff" & affiliate.Bvin & """ class=""hidden"">"

                    closeDiv.Text = "</div>"
                End If
            End If
        End If
    End Sub

    Protected Sub NextImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles NextImageButton.Click
        Dim month As Integer = CInt(MonthDropDownList.SelectedValue)
        Dim year As Integer = CInt(YearDropDownList.SelectedValue)
        If month < 12 Then
            month += 1
        Else
            month = 1
            year += 1
        End If
        MonthDropDownList.SelectedValue = month.ToString()
        YearDropDownList.SelectedValue = year.ToString()
    End Sub

    Protected Sub PreviousImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles PreviousImageButton.Click
        Dim month As Integer = CInt(MonthDropDownList.SelectedValue)
        Dim year As Integer = CInt(YearDropDownList.SelectedValue)
        If month > 1 Then
            month -= 1
        Else
            month = 12
            year -= 1
        End If
        MonthDropDownList.SelectedValue = month.ToString()
        YearDropDownList.SelectedValue = year.ToString()
    End Sub



End Class
