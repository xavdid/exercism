Imports System

Public Module ArmstrongNumbers
    Public Function IsArmstrongNumber(ByVal number As Integer) As Boolean
        Dim numberString As String = number.ToString()
        Dim power as Integer = numberString.length

        dim total as Integer = 0

        For Each digitChar As Char In numberString
            Dim digit As Integer = Convert.ToInt32(digitChar.ToString())
            total = total + math.pow(digit, power)
        Next

        return total = number
    End Function
End Module
