Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Public Class WebServices4aLoader

    ''' <summary>
    ''' This method loads processors into the web services interface. You can add/remove commands as needed. It is recommended that you add command in the "WebServices4aCustomLoader" class only.
    ''' To remove commands comment out the "result.add" line that you do not wish to expose on your store.
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Shared Function AvailableProcessors() As Collection(Of BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor)
        Dim result As New Collection(Of BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor)

        result.Add(New WS4Processors.ListCommands)
        result.Add(New BVSoftware.Bvc5.Core.Services.WS4.Processors.Help)
        result.Add(New BVSoftware.Bvc5.Core.Services.WS4.Processors.Version)
        result.Add(New BVSoftware.Bvc5.Core.Services.WS4.Processors.OrderSearch)
        result.Add(New WS4Processors.FindBvinBySKU)
        result.Add(New WS4Processors.ProductUpdatePricing)

        ' Add in custom processors here
        Dim custom As Collection(Of BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor) = WebServices4aCustomLoader.CustomProcessors()
        If custom IsNot Nothing Then
            For Each c As BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor In custom
                result.Add(c)
            Next
        End If

        Return result
    End Function

   
End Class
