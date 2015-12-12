Imports BVSoftware.Bvc5.Core

Partial Class BVModules_Controls_StaticAddressDisplay
    Inherits System.Web.UI.UserControl

    Public Sub LoadFromAddress(ByVal address As Contacts.Address)
        NameLabel.Text = address.FirstName & " " & address.LastName
        If address.Company.Trim() <> String.Empty Then
            CompanyLabel.Text = address.Company
            CompanyRow.Visible = True
        Else
            CompanyRow.Visible = False
        End If

        AddressLineOneLabel.Text = address.Line1
        If address.Line2.Trim() <> String.Empty Then
            AddressLineTwoLabel.Text = address.Line2
            LineTwoRow.Visible = True
        Else
            LineTwoRow.Visible = False
        End If
        If address.Line3.Trim() <> String.Empty Then
            AddressLineThreeLabel.Text = address.Line3
            LineThreeRow.Visible = True
        Else
            LineThreeRow.Visible = False
        End If
        AddressLineFourLabel.Text = address.City & ", " & address.RegionName & " " & address.PostalCode
    End Sub
End Class
