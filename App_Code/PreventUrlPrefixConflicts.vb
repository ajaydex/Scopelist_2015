Public Class PreventUrlPrefixConflicts
    Inherits BVSoftware.Bvc5.Core.Utilities.UrlRewritingRule

    Public Overrides Function Execute(ByRef app As HttpApplication, sourceUrl As Uri, parts As BVSoftware.Bvc5.Core.Utilities.UrlRewriterParts) As Boolean
        Dim result As Boolean = False

        ' prevents BV's URL rewriter from trying to rewrite non-aspx URLs (e.g. /images/products/)
        If Not parts.Url.EndsWith(".aspx") Then
            result = True
        End If

        Return result
    End Function

End Class