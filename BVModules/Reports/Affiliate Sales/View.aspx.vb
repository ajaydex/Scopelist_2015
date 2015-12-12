Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Partial Class BVAdmin_Reports_Affiliates
    Inherits BaseAdminPage

    Protected Sub Page_Load1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            BindAffiliates()
        End If

    End Sub

    Protected Sub BindAffiliates()
        AffiliatesDropDownList.DataSource = Contacts.Affiliate.FindAll()
        AffiliatesDropDownList.DataTextField = "DisplayName"
        AffiliatesDropDownList.DataValueField = "bvin"
        AffiliatesDropDownList.DataBind()
        AffiliatesDropDownList.Items.Insert(0, "-All Affiliates-")
    End Sub

    Protected Sub Page_PreInit1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Me.PageTitle = "Sales By Affiliates"
        Me.CurrentTab = AdminTabType.Reports
        ValidateCurrentUserHasPermission(Membership.SystemPermissions.ReportsView)
    End Sub

    Protected Sub ViewImageButton_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ViewImageButton.Click
        Dim affiliates As Collection(Of Contacts.Affiliate)
        If AffiliatesDropDownList.SelectedValue = "-All Affiliates-" Then
            affiliates = Contacts.Affiliate.FindAll()
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

                orderCriteria.IsPlaced = True
                orderCriteria.AffiliateId = affiliate.ReferralId
                orderCriteria.StartDate = Me.DateRangeField.StartDate
                orderCriteria.EndDate = Me.DateRangeField.EndDate
                'orderCriteria.PaymentStatus = Orders.OrderPaymentStatus.Paid    ' uncomment to only include paid orders

                referralCriteria.AffiliateId = affiliate.Bvin
                referralCriteria.StartDate = orderCriteria.StartDate
                referralCriteria.EndDate = orderCriteria.EndDate

                Dim affiliateOrders As Collection(Of Orders.Order) = Orders.Order.FindByCriteria(orderCriteria)

                Dim currLabel As Label = DirectCast(e.Item.FindControl("ReferralsLabel"), Label)
                Dim referralCount As Integer = Contacts.AffiliateReferral.FindCountByCriteria(referralCriteria)
                currLabel.Text = referralCount.ToString()

                currLabel = DirectCast(e.Item.FindControl("SalesLabel"), Label)
                currLabel.Text = affiliateOrders.Count

                currLabel = DirectCast(e.Item.FindControl("ConversionLabel"), Label)
                Dim conversion As Double = CType(affiliateOrders.Count, Double) / CType(referralCount, Double)
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
                    openDiv.Text += "javascript:toggle('aff" & affiliate.Bvin & "');"
                    openDiv.Text += """><img id=""aff" & affiliate.Bvin & "Carrot"" name=""aff" & affiliate.Bvin & "Carrot"" src=""../../../BVAdmin/Images/Buttons/Details.png"" border=""0"" alt=""Details""></a></img><div style=""display:none"" id=""aff" & affiliate.Bvin & """ class=""hidden"">"

                    closeDiv.Text = "</div>"
                End If
            End If
        End If
    End Sub

End Class
