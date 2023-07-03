Public Class Bob
    Public Function Hey(statement As String) As String
        Dim isQuestion As Boolean = statement.Trim().EndsWith("?")
        Dim isYelling As Boolean = statement.Any(Function(c) Char.IsLetter(c)) and statement.Equals(statement.ToUpper())

        If isQuestion and isYelling Then
            Return "Calm down, I know what I'm doing!"
        End If

        If isQuestion Then
            Return "Sure."
        End If

        If isYelling Then
            Return "Whoa, chill out!"
        End If

        If statement.Trim() = "" Then
            Return "Fine. Be that way!"
        End If

        Return "Whatever."
    End Function
End Class
