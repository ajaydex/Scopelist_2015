Imports Microsoft.VisualBasic
Imports BVSoftware.Bvc5.Core
Imports System.Text
Imports System.Xml
Imports System.IO

Namespace WS4Processors

    Public Class ListCommands
        Inherits Services.WS4.CommandProcessor


        Public Overrides ReadOnly Property CommandName() As String
            Get
                Return "ListCommands"
            End Get
        End Property

        Public Overrides Function Help(ByVal summary As Boolean) As String
            Return "The ListCommmands command returns a list of all available web services commands. For help on a specific command try the ""Help"" command which takes a command name as it's data parameter and returns more information."
        End Function

        Public Overrides Function ProcessRequest(ByVal data As String) As BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            Dim result As New BVSoftware.Bvc5.Core.Services.WS4.WS4Response
            Try
                Dim sw As StringWriter = New StringWriter(System.Globalization.CultureInfo.InvariantCulture)
                Dim xw As XmlTextWriter = New XmlTextWriter(sw)

                xw.Formatting = Formatting.Indented
                xw.Indentation = 3
                xw.WriteStartDocument()


                xw.WriteStartElement("Commands")
                For Each c As BVSoftware.Bvc5.Core.Services.WS4.CommandProcessor In WebServices4aLoader.AvailableProcessors()
                    xw.WriteStartElement("Command")
                    xw.WriteElementString("Name", c.CommandName)
                    xw.WriteElementString("Description", c.Help(True))
                    xw.WriteEndElement()
                Next
                xw.WriteEndElement()


                xw.WriteEndDocument()
                xw.Flush()
                xw.Close()
                result.ResponseData = sw.GetStringBuilder.ToString()
                sw.Close()
            Catch ex As Exception
                result.Errors.Add(New BVSoftware.Bvc5.Core.Services.WS4.WS4Error("Exception", ex.Message))
            End Try
            Return result
        End Function
    End Class

End Namespace