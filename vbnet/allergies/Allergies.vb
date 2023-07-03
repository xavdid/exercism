Public Class Allergies
    private property allergens As New Dictionary(Of Integer, String)() From
    {
        {0, "cats"},
        {1, "pollen"},
        {2, "chocolate"},
        {3, "tomatoes"},
        {4, "strawberries"},
        {5, "shellfish"},
        {6, "peanuts"},
        {7, "eggs"}
    }
    private property _score as string
    
    Public Sub New(score As Integer)
      dim binaryString as string = Convert.ToString(score, 2).PadLeft(8, "0"c)
      dim last8Characters as string = binaryString.substring(math.max(binaryString.length - 8, 0))
      _score = last8Characters
    End Sub

    Public Function AllergicTo(allergy As String) As Boolean
        For Each kvp As KeyValuePair(Of Integer, String) In allergens
            If kvp.Value = allergy Then
                return _score.chars(kvp.key) = "1"
            End If
        Next
    End Function

    Public Function List() As IList(Of String)
        Dim result As New List(Of String)()
        
        For index As Integer = _score.Length - 1 To 0 step -1
          Dim ch As Char = _score.Chars(index)
          if ch = "1" then
            result.add(allergens(index))
          end if
        Next

        return result
    End Function
End Class