Imports BVSoftware.Bvc5.Core
Imports System.Collections.ObjectModel
Imports System.Collections.Generic

Partial Class BVAdmin_Controls_InventoryModifications
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub

    Public Function PostChanges(ByVal item As Catalog.ProductInventory) As Boolean
        Dim process As Boolean = False
        Dim controls As New Collection(Of Controls.ModificationControlBase)
        For Each rowControl As System.Web.UI.Control In Me.InventoryModificationsPanel.Controls
            If TypeOf rowControl Is HtmlTableRow Then
                For Each cellControl As System.Web.UI.Control In rowControl.Controls
                    If TypeOf cellControl Is HtmlTableCell Then
                        For Each control As System.Web.UI.Control In cellControl.Controls
                            If TypeOf control Is CheckBox Then
                                process = DirectCast(control, CheckBox).Checked
                            End If
                            If process Then
                                If TypeOf control Is Controls.ModificationControlBase Then
                                    controls.Add(control)
                                End If
                            End If
                        Next
                    End If
                Next
            End If
        Next

        Dim result As Boolean = False
        For Each control As Controls.ModificationControlBase In controls
            If TypeOf control Is Controls.ModificationControl(Of Integer) Then
                Dim integerControl As Controls.ModificationControl(Of Integer) = DirectCast(control, Controls.ModificationControl(Of Integer))
                If MakeChanges(integerControl, item) Then
                    result = True
                End If
            ElseIf TypeOf control Is Controls.ModificationControl(Of Double) Then
                Dim floatControl As Controls.ModificationControl(Of Double) = DirectCast(control, Controls.ModificationControl(Of Double))
                If MakeChanges(floatControl, item) Then
                    result = True
                End If
            ElseIf TypeOf control Is Controls.ModificationControl(Of Decimal) Then
                Dim monetaryControl As Controls.ModificationControl(Of Decimal) = DirectCast(control, Controls.ModificationControl(Of Decimal))
                If MakeChanges(monetaryControl, item) Then
                    result = True
                End If
            End If
        Next

        Return result
    End Function

    Protected Overloads Function MakeChanges(ByVal control As Controls.ModificationControl(Of Integer), ByVal item As Catalog.ProductInventory) As Boolean
        If control.ID = "QuantityAvailableIntegerModifierField" Then
            Dim newVal As Integer = control.ApplyChanges(item.QuantityAvailable)
            If newVal <> item.QuantityAvailable Then
                item.QuantityAvailable = newVal
                Return True
            Else
                Return False
            End If
        ElseIf control.ID = "QuantityOutOfStockPointIntegerModifierField" Then
            Dim newVal As Integer = control.ApplyChanges(item.QuantityOutOfStockPoint)
            If newVal <> item.QuantityOutOfStockPoint Then
                item.QuantityOutOfStockPoint = newVal
                Return True
            Else
                Return False
            End If
        ElseIf control.ID = "QuantityReserveIntegerModifierField" Then
            Dim newVal As Integer = control.ApplyChanges(item.QuantityReserved)
            If newVal <> item.QuantityReserved Then
                item.QuantityReserved = newVal
                Return True
            Else
                Return False
            End If
        Else
            Throw New Controls.ControlNotFoundException(control.ID)
        End If
    End Function

    Protected Overloads Function MakeChanges(ByVal control As Controls.ModificationControl(Of Double), ByVal item As Catalog.ProductInventory) As Boolean
        Throw New Controls.ControlNotFoundException(control.ID)
    End Function

    Protected Overloads Function MakeChanges(ByVal control As Controls.ModificationControl(Of Decimal), ByVal item As Catalog.ProductInventory) As Boolean
        Throw New Controls.ControlNotFoundException(control.ID)
    End Function

End Class