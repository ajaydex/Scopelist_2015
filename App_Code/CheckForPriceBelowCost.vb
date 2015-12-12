Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core

Public Class CheckForPriceBelowCost
    Inherits BusinessRules.ProductTask


    Public Overrides Function TaskName() As String
        Return "Check for Price Below Cost"
    End Function

    Public Overrides Function TaskId() As String
        Return "4EDA00D6-CBC0-4b13-8B5B-FEAACEF63B15"
    End Function

    Public Overloads Overrides Function Execute(ByVal context As BVSoftware.Bvc5.Core.BusinessRules.ProductTaskContext) As Boolean
        Dim result As Boolean = False

        If context.Product.SitePrice < context.Product.SiteCost Then
            context.Product.SitePrice = context.Product.SiteCost
        End If
        result = True

        Return result
    End Function

    Public Overloads Overrides Function Rollback(ByVal context As BVSoftware.Bvc5.Core.BusinessRules.ProductTaskContext) As Boolean
        Return True
    End Function

    Public Overrides Function Clone() As BVSoftware.Bvc5.Core.BusinessRules.Task
        Return New CheckForPriceBelowCost
    End Function

End Class
