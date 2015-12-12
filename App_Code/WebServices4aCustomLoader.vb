Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel

Public Class WebServices4aCustomLoader

    ''' <summary>    
    ''' Use this method to add your own processors to the WebServices4a stack
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>    
    Public Shared Function CustomProcessors() As Collection(Of BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor)
        Dim result As New Collection(Of BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor)

        'result.Add(New MyCompany.MyProcessor)

        Return result
    End Function

End Class

